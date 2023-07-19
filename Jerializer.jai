#scope_export

JerializeFault :: enum
{
	OK :: 0;
	FAILED_TO_ALLOCATE :: 1;
	NOT_ENOUGH_SPACE_IN_SOURCE :: 2;
	SOURCE_VERSION_TOO_HIGH :: 3;
	SOURCE_BUFFER_HEADER_MAGIC_WRONG :: 4;
};


jerialize :: (
	obj : *$T,
	endian := ENDIANNESS.LITTLE,
	version : int = -1) -> string, JerializeFault
{
	ctrl : Jerializer(.Serialize);
	ctrl.endian_target = endian;
	init_string_builder(*ctrl.builder);


	header_range := ensure_contiguous_space_and_return_available_range(*ctrl.builder, size_of(JerializerHeader));
	if header_range.count < size_of(JerializerHeader)  return "Failed to allocate space for header", .FAILED_TO_ALLOCATE;
	header : *JerializerHeader = xx header_range.data;
	
	header_template : JerializerHeader;
	header_template.endian = ctrl.endian_target;

	res : JerializeFault;
	if ctrl.endian_source == ctrl.endian_target
	{
		res = serialize(*ctrl, *header_template, endian_swap = false);
		if res == .OK  res = serialize(*ctrl, obj, endian_swap = false);
	}else{
		res = serialize(*ctrl, *header_template, endian_swap = true);
		if res == .OK  res = serialize(*ctrl, obj, endian_swap = true);
	}

	if res != .OK
	{
		print("Failed to serialize with error %\n", name_Of_Enum(res));
	}

	print("Serialized using version '%' and '%' Endian Format\n", ctrl.max_version, name_Of_Enum(ctrl.endian_target));

	default_header : JerializerHeader;
	<<header = default_header;
	header.version = ctrl.max_version;
	header.endian = ctrl.endian_target;

	return builder_to_string(*ctrl.builder, do_reset = true, extra_bytes_to_prepend = 0), .OK;
}

dejerialize :: (
	obj : *$T,
	source : string) -> JerializeFault
{
	ctrl : Jerializer(.Deserialize);
	ctrl.data = source;
	if ctrl.data.count < size_of(JerializerHeader)  return .NOT_ENOUGH_SPACE_IN_SOURCE;
	header_template : JerializerHeader;
	header : *JerializerHeader = xx ctrl.data.data;
	for header.magic
	{
		if it != header_template.magic[it_index]  return .SOURCE_BUFFER_HEADER_MAGIC_WRONG;
	}
	ctrl.endian_source = header.endian;
	print("Deserialized using header version '%' and '%' Endian Format, local format is '%'\n", header.version, name_Of_Enum(ctrl.endian_source), name_Of_Enum(ctrl.endian_target));

	res : JerializeFault;
	if ctrl.endian_source == ctrl.endian_target
	{
		res = serialize(*ctrl, *header_template, endian_swap = false);
		if res == .OK  res = serialize(*ctrl, obj, endian_swap = false);
	}else{
		res = serialize(*ctrl, *header_template, endian_swap = true);
		if res == .OK  res = serialize(*ctrl, obj, endian_swap = true);
	}

	if res != .OK
	{
		print("Failed to deserialize with error %\n", name_Of_Enum(res));
	}

	return .OK;
}



serialize :: (ctrl : *$Jeri/Jerializer, obj : *$T, $endian_swap : bool = false) -> JerializeFault
{
	#insert #run create_jerialize(Jeri.{}, T, endian_swap);
	/* Note(Qwendo): 
	 * I create an instance here, because I want a convenient syntax to check direction
	 * without having to cast to Type_Info and extract that member myself
	 */
	return .OK;
};


Direction :: enum
{
	Serialize   :: 0;
	Deserialize :: 1;
};

ENDIANNESS :: enum u8
{
	LITTLE :: 0;
	BIG :: 1; 
};

#scope_module

Jerializer :: struct(direction : Direction)
{
	endian_source : ENDIANNESS;
	endian_target : ENDIANNESS;
	max_version : int;
	#if direction == .Serialize
	{
		builder : String_Builder;
	}else{
		data : string;
		cursor : int;
	}
};

