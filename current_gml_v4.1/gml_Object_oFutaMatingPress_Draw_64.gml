if (global.palette > 0)
{
    application_surface_draw_enable(false);
    scrSetPalette(global.palette);
    draw_surface_ext(application_surface, 0, 0, 1, 1, 0, c_white, 1);
    shader_reset();
}
else
{
    application_surface_draw_enable(true);
}
