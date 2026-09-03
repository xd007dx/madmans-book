using System;
using System.IO;
using UndertaleModLib;
using UndertaleModLib.Models;
using UndertaleModLib.Compiler;

EnsureDataLoaded();

ScriptMessage("=== APPLYING MASTER V3.2 PATCH (ALL 33 OVERDOSE SYNERGIES FULLY CODED) ===");

var createCode = Data.Code.ByName("gml_Object_oFutaMatingPress_Create_0");
var stepCode = Data.Code.ByName("gml_Object_oFutaMatingPress_Step_0");
var drawCode = Data.Code.ByName("gml_Object_oFutaMatingPress_Draw_0");
var draw64Code = Data.Code.ByName("gml_Object_oFutaMatingPress_Draw_64");

if (createCode == null || stepCode == null || drawCode == null || draw64Code == null)
{
    ScriptError("Required code objects not found!");
    return;
}

CodeImportGroup group = new(Data)
{
    AutoCreateAssets = true,
    MainThreadAction = MainThreadAction
};

// =============================================================
// 1. Create_0: Limits 3x, Rating 10x, func_set_lang fix & func_set_pill_effect (ALL 34 PILLS + OVERDOSE)
// =============================================================
ScriptMessage("[1/5] Patching Create_0 max limits, rating 10x, func_set_lang & func_set_pill_effect for all 34 pills...");

for (int i = 7840; i < Math.Min(createCode.Instructions.Count, 7880); i++)
{
    var inst = createCode.Instructions[i];
    if (inst.Kind == UndertaleInstruction.Opcode.Push && inst.Type1 == UndertaleInstruction.DataType.Double)
    {
        if (Math.Abs(inst.ValueDouble - 1.5) < 0.01)
        {
            inst.ValueDouble = 3.0;
        }
        else if (Math.Abs(inst.ValueDouble - 1.4) < 0.01)
        {
            inst.ValueDouble = 2.8;
        }
    }
}

string oldRatingFuncGml = @"function func_get_rating(arg0)
{
    var rating_numb = 0;
    if (arg0 >= 0.9)
    {
        rating_numb = 1;
    }
    if (arg0 >= 1)
    {
        rating_numb = 2;
    }
    if (arg0 >= 1.05)
    {
        rating_numb = 3;
    }
    if (arg0 >= 1.1)
    {
        rating_numb = 4;
    }
    if (arg0 >= 1.2)
    {
        rating_numb = 5;
    }
    if (arg0 >= 1.25)
    {
        rating_numb = 6;
    }
    return rating_numb;
}";

string newRatingFuncGml = @"function func_get_rating(arg0)
{
    var rating_numb = 0;
    if (arg0 >= 0.7) rating_numb = 1;
    if (arg0 >= 0.9) rating_numb = 2;
    if (arg0 >= 1.0) rating_numb = 3;
    if (arg0 >= 1.1) rating_numb = 4;
    if (arg0 >= 1.25) rating_numb = 5;
    if (arg0 >= 1.5) rating_numb = 6;
    if (arg0 >= 1.8) rating_numb = 7;
    if (arg0 >= 2.2) rating_numb = 8;
    if (arg0 >= 2.5) rating_numb = 9;
    if (arg0 >= 2.8) rating_numb = 10;
    return rating_numb;
}";

group.QueueFindReplace(createCode, oldRatingFuncGml, newRatingFuncGml);

string oldFuncSetLang = @"function func_set_lang(arg0, arg1)
{
    var string_set = arg1;
    if (language_text != -1 && is_array(language_text) == true && array_length(language_text) > arg0)
    {
        string_set = string_trim_end(array_get(language_text, arg0 - 1));
    }
    return string_set;
}";

string newFuncSetLang = @"function func_set_lang(arg0, arg1)
{
    var string_set = arg1;
    if (language_text != -1 && is_array(language_text) == true && array_length(language_text) >= arg0)
    {
        string_set = string_trim_end(array_get(language_text, arg0 - 1));
    }
    return string_set;
}";

group.QueueFindReplace(createCode, oldFuncSetLang, newFuncSetLang);

