function scr_anim_intro(){
	// Next letter
	if (intro_x < 0) {
	    if (intro_tile > -1) {
	        var char = string_char_at(intro_text, intro_tile + 1);
	        if (ds_map_exists(letter_data, char)) {
	            var char_data = letter_data[? char];
	            intro_x += char_data[2];
	        }
	    }
	    intro_letter++;
	    if (intro_letter >= string_length(intro_text)) {
	        state = "splash";
	        iteration = 0;
	        return;
	    }
	    intro_tile = intro_letter;
	}
	intro_x -= intro_speed;

	// Scroll temp canvas
	surface_set_target(surf_scroll2);
	draw_clear_alpha(c_black, 0);
	draw_surface_part(surf_scroll1, intro_speed, 0, screen_width + 48 - intro_speed, font_height, 0, 0);
	surface_reset_target();

	surface_set_target(surf_scroll1);
	draw_clear_alpha(c_black, 0);
	draw_surface(surf_scroll2, 0, 0);

	// Draw letter
	var char = string_char_at(intro_text, intro_tile + 1);
	if (ds_map_exists(letter_data, char)) {
	    var char_data = letter_data[? char];
	    draw_sprite_part(spr_font, 0, char_data[0], char_data[1], char_data[2], 36, screen_width + intro_x, 0);
	}
	surface_reset_target();

	// Draw to main surface
	surface_set_target(surf_main);
	draw_clear(c_black);
	draw_surface(surf_scroll1, 0, 170);
	surface_reset_target();
}