JerializerHeader :: struct 
{
	magic   : [7]u8 = .[#char "J", #char "e", #char "r", #char "i", #char "a", #char "l", #char "i"];
	endian  : ENDIANNESS = .LITTLE;
	version : int;
};


version_Of_Member :: (member : *Type_Info_Struct_Member) -> int, bool #expand
{
	for note: member.notes
	{
		if starts_with(note, "JerializeVersion(")
		{
			succ , parsed := scan("JerializeVersion(%i)", note);
			if succ && parsed[0].type.type == .INTEGER 
			{
				version : int =  <<cast(*int)parsed[0].value_pointer;
				return version, true;
			}

		}
	}
	return 0, false;
}

create_jerialize :: (jerializer : $T/Jerializer, $type_to_serialize : Type, $endian_swap : bool = false) -> string
{
	builder : String_Builder;
	init_string_builder(*builder);
	complicated :: Type_Info_Struct_Member.Flags.CONSTANT | .IMPORTED | .PROCEDURE_WITH_VOID_POINTER_TYPE_INFO;
	ti := cast(*Type_Info) type_to_serialize;
	#if T.direction == .Serialize
	{
		print_to_builder(*builder, "\t// Serialize\n");
	}else if T.direction == .Deserialize
	{
		print_to_builder(*builder, "\t// Deserialize\n");
	}
	#if endian_swap
	{
		print_to_builder(*builder, "\t// Endian swapping\n");
	}else 
	{
		print_to_builder(*builder, "\t// Plain copy\n");
	}

	if ti.type ==
	{
		case .STRUCT;
		{
			struct_info := cast(*Type_Info_Struct) ti;
			print_to_builder(*builder, "\t// Struct '%'\n", struct_info.name);
			water_mark_to_detect_overlaps_in_struct := 0;
			for struct_info.members
			{
				if it.offset_in_bytes < water_mark_to_detect_overlaps_in_struct  continue;
				if it.flags & complicated continue;
				if it.type.runtime_size != -1
				{
					water_mark_to_detect_overlaps_in_struct = it.offset_in_bytes + it.type.runtime_size;
				}else{
					assert(false, "We dont know the size of member %\nWe dont know what to do!Stopping", it.name);
				}
				version, found_version := version_Of_Member(*it);
				if found_version
				{
					#if T.direction == .Serialize
					{
						print_to_builder(*builder, "\tif ctrl.max_version < %1  ctrl.max_version = %1;\n", version);
					}else if T.direction == .Deserialize
					{
						print_to_builder(*builder, "\tif ctrl.max_version > %1  return .SOURCE_VERSION_TOO_HIGH;\n", version);
					}
				}
				print_to_builder(*builder, "\tserialize(ctrl, *obj.%, endian_swap = %);\n", it.name, endian_swap);
			}
		}
		case .ARRAY;
		{
			ai := cast(*Type_Info_Array) ti;

			if ai.array_type == .FIXED
			{
				print_to_builder(*builder,"\t// [%] %\n", ai.array_count, name_Of_Enum(ai.type));
			}else if ai.array_type == .VIEW{
				print_to_builder(*builder,"\t// %\n", name_Of_Enum(ai.type));
				print_to_builder(*builder, "\tserialize(ctrl, *obj.count, endian_swap = %);\n", endian_swap);
			}
			fmt := 
			#string DONE
	for * <<obj 
	{
		serialize(ctrl, it, endian_swap = %);
	}
			DONE
			print_to_builder(*builder, fmt,endian_swap);
		}

		case .FLOAT; #through;
		case .INTEGER;
		{
			print_to_builder(*builder,"\t// BaseType '%'\n", name_Of_Enum(ti.type) );

			#if endian_swap
			{
				format := #string DONE
	buffer : *u8 = xx obj;
	for 0..size_of(T)-1
	{
		%1
		%2
	} 
DONE
				endian_swap_string := "indx := size_of(T) - it - 1;";
				rw_string : string;
				#if T.direction == .Serialize
				{
					rw_string = "append(*ctrl.builder, buffer + indx, 1);\n";
				}else if T.direction == .Deserialize
				{
					rw_string = "<<(buffer + indx) = ctrl.data[ctrl.cursor];\n\t\tctrl.cursor += 1;\n";

				}
				print_to_builder(*builder, format, endian_swap_string, rw_string);
	
			}else{
				#if T.direction == .Serialize
				{
					print_to_builder(*builder, "\tappend(*ctrl.builder, xx obj, size_of(T));");
				}else if T.direction == .Deserialize
				{
					print_to_builder(*builder, "\t<<obj = <<(cast(*T)*(ctrl.data[ctrl.cursor]));\n\tctrl.cursor += size_of(type_of(<<obj));\n");
				}
			}
		}
		case .ENUM;
		{
			enum_info := cast(*Type_Info_Enum)ti;
			print_to_builder(*builder, "\t// Enum %\n", enum_info.name);
			integer_size := enum_info.info.runtime_size * 8;
			print_to_builder(*builder, "\tserialize(ctrl, cast(*u%)obj);", integer_size);
		}
		case;
			print("currently not supporting the type %\n", name_Of_Enum(ti.type));
	}
	return builder_to_string(*builder);
};



as_Big_Endian :: (val : $T) -> T
{
	buffer : [size_of(T)] u8;
	for * buffer
	{
		<<it = <<(cast(*u8) *val + size_of(T) - it_index - 1);
	}
	return <<cast(*T)buffer.data;
};


name_Of_Enum :: (val : $Enum) -> string
{
	einfo := cast(*Type_Info_Enum) Enum;
	assert(einfo.type == .ENUM);
	
	for einfo.values
	{
		if it == cast(type_of(einfo.values[0])) val  return einfo.names[it_index];
	}
	return "Unkown Enum Value";
}

#import "Basic";
#import "String";