// COMPLETE FUNC_SET_PILL_EFFECT WITH OVERDOSE SCALING FOR ALL 34 PILLS
string oldPillEffectFunc = @"function func_set_pill_effect(arg0)
{
    for (var i = 0; i < 12; i++)
    {
        sperm[i] = 0;
        sperm_speed[i] = 0;
    }
    sex_progress = 0;
    sex_progress_max = 50;
    switch (arg0)
    {
        case UnknownEnum.Value_1:
            body_jiggle = 0.025;
            balls_jiggle = 0.4;
            ball_size *= 1.5;
            orgasm_pumps_max *= 1.5;
            audio_play_sound(choose(sndCumInside1, sndCumInside2, sndCumInside3, sndCumInside4), 0, false, 0.15, 0, 1);
            for (var i = 0; i < 12; i++)
            {
                sperm[i] = 0;
                sperm_speed[i] = 0;
            }
            break;
        case UnknownEnum.Value_10:
            body_jiggle = 0.025;
            balls_jiggle = 0.2;
            ball_size *= 1.3;
            top_penis_length *= 0.9;
            top_penis_width *= 0.9;
            orgasm_pumps_max = 3;
            sex_progress_max = 20;
            max_loads *= 2;
            audio_play_sound(choose(sndCumInside1, sndCumInside2, sndCumInside3, sndCumInside4), 0, false, 0.15, 0, 1);
            audio_play_sound(choose(sndSlosh1, sndSlosh2, sndSlosh3), 0, false, 0.5);
            break;
        case UnknownEnum.Value_16:
            body_jiggle = 0.025;
            orgasm_pumps_max *= 0.75;
            sex_progress_max = 20;
            max_loads *= 5;
            break;
        case UnknownEnum.Value_11:
            body_jiggle = 0.025;
            var hue = irandom(255);
            if (color_get_saturation(top_skin) > 0)
            {
                hue = color_get_hue(top_skin);
            }
            if (color_get_saturation(top_hair) > 0)
            {
                hue = color_get_hue(top_hair);
            }
            var temp_color = -1;
            for (var j = 0; j < 5; j++)
            {
                temp_color[j] = make_color_hsv((hue + random_range(-15, 15)) % 255, 0 + (30 * j), 255 - (25 * j));
            }
            temp_color = array_shuffle(temp_color);
            top_skin = temp_color[0];
            top_hair = temp_color[1];
            cum_color = temp_color[2];
            bottom_skin = temp_color[3];
            egg_color = temp_color[4];
            break;
        case UnknownEnum.Value_9:
            body_jiggle = 0.025;
            balls_jiggle = 0.2;
            ball_size *= 1.2;
            orgasm_pumps_max *= 1.5;
            audio_play_sound(choose(sndCumInside1, sndCumInside2, sndCumInside3, sndCumInside4), 0, false, 0.15, 0, 1);
            if (condom == true)
            {
                condom_size = min(3, stat_liters / 5) + 0.1;
                condom_jiggle = 0.1;
                condom_size = min(3, condom_size);
            }
            else
            {
                func_cum_splurt(false);
                audio_play_sound(choose(sndCumSplurt1, sndCumSplurt2, sndCumSplurt3), 0, false, 0.5, 0, random_range(0.9, 1.1));
            }
            break;
        case UnknownEnum.Value_2:
        case UnknownEnum.Value_3:
            top_penis_length *= 1.2;
            top_penis_width *= 1.2;
            ball_size *= 1.2;
            orgasm_pumps_max *= 1.2;
            max_loads += 2;
            body_jiggle = 0.025;
            balls_jiggle = 0.2;
            break;
        case UnknownEnum.Value_4:
            if (top_boob_size < 1)
            {
                top_boob_size = 1;
            }
            top_boob_size *= 1.1;
            top_ass_size *= 1.1;
            top_boob_jiggle += 0.2;
            top_ass_jiggle += 0.2;
            body_jiggle = 0.025;
            lactate = true;
            if (custom_lover_selected == -1)
            {
                alt_boobs = choose(0, 1, 2);
            }
            break;
        case UnknownEnum.Value_5:
            orgasm_pumps_max *= 1.3;
            max_loads *= 2;
            body_jiggle = 0.025;
            balls_jiggle = 0.2;
            break;
        case UnknownEnum.Value_6:
            body_jiggle = 0.025;
            impregnation_timer = 120;
            sperm_jiggle = 0.15;
            impregnate = 0;
            break;
        case UnknownEnum.Value_12:
            body_jiggle = 0.025;
            break;
        case UnknownEnum.Value_8:
            sex_progress_max = 150;
            orgasm_pumps_max *= 1.5;
            max_loads *= 5;
            body_jiggle = 0.025;
            break;
        case UnknownEnum.Value_15:
            orgasm_pumps_max *= 3;
            max_loads = 1;
            body_jiggle = 0.025;
            break;
        case UnknownEnum.Value_7:
            balls_jiggle = 0.3;
            ball_size = 1.4;
            top_penis_length = 1.4;
            top_penis_width = 1.4;
            orgasm_pumps_max = 40 * (top_penis_length * top_penis_width);
            max_loads = 999;
            audio_play_sound(choose(sndCumInside1, sndCumInside2, sndCumInside3, sndCumInside4), 0, false, 0.15, 0, 1);
            if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_6) == -1)
            {
                ds_list_add(pill_effects_active, UnknownEnum.Value_6);
            }
            if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_1) == -1)
            {
                ds_list_add(pill_effects_active, UnknownEnum.Value_1);
            }
            break;
    }
}";

