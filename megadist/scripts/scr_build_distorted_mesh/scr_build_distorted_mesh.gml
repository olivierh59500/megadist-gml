function scr_build_distorted_mesh(){
	var vbuff = argument0;
	var surf = argument1;
	var wave_data = argument2;
	var bounce = argument3;
	var is_background = argument4;

	vertex_begin(vbuff, vf_distort);

	var tex_w = surface_get_width(surf);
	var tex_h = surface_get_height(surf);

	for (var local_y = 0; local_y < grid_height; local_y++) {
	    for (var local_x = 0; local_x < grid_width; local_x++) {
	        var x_pos = (local_x / (grid_width - 1)) * screen_width;
	        var y_pos = local_y;
        
	        // Calculate distortion
	        var distortion = 0;
	        if (local_y < array_length(wave_data)) {
	            if (is_background) {
	                distortion = wave_data[local_y] / 2;
	            } else {
	                distortion = wave_data[local_y] - letter_decal;
	            }
	        }
        
	        // Apply distortion to x position
	        var final_x = x_pos + distortion;
	        var final_y = y_pos * zoom;
        
	        // Calculate UV coordinates
	        var u = (x_pos + distortion) / tex_w;
	        var v = ((local_y + bounce) mod tex_h) / tex_h;
        
	        // For background, handle tiling
	        if (is_background) {
	            u = ((80 + floor(distortion)) mod tex_w) / tex_w + (x_pos / screen_width);
	        }
        
	        // Create quad (2 triangles)
	        if (local_x < grid_width - 1 && local_y < grid_height - 1) {
	            // Triangle 1
	            vertex_position(vbuff, final_x * zoom, final_y);
	            vertex_texcoord(vbuff, u, v);
	            vertex_color(vbuff, c_white, 1);
            
	            vertex_position(vbuff, (x_pos + distortion + (screen_width / (grid_width - 1))) * zoom, final_y);
	            vertex_texcoord(vbuff, u + (1 / (grid_width - 1)), v);
	            vertex_color(vbuff, c_white, 1);
            
	            vertex_position(vbuff, final_x * zoom, (y_pos + 1) * zoom);
	            vertex_texcoord(vbuff, u, v + (1 / tex_h));
	            vertex_color(vbuff, c_white, 1);
            
	            // Triangle 2
	            vertex_position(vbuff, (x_pos + distortion + (screen_width / (grid_width - 1))) * zoom, final_y);
	            vertex_texcoord(vbuff, u + (1 / (grid_width - 1)), v);
	            vertex_color(vbuff, c_white, 1);
            
	            vertex_position(vbuff, (x_pos + distortion + (screen_width / (grid_width - 1))) * zoom, (y_pos + 1) * zoom);
	            vertex_texcoord(vbuff, u + (1 / (grid_width - 1)), v + (1 / tex_h));
	            vertex_color(vbuff, c_white, 1);
            
	            vertex_position(vbuff, final_x * zoom, (y_pos + 1) * zoom);
	            vertex_texcoord(vbuff, u, v + (1 / tex_h));
	            vertex_color(vbuff, c_white, 1);
	        }
	    }
	}

	vertex_end(vbuff);

}