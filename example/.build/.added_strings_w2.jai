// Workspace: Target Program
//
// #insert text. Generated from D:/dev/projects/Jerialize/example/../Jerializer.jai:93.
//
	// Deserialize
	// Endian swapping
	// Struct 'Manager'
	serialize(ctrl, *obj.baba, endian_swap = true);
	serialize(ctrl, *obj.bababuyi, endian_swap = true);
	serialize(ctrl, *obj.monsters, endian_swap = true);
	if ctrl.max_version > 3  return .SOURCE_VERSION_TOO_HIGH;
	serialize(ctrl, *obj.entities, endian_swap = true);

//
// #insert text. Generated from D:/dev/projects/Jerialize/example/../Jerializer.jai:93.
//
	// Serialize
	// Endian swapping
	// Struct 'JerializerHeader'
	serialize(ctrl, *obj.magic, endian_swap = true);
	serialize(ctrl, *obj.endian, endian_swap = true);
	serialize(ctrl, *obj.version, endian_swap = true);

//
// #insert text. Generated from D:/dev/projects/Jerialize/example/../Jerializer.jai:93.
//
	// Deserialize
	// Endian swapping
	// [8] ARRAY
	for * <<obj 
	{
		serialize(ctrl, it, endian_swap = true);
	}

//
// #insert text. Generated from D:/dev/projects/Jerialize/example/../Jerializer.jai:93.
//
	// Serialize
	// Endian swapping
	// [7] ARRAY
	for * <<obj 
	{
		serialize(ctrl, it, endian_swap = true);
	}

//
// #insert text. Generated from D:/dev/projects/Jerialize/example/../Jerializer.jai:93.
//
	// Serialize
	// Endian swapping
	// Enum ENDIANNESS
	serialize(ctrl, cast(*u8)obj);

//
// #insert text. Generated from D:/dev/projects/Jerialize/example/../Jerializer.jai:93.
//
	// Deserialize
	// Endian swapping
	// BaseType 'INTEGER'
	buffer : *u8 = xx obj;
	for 0..size_of(T)-1
	{
		indx := size_of(T) - it - 1;
		<<(buffer + indx) = ctrl.data[ctrl.cursor];
		ctrl.cursor += 1;

	} 

//
// #insert text. Generated from D:/dev/projects/Jerialize/example/../Jerializer.jai:93.
//
	// Serialize
	// Endian swapping
	// BaseType 'INTEGER'
	buffer : *u8 = xx obj;
	for 0..size_of(T)-1
	{
		indx := size_of(T) - it - 1;
		append(*ctrl.builder, buffer + indx, 1);

	} 

//
// #insert text. Generated from D:/dev/projects/Jerialize/example/../Jerializer.jai:93.
//
	// Serialize
	// Plain copy
	// BaseType 'INTEGER'
	append(*ctrl.builder, xx obj, size_of(T));

//
// #insert text. Generated from D:/dev/projects/Jerialize/example/../Jerializer.jai:93.
//
	// Serialize
	// Endian swapping
	// BaseType 'INTEGER'
	buffer : *u8 = xx obj;
	for 0..size_of(T)-1
	{
		indx := size_of(T) - it - 1;
		append(*ctrl.builder, buffer + indx, 1);

	} 

//
// #insert text. Generated from D:/dev/projects/Jerialize/example/../Jerializer.jai:93.
//
	// Deserialize
	// Endian swapping
	// [1] ARRAY
	for * <<obj 
	{
		serialize(ctrl, it, endian_swap = true);
	}

//
// #insert text. Generated from D:/dev/projects/Jerialize/example/../Jerializer.jai:93.
//
	// Deserialize
	// Endian swapping
	// [1] ARRAY
	for * <<obj 
	{
		serialize(ctrl, it, endian_swap = true);
	}

//
// #insert text. Generated from D:/dev/projects/Jerialize/example/../Jerializer.jai:93.
//
	// Deserialize
	// Endian swapping
	// BaseType 'INTEGER'
	buffer : *u8 = xx obj;
	for 0..size_of(T)-1
	{
		indx := size_of(T) - it - 1;
		<<(buffer + indx) = ctrl.data[ctrl.cursor];
		ctrl.cursor += 1;

	} 