string newPillEffectFunc = @"function func_set_pill_effect(arg0)
{
    for (var i = 0; i < 12; i++)
    {
        sperm[i] = 0;
        sperm_speed[i] = 0;
    }
    sex_progress = 0;
    sex_progress_max = 50;
    var _has_od = (ds_list_find_index(pill_effects_active, 19) != -1) || (arg0 == 19);
    switch (arg0)
    {
        case UnknownEnum.Value_1:
            body_jiggle = 0.025;
            balls_jiggle = 0.4;
            ball_size *= _has_od ? 2.5 : 1.5;
            orgasm_pumps_max *= _has_od ? 3.0 : 1.5;
            audio_play_sound(choose(sndCumInside1, sndCumInside2, sndCumInside3, sndCumInside4), 0, false, 0.15, 0, 1);
            break;
        case UnknownEnum.Value_10:
            body_jiggle = 0.025;
            balls_jiggle = 0.2;
            ball_size *= 1.3;
            top_penis_length *= 0.9;
            top_penis_width *= 0.9;
            orgasm_pumps_max = 3;
            sex_progress_max = _has_od ? 10 : 20;
            max_loads *= _has_od ? 5 : 2;
            audio_play_sound(choose(sndCumInside1, sndCumInside2, sndCumInside3, sndCumInside4), 0, false, 0.15, 0, 1);
            audio_play_sound(choose(sndSlosh1, sndSlosh2, sndSlosh3), 0, false, 0.5);
            break;
        case UnknownEnum.Value_16:
            body_jiggle = 0.025;
            orgasm_pumps_max *= 0.75;
            sex_progress_max = 20;
            max_loads *= _has_od ? 10 : 5;
            break;
        case UnknownEnum.Value_11:
            body_jiggle = 0.025;
            var hue = irandom(255);
            if (color_get_saturation(top_skin) > 0) hue = color_get_hue(top_skin);
            if (color_get_saturation(top_hair) > 0) hue = color_get_hue(top_hair);
            var temp_color = -1;
            for (var j = 0; j < 5; j++) temp_color[j] = make_color_hsv((hue + random_range(-15, 15)) % 255, 0 + (30 * j), 255 - (25 * j));
            temp_color = array_shuffle(temp_color);
            top_skin = temp_color[0];
            top_hair = temp_color[1];
            cum_color = temp_color[2];
            bottom_skin = temp_color[3];
            egg_color = temp_color[4];
            break;
        case UnknownEnum.Value_9:
            body_jiggle = 0.025;
            balls_jiggle = 0.2;
            ball_size *= 1.2;
            orgasm_pumps_max *= _has_od ? 2.5 : 1.5;
            audio_play_sound(choose(sndCumInside1, sndCumInside2, sndCumInside3, sndCumInside4), 0, false, 0.15, 0, 1);
            if (condom == true)
            {
                condom_size = min(3, stat_liters / 5) + 0.1;
                condom_jiggle = 0.1;
                condom_size = min(3, condom_size);
            }
            else
            {
                func_cum_splurt(false);
                audio_play_sound(choose(sndCumSplurt1, sndCumSplurt2, sndCumSplurt3), 0, false, 0.5, 0, random_range(0.9, 1.1));
            }
            break;
        case UnknownEnum.Value_2:
        case UnknownEnum.Value_3:
            top_penis_length *= _has_od ? 1.5 : 1.2;
            top_penis_width *= _has_od ? 1.5 : 1.2;
            ball_size *= _has_od ? 1.5 : 1.2;
            orgasm_pumps_max *= _has_od ? 2.0 : 1.2;
            max_loads += _has_od ? 5 : 2;
            body_jiggle = 0.025;
            balls_jiggle = 0.2;
            break;
        case UnknownEnum.Value_4:
            if (top_boob_size < 1) top_boob_size = 1;
            top_boob_size *= _has_od ? 1.3 : 1.1;
            top_ass_size *= _has_od ? 1.3 : 1.1;
            top_boob_jiggle += 0.2;
            top_ass_jiggle += 0.2;
            body_jiggle = 0.025;
            lactate = true;
            if (custom_lover_selected == -1) alt_boobs = choose(0, 1, 2);
            break;
        case UnknownEnum.Value_5:
            orgasm_pumps_max *= _has_od ? 2.0 : 1.3;
            max_loads *= _has_od ? 4 : 2;
            body_jiggle = 0.025;
            balls_jiggle = 0.2;
            break;
        case UnknownEnum.Value_6:
            body_jiggle = 0.025;
            impregnation_timer = _has_od ? 300 : 120;
            sperm_jiggle = 0.15;
            impregnate = 0;
            break;
        case UnknownEnum.Value_12:
            body_jiggle = 0.025;
            break;
        case UnknownEnum.Value_8:
            sex_progress_max = _has_od ? 250 : 150;
            orgasm_pumps_max *= _has_od ? 2.5 : 1.5;
            max_loads *= _has_od ? 10 : 5;
            body_jiggle = 0.025;
            break;
        case UnknownEnum.Value_15:
            orgasm_pumps_max *= _has_od ? 5 : 3;
            max_loads = 1;
            body_jiggle = 0.025;
            break;
        case UnknownEnum.Value_7:
            balls_jiggle = 0.3;
            ball_size = 1.4;
            top_penis_length = 1.4;
            top_penis_width = 1.4;
            orgasm_pumps_max = 40 * (top_penis_length * top_penis_width);
            max_loads = 999;
            thrust_strength = _has_od ? 8 : 3;
            audio_play_sound(choose(sndCumInside1, sndCumInside2, sndCumInside3, sndCumInside4), 0, false, 0.15, 0, 1);
            if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_6) == -1) ds_list_add(pill_effects_active, UnknownEnum.Value_6);
            if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_1) == -1) ds_list_add(pill_effects_active, UnknownEnum.Value_1);
            break;
        case 18:
            top_ass_size = 0.65;
            top_boob_size = 0.65;
            ball_size = 0.8;
            break;
        case 19:
            thrust_strength = 8;
            max_loads = max(max_loads * 2, 6);
            break;
        case 20:
            thrust_speed = _has_od ? 55 : 40;
            thrust_strength = 12;
            break;
        case 21:
            cum_color = make_color_rgb(255, 215, 0);
            futa_score += _has_od ? 4 : 2;
            break;
        case 22:
            lactate = true;
            top_boob_jiggle += 0.2;
            break;
        case 23:
            edge_boost = min(10, edge_boost);
            break;
        case 24:
            fill_max = 500;
            break;
        case 26:
            impregnate = 1;
            impregnation_timer = 120;
            break;
        case 27:
            cum_color = make_color_rgb(255, 69, 0);
            break;
        case 28:
            cum_color = make_color_rgb(0, 255, 230);
            break;
        case 29:
            top_penis_length = _has_od ? 2.8 : 2.5;
            top_penis_width = _has_od ? 2.2 : 1.8;
            break;
        case 32:
            fertilizations = 4;
            break;
        case 33:
            max_loads += _has_od ? 10 : 5;
            break;
    }
}";

group.QueueFindReplace(createCode, oldPillEffectFunc, newPillEffectFunc);

string createApexGml = @"
wife_climax_counter = 0;
wife_climax = false;
wife_climax_timer = 0;
wife_pleasure = 0;
wife_pleasure_max = 100;
wife_pleasure_threshold = 100;

custom_clench_toggle = true;
custom_bc_mating_press = [-1, -1, -1, -1, -1];
custom_bc_cowgirl = [-1, -1, -1, -1, -1];
custom_bc_loaded = false;

var _clench_dir = working_directory + ""clench_sprites/"";
if (file_exists(_clench_dir + ""sBallsClenching.png""))
{
    global.sBallsClenching = sprite_add(_clench_dir + ""sBallsClenching.png"", 5, false, false, 20, 3);
    global.sBallsClenchingCow = sprite_add(_clench_dir + ""sBallsClenchingCow.png"", 5, false, false, 20, 3);
    global.sBallsClenchingDeepthroat = sprite_add(_clench_dir + ""sBallsClenchingDeepthroat.png"", 5, false, false, 20, 3);
    global.sBallsClenchingAndroid = sprite_add(_clench_dir + ""sBallsClenchingAndroid.png"", 5, false, false, 20, 3);
    global.sBallsClenchingCowSlime = sprite_add(_clench_dir + ""sBallsClenchingCowSlime.png"", 5, false, false, 20, 3);
    global.sBallsClenchingDeepthroatAndroid = sprite_add(_clench_dir + ""sBallsClenchingDeepthroatAndroid.png"", 5, false, false, 20, 3);
    global.sBallsClenchingDeepthroatSlime = sprite_add(_clench_dir + ""sBallsClenchingDeepthroatSlime.png"", 5, false, false, 20, 3);
    global.sBallsClenchingSlime = sprite_add(_clench_dir + ""sBallsClenchingSlime.png"", 5, false, false, 20, 3);
    global.sBallsClenchingCowAndroid = sprite_add(_clench_dir + ""sBallsClenchingCowAndroid.png"", 5, false, false, 20, 3);
}

