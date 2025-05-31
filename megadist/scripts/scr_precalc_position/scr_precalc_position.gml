function scr_precalc_position(){
	var i, j, count = 0, local_x = 0;
	for (i = 0; i < string_length(text); i++) {
	    var char = string_char_at(text, i + 1);
	    if (ds_map_exists(letter_data, char)) {
	        var char_data = letter_data[? char];
	        count += char_data[2];
	        position[local_x++] = count;
	    }
	}
}