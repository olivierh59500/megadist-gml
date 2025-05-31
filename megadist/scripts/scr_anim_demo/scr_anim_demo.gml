function scr_anim_demo(){
	var decal_x, ligne, c, i, dir, scroll_x, back_x, bounce_back, bounce_front;

	// Bounce value
	bounce_back = floor(abs(30.1 * sin(degtorad((iteration mod 42) * 4.26))));
	bounce_front = floor(abs(18.1 * sin(degtorad((iteration mod 42) * 4.26))));

	// Calc decal_x
	decal_x = 999999999;
	for (ligne = 0; ligne < screen_height; ligne++) {
	    c = scr_get_wave(front_wave_pos + ligne, front_intro_wave, front_main_wave);
	    if (c < decal_x) {
	        decal_x = max(0, c);
	    }
	}

	// Calc first letter
	i = 0;
	dir = 0;
	if (decal_x > letter_decal) {
	    dir = 1;
	} else if (decal_x < letter_decal) {
	    dir = -1;
	}

	while (decal_x < scr_get_position(letter_num + i) || scr_get_position(letter_num + i + 1) <= decal_x) {
	    i += dir;
	}
	letter_num += i;
	letter_decal = scr_get_position(letter_num);

	// Display text
	scr_display_text(letter_num);

	// Option 1: Traditional line-by-line rendering (original method)
	surface_set_target(surf_main);
	draw_clear_alpha(c_black, 0);

	for (ligne = 0; ligne < screen_height; ligne++) {
	    // Background
	    back_x = (80 + floor(scr_get_wave(back_wave_pos + ligne, back_intro_wave, back_main_wave) / 2)) mod sprite_get_width(spr_back);
	    draw_surface_part(surf_back, back_x, (ligne + bounce_back) mod back_height, screen_width, 1, 0, ligne);
    
	    // Scroll
	    scroll_x = scr_get_wave(front_wave_pos + ligne, front_intro_wave, front_main_wave) - letter_decal;
	    draw_surface_part(surf_scroll, scroll_x, (ligne + bounce_front) mod font_height, screen_width, 1, 0, ligne);
	}

	// Draw logo sprites
	scr_update_sprites();
	for (var s = 0; s < nb_sprites; s++) {
	    draw_sprite(spr_logo, 0, sprites[s].x - sprite_size/2, sprites[s].y - sprite_size/2);
	}

	surface_reset_target();
/*
	// Option 2: Build vertex buffers for distortion (smoother but more complex)
	// Uncomment to use vertex buffer rendering
	
	// Calculate wave arrays for current frame
	var back_waves = array_create(screen_height);
	var front_waves = array_create(screen_height);
	for (var local_y = 0; local_y < screen_height; local_y++) {
	    back_waves[local_y] = scr_get_wave(back_wave_pos + local_y, back_intro_wave, back_main_wave);
	    front_waves[local_y] = scr_get_wave(front_wave_pos + local_y, front_intro_wave, front_main_wave);
	}

	// Build distorted meshes
	vertex_clear(vb_background);
	scr_build_distorted_mesh(vb_background, surf_back, back_waves, bounce_back, true);

	vertex_clear(vb_scroll);
	scr_build_distorted_mesh(vb_scroll, surf_scroll, front_waves, bounce_front, false);
*/	

	// Next frame
	var delta = (current_time - delta_time_start) / 1000 * 60;
	iteration = floor(delta);
	back_wave_pos = iteration * 5;
	front_wave_pos = iteration * 10;

	// Update sprite counter
	ctr_sprite += 0.02; // Adjust speed as needed

}