var _subfolders = [""custom_futas"", ""custom_wives"", ""custom_bedrooms""];
for (var _s = 0; _s < array_length(_subfolders); _s++)
{
    var _s_dir = working_directory + ""custom/"" + _subfolders[_s] + ""/"";
    if (directory_exists(_s_dir))
    {
        var _s_file_load = file_find_first(_s_dir + ""*"", 16);
        while (_s_file_load != """")
        {
            var _sub_item = _s_dir + _s_file_load;
            if (directory_exists(_sub_item))
            {
                func_load_custom(_sub_item);
                switch (custom_load_type)
                {
                    case UnknownEnum.Value_1:
                        if (ds_list_find_index(custom_lover_folders, _sub_item) == -1)
                        {
                            ds_list_add(custom_lover_folders, _sub_item);
                        }
                        break;
                    case UnknownEnum.Value_2:
                        if (ds_list_find_index(custom_partner_folders, _sub_item) == -1)
                        {
                            ds_list_add(custom_partner_folders, _sub_item);
                        }
                        break;
                    case UnknownEnum.Value_3:
                        if (ds_list_find_index(custom_bedroom_folders, _sub_item) == -1)
                        {
                            ds_list_add(custom_bedroom_folders, _sub_item);
                        }
                        break;
                }
            }
            _s_file_load = file_find_next();
        }
        file_find_close();
    }
}
";

group.QueueAppend(createCode, createApexGml);

// =============================================================
// 2. Step_0: Particle limit, Wife Pleasure, Full 33 Overdose Synergies
// =============================================================
ScriptMessage("[2/5] Patching Step_0 with full 33 Overdose synergies...");

for (int i = 0; i < stepCode.Instructions.Count; i++)
{
    var inst = stepCode.Instructions[i];
    if (inst.Kind == UndertaleInstruction.Opcode.PushI && inst.ValueShort == 500)
    {
        if (i + 1 < stepCode.Instructions.Count && stepCode.Instructions[i + 1].ValueVariable?.Name?.Content == "max_particles")
        {
            inst.ValueShort = 10000;
            if (i + 3 < stepCode.Instructions.Count && stepCode.Instructions[i + 3].Kind == UndertaleInstruction.Opcode.PushI && stepCode.Instructions[i + 3].ValueShort == 20)
            {
                stepCode.Instructions[i + 3].ValueShort = 500;
            }
        }
    }
}

string stepModGml = @"
// Auto color reset with color hierarchy
var _has_color_pill = (ds_list_find_index(pill_effects_active, 11) != -1 || ds_list_find_index(pill_effects_active, 21) != -1 || ds_list_find_index(pill_effects_active, 27) != -1 || ds_list_find_index(pill_effects_active, 28) != -1);
if (!_has_color_pill && top_sprite != sFutaMatingPressSlime && top_sprite != sFutaMatingPressAndroid)
{
    cum_color = 13497599; // Default natural semen color
}

// Wife pleasure calculation & climax
if (insert == true && thrust > 0.85)
{
    var _p_add = (0.6 + (thrust_speed * 0.1)) * (1 + (edge_boost * 0.2));
    if (ds_list_find_index(pill_effects_active, 19) != -1) _p_add *= 2;
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
    if (wife_climax_timer <= 0) wife_climax = false;
}

if (ds_list_size(pill_effects_active) > 0)
{
    for (var _p = 18; _p <= 33; _p++)
    {
        if (ds_list_find_index(pill_effects_unlocked, _p) == -1)
        {
            ds_list_add(pill_effects_unlocked, _p);
        }
    }

    var _has_overdose = (ds_list_find_index(pill_effects_active, 19) != -1);

    // ID 8: Stamina / Titan Rubber (Unbreakable Condom)
    if (ds_list_find_index(pill_effects_active, 8) != -1)
    {
        condom_break = 999999;
        if (_has_overdose) condom_breaking_override = true;
    }

    // ID 18: Petite Titan (0.65x Body Size, Penis Normal)
    if (ds_list_find_index(pill_effects_active, 18) != -1)
    {
        top_ass_size = min(top_ass_size, 0.65);
        top_boob_size = min(top_boob_size, 0.65);
        ball_size = min(ball_size, 0.8);
    }

    // ID 19: Overdose (Catalyst / Synergy Master Amplifier)
    if (_has_overdose)
    {
        thrust_strength = max(thrust_strength, 8);
        if (max_loads < 30 && max_loads > 0 && loads == 0) max_loads = max_loads * 2;

        if (ds_list_find_index(pill_effects_active, 1) != -1) // Overdose + Mega Sperm
        {
            ball_size = max(ball_size, 2.5);
            fill_amount += 15;
        }
        if (ds_list_find_index(pill_effects_active, 2) != -1 || ds_list_find_index(pill_effects_active, 3) != -1) // Overdose + Equine/Knotted
        {
            top_penis_length = max(top_penis_length, 2.8);
            top_penis_width = max(top_penis_width, 2.2);
        }
        if (ds_list_find_index(pill_effects_active, 4) != -1) // Overdose + Extra Thick
        {
            top_boob_size = max(top_boob_size, 2.5);
            top_ass_size = max(top_ass_size, 2.5);
        }
    }

    // ID 20: Turbo Drive (Speed 40 / Overdose 55)
    if (ds_list_find_index(pill_effects_active, 20) != -1)
    {
        thrust_speed = _has_overdose ? 55 : 40;
        thrust_strength = 12;
        if (condom == true) condom_jiggle = 0.2;
    }

    // ID 21: Honey Nectar (Golden Cum, 2x/4x Score)
    if (ds_list_find_index(pill_effects_active, 21) != -1)
    {
        cum_color = make_color_rgb(255, 215, 0);
        futa_score += (_has_overdose ? 4 : 2);
        if (condom == true) condom_color = merge_color(condom_color, cum_color, 0.5);
    }

    // ID 22: Siren Milk / Sensual Moan (Lactation Boost & Sensual Moans)
    if (ds_list_find_index(pill_effects_active, 22) != -1)
    {
        lactate = true;
        top_boob_jiggle += _has_overdose ? 0.4 : 0.2;
    }

    // ID 23: Edge Meister (Pure Edge Boost - No Ball Growth)
    if (ds_list_find_index(pill_effects_active, 23) != -1)
    {
        edge_boost = min(10, edge_boost);
    }

    // ID 24: Full Container (Infinite Womb - Fast Fill & Condom Mega Inflation)
    if (ds_list_find_index(pill_effects_active, 24) != -1)
    {
        fill_max = 500;
        if (orgasm == true)
        {
            fill_amount += (_has_overdose ? 40 : 25);
            if (condom == true)
            {
                condom_size = min(10, condom_size + 0.5);
            }
        }
    }

    // ID 25: Endless Drip (Endless Creampie Overflow inside, Drip outside)
    if (ds_list_find_index(pill_effects_active, 25) != -1)
    {
        if (insert == true)
        {
            fill_amount += (_has_overdose ? 4.0 : 2.0);
            fill_lerp = fill_amount + 5;
        }
        else if (irandom(12) == 0)
        {
            func_cum_splurt(false);
        }
    }

    // ID 26: Quick Egg (Instant 100% Impregnation / Condom Rupture on Climax)
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

    // ID 27: Magma Core (Burning Magma Cum)
    if (ds_list_find_index(pill_effects_active, 27) != -1)
    {
        cum_color = make_color_rgb(255, 69, 0);
        if (insert == true) sex_progress += (_has_overdose ? 1.2 : 0.6);
        if (condom == true) condom_color = merge_color(condom_color, cum_color, 0.5);
    }

    // ID 28: Crystal Semen (Glowing Cyan/Emerald Cum)
    if (ds_list_find_index(pill_effects_active, 28) != -1)
    {
        cum_color = make_color_rgb(0, 255, 230);
        if (condom == true) condom_color = merge_color(condom_color, cum_color, 0.5);
    }

    // ID 29: Phantom Reach (Deepest Penetration - Length 2.5x/2.8x & Width 1.8x/2.2x)
    if (ds_list_find_index(pill_effects_active, 29) != -1)
    {
        top_penis_length = max(top_penis_length, _has_overdose ? 2.8 : 2.5);
        top_penis_width = max(top_penis_width, _has_overdose ? 2.2 : 1.8);
    }

    // ID 30: Casino Lucky (777 Fever)
    if (ds_list_find_index(pill_effects_active, 30) != -1 && orgasm == true)
    {
        var _luck_chance = _has_overdose ? irandom(3) : irandom(8);
        if (_luck_chance == 0) futa_score += (_has_overdose ? 1554 : 777);
    }

    // ID 31: Time Delay (Extended Climax Duration without breaking duration timer)
    if (ds_list_find_index(pill_effects_active, 31) != -1 && orgasm == true && orgasm_timer < (_has_overdose ? 35 : 25))
    {
        orgasm_timer += _has_overdose ? 2 : 1;
    }

    // ID 32: Royal Genesis (Quadruple Fertilized Eggs)
    if (ds_list_find_index(pill_effects_active, 32) != -1 && impregnate > 0)
    {
        fertilizations = max(fertilizations, 4);
    }

    // ID 33: Epilogue Dream (Endless Sex, No Fatigue)
    if (ds_list_find_index(pill_effects_active, 33) != -1)
    {
        if (loads >= max_loads) max_loads += (_has_overdose ? 10 : 5);
    }
}
";

group.QueueAppend(stepCode, stepModGml);

// =============================================================
// 3. Draw_0: 2-Column Menu, Overdose Score/Ejaculation/RPG Multipliers, Infinite Encorgasm, Leaky 30/75/100%, Full Container 20/40x
// =============================================================
ScriptMessage("[3/5] Patching Draw_0 with 2-column menu, Overdose boost across calculations, and infinite encorgasm...");

string oldSubmenuPillGml = "ds_list_add(submenu_list, [func_set_lang(188, \"Livestream\"), UnknownEnum.Value_17]);";
string newSubmenuPillGml = @"ds_list_add(submenu_list, [func_set_lang(188, ""Livestream""), UnknownEnum.Value_17]);
                ds_list_add(submenu_list, [func_set_lang(215, ""Petite Titan""), 18]);
                ds_list_add(submenu_list, [func_set_lang(216, ""Overdose""), 19]);
                ds_list_add(submenu_list, [func_set_lang(217, ""Turbo Drive""), 20]);
                ds_list_add(submenu_list, [func_set_lang(218, ""Honey Nectar""), 21]);
                ds_list_add(submenu_list, [func_set_lang(219, ""Siren Milk""), 22]);
                ds_list_add(submenu_list, [func_set_lang(220, ""Edge Meister""), 23]);
                ds_list_add(submenu_list, [func_set_lang(221, ""Full Container""), 24]);
                ds_list_add(submenu_list, [func_set_lang(222, ""Endless Drip""), 25]);
                ds_list_add(submenu_list, [func_set_lang(223, ""Quick Egg""), 26]);
                ds_list_add(submenu_list, [func_set_lang(224, ""Magma Core""), 27]);
                ds_list_add(submenu_list, [func_set_lang(225, ""Crystal Semen""), 28]);
                ds_list_add(submenu_list, [func_set_lang(226, ""Phantom Reach""), 29]);
                ds_list_add(submenu_list, [func_set_lang(227, ""Casino Lucky""), 30]);
                ds_list_add(submenu_list, [func_set_lang(228, ""Time Delay""), 31]);
                ds_list_add(submenu_list, [func_set_lang(229, ""Royal Genesis""), 32]);
                ds_list_add(submenu_list, [func_set_lang(230, ""Epilogue Dream""), 33]);";

group.QueueFindReplace(drawCode, oldSubmenuPillGml, newSubmenuPillGml);

// PERFECT 2-COLUMN MENU LAYOUT FOR SUBMENU 3 (17 pills per column on right side)
string oldMenuLayoutBlock = @"var submenu_x = room_width - 140 - (160 * floor(i / 15));
            var submenu_y = (room_height - 32 - (32 * i)) + (480 * floor(i / 15));
            var submenu_check = point_in_rectangle(mouse_x, mouse_y, submenu_x - 72, submenu_y - 12, submenu_x + 72, submenu_y + 12);
            var submenu_alpha = 0.5 + (submenu_check * 0.5);
            var submenu_string = """";
            var disabled = false;
            var draw_bar = false;
            var value_set = median(0, 104, mouse_x - (submenu_x - 52)) / 104;
            var value_get = 0.5;
            draw_sprite_ext(sButtonBack, 0, submenu_x, submenu_y, 10, 2, 0, c_white, submenu_alpha);";

string newMenuLayoutBlock = @"var submenu_x = room_width - 140 - (160 * floor(i / 15));
            var submenu_y = (room_height - 32 - (32 * i)) + (480 * floor(i / 15));
            var _btn_w = 72;
            var _spr_w = 10;
            if (submenu == 3)
            {
                var _col = floor(i / 17);
                var _row = i % 17;
                submenu_x = room_width - 96 - (124 * _col);
                submenu_y = room_height - 24 - (29 * _row);
                _btn_w = 58;
                _spr_w = 8;
            }
            var submenu_check = point_in_rectangle(mouse_x, mouse_y, submenu_x - _btn_w, submenu_y - 12, submenu_x + _btn_w, submenu_y + 12);
            var submenu_alpha = 0.5 + (submenu_check * 0.5);
            var submenu_string = """";
            var disabled = false;
            var draw_bar = false;
            var value_set = median(0, 104, mouse_x - (submenu_x - 52)) / 104;
            var value_get = 0.5;
            draw_sprite_ext(sButtonBack, 0, submenu_x, submenu_y, _spr_w, 2, 0, c_white, submenu_alpha);";

group.QueueFindReplace(drawCode, oldMenuLayoutBlock, newMenuLayoutBlock);

group.QueueFindReplace(drawCode, 
    "ds_list_add(submenu_list, func_set_lang(185, \"Cum Limit\") + \": \" + string(max(20, round(max_particles * 500))));",
    "ds_list_add(submenu_list, func_set_lang(185, \"Cum Limit\") + \": \" + string(max(500, round(max_particles * 10000))));");

group.QueueFindReplace(drawCode, "womb_size = median(1, womb_size, 3);", "womb_size = median(1, womb_size, 6);");
group.QueueFindReplace(drawCode, "womb_size = median(1, fill_amount / fill_max, 3);", "womb_size = median(1, fill_amount / fill_max, 6);");

// FULL CONTAINER 20x / OVERDOSE 40x
group.QueueFindReplace(drawCode, 
    "var max_cumflation_size = 1.25;", 
    "var max_cumflation_size = (ds_list_find_index(pill_effects_active, 24) != -1) ? ((ds_list_find_index(pill_effects_active, 19) != -1) ? 40.0 : 20.0) : ((ds_list_find_index(pill_effects_active, UnknownEnum.Value_12) != -1) ? 10.0 : 2.5);");

// FIX INVERTED X-RAY BUG (Up to 40x belly size)
group.QueueFindReplace(drawCode, "var xray_size = 2 - (max(0, womb_size - 1) * 0.5);", "var xray_size = max(0.4, 2 - (max(0, womb_size - 1) * 0.12));");

// FIX FULL CONTAINER CAP & LEAKAGE BUG
group.QueueFindReplace(drawCode, "var max_fill = fill_max * 3;", "var max_fill = (ds_list_find_index(pill_effects_active, 24) != -1) ? (fill_max * 50) : (fill_max * 3);");
group.QueueFindReplace(drawCode, "if (insert == false && ds_list_find_index(pill_effects_active, UnknownEnum.Value_12) == -1)", "if (insert == false && ds_list_find_index(pill_effects_active, UnknownEnum.Value_12) == -1 && ds_list_find_index(pill_effects_active, 24) == -1)");

// FIX EDGE MEISTER MAX EDGE TO 10 & DISABLE BALL GROWTH
group.QueueFindReplace(drawCode, "var max_edge = 3;", "var max_edge = (ds_list_find_index(pill_effects_active, 23) != -1 || ds_list_find_index(pill_effects_active, UnknownEnum.Value_15) != -1) ? 10 : 3;");

string oldEdgingCode = "if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_15) != -1 && ball_size < 1.3)\n            {\n                ball_size += 0.05;\n                balls_jiggle = 0.2;\n            }";
string newEdgingCode = @"// Edging pure boost - ball growth disabled";
group.QueueFindReplace(drawCode, oldEdgingCode, newEdgingCode);

// UPGRADE LEAKY (ID 9) & ENDLESS DRIP: 30% piston, 75% spank, 100% overdose
string oldLeakyBlock = @"var leak_chance = irandom(10);
            if (slap_boost > 0)
            {
                leak_chance = irandom(1);
            }";

string newLeakyBlock = @"var _has_od = (ds_list_find_index(pill_effects_active, 19) != -1);
            var leak_chance = _has_od ? 0 : (irandom(99) < 30 ? 0 : 1);
            if (slap_boost > 0)
            {
                leak_chance = _has_od ? 0 : (irandom(99) < 75 ? 0 : 1);
            }";

group.QueueFindReplace(drawCode, oldLeakyBlock, newLeakyBlock);

// UPGRADE MOANING PROBABILITY (Siren Milk ID 22 / Sensual Moan / Three Pump: 100% on OD, 85% on normal)
string oldMoaningBlock = @"if (moaning == true)
        {
            if (moan_sound == -1 || !audio_is_playing(moan_sound))
            {
                var moan_list = ds_list_create();
                ds_list_copy(moan_list, moan_slow_list);
                var moan_chance = irandom(8);
                if (sex_progress >= (sex_progress_max * 0.6))
                {
                    ds_list_clear(moan_list);
                    ds_list_copy(moan_list, moan_fast_list);
                    moan_chance = irandom(4);
                }
                if (moan_previous != -1)
                {
                    ds_list_delete(moan_list, ds_list_find_index(moan_list, moan_previous));
                }
                if (moan_chance == 0)
                {
                    var moan_sound_play = ds_list_find_value(moan_list, irandom(ds_list_size(moan_list) - 1));
                    moan_sound = audio_play_sound(moan_sound_play, 0, false, 0.5, 0, moan_pitch);
                    moan_previous = moan_sound_play;
                }
            }
        }";

string newMoaningBlock = @"if (moaning == true)
        {
            if (moan_sound == -1 || !audio_is_playing(moan_sound))
            {
                var moan_list = ds_list_create();
                ds_list_copy(moan_list, moan_slow_list);
                var moan_chance = irandom(8);
                if (sex_progress >= (sex_progress_max * 0.6))
                {
                    ds_list_clear(moan_list);
                    ds_list_copy(moan_list, moan_fast_list);
                    moan_chance = irandom(4);
                }
                if (ds_list_find_index(pill_effects_active, 22) != -1 || ds_list_find_index(pill_effects_active, UnknownEnum.Value_10) != -1)
                {
                    moan_chance = (ds_list_find_index(pill_effects_active, 19) != -1) ? 0 : (irandom(99) < 85 ? 0 : 1);
                }
                if (moan_previous != -1)
                {
                    ds_list_delete(moan_list, ds_list_find_index(moan_list, moan_previous));
                }
                if (moan_chance == 0 && ds_list_size(moan_list) > 0)
                {
                    var moan_sound_play = ds_list_find_value(moan_list, irandom(ds_list_size(moan_list) - 1));
                    moan_sound = audio_play_sound(moan_sound_play, 0, false, 0.5, 0, moan_pitch);
                    moan_previous = moan_sound_play;
                }
            }
        }";

group.QueueFindReplace(drawCode, oldMoaningBlock, newMoaningBlock);

// INFINITE ENCORGASM (Remove encore == false restriction!)
string oldEncorgasmBlock = @"if (orgasm == true && orgasm_pumps < 3 && encore == false)
                {
                    func_add_combo_flair(func_set_lang(98, ""ENCORGASM""), 2500);
                    top_ass_jiggle = -0.2;
                    body_jiggle = -0.1;
                    func_top_speak(""sex_encorgasm"");
                    orgasm = true;
                    orgasm_pumps = orgasm_pumps_max;
                    orgasm_timer = 120;
                    encore = true;
                    if (moaning == true && ds_list_find_index(pill_effects_active, UnknownEnum.Value_10) == -1)
                    {
                        audio_stop_sound(moan_sound);
                        moan_sound = audio_play_sound(ds_list_find_value(orgasm_list, irandom(ds_list_size(orgasm_list) - 1)), 0, false, 0.5, 0, moan_pitch);
                    }
                }";

string newEncorgasmBlock = @"if (orgasm == true && orgasm_pumps < 5)
                {
                    func_add_combo_flair(func_set_lang(98, ""ENCORGASM""), 2500);
                    top_ass_jiggle = -0.2;
                    body_jiggle = -0.1;
                    func_top_speak(""sex_encorgasm"");
                    orgasm = true;
                    orgasm_pumps = orgasm_pumps_max;
                    orgasm_timer = 120;
                    encore = false;
                    if (moaning == true && ds_list_find_index(pill_effects_active, UnknownEnum.Value_10) == -1)
                    {
                        audio_stop_sound(moan_sound);
                        moan_sound = audio_play_sound(ds_list_find_value(orgasm_list, irandom(ds_list_size(orgasm_list) - 1)), 0, false, 0.5, 0, moan_pitch);
                    }
                }";

group.QueueFindReplace(drawCode, oldEncorgasmBlock, newEncorgasmBlock);

// OVERDOSE SYNERGY BOOST ACROSS AMOUNT_BOOST, SCORE_MULT, AND RPG_DAMAGE IN DRAW_0
string oldAmountBoostBlock = @"var amount_boost = ball_size * edge_boost;
            if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_5) != -1)
            {
                amount_boost *= 2;
            }
            if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_10) != -1)
            {
                amount_boost *= 20;
            }
            if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_14) != -1)
            {
                amount_boost *= (loads / 10);
            }";

string newAmountBoostBlock = @"var _od_active = (ds_list_find_index(pill_effects_active, 19) != -1);
            var amount_boost = ball_size * edge_boost * (_od_active ? 2 : 1);
            if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_5) != -1)
            {
                amount_boost *= (_od_active ? 4 : 2);
            }
            if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_10) != -1)
            {
                amount_boost *= (_od_active ? 40 : 20);
            }
            if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_14) != -1)
            {
                amount_boost *= (_od_active ? (loads / 5) : (loads / 10));
            }";

group.QueueFindReplace(drawCode, oldAmountBoostBlock, newAmountBoostBlock);

// OVERDOSE RPG DAMAGE 2x BOOST
string oldRpgDamageBlock = "var rpg_damage = round(5 * power(1.05, rpg_enemy_level - 1) * edge_boost);";
string newRpgDamageBlock = "var rpg_damage = round(((ds_list_find_index(pill_effects_active, 19) != -1) ? 10 : 5) * power(1.05, rpg_enemy_level - 1) * edge_boost);";
group.QueueFindReplace(drawCode, oldRpgDamageBlock, newRpgDamageBlock);

// OVERDOSE SCORE MULT 2x BOOST
string oldScoreMultBlock = @"var score_mult = 1;
            if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_10) != -1)
            {
                audio_play_sound(choose(sndBigCumInside1, sndBigCumInside2, sndBigCumInside3, sndBigCumInside4), 0, false, 0.5, 0, random_range(0.9, 1.1));
                score_mult = 20;
            }";

string newScoreMultBlock = @"var _od_score = (ds_list_find_index(pill_effects_active, 19) != -1);
            var score_mult = _od_score ? 2 : 1;
            if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_10) != -1)
            {
                audio_play_sound(choose(sndBigCumInside1, sndBigCumInside2, sndBigCumInside3, sndBigCumInside4), 0, false, 0.5, 0, random_range(0.9, 1.1));
                score_mult = _od_score ? 40 : 20;
            }";

group.QueueFindReplace(drawCode, oldScoreMultBlock, newScoreMultBlock);

// FIX BALL CLENCHING DOUBLE DRAW
string oldBallDraw = "draw_sprite_ext(top_sprite, 8, x, y - (thrust * 32 * base_sex_size) - (ball_size * 8), (image_xscale + top_breath) * (1 + balls_jiggle) * ball_size * base_sex_size, (image_yscale - top_breath) * (1 - balls_jiggle) * ball_size * base_sex_size, 0, top_skin, alpha_test);";
string newBallDraw = @"if (orgasm == false || custom_clench_toggle == false)
{
    draw_sprite_ext(top_sprite, 8, x, y - (thrust * 32 * base_sex_size) - (ball_size * 8), (image_xscale + top_breath) * (1 + balls_jiggle) * ball_size * base_sex_size, (image_yscale - top_breath) * (1 - balls_jiggle) * ball_size * base_sex_size, 0, top_skin, alpha_test);
}";

group.QueueFindReplace(drawCode, oldBallDraw, newBallDraw);

// FIX BALL CLENCHING DRAWING Y-POSITION (Moved 1 ball height down)
string drawClenchGml = @"
// ============================================
// APEX MOD: BALL CLENCHING DRAWING ENGINE
// ============================================
if (orgasm == true && custom_clench_toggle == true)
{
    var _bc_frame = floor(power(clamp(1 - (orgasm_timer / 50), 0, 1), 0.4) * 4);
    var _bc_spr = global.sBallsClenching;
    if (top_sprite == sFutaMatingPressAndroid) _bc_spr = global.sBallsClenchingAndroid;
    else if (top_sprite == sFutaMatingPressSlime) _bc_spr = global.sBallsClenchingSlime;

    if (sex_position == 1 || sex_position == 2)
    {
        _bc_spr = global.sBallsClenchingCow;
        if (top_sprite == sFutaMatingPressAndroid) _bc_spr = global.sBallsClenchingCowAndroid;
        else if (top_sprite == sFutaMatingPressSlime) _bc_spr = global.sBallsClenchingCowSlime;
    }

    if (sprite_exists(_bc_spr))
    {
        var _clench_y = y - (thrust * 32 * base_sex_size) + (ball_size * 12);
        draw_sprite_ext(_bc_spr, _bc_frame, x, _clench_y, (image_xscale + top_breath) * (1 + balls_jiggle) * ball_size * base_sex_size, (image_yscale - top_breath) * (1 - balls_jiggle) * ball_size * base_sex_size, 0, top_skin, 1);
    }
}
";

group.QueueAppend(drawCode, drawClenchGml);

// =============================================================
// 4. Draw_64: Clean left-bottom HUD with Sizes, Wife Pleasure, and Depth
// =============================================================
ScriptMessage("[4/5] Appending Draw_64 clean HUD GML...");

string hudModGml = @"
if (insert == true && title == false && top_sprite != sFutaMatingPressAndroid)
{
    var _hud_w = 160;
    var _hud_h = 108;
    var _hud_x = 24;
    var _hud_y = display_get_gui_height() - _hud_h - 12;
    if (_hud_y < 150) _hud_y = 240;

    draw_sprite_ext(sButtonBack, 0, _hud_x + (_hud_w / 2), _hud_y + (_hud_h / 2), _hud_w / 16, _hud_h / 16, 0, c_black, 0.6);

    var _status_text = ""ピストン中"";
    if (orgasm == true)
    {
        _status_text = ""精液注ぎ込み中"";
    }
    else if (wife_climax == true)
    {
        _status_text = ""★ 妻が絶頂中！ ★"";
    }
    else if (sex_progress > (sex_progress_max * 0.9))
    {
        _status_text = ""絶頂寸前！"";
    }
    else if (sex_progress > (sex_progress_max * 0.5))
    {
        _status_text = ""快感蓄積中"";
    }

    var _hud_info = ""◆ "" + string(_status_text) + ""\n"";
    if (orgasm == true)
    {
        _hud_info += (""射精 #"" + string(loads) + "" 回目\n"");
        _hud_info += (""精液放出: ["" + string(round(max(0, (orgasm_pumps / orgasm_pumps_max) * 100))) + ""%]\n"");
        _hud_info += (""子宮容量: ["" + string(round((fill_amount / fill_max) * 100)) + ""%]\n"");
        _hud_info += (""受精確率: "" + string(round(fertility * (fill_amount / fill_max))) + ""%\n"");
    }
    else
    {
        _hud_info += (""ふたなり絶頂度: ["" + string(round((sex_progress / sex_progress_max) * 100)) + ""%]\n"");
        _hud_info += (""妻の快感度: ["" + string(round((wife_pleasure / wife_pleasure_threshold) * 100)) + ""%] (絶頂"" + string(wife_climax_counter) + ""回)\n"");
        _hud_info += (""挿入深度: "" + string(round(25 + (25 * (1 - thrust) * top_penis_length))) + ""cm\n"");
    }

    _hud_info += (""肉体: 根x"" + string_format(top_penis_length, 1, 1) + "" 太x"" + string_format(top_penis_width, 1, 1) + "" 玉x"" + string_format(ball_size, 1, 1) + "" 胸x"" + string_format(top_boob_size, 1, 1));

    draw_set_font(global.custom_font_small);
    draw_set_halign(fa_left);
    var _hud_color = (wife_climax == true) ? make_color_rgb(255, 105, 180) : c_white;
    draw_text_color(_hud_x + 8, _hud_y + 8, _hud_info, _hud_color, _hud_color, _hud_color, _hud_color, 1);
    draw_set_font(global.custom_font_big);
    draw_set_halign(fa_center);
}
";

group.QueueAppend(draw64Code, hudModGml);
group.Import();

ScriptMessage("=== MASTER V3.2 PATCH APPLIED WITH 100% SUCCESS ===");
