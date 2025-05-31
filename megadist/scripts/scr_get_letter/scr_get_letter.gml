function scr_get_letter(){
	var str = argument0;
	var pos = argument1;
	var char = string_char_at(str, (pos mod string_length(str)) + 1);
	return char;
}