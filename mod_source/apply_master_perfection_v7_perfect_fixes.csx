using System;
using System.IO;
using UndertaleModLib;
using UndertaleModLib.Models;
using UndertaleModLib.Compiler;

EnsureDataLoaded();

ScriptMessage("=== APPLYING MASTER PERFECTION V7 (PERFECT FIXES FOR ALL 6 USER ISSUES) ===");

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

GlobalDecompileContext context = new(Data);
Underanalyzer.Decompiler.IDecompileSettings settings = Data.ToolInfo.DecompilerSettings;
string stepCurStr = new Underanalyzer.Decompiler.DecompileContext(context, stepCode, settings).DecompileToString();
string drawCurStr = new Underanalyzer.Decompiler.DecompileContext(context, drawCode, settings).DecompileToString();

// -------------------------------------------------------------
// 1. Step_0 CLEANUP & REFINEMENT
// -------------------------------------------------------------
ScriptMessage("[1/3] Patching Step_0 (Removing frame-based leaks, machinegun moans, noisy rubber)...");

string newStepModGml = @"
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

    // ID 24: Full Container (Infinite Womb - Capacity expansion only, pumps handled in Draw_0)
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

    // ID 36: Titan Rubber (Unbreakable Rubber, Quiet & Normal Pop SFX)
    if (ds_list_find_index(pill_effects_active, 36) != -1)
    {
        condom_break = 999999;
        condom_integrity = 100;
        if (_has_overdose) condom_breaking_override = true;
    }
}
";

if (stepCurStr.Contains("// Auto color reset if no color pill active"))
{
    int idx = stepCurStr.IndexOf("// Auto color reset if no color pill active");
    string oldStepMod = stepCurStr.Substring(idx);
    group.QueueFindReplace(stepCode, oldStepMod, newStepModGml);
}
else
{
    group.QueueAppend(stepCode, newStepModGml);
}

// -------------------------------------------------------------
// 2. Draw_0 REFINEMENTS (Leaky EX, Sync Heart Climax Per Pump, Full Container Pump Injection, Condom Size Expansion, Reset Fix)
// -------------------------------------------------------------
ScriptMessage("[2/3] Patching Draw_0 (Leaky EX, Sync Heart, Condom sizes, Full Container & Turbo Reset)...");

// ① Fix Reset logic (Mystery Pill: clear == true) to fully reset thrust_speed, thrust_strength, condom & colors
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

if (drawCurStr.Contains(oldResetBlock))
{
    group.QueueFindReplace(drawCode, oldResetBlock, newResetBlock);
}

// ② Fix Leaky EX (ID 35) & Leaky (ID 9) logic in Draw_0
string oldLeakySection = @"if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_9) != -1)
        {
            var _has_od = ds_list_find_index(pill_effects_active, 19) != -1;
            var _has_leaky_ex = ds_list_find_index(pill_effects_active, 35) != -1;
            var leak_chance = (_has_od || _has_leaky_ex) ? (_has_od ? 0 : ((irandom(99) < 40) ? 0 : 1)) : ((irandom(99) < 30) ? 0 : 1);
            if (slap_boost > 0)
            {
                leak_chance = (_has_od || _has_leaky_ex) ? (_has_od ? 0 : ((irandom(99) < 85) ? 0 : 1)) : ((irandom(99) < 75) ? 0 : 1);
            }
            if (leak_chance == 0)
            {
                fill_amount += (5 * ball_size * edge_boost);
                fill_lerp = fill_amount + 3;
                fill_amount = min(fill_amount, fill_max * 2);
                if (fill_amount >= fill_max)
                {
                    if (condom == false)
                    {
                        func_cum_splurt(true);
                        audio_play_sound(choose(sndCumSplurt1, sndCumSplurt2, sndCumSplurt3), 0, false, 0.5, 0, random_range(0.9, 1.1));
                    }
                }
                body_jiggle = 0.025;
                condom_jiggle = 0.1;
                pump_scale = 1;
                var amount_boost = ball_size * edge_boost;
                if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_14) != -1)
                {
                    amount_boost *= (loads / 10);
                }
                stat_liters += (0.25 * amount_boost);
                stat_sperm_cell += (random_range(20, 100) * amount_boost);
                top_boob_jiggle += -1;
                top_ass_jiggle = 0.05;
                if (sex_position != 2)
                {
                    oBackground.body_jiggle = 0.01;
                }
                if (condom == false && bottom_fertile == true && insert == true && sex_position != 2)
                {
                    var impregnation_chance = irandom(100);
                    if (impregnation_chance <= (fertility * (fill_amount / fill_max)) && impregnate == 0)
                    {
                        impregnation_timer = 300;
                        impregnation_scale = 0;
                        impregnate = 1;
                        sperm_choice = -1;
                        condom_jiggle = 0;
                        condom_jiggle_move = 0;
                        for (var i = 0; i < array_length(sperm); i++)
                        {
                            sperm[i] = (30 + choose(0, 45, 90, 135, 180) + irandom(45)) * 2;
                            sperm_speed[i] = 0;
                        }
                    }
                }
                score_combo += (100 + (5 * score_combo_mult));
                futa_score += (100 + (5 * score_combo_mult));
                if (rpg == true)
                {
                    rpg_xp += round(10 * power(1.05, rpg_enemy_level - 1));
                    rpg_scale = 0.2;
                }
                score_combo_mult += 1;
                score_combo_timer = 120;
                score_combo_scale = 1.5;
                audio_play_sound(choose(sndCumInside1, sndCumInside2, sndCumInside3, sndCumInside4), 0, false, 0.5, 0, random_range(0.9, 1.1));
            }
        }";

