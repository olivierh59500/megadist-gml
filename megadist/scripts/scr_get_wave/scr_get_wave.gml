function scr_get_wave(){
	var i = argument0;
	var intro_wave = argument1;
	var main_wave = argument2;

	if (i < array_length(intro_wave)) {
	    return scr_get_sum(intro_wave, i, 0);
	} else {
	    return scr_get_sum(main_wave, i - array_length(intro_wave), intro_wave[array_length(intro_wave) - 1]);
	}
}