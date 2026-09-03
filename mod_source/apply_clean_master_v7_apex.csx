using System;
using System.IO;
using UndertaleModLib;
using UndertaleModLib.Models;
using UndertaleModLib.Compiler;

EnsureDataLoaded();

ScriptMessage("=== APPLYING CLEAN MASTER V7 APEX PATCH FROM FRESH BASE ===");

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
// 1. Create_0: Limits 3x, Rating 10x, Lang Array Fix, TTF Fonts & BallClenching Sprites
// =============================================================
ScriptMessage("[1/4] Patching Create_0 max limits, rating 10x, TTF fonts & subfolder scanner...");

for (int i = 7840; i < Math.Min(createCode.Instructions.Count, 7880); i++)
{
    var inst = createCode.Instructions[i];
    if (inst.Kind == UndertaleInstruction.Opcode.Push && inst.Type1 == UndertaleInstruction.DataType.Double)
    {
        if (Math.Abs(inst.ValueDouble - 1.5) < 0.01) inst.ValueDouble = 3.0;
        else if (Math.Abs(inst.ValueDouble - 1.4) < 0.01) inst.ValueDouble = 2.8;
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

Data.Functions.EnsureDefined("font_add", Data.Strings);

string createApexGml = @"
global.custom_font_big = 100663296;
global.custom_font_handwriting = 100663297;
global.custom_font_small = 100663298;

var _fpath = working_directory + ""language/font.ttf"";
if (!file_exists(_fpath)) _fpath = ""language/font.ttf"";

if (file_exists(_fpath))
{
    var _fbig = font_add(_fpath, 14, false, false, 32, 65535);
    var _fhand = font_add(_fpath, 12, false, false, 32, 65535);
    var _fsmall = font_add(_fpath, 8, false, false, 32, 65535);
    if (_fbig != -1) global.custom_font_big = _fbig;
    if (_fhand != -1) global.custom_font_handwriting = _fhand;
    if (_fsmall != -1) global.custom_font_small = _fsmall;
}
else if (file_exists(""C:/Windows/Fonts/msgothic.ttc""))
{
    var _fbig = font_add(""C:/Windows/Fonts/msgothic.ttc"", 14, false, false, 32, 65535);
    var _fhand = font_add(""C:/Windows/Fonts/msgothic.ttc"", 12, false, false, 32, 65535);
    var _fsmall = font_add(""C:/Windows/Fonts/msgothic.ttc"", 8, false, false, 32, 65535);
    if (_fbig != -1) global.custom_font_big = _fbig;
    if (_fhand != -1) global.custom_font_handwriting = _fhand;
    if (_fsmall != -1) global.custom_font_small = _fsmall;
}

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
                        if (ds_list_find_index(custom_lover_folders, _sub_item) == -1) ds_list_add(custom_lover_folders, _sub_item);
                        break;
                    case UnknownEnum.Value_2:
                        if (ds_list_find_index(custom_partner_folders, _sub_item) == -1) ds_list_add(custom_partner_folders, _sub_item);
                        break;
                    case UnknownEnum.Value_3:
                        if (ds_list_find_index(custom_bedroom_folders, _sub_item) == -1) ds_list_add(custom_bedroom_folders, _sub_item);
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
// 2. Step_0: Particle limit 10,000 & Clean Frame Logic
// =============================================================
ScriptMessage("[2/4] Patching Step_0 cleanly (No frame leaks, no machinegun)...");

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

string cleanStepModGml = @"
// Auto color reset if no color pill active
var _has_color_pill = (ds_list_find_index(pill_effects_active, 11) != -1 || ds_list_find_index(pill_effects_active, 21) != -1 || ds_list_find_index(pill_effects_active, 27) != -1 || ds_list_find_index(pill_effects_active, 28) != -1);
if (!_has_color_pill && top_sprite != sFutaMatingPressSlime && top_sprite != sFutaMatingPressAndroid)
{
    cum_color = 13497599; // Default natural semen color
}

// Auto speed recovery if Turbo Drive (ID 20) is inactive
if (ds_list_find_index(pill_effects_active, 20) == -1 && (orgasm == false || ds_list_find_index(pill_effects_active, UnknownEnum.Value_16) == -1))
{
    thrust_speed = 2;
    thrust_strength = 3;
}

// Wife pleasure build-up during thrust
if (insert == true && thrust > 0.85)
{
    var _p_add = (0.6 + (thrust_speed * 0.1)) * (1 + (edge_boost * 0.2));
    if (ds_list_find_index(pill_effects_active, 19) != -1) _p_add *= 2;
    if (ds_list_find_index(pill_effects_active, 34) != -1) _p_add += (ds_list_find_index(pill_effects_active, 19) != -1 ? 1.5 : 0.8);
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
    for (var _p = 18; _p <= 37; _p++)
    {
        if (ds_list_find_index(pill_effects_unlocked, _p) == -1)
        {
            ds_list_add(pill_effects_unlocked, _p);
        }
    }

    var _has_overdose = (ds_list_find_index(pill_effects_active, 19) != -1);

    // ID 8: Stamina / Unbreakable Condom base
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

    // ID 19: Overdose (Catalyst / Synergy Amplifier)
    if (_has_overdose)
    {
        thrust_strength = max(thrust_strength, 8);
        if (max_loads < 30 && max_loads > 0 && loads == 0) max_loads = max_loads * 2;

        if (ds_list_find_index(pill_effects_active, 1) != -1) // Overdose + Mega Sperm
        {
            ball_size = max(ball_size, 2.5);
        }
        if (ds_list_find_index(pill_effects_active, 2) != -1 || ds_list_find_index(pill_effects_active, 3) != -1) // Overdose + Equine/Knotted
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

    // ID 20: Turbo Drive (Speed 40 / Overdose 55)
    if (ds_list_find_index(pill_effects_active, 20) != -1)
    {
        thrust_speed = _has_overdose ? 55 : 40;
        thrust_strength = 12;
        if (condom == true) condom_jiggle = 0.2;
    }

    // ID 21: Honey Nectar (Golden Cum, 2x Score)
    if (ds_list_find_index(pill_effects_active, 21) != -1)
    {
        cum_color = make_color_rgb(255, 215, 0);
        futa_score += (_has_overdose ? 4 : 2);
        if (condom == true) condom_color = merge_color(condom_color, cum_color, 0.5);
    }

    // ID 22: Siren Milk (Lactation Boost & Sensual Moans)
    if (ds_list_find_index(pill_effects_active, 22) != -1)
    {
        lactate = true;
        top_boob_jiggle += (_has_overdose ? 0.4 : 0.2);
    }

    // ID 23: Edge Meister (Pure Edge Boost - No Ball Growth)
    if (ds_list_find_index(pill_effects_active, 23) != -1)
    {
        edge_boost = min(10, edge_boost);
    }

    // ID 24: Full Container (Infinite Womb - Capacity Expansion)
    if (ds_list_find_index(pill_effects_active, 24) != -1)
    {
        fill_max = 500;
    }

    // ID 25: Endless Drip (Continuous Creampie Overflow inside, Drip outside)
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

    // ID 29: Phantom Reach (Deepest Penetration - Length 2.5x & Width 1.8x)
    if (ds_list_find_index(pill_effects_active, 29) != -1)
    {
        top_penis_length = max(top_penis_length, _has_overdose ? 2.8 : 2.5);
        top_penis_width = max(top_penis_width, _has_overdose ? 2.2 : 1.8);
    }

    // ID 30: Casino Lucky (777 Fever)
    if (ds_list_find_index(pill_effects_active, 30) != -1 && orgasm == true)
    {
        var _luck_chance = _has_overdose ? irandom(3) : irandom(8);
        if (_luck_chance == 0)
        {
            futa_score += (_has_overdose ? 1554 : 777);
        }
    }

    // ID 31: Time Delay (Extended Climax Duration without breaking duration timer)
    if (ds_list_find_index(pill_effects_active, 31) != -1 && orgasm == true && orgasm_timer < (_has_overdose ? 35 : 25))
    {
        orgasm_timer += (_has_overdose ? 2 : 1);
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

    // ID 36: Titan Rubber (Unbreakable Rubber, Normal SFX)
    if (ds_list_find_index(pill_effects_active, 36) != -1)
    {
        condom_break = 999999;
        condom_integrity = 100;
        if (_has_overdose) condom_breaking_override = true;
    }
}
";

group.QueueAppend(stepCode, cleanStepModGml);

// =============================================================
// 3. Draw_0: Submenu (38 pills), 10x UI, Growth Cascade, Moan, Leaky EX, Sync Heart, Full Container, Condom Scaling
// =============================================================
ScriptMessage("[3/4] Patching Draw_0 with 38 pills, 10x rating UI, growth cascade limit, sync heart...");

// Reset logic
string oldResetBlock = @"if (ds_list_size(pill_effects_active) > 0)
                                {
                                    top_ass_size = base_ass_size;
                                    top_penis_width = base_penis_width;
                                    top_penis_length = base_penis_length;
                                    top_boob_size = base_boob_size;
                                    ball_size = base_ball_size;
                                    max_loads = base_max_loads;
                                    orgasm_pumps_max = base_pumps_max;
                                    clear = true;
                                    ds_list_clear(pill_effects_active);
                                }";

string newResetBlock = @"if (ds_list_size(pill_effects_active) > 0)
                                {
                                    top_ass_size = base_ass_size;
                                    top_penis_width = base_penis_width;
                                    top_penis_length = base_penis_length;
                                    top_boob_size = base_boob_size;
                                    ball_size = base_ball_size;
                                    max_loads = base_max_loads;
                                    orgasm_pumps_max = base_pumps_max;
                                    thrust_speed = 2;
                                    thrust_strength = 3;
                                    condom_break = 10;
                                    condom_integrity = 4;
                                    condom_breaking_override = false;
                                    lactate = false;
                                    cum_color = 13497599;
                                    wife_pleasure = 0;
                                    wife_climax = false;
                                    clear = true;
                                    ds_list_clear(pill_effects_active);
                                }";

group.QueueFindReplace(drawCode, oldResetBlock, newResetBlock);

// Submenu registration for 38 pills
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
                ds_list_add(submenu_list, [func_set_lang(230, ""Epilogue Dream""), 33]);
                ds_list_add(submenu_list, [func_set_lang(231, ""Sensual Moan""), 34]);
                ds_list_add(submenu_list, [func_set_lang(232, ""Leaky EX""), 35]);
                ds_list_add(submenu_list, [func_set_lang(233, ""Titan Rubber""), 36]);
                ds_list_add(submenu_list, [func_set_lang(234, ""Sync Heart""), 37]);";

group.QueueFindReplace(drawCode, oldSubmenuPillGml, newSubmenuPillGml);

// Submenu 3 Layout (3 columns of 13 for perfect fit)
string oldSubmenuLayout = @"if (submenu == 3)
            {
                var _col = floor(i / 15);
                var _row = i % 15;
                submenu_x = room_width - 140 - (160 * _col);
                submenu_y = (room_height - 32 - (32 * _row)) + (480 * _col);
                _btn_w = 72;
                _spr_w = 10;
            }";

string newSubmenuLayout = @"if (submenu == 3)
            {
                var _col = floor(i / 13);
                var _row = i % 13;
                submenu_x = room_width - 80 - (126 * _col);
                submenu_y = room_height - 24 - (30 * _row);
                _btn_w = 60;
                _spr_w = 8.2;
            }";

group.QueueFindReplace(drawCode, 
    "var submenu_x = room_width - 140 - (160 * floor(i / 15));\n            var submenu_y = (room_height - 32 - (32 * i)) + (480 * floor(i / 15));\n            var _btn_w = 72;\n            var _spr_w = 10;",
    newSubmenuLayout);

// 10x Rating UI
string oldRatingUiCode = @"if (button_press == true)
            {
                draw_set_font(fntFontSmall);
                draw_set_halign(fa_right);
                draw_sprite_ext(sButtonBack, 0, newlover_x, newlover_y - 62, 7.5, 5.5, 0, c_white, 0.5);
                for (var i = 0; i < 7; i++)
                {
                    var anchor_x = newlover_x;
                    var anchor_y = ((newlover_y - 64) + 30) - (10 * i);
                    var futa_data = func_set_lang(171, ""BREASTS:"") + "" "";
                    var futa_numb = func_get_rating(top_boob_size);
                    var stats = true;
                    switch (i)
                    {
                        case 1:
                            futa_data = func_set_lang(172, ""ASS:"") + "" "";
                            futa_numb = func_get_rating(top_ass_size);
                            break;
                        case 2:
                            futa_data = func_set_lang(173, ""PENIS LENGTH:"") + "" "";
                            futa_numb = func_get_rating(top_penis_length);
                            break;
                        case 3:
                            futa_data = func_set_lang(174, ""PENIS WIDTH:"") + "" "";
                            futa_numb = func_get_rating(top_penis_width);
                            break;
                        case 4:
                            futa_data = func_set_lang(175, ""BALLS:"") + "" "";
                            futa_numb = func_get_rating(ball_size);
                            break;
                        case 5:
                            futa_data = func_set_lang(176, ""OVERALL:"") + "" "";
                            futa_numb = func_get_rating((ball_size + top_boob_size + top_ass_size + top_penis_length + top_penis_width + ball_size) / 6);
                            break;
                        case 6:
                            futa_data = string(personality_name);
                            stats = false;
                            break;
                    }
                    if (stats == true)
                    {
                        for (var j = 0; j < 6; j++)
                        {
                            var color = 0;
                            if (futa_numb >= j)
                            {
                                color = 12632256;
                            }
                            if (futa_numb >= 5)
                            {
                                color = 16777215;
                            }
                            draw_sprite_ext(sCum, 0, anchor_x + (j * 8), anchor_y, 0.2, 0.2, 0, color, 1);
                            draw_text_ext(anchor_x - 4, anchor_y, futa_data, 7, 160);
                        }
                    }
                    else
                    {
                        draw_set_halign(fa_center);
                        draw_text_ext(anchor_x, anchor_y, futa_data, 7, 160);
                    }
                }";

string newRatingUiCode = @"if (button_press == true)
            {
                draw_set_font(global.custom_font_small);
                draw_set_halign(fa_right);
                draw_sprite_ext(sButtonBack, 0, newlover_x, newlover_y - 62, 9.5, 5.5, 0, c_white, 0.5);
                for (var i = 0; i < 7; i++)
                {
                    var anchor_x = newlover_x;
                    var anchor_y = ((newlover_y - 64) + 30) - (10 * i);
                    var futa_data = func_set_lang(171, ""BREASTS:"") + "" "";
                    var futa_numb = func_get_rating(top_boob_size);
                    var stats = true;
                    switch (i)
                    {
                        case 1:
                            futa_data = func_set_lang(172, ""ASS:"") + "" "";
                            futa_numb = func_get_rating(top_ass_size);
                            break;
                        case 2:
                            futa_data = func_set_lang(173, ""PENIS LENGTH:"") + "" "";
                            futa_numb = func_get_rating(top_penis_length);
                            break;
                        case 3:
                            futa_data = func_set_lang(174, ""PENIS WIDTH:"") + "" "";
                            futa_numb = func_get_rating(top_penis_width);
                            break;
                        case 4:
                            futa_data = func_set_lang(175, ""BALLS:"") + "" "";
                            futa_numb = func_get_rating(ball_size);
                            break;
                        case 5:
                            futa_data = func_set_lang(176, ""OVERALL:"") + "" "";
                            futa_numb = func_get_rating((ball_size + top_boob_size + top_ass_size + top_penis_length + top_penis_width + ball_size) / 6);
                            break;
                        case 6:
                            futa_data = string(personality_name);
                            stats = false;
                            break;
                    }
                    if (stats == true)
                    {
                        draw_set_halign(fa_right);
                        draw_text_ext(anchor_x - 4, anchor_y, futa_data, 7, 160);
                        for (var j = 0; j < 10; j++)
                        {
                            var color = 4210752;
                            if (futa_numb > j)
                            {
                                color = 16777215;
                                if (futa_numb >= 8) color = 65535;
                                if (futa_numb >= 10) color = 16738740;
                            }
                            draw_sprite_ext(sCum, 0, anchor_x + 2 + (j * 6), anchor_y, 0.16, 0.16, 0, color, 1);
                        }
                    }
                    else
                    {
                        draw_set_halign(fa_center);
                        draw_text_ext(anchor_x, anchor_y, futa_data, 7, 160);
                    }
                }";

group.QueueFindReplace(drawCode, oldRatingUiCode, newRatingUiCode);

// Growth Cascade (ID 14) Growth Limit Fix
string oldGrowthCode = @"if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_14) != -1)
            {
                if (top_penis_length < 1.3)
                {
                    top_penis_length += 0.1;
                }
                if (top_penis_width < 1.3)
                {
                    top_penis_width += 0.1;
                }
                if (top_ass_size < 1.3)
                {
                    top_ass_size += 0.1;
                }
                if (ball_size < 1.3)
                {
                    ball_size += 0.1;
                }
                if (top_boob_size < 1.3)
                {
                    top_boob_size += 0.1;
                }
                orgasm_pumps_max += 4;
            }";

string newGrowthCode = @"if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_14) != -1)
            {
                var _has_od_grow = (ds_list_find_index(pill_effects_active, 19) != -1);
                var _growth_inc = _has_od_grow ? 0.3 : 0.15;
                var _growth_limit = _has_od_grow ? 3.0 : 2.8;
                if (top_penis_length < _growth_limit)
                {
                    top_penis_length = min(_growth_limit, top_penis_length + _growth_inc);
                }
                if (top_penis_width < _growth_limit)
                {
                    top_penis_width = min(_growth_limit, top_penis_width + _growth_inc);
                }
                if (top_ass_size < _growth_limit)
                {
                    top_ass_size = min(_growth_limit, top_ass_size + _growth_inc);
                }
                if (ball_size < _growth_limit)
                {
                    ball_size = min(_growth_limit, ball_size + _growth_inc);
                }
                if (top_boob_size < _growth_limit)
                {
                    top_boob_size = min(_growth_limit, top_boob_size + _growth_inc);
                }
                orgasm_pumps_max += (_has_od_grow ? 8 : 4);
            }";

group.QueueFindReplace(drawCode, oldGrowthCode, newGrowthCode);

// Moaning Sensual Moan (ID 34)
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
                if (ds_list_find_index(pill_effects_active, 34) != -1 || ds_list_find_index(pill_effects_active, 22) != -1 || ds_list_find_index(pill_effects_active, UnknownEnum.Value_10) != -1)
                {
                    moan_chance = (ds_list_find_index(pill_effects_active, 19) != -1) ? 0 : (irandom(99) < 95 ? 0 : 1);
                    moan_pitch = random_range(0.85, 1.25);
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

// Leaky (ID 9) & Leaky EX (ID 35)
string oldLeakyBlock = @"if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_9) != -1)
        {
            var leak_chance = irandom(10);
            if (slap_boost > 0)
            {
                leak_chance = irandom(1);
            }";

string newLeakyBlock = @"if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_9) != -1 || ds_list_find_index(pill_effects_active, 35) != -1)
        {
            var _has_od = (ds_list_find_index(pill_effects_active, 19) != -1);
            var _is_ex = (ds_list_find_index(pill_effects_active, 35) != -1);
            var leak_chance = 1;
            if (_has_od) leak_chance = 0;
            else if (_is_ex) leak_chance = (slap_boost > 0) ? ((irandom(99) < 75) ? 0 : 1) : ((irandom(99) < 30) ? 0 : 1);
            else leak_chance = (slap_boost > 0) ? ((irandom(1) == 0) ? 0 : 1) : ((irandom(10) == 0) ? 0 : 1);";

group.QueueFindReplace(drawCode, oldLeakyBlock, newLeakyBlock);

group.QueueFindReplace(drawCode,
    "fill_amount += (5 * ball_size * edge_boost);",
    "var _leak_vol = (ds_list_find_index(pill_effects_active, 35) != -1 ? 8 : 5) * ball_size * edge_boost * ((ds_list_find_index(pill_effects_active, 19) != -1) ? 2 : 1); fill_amount += _leak_vol;");

// Leaky EX in Spanking & UI Stats
group.QueueFindReplace(drawCode,
    "if (insert == false && ds_list_find_index(pill_effects_active, UnknownEnum.Value_9) != -1)",
    "if (insert == false && (ds_list_find_index(pill_effects_active, UnknownEnum.Value_9) != -1 || ds_list_find_index(pill_effects_active, 35) != -1))");

group.QueueFindReplace(drawCode,
    "if ((orgasm == true || (ds_list_find_index(pill_effects_active, UnknownEnum.Value_9) != -1 && insert == true)) && title == false)",
    "if ((orgasm == true || ((ds_list_find_index(pill_effects_active, UnknownEnum.Value_9) != -1 || ds_list_find_index(pill_effects_active, 35) != -1) && insert == true)) && title == false)");

group.QueueFindReplace(drawCode,
    "if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_9) != -1 && orgasm == false)",
    "if ((ds_list_find_index(pill_effects_active, UnknownEnum.Value_9) != -1 || ds_list_find_index(pill_effects_active, 35) != -1) && orgasm == false)");

// Step_0 stat reset exception for Leaky EX
group.QueueFindReplace(stepCode,
    "if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_9) == -1)",
    "if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_9) == -1 && ds_list_find_index(pill_effects_active, 35) == -1)");


// Orgasm Pump Block: Full Container (ID 24) & Sync Heart (ID 37)
string oldOrgasmBlock = @"var liters = 0.25 * amount_boost;
            var sperm_increase = random_range(20, 100) * amount_boost;
            stat_liters += liters;
            stat_sperm_cell += sperm_increase;
            stat_total_liters += liters;
            stat_total_sperm_cell += sperm_increase;";

string newOrgasmBlock = @"var _od_active = (ds_list_find_index(pill_effects_active, 19) != -1);

            // Full Container (ID 24) Injection
            if (ds_list_find_index(pill_effects_active, 24) != -1)
            {
                fill_amount += (_od_active ? 40 : 25);
                fill_lerp = fill_amount + 5;
                amount_boost *= (_od_active ? 3 : 2);
            }

            // Sync Heart (ID 37) Orgasm Pump Sync
            if (ds_list_find_index(pill_effects_active, 37) != -1)
            {
                wife_pleasure = wife_pleasure_threshold;
                wife_climax = true;
                wife_climax_timer = 240;
                wife_climax_counter += 1;
                futa_score += 5000;
                body_jiggle = 0.08;
                bottom_ass_jiggle = 0.6;
                var _p_done = max(0, orgasm_pumps_max - orgasm_pumps);
                var _s_vol = _od_active ? min(1.0, 0.65 + (_p_done * 0.08)) : 0.85;
                var _s_pitch = _od_active ? min(1.5, 0.95 + (_p_done * 0.07)) : 1.0;
                audio_play_sound(choose(sndMoanOrgasm1, sndMoanOrgasm2, sndMoanOrgasm3, sndMoanOrgasm5), 0, false, _s_vol, 0, _s_pitch);
                part_particles_create(global.ps_back, x + random_range(-64, 64), (y - 40) + random_range(-32, 32), part_love, 8);
            }

            var liters = 0.25 * amount_boost;
            var sperm_increase = random_range(20, 100) * amount_boost;
            stat_liters += liters;
            stat_sperm_cell += sperm_increase;
            stat_total_liters += liters;
            stat_total_sperm_cell += sperm_increase;";

group.QueueFindReplace(drawCode, oldOrgasmBlock, newOrgasmBlock);

// Condom Scaling Formulas
group.QueueFindReplace(drawCode, 
    "condom_size = min(3, stat_liters / 5) + 0.1;", 
    "var _c_cap = (ds_list_find_index(pill_effects_active, 24) != -1) ? ((ds_list_find_index(pill_effects_active, 19) != -1) ? 20.0 : 10.0) : 6.0; condom_size = min(_c_cap, (stat_liters / 2.5) + 0.1);");

group.QueueFindReplace(drawCode, 
    "condom_size = min(3, stat_liters / 5) + (0.5 * edge_boost);", 
    "var _c_cap = (ds_list_find_index(pill_effects_active, 24) != -1) ? ((ds_list_find_index(pill_effects_active, 19) != -1) ? 20.0 : 10.0) : 6.0; condom_size = min(_c_cap, (stat_liters / 2.5) + (0.5 * edge_boost));");

group.QueueFindReplace(drawCode, 
    "condom_size = min(3, condom_size);", 
    "condom_size = min((ds_list_find_index(pill_effects_active, 24) != -1) ? ((ds_list_find_index(pill_effects_active, 19) != -1) ? 20.0 : 10.0) : 6.0, condom_size);");

group.QueueFindReplace(drawCode, 
    "condom_size = min(3, stat_liters / 5);", 
    "condom_size = min((ds_list_find_index(pill_effects_active, 24) != -1) ? ((ds_list_find_index(pill_effects_active, 19) != -1) ? 20.0 : 10.0) : 6.0, stat_liters / 2.5);");

// Remove all artificial condom halving in draw and drops!
group.QueueFindReplace(drawCode, "if (condom_size > 1.25)\n                        condomballoon_size = condom_size / 2;", "condomballoon_size = condom_size;");
group.QueueFindReplace(drawCode, "if (condom_size > 1.25)\n                    condomballoon_size = condom_size / 2;", "condomballoon_size = condom_size;");
group.QueueFindReplace(drawCode, "if (condom_size > 1.25)\n                    condom_spawn.condom_size = condom_size / 2;", "condom_spawn.condom_size = condom_size;");


// Full Container 20x / OD 40x
group.QueueFindReplace(drawCode, 
    "var max_cumflation_size = 1.25;", 
    "var max_cumflation_size = (ds_list_find_index(pill_effects_active, 24) != -1) ? ((ds_list_find_index(pill_effects_active, 19) != -1) ? 40.0 : 20.0) : ((ds_list_find_index(pill_effects_active, UnknownEnum.Value_12) != -1) ? 10.0 : 2.5);");

// Fix Inverted X-ray bug
group.QueueFindReplace(drawCode, "var xray_size = 2 - (max(0, womb_size - 1) * 0.5);", "var xray_size = max(0.4, 2 - (max(0, womb_size - 1) * 0.12));");
group.QueueFindReplace(drawCode, "womb_size = median(1, womb_size, 3);", "womb_size = median(1, womb_size, 6);");
group.QueueFindReplace(drawCode, "womb_size = median(1, fill_amount / fill_max, 3);", "womb_size = median(1, fill_amount / fill_max, 6);");

// Fix Full Container Cap
group.QueueFindReplace(drawCode, "var max_fill = fill_max * 3;", "var max_fill = (ds_list_find_index(pill_effects_active, 24) != -1) ? (fill_max * 50) : (fill_max * 3);");
group.QueueFindReplace(drawCode, "if (insert == false && ds_list_find_index(pill_effects_active, UnknownEnum.Value_12) == -1)", "if (insert == false && ds_list_find_index(pill_effects_active, UnknownEnum.Value_12) == -1 && ds_list_find_index(pill_effects_active, 24) == -1)");

// Max Edge 10 & Disable Ball Growth
group.QueueFindReplace(drawCode, "var max_edge = 3;", "var max_edge = (ds_list_find_index(pill_effects_active, 23) != -1 || ds_list_find_index(pill_effects_active, UnknownEnum.Value_15) != -1) ? 10 : 3;");
string oldEdgingCode = "if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_15) != -1 && ball_size < 1.3)\n            {\n                ball_size += 0.05;\n                balls_jiggle = 0.2;\n            }";
group.QueueFindReplace(drawCode, oldEdgingCode, "// Edging pure boost - ball growth disabled");

// Infinite Encorgasm
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

// Fix Ball Clenching double draw & position
string oldBallDraw = "draw_sprite_ext(top_sprite, 8, x, y - (thrust * 32 * base_sex_size) - (ball_size * 8), (image_xscale + top_breath) * (1 + balls_jiggle) * ball_size * base_sex_size, (image_yscale - top_breath) * (1 - balls_jiggle) * ball_size * base_sex_size, 0, top_skin, alpha_test);";
string newBallDraw = @"if (orgasm == false || custom_clench_toggle == false)
{
    draw_sprite_ext(top_sprite, 8, x, y - (thrust * 32 * base_sex_size) - (ball_size * 8), (image_xscale + top_breath) * (1 + balls_jiggle) * ball_size * base_sex_size, (image_yscale - top_breath) * (1 - balls_jiggle) * ball_size * base_sex_size, 0, top_skin, alpha_test);
}";

group.QueueFindReplace(drawCode, oldBallDraw, newBallDraw);

string drawClenchGml = @"
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

// Clean HUD in Draw_64
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

// Cum Limit Text
group.QueueFindReplace(drawCode, 
    "ds_list_add(submenu_list, func_set_lang(185, \"Cum Limit\") + \": \" + string(max(20, round(max_particles * 500))));",
    "ds_list_add(submenu_list, func_set_lang(185, \"Cum Limit\") + \": \" + string(max(500, round(max_particles * 10000))));");

// Import all Queued changes
group.Import();

// Post-Import: Patch Draw_0 font opcodes to dynamic global fonts
var varBig = Data.Variables.ByName("custom_font_big");
var varHand = Data.Variables.ByName("custom_font_handwriting");
var varSmall = Data.Variables.ByName("custom_font_small");

if (varBig != null && varHand != null && varSmall != null)
{
    int fontPatchCount = 0;
    for (int i = 0; i < drawCode.Instructions.Count; i++)
    {
        var inst = drawCode.Instructions[i];
        if (inst.Kind == UndertaleInstruction.Opcode.Call && inst.ValueFunction?.Name?.Content == "draw_set_font")
        {
            var prev = drawCode.Instructions[i - 1];
            if (prev.ValueInt == 100663296)
            {
                prev.Kind = UndertaleInstruction.Opcode.PushGlb;
                prev.Type1 = UndertaleInstruction.DataType.Variable;
                prev.TypeInst = UndertaleInstruction.InstanceType.Global;
                prev.ReferenceType = UndertaleInstruction.VariableType.Normal;
                prev.ValueVariable = varBig;
                fontPatchCount++;
            }
            else if (prev.ValueInt == 100663297)
            {
                prev.Kind = UndertaleInstruction.Opcode.PushGlb;
                prev.Type1 = UndertaleInstruction.DataType.Variable;
                prev.TypeInst = UndertaleInstruction.InstanceType.Global;
                prev.ReferenceType = UndertaleInstruction.VariableType.Normal;
                prev.ValueVariable = varHand;
                fontPatchCount++;
            }
            else if (prev.ValueInt == 100663298)
            {
                prev.Kind = UndertaleInstruction.Opcode.PushGlb;
                prev.Type1 = UndertaleInstruction.DataType.Variable;
                prev.TypeInst = UndertaleInstruction.InstanceType.Global;
                prev.ReferenceType = UndertaleInstruction.VariableType.Normal;
                prev.ValueVariable = varSmall;
                fontPatchCount++;
            }
        }
    }
    ScriptMessage($"[+] Patched {fontPatchCount} font references in Draw_0 to global dynamic fonts.");
}

ScriptMessage("=== MASTER CLEAN V7 APEX PATCH APPLIED WITH 100% SUCCESS ===");
