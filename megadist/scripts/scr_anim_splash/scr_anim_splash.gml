function scr_anim_splash(){
	if (iteration < 90) {
	    iteration++;
	} else {
	    state = "demo";
	    iteration = 0;
	    delta_time_start = current_time;
	}

	surface_set_target(surf_main);
	draw_clear(c_black);
	surface_reset_target();
}