using System;
using System.IO;
using UndertaleModLib;
using UndertaleModLib.Models;
using UndertaleModLib.Compiler;

EnsureDataLoaded();

ScriptMessage("=== APPLYING MASTER PERFECTION V6 APEX PATCH (ALL NEW PILLS + 10x UI + GROWTH CASCADE) ===");

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

// -------------------------------------------------------------
// 1. Create_0: Limits 3x, Rating 10x, Subfolder Scanner, BallClenching Sprites
// -------------------------------------------------------------
ScriptMessage("[1/4] Patching Create_0 max limits, rating 10x func & assets...");

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

// -------------------------------------------------------------
// 2. Step_0 (Pills 0..37, Sensual Moan, Leaky EX, Titan Rubber, Sync Heart)
// -------------------------------------------------------------
ScriptMessage("[2/4] Patching Step_0 with 38 pills, new synergies & mechanics...");

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

// Check if old stepModGml already exists, if so we replace it; otherwise append
string stepModGml = @"
// Auto color reset if no color pill active
var _has_color_pill = (ds_list_find_index(pill_effects_active, 11) != -1 || ds_list_find_index(pill_effects_active, 21) != -1 || ds_list_find_index(pill_effects_active, 27) != -1 || ds_list_find_index(pill_effects_active, 28) != -1);
if (!_has_color_pill && top_sprite != sFutaMatingPressSlime && top_sprite != sFutaMatingPressAndroid)
{
    cum_color = 13497599; // Default natural semen color
}

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
            fill_amount += 15;
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

    // ★ ID 34: Sensual Moan (Extra pleasure boost handled in thrust block above)

    // ★ ID 35: Leaky EX (Extreme Pre-cum Overflow)
    if (ds_list_find_index(pill_effects_active, 35) != -1)
    {
        if (insert == true)
        {
            fill_amount += (_has_overdose ? 3.0 : 1.5);
            fill_lerp = fill_amount + 6;
        }
    }

    // ★ ID 36: Titan Rubber (Unbreakable High-Tension Rubber, Tight Squeak SFX)
    if (ds_list_find_index(pill_effects_active, 36) != -1)
    {
        condom_break = 999999;
        condom_integrity = 100;
        if (_has_overdose) condom_breaking_override = true;
        if (condom == true && ((insert == true && thrust > 0.8 && irandom(7) == 0) || (orgasm == true && irandom(4) == 0)))
        {
            audio_play_sound(choose(sndCondomOn, sndCloth), 0, false, 0.55, 0, random_range(0.75, 1.25));
            condom_jiggle = 0.15;
        }
    }

    // ★ ID 37: Sync Heart (Simultaneous Climax & OD Continuous Rising Orgasm)
    if (ds_list_find_index(pill_effects_active, 37) != -1)
    {
        if (orgasm == true)
        {
            if (wife_climax == false)
            {
                wife_pleasure = wife_pleasure_threshold;
                wife_climax = true;
                wife_climax_timer = 360;
                wife_climax_counter += 1;
                futa_score += 10000;
                body_jiggle = 0.08;
                bottom_ass_jiggle = 0.6;
                audio_play_sound(choose(sndMoanOrgasm1, sndMoanOrgasm2, sndMoanOrgasm3, sndMoanOrgasm5), 0, false, 0.9, 0, 1.0);
                part_particles_create(global.ps_back, x + random_range(-64, 64), (y - 40) + random_range(-32, 32), part_love, 10);
            }
            if (_has_overdose)
            {
                var _p_done = max(0, orgasm_pumps_max - orgasm_pumps);
                var _s_vol = min(1.0, 0.6 + (_p_done * 0.08));
                var _s_pitch = min(1.6, 0.95 + (_p_done * 0.07));
                wife_climax = true;
                wife_climax_timer = 180;
                futa_score += 5000;
                body_jiggle = 0.1;
                bottom_ass_jiggle = 0.8;
                if (irandom(2) == 0)
                {
                    audio_play_sound(choose(sndMoanOrgasm1, sndMoanOrgasm2, sndMoanOrgasm3, sndMoanOrgasm5), 0, false, _s_vol, 0, _s_pitch);
                    part_particles_create(global.ps_back, x + random_range(-96, 96), (y - 40) + random_range(-48, 48), part_love, 5);
                }
            }
        }
    }
}
";

// If Step_0 already had stepModGml from v5, let's find the header or append cleanly
string oldStepHeader = "// Auto color reset if no color pill active";
var stepDecompiled = stepCode.Instructions; // We can use QueueFindReplace if present
// Let's replace the whole block if it exists, or append if not
// To be 100% clean, let's use decompiler check
GlobalDecompileContext context = new(Data);
Underanalyzer.Decompiler.IDecompileSettings settings = Data.ToolInfo.DecompilerSettings;
string stepCurStr = new Underanalyzer.Decompiler.DecompileContext(context, stepCode, settings).DecompileToString();