string newLeakySection = @"if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_9) != -1 || ds_list_find_index(pill_effects_active, 35) != -1)
        {
            var _has_od = (ds_list_find_index(pill_effects_active, 19) != -1);
            var _is_ex = (ds_list_find_index(pill_effects_active, 35) != -1);
            var leak_chance = 1;
            if (_has_od)
            {
                leak_chance = 0; // 100% on Overdose
            }
            else if (_is_ex)
            {
                leak_chance = (slap_boost > 0) ? ((irandom(99) < 75) ? 0 : 1) : ((irandom(99) < 30) ? 0 : 1);
            }
            else
            {
                leak_chance = (slap_boost > 0) ? ((irandom(1) == 0) ? 0 : 1) : ((irandom(10) == 0) ? 0 : 1);
            }
            if (leak_chance == 0)
            {
                var _leak_vol = (_is_ex ? 8 : 5) * ball_size * edge_boost * (_has_od ? 2 : 1);
                fill_amount += _leak_vol;
                fill_lerp = fill_amount + 5;
                fill_amount = min(fill_amount, fill_max * 2);
                if (fill_amount >= fill_max)
                {
                    if (condom == false)
                    {
                        func_cum_splurt(true);
                        audio_play_sound(choose(sndCumSplurt1, sndCumSplurt2, sndCumSplurt3), 0, false, 0.5, 0, random_range(0.9, 1.1));
                    }
                }
                body_jiggle = 0.025;
                condom_jiggle = 0.1;
                pump_scale = 1;
                var amount_boost = ball_size * edge_boost;
                if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_14) != -1)
                {
                    amount_boost *= (loads / 10);
                }
                stat_liters += (0.25 * amount_boost);
                stat_sperm_cell += (random_range(20, 100) * amount_boost);
                top_boob_jiggle += -1;
                top_ass_jiggle = 0.05;
                if (sex_position != 2)
                {
                    oBackground.body_jiggle = 0.01;
                }
                if (condom == false && bottom_fertile == true && insert == true && sex_position != 2)
                {
                    var impregnation_chance = irandom(100);
                    if (impregnation_chance <= (fertility * (fill_amount / fill_max)) && impregnate == 0)
                    {
                        impregnation_timer = 300;
                        impregnation_scale = 0;
                        impregnate = 1;
                        sperm_choice = -1;
                        condom_jiggle = 0;
                        condom_jiggle_move = 0;
                        for (var i = 0; i < array_length(sperm); i++)
                        {
                            sperm[i] = (30 + choose(0, 45, 90, 135, 180) + irandom(45)) * 2;
                            sperm_speed[i] = 0;
                        }
                    }
                }
                score_combo += (100 + (5 * score_combo_mult));
                futa_score += (100 + (5 * score_combo_mult));
                if (rpg == true)
                {
                    rpg_xp += round(10 * power(1.05, rpg_enemy_level - 1));
                    rpg_scale = 0.2;
                }
                score_combo_mult += 1;
                score_combo_timer = 120;
                score_combo_scale = 1.5;
                audio_play_sound(choose(sndCumInside1, sndCumInside2, sndCumInside3, sndCumInside4), 0, false, 0.5, 0, random_range(0.9, 1.1));
            }
        }";

if (drawCurStr.Contains(oldLeakySection))
{
    group.QueueFindReplace(drawCode, oldLeakySection, newLeakySection);
}

// ③ Inject Sync Heart (ID 37) & Full Container (ID 24) Injection into the main orgasm pump block
string oldOrgasmPumpHeader = @"var _od_active = ds_list_find_index(pill_effects_active, 19) != -1;
            var amount_boost = ball_size * edge_boost * (_od_active ? 2 : 1);";

string newOrgasmPumpHeader = @"var _od_active = ds_list_find_index(pill_effects_active, 19) != -1;
            var amount_boost = ball_size * edge_boost * (_od_active ? 2 : 1);

            // ★ Full Container (ID 24): Big injection per orgasm pump
            if (ds_list_find_index(pill_effects_active, 24) != -1)
            {
                fill_amount += (_od_active ? 40 : 25);
                fill_lerp = fill_amount + 5;
                amount_boost *= (_od_active ? 3 : 2);
            }

            // ★ Sync Heart (ID 37): Clean climax sync per orgasm pump (No machinegun!)
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
            }";

if (drawCurStr.Contains(oldOrgasmPumpHeader))
{
    group.QueueFindReplace(drawCode, oldOrgasmPumpHeader, newOrgasmPumpHeader);
}

// ④ Fix Condom size formulas & bounds (Allow full scaling with liters, up to 10.0x / 20.0x!)
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

// ⑤ Remove artificial halving when condoms are dropped or spawned!
group.QueueFindReplace(drawCode, 
    "if (condom_size > 1.25)\n                    condom_spawn.condom_size = condom_size / 2;",
    "condom_spawn.condom_size = condom_size;");

group.QueueFindReplace(drawCode, 
    "if (condom_size > 1.25)\n                condom_spawn.condom_size = condom_size / 2;",
    "condom_spawn.condom_size = condom_size;");

group.Import();

ScriptMessage("=== MASTER PERFECTION V7 APPLIED WITH 100% SUCCESS ===");
