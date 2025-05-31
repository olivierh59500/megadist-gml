function scr_display_text(){
	var letter_offset = argument0;
	surface_set_target(surf_scroll);
	draw_clear_alpha(c_black, 0);

	var x_pos = 0;
	var i = 0;
	while (x_pos < surface_get_width(surf_scroll)) {
	    var char = scr_get_letter(text, i + letter_offset);
	    if (ds_map_exists(letter_data, char)) {
	        var char_data = letter_data[? char];
	        draw_sprite_part(spr_font, 0, char_data[0], char_data[1], char_data[2], font_height, x_pos, 0);
	        x_pos += char_data[2];
	    }
	    i++;
	}
	surface_reset_target();
}