if (stepCurStr.Contains("// Auto color reset if no color pill active"))
{
    // Find from "// Auto color reset" to end
    int idx = stepCurStr.IndexOf("// Auto color reset if no color pill active");
    string oldStepMod = stepCurStr.Substring(idx);
    group.QueueFindReplace(stepCode, oldStepMod, stepModGml);
}
else
{
    group.QueueAppend(stepCode, stepModGml);
}

// -------------------------------------------------------------
// 3. Draw_0: Submenu (38 pills, 3 columns), 10x Rating UI, Growth Cascade Limit 3.0x, Moaning & Leaky EX
// -------------------------------------------------------------
ScriptMessage("[3/4] Patching Draw_0 submenu 38 pills, 10x rating UI, growth cascade limit & moaning...");

string drawCurStr = new Underanalyzer.Decompiler.DecompileContext(context, drawCode, settings).DecompileToString();

// Replace submenu items (Add IDs 34, 35, 36, 37)
string oldSubmenuPillGml = "ds_list_add(submenu_list, [func_set_lang(230, \"Epilogue Dream\"), 33]);";
string newSubmenuPillGml = @"ds_list_add(submenu_list, [func_set_lang(230, ""Epilogue Dream""), 33]);
                ds_list_add(submenu_list, [func_set_lang(231, ""Sensual Moan""), 34]);
                ds_list_add(submenu_list, [func_set_lang(232, ""Leaky EX""), 35]);
                ds_list_add(submenu_list, [func_set_lang(233, ""Titan Rubber""), 36]);
                ds_list_add(submenu_list, [func_set_lang(234, ""Sync Heart""), 37]);";

if (drawCurStr.Contains(oldSubmenuPillGml))
{
    group.QueueFindReplace(drawCode, oldSubmenuPillGml, newSubmenuPillGml);
}

// Layout submenu 3: 3 columns of 13 items for perfect fit
string oldSubmenuLayout = @"if (submenu == 3)
            {
                var _col = floor(i / 17);
                var _row = i % 17;
                submenu_x = room_width - 96 - (124 * _col);
                submenu_y = room_height - 24 - (29 * _row);
                _btn_w = 58;
                _spr_w = 8;
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

if (drawCurStr.Contains(oldSubmenuLayout))
{
    group.QueueFindReplace(drawCode, oldSubmenuLayout, newSubmenuLayout);
}

// 10x Rating UI
string oldRatingUiCode = @"if (button_press == true)
            {
                draw_set_font(global.custom_font_small);
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

if (drawCurStr.Contains(oldRatingUiCode))
{
    group.QueueFindReplace(drawCode, oldRatingUiCode, newRatingUiCode);
}

// Growth Cascade (ID 14) Growth Limit Fix (Up to 3.0x with Overdose!)
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

if (drawCurStr.Contains(oldGrowthCode))
{
    group.QueueFindReplace(drawCode, oldGrowthCode, newGrowthCode);
}

// Moaning Sensual Moan (ID 34)
string oldMoanLine = @"if (ds_list_find_index(pill_effects_active, 22) != -1 || ds_list_find_index(pill_effects_active, UnknownEnum.Value_10) != -1)
                {
                    moan_chance = (ds_list_find_index(pill_effects_active, 19) != -1) ? 0 : (irandom(99) < 85 ? 0 : 1);
                }";

string newMoanLine = @"if (ds_list_find_index(pill_effects_active, 34) != -1 || ds_list_find_index(pill_effects_active, 22) != -1 || ds_list_find_index(pill_effects_active, UnknownEnum.Value_10) != -1)
                {
                    moan_chance = (ds_list_find_index(pill_effects_active, 19) != -1) ? 0 : (irandom(99) < 95 ? 0 : 1);
                    moan_pitch = random_range(0.85, 1.25);
                }";

if (drawCurStr.Contains(oldMoanLine))
{
    group.QueueFindReplace(drawCode, oldMoanLine, newMoanLine);
}

// Leaky EX (ID 35) & Leaky (ID 9)
string oldLeakyLine = @"var _has_od = (ds_list_find_index(pill_effects_active, 19) != -1);
            var leak_chance = _has_od ? 0 : (irandom(99) < 30 ? 0 : 1);
            if (slap_boost > 0)
            {
                leak_chance = _has_od ? 0 : (irandom(99) < 75 ? 0 : 1);
            }";

string newLeakyLine = @"var _has_od = (ds_list_find_index(pill_effects_active, 19) != -1);
            var _has_leaky_ex = (ds_list_find_index(pill_effects_active, 35) != -1);
            var leak_chance = (_has_od || _has_leaky_ex) ? (_has_od ? 0 : (irandom(99) < 40 ? 0 : 1)) : (irandom(99) < 30 ? 0 : 1);
            if (slap_boost > 0)
            {
                leak_chance = (_has_od || _has_leaky_ex) ? (_has_od ? 0 : (irandom(99) < 85 ? 0 : 1)) : (irandom(99) < 75 ? 0 : 1);
            }";

if (drawCurStr.Contains(oldLeakyLine))
{
    group.QueueFindReplace(drawCode, oldLeakyLine, newLeakyLine);
}

group.Import();

ScriptMessage("=== MASTER PERFECTION V6 APEX PATCH APPLIED WITH 100% SUCCESS ===");
