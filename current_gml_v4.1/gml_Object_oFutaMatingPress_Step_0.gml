title_scale += ((title - title_scale) * 0.1);
logo_scale += (((title_timer > 60) - logo_scale) * 0.1);
title_alpha += (((title_timer < 1 && disclaimer == false && outside_wait_timer < 900) - title_alpha) * 0.1);
disclaimer_scale += ((disclaimer - disclaimer_scale) * 0.1);
if (title == true && title_timer < 1 && outside_wait_timer < 900 && virgin == false)
{
    outside_wait_timer += 1;
    if (mouse_x_prev != mouse_x || mouse_y_prev != mouse_y)
    {
        outside_wait_timer = 0;
    }
}
stat_liters_lerp += ((stat_liters - stat_liters_lerp) * 0.1);
stat_sperm_cell_lerp += ((stat_sperm_cell - stat_sperm_cell_lerp) * 0.1);
top_dialogue_scale += (((top_dialogue_timer > 0) - top_dialogue_scale) * 0.1);
bottom_dialogue_scale += (((bottom_dialogue_timer > 0 && bottom_dialogue_delay < 1) - bottom_dialogue_scale) * 0.1);
plap_scale += ((0 - plap_scale) * 0.1);
pump_scale += ((0 - pump_scale) * 0.05);
fill_lerp += (((fill_amount + (5 * (orgasm_timer > 30))) - fill_lerp) * 0.1);
if (banner_timer > 0)
{
    banner_timer -= 1;
}
banner_scale += (((banner_timer > 0) - banner_scale) * 0.1);
if (score_combo_timer > 0)
{
    score_combo_timer -= 1;
    if (score_combo_timer < 1)
    {
        score_combo = 0;
        score_combo_mult = 0;
        ds_list_clear(score_combo_mods);
    }
}
if (insert == true)
{
    if (sex_timer > 0)
    {
        sex_timer -= 1;
    }
    else
    {
        sex_timer = 60;
        stat_total_sex_sec += 1;
    }
}
else
{
    sex_timer = 60;
}
if (stat_total_sex_sec > 60)
{
    stat_total_sex_sec -= 60;
    stat_total_sex_min += 1;
}
if (stat_total_sex_min > 60)
{
    stat_total_sex_min -= 60;
    stat_total_sex_hour += 1;
}
if (sex_progress >= sex_progress_max || keyboard_check_pressed(ord("M")))
{
    orgasm = true;
    orgasm_pumps = orgasm_pumps_max;
    orgasm_timer = 120;
    orgasm_sec_timer = 60;
    sex_progress = 0;
    slap_boost = 0;
    thrust_speed = 2;
    thrust_strength = 3;
    thrust_middle = 0.5;
    if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_16) != -1)
    {
        thrust_speed = random_range(8, 14);
        thrust_strength = 5;
    }
    stat_total_orgasms += 1;
    stat_duration = 0;
    stat_pumps = 0;
    if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_9) == -1)
    {
        stat_sperm_cell = 0;
        stat_liters_lerp = 0;
        stat_sperm_cell_lerp = 0;
        stat_liters = 0;
    }
    if (edge_boost > 2 || ((top_penis_length + top_penis_width + ball_size) / 3) > 1.2)
    {
        audio_play_sound(choose(sndWombSlosh1, sndWombSlosh2, sndWombSlosh3), 0, false, 0.75);
    }
    if (moaning == true && ds_list_find_index(pill_effects_active, UnknownEnum.Value_10) == -1)
    {
        audio_stop_sound(moan_sound);
        moan_sound = audio_play_sound(ds_list_find_value(orgasm_list, irandom(ds_list_size(orgasm_list) - 1)), 0, false, 0.5, 0, moan_pitch);
    }
    loads += 1;
    if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_5) != -1)
    {
        loads += 1;
    }
    if (loads >= max_loads)
    {
        func_add_combo_flair(func_set_lang(103, "FINAL LOAD"), 500 * max_loads);
    }
    func_top_speak("sex_orgasm");
    func_bottom_speak("sex_orgasm");
}
top_ass_jiggle_move += ((((0 - top_ass_jiggle) * (0.65 * top_ass_size)) - top_ass_jiggle_move) * 0.05);
top_ass_jiggle += top_ass_jiggle_move;
top_boob_jiggle_move += ((((0 - top_boob_jiggle) * (0.65 * top_boob_size)) - top_boob_jiggle_move) * 0.05);
top_boob_jiggle += top_boob_jiggle_move;
bottom_boob_jiggle_move += ((((0 - bottom_boob_jiggle) * 0.75) - bottom_boob_jiggle_move) * 0.05);
bottom_boob_jiggle += bottom_boob_jiggle_move;
var jiggle_amount = 0.75;
if (top_sprite == sFutaMatingPressSlime)
{
    jiggle_amount = 1.5;
}
body_jiggle_move += ((((0 - body_jiggle) * jiggle_amount) - body_jiggle_move) * 0.05);
body_jiggle += body_jiggle_move;
condom_jiggle_move += ((((0 - condom_jiggle) * 0.75) - condom_jiggle_move) * 0.05);
condom_jiggle += condom_jiggle_move;
sperm_jiggle_move += ((((0 - sperm_jiggle) * 0.75) - sperm_jiggle_move) * 0.05);
sperm_jiggle += sperm_jiggle_move;
impregnation_scale += (((impregnation_timer > 0) - impregnation_scale) * 0.1);
if (impregnation_timer > 0)
{
    impregnation_timer -= 1;
}
score_combo_scale += (((score_combo_timer > 15) - score_combo_scale) * 0.1);
if (title_timer > 0)
{
    title_timer -= 1;
    if (title_timer == 0)
    {
        insert = true;
        alarm[0] = 5;
    }
}
if (start_timer > 0)
{
    start_timer -= 1;
    if (start_timer == 0 && orgasm == false)
    {
        if (virgin == true)
        {
            tutorial = true;
        }
        else
        {
            top_dialogue_timer = 0;
            func_top_speak("intro_return");
        }
        show_debug_message("showed tutorial");
        insert = false;
        futa_score = 0;
    }
}
var cum_limit = max(500, 10000 * max_particles);
if (instance_number(oCum) > cum_limit)
{
    with (instance_find(oCum, 0))
    {
        instance_destroy();
    }
}
if (auto_sex_timer > 0)
{
    auto_sex_timer -= 1;
}
if (auto_insert == true && loads == max_loads && orgasm == false && auto_sex_timer < 1)
{
    top_dialogue_timer = 0;
    func_randomize_top();
    sex_progress = 0;
    futa_score = 0;
    loads = 0;
    body_jiggle = 0.025;
    audio_play_sound(sndCloth, 0, 0, 0.6, 0, random_range(0.8, 1.2));
    if (instance_exists(oCum))
    {
        with (oCum)
        {
            instance_destroy();
        }
    }
    if (instance_exists(oCondom))
    {
        with (oCondom)
        {
            instance_destroy();
        }
    }
    oBackground.cum = false;
    fill_amount = 0;
    impregnate = 0;
    fertilizations = 0;
    condom_broken = false;
    audio_play_sound(sndDoorOpen, 0, 0);
}
audio_master_gain(master_volume);
if (background_music != -1 && audio_is_playing(background_music))
{
    audio_sound_gain(background_music, background_music_volume, 0);
}
rpg = false;
if (oBackground.background_id == 5 || ds_list_find_index(pill_effects_active, UnknownEnum.Value_13) != -1)
{
    rpg = true;
}
var _has_color_pill = ds_list_find_index(pill_effects_active, 11) != -1 || ds_list_find_index(pill_effects_active, 21) != -1 || ds_list_find_index(pill_effects_active, 27) != -1 || ds_list_find_index(pill_effects_active, 28) != -1;
if (!_has_color_pill && top_sprite != sFutaMatingPressSlime && top_sprite != sFutaMatingPressAndroid)
{
    cum_color = 13497599;
}
if (ds_list_find_index(pill_effects_active, 20) == -1 && ds_list_find_index(pill_effects_active, 38) == -1 && (orgasm == false || ds_list_find_index(pill_effects_active, UnknownEnum.Value_16) == -1))
{
    if (slap_boost <= 0)
    {
        thrust_speed = 2;
        thrust_strength = 3;
    }
}
if (insert == true && thrust > 0.85)
{
    var _p_add = (0.6 + (thrust_speed * 0.1)) * (1 + (edge_boost * 0.2));
    if (ds_list_find_index(pill_effects_active, 19) != -1)
    {
        _p_add *= 2;
    }
    wife_pleasure += _p_add;
    if (wife_pleasure >= wife_pleasure_threshold)
    {
        wife_pleasure -= wife_pleasure_threshold;
        wife_pleasure_threshold *= 1.25;
        wife_climax = true;
        wife_climax_timer = 360;
        wife_climax_counter += 1;
        futa_score += (5000 * wife_climax_counter);
        body_jiggle = 0.05;
        bottom_ass_jiggle = 0.5;
        audio_play_sound(choose(sndMoanOrgasm1, sndMoanOrgasm2, sndMoanOrgasm3, sndMoanOrgasm5), 0, false, 0.9);
    }
}
if (wife_climax_timer > 0)
{
    wife_climax_timer -= 1;
    if (wife_climax_timer <= 0)
    {
        wife_climax = false;
    }
}
if (ds_list_size(pill_effects_active) > 0)
{
    for (var _p = 18; _p <= 40; _p++)
    {
        if (ds_list_find_index(pill_effects_unlocked, _p) == -1)
        {
            ds_list_add(pill_effects_unlocked, _p);
        }
    }
    var _has_overdose = ds_list_find_index(pill_effects_active, 19) != -1;
    if (ds_list_find_index(pill_effects_active, 8) != -1)
    {
        condom_break = 999999;
        if (_has_overdose)
        {
            condom_breaking_override = true;
        }
    }
    if (ds_list_find_index(pill_effects_active, 18) != -1)
    {
        top_ass_size = min(top_ass_size, 0.65);
        top_boob_size = min(top_boob_size, 0.65);
        ball_size = min(ball_size, 0.8);
        if (_has_overdose)
        {
            top_penis_length = max(top_penis_length, 2.8);
            top_penis_width = max(top_penis_width, 2.2);
        }
    }
    if (_has_overdose)
    {
        thrust_strength = max(thrust_strength, 8);
        if (max_loads < 30 && max_loads > 0 && loads == 0)
        {
            max_loads *= 2;
        }
        if (ds_list_find_index(pill_effects_active, 1) != -1)
        {
            ball_size = max(ball_size, 1.4);
        }
        if (ds_list_find_index(pill_effects_active, 2) != -1 || ds_list_find_index(pill_effects_active, 3) != -1)
        {
            top_penis_length = max(top_penis_length, 2.8);
            top_penis_width = max(top_penis_width, 2.2);
        }
        if (ds_list_find_index(pill_effects_active, 4) != -1)
        {
            top_boob_size = max(top_boob_size, 2.5);
            top_ass_size = max(top_ass_size, 2.5);
        }
    }
    if (ds_list_find_index(pill_effects_active, 20) != -1)
    {
        thrust_speed = _has_overdose ? 55 : 40;
        thrust_strength = 12;
        if (condom == true)
        {
            condom_jiggle = 0.2;
        }
    }
    if (ds_list_find_index(pill_effects_active, 21) != -1)
    {
        cum_color = make_color_rgb(255, 215, 0);
        futa_score += (_has_overdose ? 4 : 2);
        if (condom == true)
        {
            condom_color = merge_color(condom_color, cum_color, 0.5);
        }
    }
    if (ds_list_find_index(pill_effects_active, 22) != -1)
    {
        lactate = true;
        top_boob_jiggle += (_has_overdose ? 0.4 : 0.2);
    }
    if (ds_list_find_index(pill_effects_active, 23) != -1)
    {
        if (_has_overdose)
        {
            edge_boost = 10;
        }
        else
        {
            edge_boost = min(10, edge_boost);
        }
    }
    if (ds_list_find_index(pill_effects_active, 24) != -1)
    {
        fill_max = 500;
    }
    if (ds_list_find_index(pill_effects_active, 25) != -1)
    {
        if (insert == true)
        {
            fill_amount += (_has_overdose ? 4 : 2);
            fill_lerp = fill_amount + 5;
        }
        else if (irandom(12) == 0)
        {
            func_cum_splurt(false);
        }
    }
    if (ds_list_find_index(pill_effects_active, 26) != -1 && insert == true && orgasm == true)
    {
        if (condom == true)
        {
            condom_broken = true;
            condom = false;
            audio_play_sound(choose(sndCumSplurt1, sndCumSplurt2), 0, false, 0.9);
        }
        impregnate = 1;
        impregnation_timer = 120;
    }
    if (ds_list_find_index(pill_effects_active, 27) != -1)
    {
        cum_color = make_color_rgb(255, 69, 0);
        if (insert == true)
        {
            sex_progress += (_has_overdose ? 1.2 : 0.6);
        }
        if (condom == true)
        {
            condom_color = merge_color(condom_color, cum_color, 0.5);
        }
    }
    if (ds_list_find_index(pill_effects_active, 28) != -1)
    {
        cum_color = make_color_rgb(0, 255, 230);
        if (condom == true)
        {
            condom_color = merge_color(condom_color, cum_color, 0.5);
        }
    }
    if (ds_list_find_index(pill_effects_active, 29) != -1)
    {
        top_penis_length = max(top_penis_length, _has_overdose ? 2.8 : 2.5);
        top_penis_width = max(top_penis_width, _has_overdose ? 2.2 : 1.8);
    }
    if (ds_list_find_index(pill_effects_active, 30) != -1 && orgasm == true)
    {
        futa_score += (_has_overdose ? 7777 : 777);
    }
    if (ds_list_find_index(pill_effects_active, 31) != -1 && orgasm == true && orgasm_timer > 5)
    {
        orgasm_timer -= (_has_overdose ? 3 : 2);
    }
    if (ds_list_find_index(pill_effects_active, 32) != -1 && impregnate > 0)
    {
        fertilizations = max(fertilizations, 4);
    }
    if (ds_list_find_index(pill_effects_active, 33) != -1)
    {
        if (loads >= max_loads)
        {
            max_loads += (_has_overdose ? 10 : 5);
        }
    }
    if (ds_list_find_index(pill_effects_active, 36) != -1)
    {
        condom_break = 999999;
        condom_integrity = 100;
        if (_has_overdose)
        {
            condom_breaking_override = true;
        }
    }
    if (ds_list_find_index(pill_effects_active, 38) != -1)
    {
        thrust_strength = _has_overdose ? 35 : 20;
        thrust_speed = max(thrust_speed, 3);
    }
}

enum UnknownEnum
{
    Value_5 = 5,
    Value_9 = 9,
    Value_10,
    Value_13 = 13,
    Value_16 = 16
}
