surface_free(surf_main);
surface_free(surf_scroll);
surface_free(surf_back);
if (surface_exists(surf_scroll1)) surface_free(surf_scroll1);
if (surface_exists(surf_scroll2)) surface_free(surf_scroll2);
ds_map_destroy(letter_data);
vertex_delete_buffer(vb_background);
vertex_delete_buffer(vb_scroll);
vertex_format_delete(vf_distort);
