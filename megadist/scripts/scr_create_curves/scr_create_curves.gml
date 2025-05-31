function scr_create_curves(){

	var func, step, progress, i, c, decal, previous, local, nitem;

	// Helper function to create a single curve
	for (var func_type = 0; func_type <= 10; func_type++) {
	    switch (func_type) {
	        case cd_zero:     step = 2.25; progress = 0; break;
	        case cd_slow_sin: step = 0.20; progress = 140; break;
	        case cd_med_sin:  step = 0.25; progress = 175; break;
	        case cd_fast_sin: step = 0.30; progress = 210; break;
	        case cd_slow_dist: step = 0.12; progress = 175; break;
	        case cd_med_dist: step = 0.16; progress = 210; break;
	        case cd_fast_dist: step = 0.20; progress = 245; break;
	        case cd_splitted: step = 0.18; progress = 0; break;
	        case bg_sin1: step = 0.50; progress = 0; break;
	        case bg_sin2: step = 0.80; progress = 0; break;
	        case bg_sin3: step = 0.50; progress = 0; break;
	    }
    
	    local = [];
	    decal = 0;
	    previous = 0;
	    c = 0;
    
	    var max_angle = (func_type == cd_splitted) ? 720 : 360;
    
	    for (i = 0; i < max_angle - step; i += step) {
	        var val = 0;
	        switch (func_type) {
	            case cd_zero:     val = 0; break;
	            case cd_slow_sin: val = 100 * sin(degtorad(i)); break;
	            case cd_med_sin:  val = 110 * sin(degtorad(i)); break;
	            case cd_fast_sin: val = 120 * sin(degtorad(i)); break;
	            case cd_slow_dist:
	                val = 100 * sin(degtorad(i)) + 25.0 * sin(degtorad(i * 10));
	                break;
	            case cd_med_dist:
	                val = 110 * sin(degtorad(i)) + 27.5 * sin(degtorad(i * 9));
	                break;
	            case cd_fast_dist:
	                val = 120 * sin(degtorad(i)) + 30.0 * sin(degtorad(i * 8));
	                break;
	            case cd_splitted:
	                var dir = (c mod 2 == 0) ? 1 : -1;
	                var amp = 12;
	                if (i < 160) {
	                    amp *= i / 160;
	                } else if ((720 - 160) < i) {
	                    amp *= (720 - i) / 160;
	                }
	                val = 90 * sin(degtorad(i)) + dir * amp * sin(degtorad(i * 3));
	                break;
	            case bg_sin1: val = -60 * sin(degtorad(i)); break;
	            case bg_sin2: val = -60 * sin(degtorad(i)); break;
	            case bg_sin3: val = -60 * sin(degtorad(i)) - 15 * sin(degtorad(i * 4)); break;
	        }
	        local[c] = val;
	        c++;
	    }
    
	    curve[func_type] = [];
	    for (i = 0; i < array_length(local); i++) {
	        nitem = -floor(local[i] - decal);
	        curve[func_type][i] = nitem - previous;
	        previous = nitem;
	        decal += progress / array_length(local);
	    }
	}

}