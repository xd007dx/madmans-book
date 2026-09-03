using System;
using System.IO;
using UndertaleModLib;
using UndertaleModLib.Models;
using UndertaleModLib.Compiler;

EnsureDataLoaded();

ScriptMessage("=== APPLYING CLEAN MASTER V9 (MACHINE GUN CLIMAX, 7777 OD, SMART BALL SIZE, UI GUARD & FONT SWITCH) ===");

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

string createApexGml = @"
global.custom_font_big = 100663296;
global.custom_font_handwriting = 100663297;
global.custom_font_small = 100663298;

global.orig_font_big = 100663296;
global.orig_font_handwriting = 100663297;
global.orig_font_small = 100663298;

var _fpath = working_directory + ""language/font.ttf"";
if (!file_exists(_fpath)) _fpath = ""language/font.ttf"";
if (file_exists(_fpath)) {
    var _fbig = font_add(_fpath, 14, false, false, 32, 65535);
    var _fhand = font_add(_fpath, 12, false, false, 32, 65535);
    var _fsmall = font_add(_fpath, 8, false, false, 32, 65535);
    if (_fbig != -1) global.custom_font_big = _fbig;
    if (_fhand != -1) global.custom_font_handwriting = _fhand;
    if (_fsmall != -1) global.custom_font_small = _fsmall;
} else if (file_exists(""C:/Windows/Fonts/msgothic.ttc"")) {
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
current_condom_has_cum = false;

custom_clench_toggle = true;
custom_bc_mating_press = [-1, -1, -1, -1, -1];
custom_bc_cowgirl = [-1, -1, -1, -1, -1];
custom_bc_loaded = false;

function func_load_bc_sprites()
{
    if (custom_lover_selected > -1 && ds_list_size(custom_lover_folders) > custom_lover_selected)
    {
        var _base_path = ds_list_find_value(custom_lover_folders, custom_lover_selected);
        var _bc_dir = _base_path + ""/BallsClench"";
        
        var _spr_origin_x = sprite_get_xoffset(sFutaMatingPressNormal);
        var _spr_origin_y = sprite_get_yoffset(sFutaMatingPressNormal);
        if (custom_lover_info_loaded && ds_map_exists(custom_lover_info, ""sprite_origin_x""))
        {
            _spr_origin_x = ds_map_find_value(custom_lover_info, ""sprite_origin_x"");
            _spr_origin_y = ds_map_find_value(custom_lover_info, ""sprite_origin_y"");
        }
        
        for (var _f = 0; _f < 5; _f++)
        {
            var _p_mp = _bc_dir + ""/custom_futa_mating_press_0_bc_"" + string(_f) + "".png"";
            if (file_exists(_p_mp))
            {
                custom_bc_mating_press[_f] = sprite_add(_p_mp, 1, false, false, _spr_origin_x, _spr_origin_y);
            }
            else
            {
                custom_bc_mating_press[_f] = -1;
            }
            
            var _p_cg = _bc_dir + ""/custom_futa_cowgirls_0_bc_"" + string(_f) + "".png"";
            if (file_exists(_p_cg))
            {
                custom_bc_cowgirl[_f] = sprite_add(_p_cg, 1, false, false, _spr_origin_x, _spr_origin_y);
            }
            else
            {
                custom_bc_cowgirl[_f] = -1;
            }
        }
        custom_bc_loaded = true;
    }
}
";

group.QueueAppend(createCode, createApexGml);

// =============================================================
// 2. Step_0: Clean Logic, Machine Gun Climax, 7777 OD, Smart Ball & Slap Acceleration
// =============================================================
ScriptMessage("[2/4] Patching Step_0 with 41 pills, Machine Gun Climax & Smart Ball Size...");

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

// Auto speed & strength recovery (Preserves slap_boost acceleration!)
if (ds_list_find_index(pill_effects_active, 20) == -1 && ds_list_find_index(pill_effects_active, 38) == -1 && (orgasm == false || ds_list_find_index(pill_effects_active, UnknownEnum.Value_16) == -1))
{
    if (slap_boost <= 0)
    {
        thrust_speed = 2;
        thrust_strength = 3;
    }
}

// Wife pleasure build-up during thrust (Natural Balanced Pacing)
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
    for (var _p = 18; _p <= 40; _p++)
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

    // ID 18: Petite Titan (0.65x Body Size, Overdose: 2.8x Length & 2.2x Width Penis!)
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

    // ID 19: Overdose (Catalyst / Synergy Amplifier)
    if (_has_overdose)
    {
        thrust_strength = max(thrust_strength, 8);
        if (max_loads < 30 && max_loads > 0 && loads == 0) max_loads = max_loads * 2;

        if (ds_list_find_index(pill_effects_active, 1) != -1) // Overdose + Mega Sperm (Smart Ball Size max 1.4x)
        {
            ball_size = max(ball_size, 1.4);
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

    // ID 23: Edge Meister (Pure Edge Boost - Instant 10x with OD)
    if (ds_list_find_index(pill_effects_active, 23) != -1)
    {
        if (_has_overdose) edge_boost = 10;
        else edge_boost = min(10, edge_boost);
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

    // ID 30: Casino Lucky (100% 777 or 7777 Fever!)
    if (ds_list_find_index(pill_effects_active, 30) != -1 && orgasm == true)
    {
        futa_score += (_has_overdose ? 7777 : 777);
    }

    // ID 31: Time Delay -> Machine Gun Climax (Rapid Pump Speed)
    if (ds_list_find_index(pill_effects_active, 31) != -1 && orgasm == true && orgasm_timer > 5)
    {
        orgasm_timer -= (_has_overdose ? 3 : 2);
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

    // ID 38: Titan Thrust (Ultra Powerful Thrust Strength: Normal 20, Overdose 35!)
    if (ds_list_find_index(pill_effects_active, 38) != -1)
    {
        thrust_strength = _has_overdose ? 35 : 20;
        thrust_speed = max(thrust_speed, 3);
    }
}
";

group.QueueAppend(stepCode, cleanStepModGml);

// =============================================================
// 3. Draw_0: Submenu (41 pills), UI Click Guard, Condom Empty Pullout Fix & Dynamic Font
// =============================================================
ScriptMessage("[3/4] Patching Draw_0 with UI Guard, Empty Condom Fix & Dynamic Font Switch...");

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
                                    current_condom_has_cum = false;
                                    clear = true;
                                    ds_list_clear(pill_effects_active);
                                }";

group.QueueFindReplace(drawCode, oldResetBlock, newResetBlock);

// Submenu registration for 41 pills (0..40)
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
                ds_list_add(submenu_list, [func_set_lang(234, ""Sync Heart""), 37]);
                ds_list_add(submenu_list, [func_set_lang(235, ""Titan Thrust""), 38]);
                ds_list_add(submenu_list, [func_set_lang(236, ""Thrust Surge""), 39]);
                ds_list_add(submenu_list, [func_set_lang(237, ""Pump Surge""), 40]);";

group.QueueFindReplace(drawCode, oldSubmenuPillGml, newSubmenuPillGml);

// Language select close submenu fix
string oldLangSelectCase = @"case 4:
                        audio_play_sound(sndSelect, 0, 0);
                        language_selected = i;
                        func_load_language(ds_list_find_value(language_folders, language_selected));
                        break;";

string newLangSelectCase = @"case 4:
                        audio_play_sound(sndSelect, 0, 0);
                        language_selected = i;
                        func_load_language(ds_list_find_value(language_folders, language_selected));
                        submenu = -1;
                        break;";

group.QueueFindReplace(drawCode, oldLangSelectCase, newLangSelectCase);

// Font set hook: Switch between pixel font for English and TTF font for Japanese
string oldFontSetBig = "draw_set_font(global.custom_font_big);";
string newFontSetBig = @"if (language_selected == 0) draw_set_font(global.orig_font_big);
else draw_set_font(global.custom_font_big);";
group.QueueFindReplace(drawCode, oldFontSetBig, newFontSetBig);

// UI Click Guard: Disable penis_grab when menus are active
string oldPenisGrabCheck = "var thrust_set = 0;";
string newPenisGrabCheck = @"if (submenu != -1 || custom_menu == true)
{
    penis_grab = false;
}
var thrust_set = 0;";
group.QueueFindReplace(drawCode, oldPenisGrabCheck, newPenisGrabCheck);

// Empty condom pullout fix: Check current_condom_has_cum
string oldPulloutCondom = @"if (condom == true)
        {
            condom_size = min((ds_list_find_index(pill_effects_active, 24) != -1) ? ((ds_list_find_index(pill_effects_active, 19) != -1) ? 20 : 10) : 6, stat_liters / 2.5);
            fill_amount = 0;
            womb_size = 1;
            womb_size_lerp = 1;
        }";

string newPulloutCondom = @"if (condom == true)
        {
            if (current_condom_has_cum == true)
            {
                condom_size = min((ds_list_find_index(pill_effects_active, 24) != -1) ? ((ds_list_find_index(pill_effects_active, 19) != -1) ? 20 : 10) : 6, stat_liters / 2.5);
            }
            else
            {
                condom_size = 0;
            }
            fill_amount = 0;
            womb_size = 1;
            womb_size_lerp = 1;
        }";

group.QueueFindReplace(drawCode, oldPulloutCondom, newPulloutCondom);

// Flag when orgasm pump fills condom
string oldOrgasmCondomFill = "stat_liters += (0.25 * amount_boost);";
string newOrgasmCondomFill = @"stat_liters += (0.25 * amount_boost);
            if (condom == true) current_condom_has_cum = true;";
group.QueueFindReplace(drawCode, oldOrgasmCondomFill, newOrgasmCondomFill);

// Leaky vs Leaky EX differentiation
string oldLeakyBlock = @"if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_9) != -1 || ds_list_find_index(pill_effects_active, 35) != -1)
        {
            var _has_od = ds_list_find_index(pill_effects_active, 19) != -1;
            var _is_ex = ds_list_find_index(pill_effects_active, 35) != -1;
            if (_has_od) leak_chance = 0;
            else if (_is_ex) leak_chance = (slap_boost > 0) ? ((irandom(99) < 75) ? 0 : 1) : ((irandom(99) < 30) ? 0 : 1);
            else leak_chance = (slap_boost > 0) ? ((irandom(1) == 0) ? 0 : 1) : ((irandom(10) == 0) ? 0 : 1);";

string newLeakyBlock = @"if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_9) != -1 || ds_list_find_index(pill_effects_active, 35) != -1)
        {
            var _has_od = ds_list_find_index(pill_effects_active, 19) != -1;
            var _is_ex = ds_list_find_index(pill_effects_active, 35) != -1;
            if (_is_ex) {
                leak_chance = _has_od ? 0 : ((slap_boost > 0) ? ((irandom(99) < 75) ? 0 : 1) : ((irandom(99) < 30) ? 0 : 1));
            } else {
                leak_chance = (slap_boost > 0) ? 0 : (_has_od ? ((irandom(10) < 2) ? 0 : 1) : ((irandom(10) == 0) ? 0 : 1));
            }";

group.QueueFindReplace(drawCode, oldLeakyBlock, newLeakyBlock);

// 10-scale Rating UI
string oldRatingLoopGml = "for (var j = 0; j < 6; j++)";
string newRatingLoopGml = "for (var j = 0; j < 10; j++)";
group.QueueFindReplace(drawCode, oldRatingLoopGml, newRatingLoopGml);

// =============================================================
// 4. Draw_64: HUD Text & Font Switch
// =============================================================
ScriptMessage("[4/4] Patching Draw_64 HUD text & font switch...");

string oldDraw64Font = "draw_set_font(global.custom_font_small);";
string newDraw64Font = @"if (language_selected == 0) draw_set_font(global.orig_font_small);
else draw_set_font(global.custom_font_small);";
group.QueueFindReplace(draw64Code, oldDraw64Font, newDraw64Font);

group.Import();

ScriptMessage("=== CLEAN MASTER V9 APPLIED SUCCESSFULLY! ===");