//
// #insert text. Generated from D:/dev/projects/Jerialize/example/../Jerializer.jai:93.
//
	// Deserialize
	// Endian swapping
	// Struct 'Entity'
	serialize(ctrl, *obj.position, endian_swap = true);
	if ctrl.max_version > 6  return .SOURCE_VERSION_TOO_HIGH;
	serialize(ctrl, *obj.health, endian_swap = true);
	if ctrl.max_version > 5  return .SOURCE_VERSION_TOO_HIGH;
	serialize(ctrl, *obj.max_health, endian_swap = true);

//
// #insert text. Generated from D:/dev/projects/Jerialize/example/../Jerializer.jai:93.
//
	// Deserialize
	// Endian swapping
	// Struct 'Monster'
	serialize(ctrl, *obj.base, endian_swap = true);
	serialize(ctrl, *obj.damage, endian_swap = true);

//
// #insert text. Generated from D:/dev/projects/Jerialize/example/../Jerializer.jai:93.
//
	// Deserialize
	// Endian swapping
	// Struct 'JerializerHeader'
	serialize(ctrl, *obj.magic, endian_swap = true);
	serialize(ctrl, *obj.endian, endian_swap = true);
	serialize(ctrl, *obj.version, endian_swap = true);

//
// #insert text. Generated from D:/dev/projects/Jerialize/example/../Jerializer.jai:93.
//
	// Deserialize
	// Endian swapping
	// Struct 'Vector2'
	serialize(ctrl, *obj.x, endian_swap = true);
	serialize(ctrl, *obj.y, endian_swap = true);

//
// #insert text. Generated from D:/dev/projects/Jerialize/example/../Jerializer.jai:93.
//
	// Serialize
	// Endian swapping
	// Struct 'Manager'
	serialize(ctrl, *obj.baba, endian_swap = true);
	serialize(ctrl, *obj.bababuyi, endian_swap = true);
	serialize(ctrl, *obj.monsters, endian_swap = true);
	if ctrl.max_version < 3  ctrl.max_version = 3;
	serialize(ctrl, *obj.entities, endian_swap = true);

//
// #insert text. Generated from D:/dev/projects/Jerialize/example/../Jerializer.jai:93.
//
	// Deserialize
	// Endian swapping
	// [7] ARRAY
	for * <<obj 
	{
		serialize(ctrl, it, endian_swap = true);
	}

//
// #insert text. Generated from D:/dev/projects/Jerialize/example/../Jerializer.jai:93.
//
	// Serialize
	// Endian swapping
	// [8] ARRAY
	for * <<obj 
	{
		serialize(ctrl, it, endian_swap = true);
	}

//
// #insert text. Generated from D:/dev/projects/Jerialize/example/../Jerializer.jai:93.
//
	// Serialize
	// Endian swapping
	// [1] ARRAY
	for * <<obj 
	{
		serialize(ctrl, it, endian_swap = true);
	}

//
// #insert text. Generated from D:/dev/projects/Jerialize/example/../Jerializer.jai:93.
//
	// Serialize
	// Endian swapping
	// [1] ARRAY
	for * <<obj 
	{
		serialize(ctrl, it, endian_swap = true);
	}

//
// #insert text. Generated from D:/dev/projects/Jerialize/example/../Jerializer.jai:93.
//
	// Deserialize
	// Endian swapping
	// BaseType 'FLOAT'
	buffer : *u8 = xx obj;
	for 0..size_of(T)-1
	{
		indx := size_of(T) - it - 1;
		<<(buffer + indx) = ctrl.data[ctrl.cursor];
		ctrl.cursor += 1;

	} 

//
// #insert text. Generated from D:/dev/projects/Jerialize/example/../Jerializer.jai:93.
//
	// Serialize
	// Endian swapping
	// Struct 'Monster'
	serialize(ctrl, *obj.base, endian_swap = true);
	serialize(ctrl, *obj.damage, endian_swap = true);

//
// #insert text. Generated from D:/dev/projects/Jerialize/example/../Jerializer.jai:93.
//
	// Serialize
	// Endian swapping
	// Struct 'Entity'
	serialize(ctrl, *obj.position, endian_swap = true);
	if ctrl.max_version < 6  ctrl.max_version = 6;
	serialize(ctrl, *obj.health, endian_swap = true);
	if ctrl.max_version < 5  ctrl.max_version = 5;
	serialize(ctrl, *obj.max_health, endian_swap = true);

//
// #insert text. Generated from D:/dev/projects/Jerialize/example/../Jerializer.jai:93.
//
	// Deserialize
	// Endian swapping
	// Enum ENDIANNESS
	serialize(ctrl, cast(*u8)obj);

