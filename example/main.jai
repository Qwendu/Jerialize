#import "Math";
#import "Basic";
#import "Compiler";
#import "String";
#import,file "../Jerializer.jai";


Manager :: struct
{
	baba : int = 0x0807060504030201;
	bababuyi : [8] u8 = .[1,2,3,4,5,6,7,8];
	monsters : [1] Monster;
	entities : [1] Entity; @JerializeVersion(3)
	// p : *int; // Currently not supporting pointers
};

Entity :: struct 
{
	position : Vector2; 
	health : int; @JerializeVersion(6)
	max_health : int; @JerializeVersion(5)
};
Monster :: struct
{
	using #as base : Entity;
	damage : int; @AddedIn(1,0)
};

main :: () 
{
	manager : Manager;

	serialized := jerialize(*manager);
	print("Result :\n");
	print_String_As_Hex(serialized);

	serialized_big_endian := jerialize(*manager, endian = .BIG);
	print("Result :\n");
	print_String_As_Hex(serialized_big_endian);

	
	print("deserializing\n");
	baby : Manager = ---;
	baby_big_endian : Manager = --- ;
	dejerialize(*baby, source = serialized);
	dejerialize(*baby_big_endian, source = serialized_big_endian);
	
	assert(baby.baba == baby_big_endian.baba);
	assert(baby.bababuyi[2] == baby_big_endian.bababuyi[2]);

	print("manager = %\nbaby = %\nbaby_big_endian = %\n", manager, baby, baby_big_endian);
}

//#run main();

print_String_As_Hex :: (data : string)
{
	address_digits := 0;
	ci := data.count;
	while ci > 0
	{
		ci = ci / 16;
		address_digits += 1;
	}
	print("Total length = %\n", formatInt(data.count, base=10));
	
	print("  ");
	for 0..address_digits  print(" ");
	for 0..15
	{
		
		if it > 0 && it % 4 == 0  print(" ");
		if it > 0 && it % 8 == 0  print(" ");
		print(" +%", formatInt(it, base = 16, minimum_digits = 1));
	}
	print("\n");
	for row : 0..((data.count - 1)/16)
	{
		start := row * 16;
		end   := min(data.count - 1, start + 15);

		print("0x%|", formatInt(start, base=16, minimum_digits = address_digits));
		for col : start..end 
		{
			idx := col - start;
			if idx > 0 && idx % 4 == 0  print(" ");
			if idx > 0 && idx % 8 == 0  print(" ");
			print(" %", formatInt(data[col], base = 16, minimum_digits = 2));
		}
		for col:end..start+15
		{
			idx := col - start;
			if idx > 0 && idx % 4 == 0  print(" ");
			if idx > 0 && idx % 8 == 0  print(" ");
			print("   ");
		}
		print(" |");
		for col : start..end
		{
			c := data[col];
			printable := ifx #char " " <= c && c <= #char "~" then c else #char "."
			print_character(printable);
		}

		print("\n");
	}
	print("\n\n");
}
