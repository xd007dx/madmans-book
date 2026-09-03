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
if (insert == true && title == false && top_sprite != sFutaMatingPressAndroid)
{
    var _hud_w = 160;
    var _hud_h = 108;
    var _hud_x = 24;
    var _hud_y = display_get_gui_height() - _hud_h - 12;
    if (_hud_y < 150)
    {
        _hud_y = 240;
    }
    draw_sprite_ext(sButtonBack, 0, _hud_x + (_hud_w / 2), _hud_y + (_hud_h / 2), _hud_w / 16, _hud_h / 16, 0, c_black, 0.6);
    var _status_text = "ピストン中";
    if (orgasm == true)
    {
        _status_text = "精液注ぎ込み中";
    }
    else if (wife_climax == true)
    {
        _status_text = "★ 妻が絶頂中！ ★";
    }
    else if (sex_progress > (sex_progress_max * 0.9))
    {
        _status_text = "絶頂寸前！";
    }
    else if (sex_progress > (sex_progress_max * 0.5))
    {
        _status_text = "快感蓄積中";
    }
    var _hud_info = "◆ " + string(_status_text) + "\n";
    if (orgasm == true)
    {
        _hud_info += ("射精 #" + string(loads) + " 回目\n");
        _hud_info += ("精液放出: [" + string(round(max(0, (orgasm_pumps / orgasm_pumps_max) * 100))) + "%]\n");
        _hud_info += ("子宮容量: [" + string(round((fill_amount / fill_max) * 100)) + "%]\n");
        _hud_info += ("受精確率: " + string(round(fertility * (fill_amount / fill_max))) + "%\n");
    }
    else
    {
        _hud_info += ("ふたなり絶頂度: [" + string(round((sex_progress / sex_progress_max) * 100)) + "%]\n");
        _hud_info += ("妻の快感度: [" + string(round((wife_pleasure / wife_pleasure_threshold) * 100)) + "%] (絶頂" + string(wife_climax_counter) + "回)\n");
        _hud_info += ("挿入深度: " + string(round(25 + (25 * (1 - thrust) * top_penis_length))) + "cm\n");
    }
    _hud_info += ("肉体: 根x" + string_format(top_penis_length, 1, 1) + " 太x" + string_format(top_penis_width, 1, 1) + " 玉x" + string_format(ball_size, 1, 1) + " 胸x" + string_format(top_boob_size, 1, 1));
    draw_set_font(global.custom_font_small);
    draw_set_halign(fa_left);
    var _hud_color = (wife_climax == true) ? make_color_rgb(255, 105, 180) : 16777215;
    draw_text_color(_hud_x + 8, _hud_y + 8, _hud_info, _hud_color, _hud_color, _hud_color, _hud_color, 1);
    draw_set_font(global.custom_font_big);
    draw_set_halign(fa_center);
}
