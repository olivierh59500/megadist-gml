function scr_get_position(){
	var i = argument0;
	if (i > 0) {
	    return scr_get_sum(position, i - 1, 0);
	} else {
	    return 0;
	}
}