//
// #insert text. Generated from D:/dev/projects/Jerialize/example/../Jerializer.jai:93.
//
	// Serialize
	// Plain copy
	// Struct 'JerializerHeader'
	serialize(ctrl, *obj.magic, endian_swap = false);
	serialize(ctrl, *obj.endian, endian_swap = false);
	serialize(ctrl, *obj.version, endian_swap = false);

//
// #insert text. Generated from D:/dev/projects/Jerialize/example/../Jerializer.jai:93.
//
	// Serialize
	// Endian swapping
	// Struct 'Vector2'
	serialize(ctrl, *obj.x, endian_swap = true);
	serialize(ctrl, *obj.y, endian_swap = true);

//
// #insert text. Generated from D:/dev/projects/Jerialize/example/../Jerializer.jai:93.
//
	// Deserialize
	// Plain copy
	// BaseType 'INTEGER'
	<<obj = <<(cast(*T)*(ctrl.data[ctrl.cursor]));
	ctrl.cursor += size_of(type_of(<<obj));

//
// #insert text. Generated from D:/dev/projects/Jerialize/example/../Jerializer.jai:93.
//
	// Serialize
	// Plain copy
	// Enum ENDIANNESS
	serialize(ctrl, cast(*u8)obj);

//
// #insert text. Generated from D:/dev/projects/Jerialize/example/../Jerializer.jai:93.
//
	// Serialize
	// Endian swapping
	// BaseType 'FLOAT'
	buffer : *u8 = xx obj;
	for 0..size_of(T)-1
	{
		indx := size_of(T) - it - 1;
		append(*ctrl.builder, buffer + indx, 1);

	} 

//
// #insert text. Generated from D:/dev/projects/Jerialize/example/../Jerializer.jai:93.
//
	// Serialize
	// Plain copy
	// BaseType 'INTEGER'
	append(*ctrl.builder, xx obj, size_of(T));

//
// #insert text. Generated from D:/dev/projects/Jerialize/example/../Jerializer.jai:93.
//
	// Serialize
	// Plain copy
	// [7] ARRAY
	for * <<obj 
	{
		serialize(ctrl, it, endian_swap = false);
	}

//
// #insert text. Generated from D:/dev/projects/Jerialize/example/../Jerializer.jai:93.
//
	// Serialize
	// Plain copy
	// Struct 'Manager'
	serialize(ctrl, *obj.baba, endian_swap = false);
	serialize(ctrl, *obj.bababuyi, endian_swap = false);
	serialize(ctrl, *obj.monsters, endian_swap = false);
	if ctrl.max_version < 3  ctrl.max_version = 3;
	serialize(ctrl, *obj.entities, endian_swap = false);

//
// #insert text. Generated from D:/dev/projects/Jerialize/example/../Jerializer.jai:93.
//
	// Deserialize
	// Plain copy
	// Struct 'JerializerHeader'
	serialize(ctrl, *obj.magic, endian_swap = false);
	serialize(ctrl, *obj.endian, endian_swap = false);
	serialize(ctrl, *obj.version, endian_swap = false);

//
// #insert text. Generated from D:/dev/projects/Jerialize/example/../Jerializer.jai:93.
//
	// Deserialize
	// Plain copy
	// Struct 'Manager'
	serialize(ctrl, *obj.baba, endian_swap = false);
	serialize(ctrl, *obj.bababuyi, endian_swap = false);
	serialize(ctrl, *obj.monsters, endian_swap = false);
	if ctrl.max_version > 3  return .SOURCE_VERSION_TOO_HIGH;
	serialize(ctrl, *obj.entities, endian_swap = false);

//
// #insert text. Generated from D:/dev/projects/Jerialize/example/../Jerializer.jai:93.
//
	// Serialize
	// Plain copy
	// [1] ARRAY
	for * <<obj 
	{
		serialize(ctrl, it, endian_swap = false);
	}

//
// #insert text. Generated from D:/dev/projects/Jerialize/example/../Jerializer.jai:93.
//
	// Deserialize
	// Plain copy
	// BaseType 'INTEGER'
	<<obj = <<(cast(*T)*(ctrl.data[ctrl.cursor]));
	ctrl.cursor += size_of(type_of(<<obj));

//
// #insert text. Generated from D:/dev/projects/Jerialize/example/../Jerializer.jai:93.
//
	// Deserialize
	// Plain copy
	// [8] ARRAY
	for * <<obj 
	{
		serialize(ctrl, it, endian_swap = false);
	}

