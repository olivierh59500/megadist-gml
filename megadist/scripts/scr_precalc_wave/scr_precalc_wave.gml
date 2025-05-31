function scr_precalc_wave(){
	var src_wave_table = argument0;
	var dst_wave_table = argument1;
	var t, i, wave, count = 0;

	for (t = 0; t < array_length(src_wave_table); t++) {
	    wave = curve[src_wave_table[t]];
	    for (i = 0; i < array_length(wave); i++) {
	        count += wave[i];
	        array_push(dst_wave_table, count);
	    }
	}
}