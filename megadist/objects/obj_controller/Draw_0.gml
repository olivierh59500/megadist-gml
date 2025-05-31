// Option 1: Traditional line-by-line rendering (original method)
 draw_surface_ext(surf_main, 0, 0, zoom, zoom, 0, c_white, 1);
/*
// Option 2: Vertex buffer rendering (smoother distortion)
if (state == "demo") {
    // Draw distorted surfaces using vertex buffers
    shader_set(shd_texture); // Use default texture shader or create custom
    vertex_submit(vb_background, pr_trianglelist, surface_get_texture(surf_back));
    vertex_submit(vb_scroll, pr_trianglelist, surface_get_texture(surf_scroll));
    shader_reset();
} else {
    // Simple scaled drawing for intro/splash
    draw_surface_ext(surf_main, 0, 0, zoom, zoom, 0, c_white, 1);
}
*/
