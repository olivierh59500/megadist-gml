function scr_update_sprites(){
	// Update positions for all sprites based on their trajectories
	for (var i = 0; i < nb_sprites; i++) {
	    var local_sprite_index = i;
	    var c = ctr_sprite + local_sprite_index * 0.155; // Increment per sprite
    
	    // Center around screen center
	    var center_x = screen_width / 2;
	    var center_y = screen_height / 2;
    
	    // Calculate position with reduced amplitudes to stay in screen
	    var pos_x = center_x + 100 * sin(c * 1.35 + 1.25) + 100 * sin(c * 1.86 + 0.54);
	    var pos_y = center_y + 60 * cos(c * 1.72 + 0.23) + 60 * cos(c * 1.63 + 0.98);
    
	    // Adjustment per sprite
	    pos_x += 20 * sin(local_sprite_index * 0.289 + 1.15);
	    pos_y += 20 * cos(local_sprite_index * 0.456 + 0.85);
    
	    // Limit positions to avoid going off-screen (sprite 32x32)
	    var half_size = sprite_size / 2;
	    if (pos_x < half_size) {
	        pos_x = half_size;
	    } else if (pos_x > screen_width - half_size) {
	        pos_x = screen_width - half_size;
	    }
    
	    if (pos_y < half_size) {
	        pos_y = half_size;
	    } else if (pos_y > screen_height - half_size) {
	        pos_y = screen_height - half_size;
	    }
    
	    // Update sprite position
	    sprites[i].x = pos_x;
	    sprites[i].y = pos_y;
	}
}