//
// #insert text. Generated from D:/dev/projects/Jerialize/example/../Jerializer.jai:93.
//
	// Serialize
	// Plain copy
	// Struct 'Entity'
	serialize(ctrl, *obj.position, endian_swap = false);
	if ctrl.max_version < 6  ctrl.max_version = 6;
	serialize(ctrl, *obj.health, endian_swap = false);
	if ctrl.max_version < 5  ctrl.max_version = 5;
	serialize(ctrl, *obj.max_health, endian_swap = false);

//
// #insert text. Generated from D:/dev/projects/Jerialize/example/../Jerializer.jai:93.
//
	// Deserialize
	// Plain copy
	// [1] ARRAY
	for * <<obj 
	{
		serialize(ctrl, it, endian_swap = false);
	}

//
// #insert text. Generated from D:/dev/projects/Jerialize/example/../Jerializer.jai:93.
//
	// Deserialize
	// Plain copy
	// [1] ARRAY
	for * <<obj 
	{
		serialize(ctrl, it, endian_swap = false);
	}

//
// #insert text. Generated from D:/dev/projects/Jerialize/example/../Jerializer.jai:93.
//
	// Serialize
	// Plain copy
	// Struct 'Vector2'
	serialize(ctrl, *obj.x, endian_swap = false);
	serialize(ctrl, *obj.y, endian_swap = false);

//
// #insert text. Generated from D:/dev/projects/Jerialize/example/../Jerializer.jai:93.
//
	// Deserialize
	// Plain copy
	// Struct 'Monster'
	serialize(ctrl, *obj.base, endian_swap = false);
	serialize(ctrl, *obj.damage, endian_swap = false);

//
// #insert text. Generated from D:/dev/projects/Jerialize/example/../Jerializer.jai:93.
//
	// Deserialize
	// Plain copy
	// Struct 'Entity'
	serialize(ctrl, *obj.position, endian_swap = false);
	if ctrl.max_version > 6  return .SOURCE_VERSION_TOO_HIGH;
	serialize(ctrl, *obj.health, endian_swap = false);
	if ctrl.max_version > 5  return .SOURCE_VERSION_TOO_HIGH;
	serialize(ctrl, *obj.max_health, endian_swap = false);

//
// #insert text. Generated from D:/dev/projects/Jerialize/example/../Jerializer.jai:93.
//
	// Serialize
	// Plain copy
	// BaseType 'FLOAT'
	append(*ctrl.builder, xx obj, size_of(T));

//
// #insert text. Generated from D:/dev/projects/Jerialize/example/../Jerializer.jai:93.
//
	// Deserialize
	// Plain copy
	// [7] ARRAY
	for * <<obj 
	{
		serialize(ctrl, it, endian_swap = false);
	}

//
// #insert text. Generated from D:/dev/projects/Jerialize/example/../Jerializer.jai:93.
//
	// Deserialize
	// Plain copy
	// Struct 'Vector2'
	serialize(ctrl, *obj.x, endian_swap = false);
	serialize(ctrl, *obj.y, endian_swap = false);

//
// #insert text. Generated from D:/dev/projects/Jerialize/example/../Jerializer.jai:93.
//
	// Deserialize
	// Plain copy
	// Enum ENDIANNESS
	serialize(ctrl, cast(*u8)obj);

//
// #insert text. Generated from D:/dev/projects/Jerialize/example/../Jerializer.jai:93.
//
	// Serialize
	// Plain copy
	// [1] ARRAY
	for * <<obj 
	{
		serialize(ctrl, it, endian_swap = false);
	}

//
// #insert text. Generated from D:/dev/projects/Jerialize/example/../Jerializer.jai:93.
//
	// Deserialize
	// Plain copy
	// BaseType 'FLOAT'
	<<obj = <<(cast(*T)*(ctrl.data[ctrl.cursor]));
	ctrl.cursor += size_of(type_of(<<obj));

//
// #insert text. Generated from D:/dev/projects/Jerialize/example/../Jerializer.jai:93.
//
	// Serialize
	// Plain copy
	// [8] ARRAY
	for * <<obj 
	{
		serialize(ctrl, it, endian_swap = false);
	}

//
// #insert text. Generated from D:/dev/projects/Jerialize/example/../Jerializer.jai:93.
//
	// Serialize
	// Plain copy
	// Struct 'Monster'
	serialize(ctrl, *obj.base, endian_swap = false);
	serialize(ctrl, *obj.damage, endian_swap = false);
