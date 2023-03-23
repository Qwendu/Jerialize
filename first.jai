


#run
{
	set_build_options_dc(.{do_output = false});
	
	w:= compiler_create_workspace("Demo program");
	if !w 
	{
		print("Failed to create workspace\n");
		return;
	}
	
	options := get_build_options(w);
	options.output_executable_name = "demo";
	set_build_options(options, w);
	

	compiler_begin_intercept(w, .SKIP_ALL & ~Intercept_Flags.SKIP_OTHERS);
	add_build_file(tprint("%src/main.jai", #filepath), w);
	while true
	{
		msg := compiler_wait_for_message();
		if msg.kind == .COMPLETE  break;
		if msg.kind == .FAILED_IMPORT
		{
			mf := cast(*Message_Failed_Import)msg;
			if mf.status == .NOT_FOUND && mf.target_module_name == "Jerializer"
			{

				provide_import(w, mf, .PATH_TO_DIRECTORY, tprint("%src/modules/Jerializer", #filepath));
			}


		}
	}
	compiler_end_intercept(w);


};

#import "Compiler";
#import "Basic";
