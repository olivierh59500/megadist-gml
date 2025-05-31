
// Screen configuration
screen_width = 416;
screen_height = 276;
zoom = 2;

// Set up the application surface and window
surface_resize(application_surface, screen_width * zoom, screen_height * zoom);
window_set_size(screen_width * zoom, screen_height * zoom);
display_set_gui_size(screen_width * zoom, screen_height * zoom);

// Sprites dimensions (assuming already loaded)
back_height = 64;
font_height = 36;

// Surfaces
surf_main = surface_create(screen_width, screen_height);
surf_scroll = surface_create(floor(screen_width * 1.6), font_height);
surf_back = surface_create(screen_width + 8, back_height);
surf_scroll1 = -1;
surf_scroll2 = -1;

// Vertex buffers for distortion effect
vertex_format_begin();
vertex_format_add_position();
vertex_format_add_texcoord();
vertex_format_add_color();
vf_distort = vertex_format_end();

vb_background = vertex_create_buffer();
vb_scroll = vertex_create_buffer();

// Grid resolution for vertex buffer (higher = smoother distortion)
grid_width = 40;  // Number of columns
grid_height = screen_height; // One row per pixel height for accuracy

// Counters
iteration = 0;
back_wave_pos = 0;
front_wave_pos = 0;
letter_num = 0;
letter_decal = 0;
delta_time_start = current_time;

// Intro variables
intro_x = -1;
intro_letter = -1;
intro_tile = -1;
intro_speed = 4;

// State management
state = "intro"; // "intro", "splash", "demo"

// Logo sprites
nb_sprites = 10;
sprites = array_create(nb_sprites);
ctr_sprite = 0; // Counter for sprite animation
sprite_size = 32; // Assuming 32x32 sprite

// Initialize sprites
for (var i = 0; i < nb_sprites; i++) {
    sprites[i] = {
        x: screen_width / 2,
        y: screen_height / 2,
        index: i
    };
}

// Wave types
cd_zero = 0;
cd_slow_sin = 1;
cd_med_sin = 2;
cd_fast_sin = 3;
cd_slow_dist = 4;
cd_med_dist = 5;
cd_fast_dist = 6;
cd_splitted = 7;
bg_sin1 = 8;
bg_sin2 = 9;
bg_sin3 = 10;

// Wave tables
back_intro_wave_table = [cd_zero, cd_zero, cd_zero, cd_zero, cd_zero];
back_main_wave_table = [
    bg_sin1, bg_sin1, bg_sin2, bg_sin2, bg_sin3, bg_sin3,
    bg_sin1, bg_sin1, bg_sin2, bg_sin2, bg_sin3, bg_sin3,
    bg_sin1, bg_sin1, bg_sin2, bg_sin2, bg_sin3, bg_sin3,
    cd_splitted
];
front_intro_wave_table = [
    cd_zero, cd_zero, cd_zero, cd_zero, cd_zero,
    cd_zero, cd_zero, cd_zero, cd_zero, cd_zero,
    cd_fast_sin, cd_med_sin, cd_slow_sin, cd_splitted
];
front_main_wave_table = [
    cd_slow_sin, cd_slow_sin, cd_slow_dist, cd_slow_sin,
    cd_slow_sin, cd_med_sin, cd_fast_sin, cd_med_sin,
    cd_slow_sin, cd_med_dist, cd_med_sin, cd_slow_sin,
    cd_splitted
];

// Precalc arrays
curve = array_create(11);
for (var i = 0; i < 11; i++) {
    curve[i] = [];
}
back_intro_wave = [];
back_main_wave = [];
front_intro_wave = [];
front_main_wave = [];
position = [];

// Font data structure
letter_data = ds_map_create();
scr_init_font_data();

// Text content
spc = "     ";
text = spc + spc + spc +
    "BILIZIR PRESENTS HIS FIRST DEMO-SCREEN IN GML." + spc +
    "ANOTHER PARALLAX DISTORTER WILL YOU SAY ? YES ! BUT A VERY BIG ONE, DON'T YOU THINK SO ? " + spc +
    "THE CREDITS FOR THIS SCREEN : " +
    "ORIGINAL SCREEN AND IDEA BY DYNO, " +
	"CODED IN GML BY BILIZIR FROM DMA, " +
    "ORIGINAL FONT BY OXAR, " +
    "BACKGROUND BY AGENT-T CREAM, " +
    "MUSIC BY MAD MAX FROM THE EXCEPTIONS." + spc +
    "AND NOW, SOME GREETING :  " +
    "MEGA-GREETINGS TO ALL MEMBERS OF DMA AND THE UNION ! " +
    "LAST BUT NOT LEAST, I'D LIKE TO SEND A SPECIAL DEDICATION TO GAMEMAKER :) " + spc +
    "IT'S NOW TIME TO WRAP !" + spc;

intro_text = spc +
    "ONCE UPON A TIME, THERE WAS A SCREEN CALLED <THE PARALLAX DISTORTER> BY ULM.      " +
    "35 YEARS LATER,  JUST FOR FUN,  BILIZIR RECODED A VERSION IN GML (ADAPTED FROM DYNO'S VERSION) !                    ";

// Initialize everything
scr_create_curves();
scr_precalc_position();
scr_precalc_wave(front_intro_wave_table, front_intro_wave);
scr_precalc_wave(front_main_wave_table, front_main_wave);
scr_precalc_wave(back_intro_wave_table, back_intro_wave);
scr_precalc_wave(back_main_wave_table, back_main_wave);

// Prepare background surface
surface_set_target(surf_back);
draw_clear_alpha(c_black, 0);
for (var i = 0; i < surface_get_width(surf_back); i += sprite_get_width(spr_back)) {
    draw_sprite(spr_back, 0, i, 0);
}
surface_reset_target();

// Initialize intro surfaces
surf_scroll1 = surface_create(screen_width + 48, font_height);
surf_scroll2 = surface_create(screen_width + 48, font_height);

// Start music
audio_play_sound(snd_music, 0, true);

