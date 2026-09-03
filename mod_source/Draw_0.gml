var top_breath = (dcos(current_time / 10) * 0.02) + body_jiggle;
var bottom_breath = (dcos((current_time + 200) / 10) * 0.02) - body_jiggle;
var boob_press = false;
var mouth_press = false;
var headpat_press = false;
var top_quality = 1 * top_penis_width * top_penis_length * ball_size * top_boob_size * top_ass_size;
if (ds_list_size(pill_effects_active) > 0)
{
    for (var i = 0; i < ds_list_size(pill_effects_active); i++)
    {
        switch (ds_list_find_value(pill_effects_active, i))
        {
            case UnknownEnum.Value_5:
            case UnknownEnum.Value_9:
            case UnknownEnum.Value_1:
                top_quality *= 2;
                break;
            case UnknownEnum.Value_2:
            case UnknownEnum.Value_3:
                top_quality *= 3;
                break;
            case UnknownEnum.Value_10:
                top_quality *= 10;
                break;
            case UnknownEnum.Value_7:
                top_quality *= 100;
                break;
        }
    }
}
var insert_thrust = 0;
if (insert == true)
{
    insert_thrust = thrust;
}
part_system_drawit(global.ps_back);
draw_set_font(global.custom_font_big);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
var cum_color_back = 0;
if (!surface_exists(outline_surface))
{
    outline_surface = surface_create(room_width, room_height);
}
surface_set_target(outline_surface);
draw_clear_alpha(c_white, 0);
part_system_drawit(global.ps);
with (oCum)
{
    draw_sprite_ext(sCum, 0, x, y, image_xscale, image_yscale, 0, other.cum_color, 1);
}
surface_reset_target();
part_type_alpha1(part_precum, 0.5 - (0.4 * cum_outline));
var base_sex_size = 2;
if (instance_exists(oBackground) && condom_strip > 0 && oBackground.allow_condom_strip == true && custom_lover_selected == -1)
{
    var strip_x = 80;
    var strip_y = 70 + (oBackground.table_bounce_amount * oBackground.body_jiggle);
    for (var i = 0; i < min(2, condom_strip); i++)
    {
        draw_sprite_ext(sCondomStrip, 0, x + (strip_x * base_sex_size), y + (strip_y * base_sex_size) + (((4 * i) - 8) * base_sex_size), base_sex_size, base_sex_size, 0, condom_color, 1);
    }
    if (condom_strip > 2)
    {
        for (var i = 2; i < condom_strip; i++)
        {
            draw_sprite_ext(sCondomStrip, 1, x + (strip_x * base_sex_size), y + (strip_y * base_sex_size) + (((22 * i) - 50) * base_sex_size), base_sex_size, base_sex_size, 0, condom_color, 1);
        }
    }
    if (insert == false && orgasm == false && point_in_rectangle(mouse_x, mouse_y, (x + (strip_x * base_sex_size)) - 16, (y + (strip_y * base_sex_size)) - 16, x + (strip_x * base_sex_size) + 16, y + (strip_y * base_sex_size) + 16))
    {
        draw_sprite_ext(sButtonBack, 0, x + (strip_x * base_sex_size) + 80, y + (strip_y * base_sex_size), 6, 3, 0, c_white, 0.6);
        var durability_string = func_set_lang(138, "Durability") + "\n" + string(round(100 * (1 - (1 / condom_break)))) + "%";
        if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_1) != -1)
        {
            durability_string = func_set_lang(138, "Durability") + "\n" + func_set_lang(139, "N/A");
        }
        draw_text(x + (strip_x * base_sex_size) + 80, y + (strip_y * base_sex_size), durability_string);
    }
}
var max_position = 2;
if (custom_lover_selected > -1 && top_deepthroat == sFutaDeepthroat)
{
    max_position = 1;
}
if (custom_partner_selected > -1 && bottom_deepthroat == sWifeDeepthroat)
{
    max_position = 1;
}
sex_position = median(0, sex_position, max_position);
switch (sex_position)
{
    case 0:
        var bottom_sprite = bottom_mating_press;
        var alpha_test = 1;
        if (keyboard_check(ord("B")))
        {
            alpha_test = 0.5;
        }
        draw_sprite_ext(bottom_sprite, 0, x, y - (insert_thrust * 8 * base_sex_size), (image_xscale + bottom_breath) * (1 - (0.1 * insert_thrust)) * base_sex_size, (image_yscale - bottom_breath) * (1 + (0.1 * insert_thrust)) * base_sex_size, 0, bottom_skin, alpha_test);
        if (fill_amount > fill_max && cumflation == true)
        {
            var max_cumflation_size = (ds_list_find_index(pill_effects_active, 24) != -1) ? ((ds_list_find_index(pill_effects_active, 19) != -1) ? 40 : 20) : ((ds_list_find_index(pill_effects_active, UnknownEnum.Value_12) != -1) ? 10 : 2.5);
            if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_12) != -1)
            {
                max_cumflation_size = 5;
            }
            var cumflation_id = 3;
            var cumflation_amount = median(0, ((fill_amount / fill_max) - 1) / 1.5, max_cumflation_size);
            draw_sprite_ext(bottom_sprite, cumflation_id, x, y + ((32 + (4 * insert_thrust)) * base_sex_size), (image_xscale + bottom_breath) * (1 - (0.1 * insert_thrust) - median(0, 0.1, condom_jiggle)) * cumflation_amount * base_sex_size, (image_yscale - bottom_breath) * ((1 - (0.1 * insert_thrust)) + median(0, 0.1, condom_jiggle)) * cumflation_amount * base_sex_size, 0, bottom_skin, 1);
        }
        draw_sprite_ext(bottom_sprite, 1, x, y - (insert_thrust * 8 * base_sex_size), (image_xscale + bottom_breath) * (1 - (0.1 * insert_thrust)) * base_sex_size, (image_yscale - bottom_breath) * (1 + (0.1 * insert_thrust)) * base_sex_size, 0, bottom_skin, alpha_test);
        var heavy_boob_scale = 0;
        var boob_offset = (((16 * thrust) + top_boob_jiggle) - 16) + (top_boob_size * 16);
        if (custom_lover_selected != -1 && custom_heavy_boobs == true)
        {
            boob_offset = 0;
            heavy_boob_scale = 1;
        }
        draw_sprite_ext(top_sprite, 0, x, y + (boob_offset * base_sex_size), (image_xscale + top_breath) * top_boob_size * (1 + (thrust * 0.05 * heavy_boob_scale)) * base_sex_size, (image_yscale - top_breath) * top_boob_size * (1 - (thrust * 0.1 * heavy_boob_scale)) * base_sex_size, 0, top_skin, alpha_test);
        draw_sprite_ext(top_sprite, 1, x, y + (16 * thrust * base_sex_size), (image_xscale + top_breath) * base_sex_size, (image_yscale - top_breath) * base_sex_size, 0, top_skin, alpha_test);
        draw_sprite_ext(top_sprite, 2, x, y + (16 * thrust * base_sex_size), (image_xscale + top_breath) * base_sex_size, (image_yscale - top_breath) * (1 - (0.05 * thrust)) * base_sex_size, 0, top_skin, alpha_test);
        draw_sprite_ext(hair_sprite, 3, x, y + (16 * thrust * base_sex_size), (image_xscale + top_breath) * base_sex_size, (image_yscale - top_breath) * base_sex_size, 0, top_hair, alpha_test);
        if (top_sprite == sFutaMatingPressDevil)
        {
            draw_sprite_ext(top_sprite, 11, x, y - (16 * thrust * base_sex_size), (image_xscale + top_breath) * base_sex_size, (image_yscale - top_breath) * (1 - (0.5 * thrust)) * base_sex_size, 0, top_skin, alpha_test);
        }
        draw_sprite_ext(top_sprite, 4, x, y - (thrust * 32 * base_sex_size), (image_xscale + top_breath) * (1 - (0.1 * thrust)) * top_ass_size * base_sex_size, (image_yscale - top_breath) * (1 + (0.3 * thrust)) * base_sex_size, 0, top_skin, alpha_test);
        draw_sprite_ext(top_sprite, 5, x, y - (thrust * 24 * base_sex_size), (image_xscale + top_breath) * (1 - (0.1 * thrust)) * top_ass_size * base_sex_size, (image_yscale - top_breath) * (1 + (0.3 * thrust)) * base_sex_size, 0, top_skin, alpha_test);
        draw_sprite_ext(top_sprite, 6, x, (y - (thrust * 32 * base_sex_size)) + (top_ass_jiggle * 2), (image_xscale + top_breath) * ((1 - (0.1 * thrust)) + (top_ass_jiggle * 0.5)) * top_ass_size * base_sex_size, (image_yscale - top_breath) * (1 - top_ass_jiggle) * top_ass_size * base_sex_size, 0, top_skin, alpha_test);
        if (top_sprite == sFutaMatingPressDevil)
        {
            draw_sprite_ext(top_sprite, 10, x, (y - (thrust * 32 * base_sex_size)) + (top_ass_jiggle * 2), (image_xscale + top_breath) * ((1 - (0.1 * thrust)) + (top_ass_jiggle * 0.5)) * top_ass_size * base_sex_size, (image_yscale - top_breath) * (1 - top_ass_jiggle) * top_ass_size * base_sex_size, 0, top_skin, alpha_test);
        }
        if (top_sprite == sFutaMatingFurry)
        {
            draw_sprite_ext(top_sprite, 9, x, (y - (thrust * 32 * base_sex_size)) + (top_ass_jiggle * 2), (image_xscale + top_breath) * ((1 - (0.1 * thrust)) + (top_ass_jiggle * 0.5)) * top_ass_size * base_sex_size, (image_yscale - top_breath) * (1 - top_ass_jiggle) * top_ass_size * base_sex_size, 0, top_skin, alpha_test);
        }
        if (insert == true)
        {
            var penis_sprite = top_sprite;
            if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_2) != -1)
            {
                penis_sprite = sFutaMatingPressDevil;
            }
            if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_3) != -1)
            {
                penis_sprite = sFutaMatingFurry;
            }
            var internal_penis_length = 0.6 + (0.3 * thrust) + body_jiggle;
            if (custom_lover_selected != -1)
            {
                internal_penis_length *= (1 / custom_bulge_height);
            }
            draw_sprite_part_ext(penis_sprite, 7, 0, 0, sprite_get_width(penis_sprite), (min(160 + (sprite_get_yoffset(penis_sprite) - 84), sprite_get_height(penis_sprite)) - 32) + (thrust * 32), x - (sprite_get_xoffset(penis_sprite) * base_sex_size), (y + (4 * base_sex_size)) - (thrust * 32 * base_sex_size) - (sprite_get_yoffset(penis_sprite) * base_sex_size), image_xscale * base_sex_size, image_yscale * base_sex_size, top_skin, 1);
            if (condom == true || condom_broken == true)
            {
                var condom_id = 0;
                var condom_sprite = func_get_condom();
                draw_sprite_part_ext(condom_sprite, condom_id, 0, 0, sprite_get_width(penis_sprite), (min(160 + (sprite_get_yoffset(penis_sprite) - 84), sprite_get_height(penis_sprite)) - 32) + (thrust * 32), x - (sprite_get_xoffset(penis_sprite) * base_sex_size), (y + (4 * base_sex_size)) - (thrust * 32 * base_sex_size) - (sprite_get_yoffset(penis_sprite) * base_sex_size), image_xscale * base_sex_size, image_yscale * base_sex_size, condom_color, 1);
            }
        }
        draw_sprite_ext(bottom_sprite, 2, x, y - (insert_thrust * 8 * base_sex_size), (image_xscale + bottom_breath) * (1 - (0.1 * insert_thrust)) * base_sex_size, (image_yscale - bottom_breath) * (1 + (0.1 * insert_thrust)) * base_sex_size, 0, bottom_skin, alpha_test);
        if (cum_outline == true)
        {
            scrOutlineSet(1, cum_color_back, outline_surface);
        }
        draw_surface(outline_surface, 0, 0);
        if (cum_outline == true)
        {
            shader_reset();
        }
        with (oCondom)
        {
            if (grab == false)
            {
                draw_sprite_ext(sprite_index, image_index, x, y, (condom_size + condom_jiggle) * base_sex_size, (condom_size - condom_jiggle) * base_sex_size, 0, merge_color(oFutaMatingPress.cum_color, condom_color, 0.5), 1);
            }
        }
        if (insert == false)
        {
            var penis_sprite = top_sprite;
            if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_2) != -1)
            {
                penis_sprite = sFutaMatingPressDevil;
            }
            if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_3) != -1)
            {
                penis_sprite = sFutaMatingFurry;
            }
            var penis_rotate = 0;
            if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_5) != -1)
            {
                penis_rotate = 5 - (5 * thrust);
                draw_sprite_ext(penis_sprite, 7, x, y - 16 - (thrust * 32 * base_sex_size), (image_xscale + top_breath) * top_penis_width * base_sex_size, (image_yscale - top_breath) * top_penis_length * base_sex_size, -penis_rotate, top_skin, 1);
                if (condom == true || condom_broken == true)
                {
                    var condom_id = 0;
                    var condom_sprite = func_get_condom();
                    draw_sprite_ext(condom_sprite, condom_id, x, y - 16 - (thrust * 32 * base_sex_size), (image_xscale + top_breath) * top_penis_width * base_sex_size, (image_yscale - top_breath) * top_penis_length * base_sex_size, -penis_rotate, condom_color, 1);
                    if (condom_size > 0)
                    {
                        var condomballoon_id = 0;
                        var condomballoon_size = condom_size;
                        if (condom_size > 1.25)
                        {
                            condomballoon_id = 1;
                            condomballoon_size = condom_size / 2;
                        }
                        draw_sprite_ext(sFutaCondomBalloon, condomballoon_id, x - (dsin(penis_rotate) * condom_offset * 2.5), (y - 16) + (((condom_offset * ((image_yscale - top_breath) * top_penis_length)) - (thrust * 32)) * base_sex_size), (image_xscale - top_breath) * (condomballoon_size + condom_jiggle) * base_sex_size, (image_yscale + top_breath) * (min(1, condomballoon_size) - condom_jiggle) * base_sex_size, -penis_rotate, merge_color(cum_color, condom_color, 0.5), 1);
                    }
                }
            }
            draw_sprite_ext(penis_sprite, 7, x, y - (thrust * 32 * base_sex_size), (image_xscale + top_breath) * top_penis_width * base_sex_size, (image_yscale - top_breath) * top_penis_length * base_sex_size, penis_rotate, top_skin, 1);
            if (condom == true || condom_broken == true)
            {
                var condom_id = 0;
                var condom_sprite = func_get_condom();
                draw_sprite_ext(condom_sprite, condom_id, x, y - (thrust * 32 * base_sex_size), (image_xscale + top_breath) * top_penis_width * base_sex_size, (image_yscale - top_breath) * top_penis_length * base_sex_size, penis_rotate, condom_color, 1);
                if (condom_size > 0)
                {
                    var condomballoon_id = 0;
                    var condomballoon_size = condom_size;
                    if (condom_size > 1.25)
                    {
                        condomballoon_id = 1;
                        condomballoon_size = condom_size / 2;
                    }
                    draw_sprite_ext(sFutaCondomBalloon, condomballoon_id, x + (dsin(penis_rotate) * condom_offset * 2.5), y + (((condom_offset * ((image_yscale - top_breath) * top_penis_length)) - (thrust * 32)) * base_sex_size), (image_xscale - top_breath) * (condomballoon_size + condom_jiggle) * base_sex_size, (image_yscale + top_breath) * (min(1, condomballoon_size) - condom_jiggle) * base_sex_size, penis_rotate, merge_color(cum_color, condom_color, 0.5), 1);
                }
            }
        }
        if (orgasm == false || custom_clench_toggle == false)
        {
            draw_sprite_ext(top_sprite, 8, x, y - (thrust * 32 * base_sex_size) - (ball_size * 8), (image_xscale + top_breath) * (1 + balls_jiggle) * ball_size * base_sex_size, (image_yscale - top_breath) * (1 - balls_jiggle) * ball_size * base_sex_size, 0, top_skin, alpha_test);
        }
        if (top_sprite == sFutaMatingPressDevil)
        {
            draw_sprite_ext(top_sprite, 9, x, y - (thrust * 32 * base_sex_size) - (ball_size * 8), (image_xscale + top_breath) * (1 + balls_jiggle) * ball_size * base_sex_size, (image_yscale - top_breath) * (1 - balls_jiggle) * ball_size * base_sex_size, 0, make_color_hsv(0, 0, 225 * (orgasm == true)), 0.25 + (0.75 * (orgasm_timer / 60)));
        }
        break;
    case 1:
        var bottom_sprite = bottom_cowgirl;
        var y_offset = (20 - (4 * thrust)) * base_sex_size;
        var lift_distance = 16;
        draw_sprite_ext(func_get_reverse_cowgirl(top_sprite), 0, x, y + y_offset, (image_xscale + top_breath) * (1 - (0.1 * insert_thrust)) * base_sex_size, (image_yscale - top_breath) * (1 + (0.1 * insert_thrust)) * base_sex_size, 0, top_skin, 1);
        draw_sprite_ext(bottom_sprite, 0, x, y + y_offset + (thrust * 20 * base_sex_size), (image_xscale + bottom_breath) * (1 - (0.1 * insert_thrust)) * base_sex_size, (image_yscale - bottom_breath) * (1 + (0.1 * insert_thrust)) * base_sex_size, 0, bottom_skin, 1);
        if (insert == false || belly_behind_bulge == true)
        {
            if (fill_amount > fill_max && cumflation == true)
            {
                var cumflation_id = 3;
                var max_cumflation_size = (ds_list_find_index(pill_effects_active, 24) != -1) ? ((ds_list_find_index(pill_effects_active, 19) != -1) ? 40 : 20) : ((ds_list_find_index(pill_effects_active, UnknownEnum.Value_12) != -1) ? 10 : 2.5);
                if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_12) != -1)
                {
                    max_cumflation_size = 5;
                }
                var cumflation_amount = median(0, (fill_amount / fill_max) - 0.5, max_cumflation_size);
                if (fill_amount >= (fill_max * 2.25))
                {
                    cumflation_id = 4;
                    cumflation_amount = median(0, ((fill_amount / fill_max) - 0.5) / 2.25, max_cumflation_size);
                }
                draw_sprite_ext(bottom_sprite, cumflation_id, x, y + ((((-32 + (16 * cumflation_amount)) - (32 * top_penis_length)) + y_offset) * base_sex_size), (image_xscale + top_breath) * (1 - (0.1 * insert_thrust) - min(0.1, condom_jiggle)) * cumflation_amount * base_sex_size, (image_yscale - top_breath) * ((1 - (0.1 * insert_thrust)) + min(0.1, condom_jiggle)) * cumflation_amount * base_sex_size, 0, bottom_skin, 1);
            }
        }
        draw_sprite_ext(bottom_sprite, 1, x, (y + y_offset) - (thrust * lift_distance * base_sex_size), (image_xscale + bottom_breath) * (1 - (0.1 * insert_thrust)) * base_sex_size, (image_yscale - bottom_breath) * (1 + (0.1 * insert_thrust)) * base_sex_size, 0, bottom_skin, 1);
        var hand_id = 4;
        if (top_sprite == top_mating_press)
        {
            if (sprite_get_number(top_cowgirl) > 6)
            {
                hand_id = 6;
            }
        }
        draw_sprite_ext(func_get_reverse_cowgirl(top_sprite), hand_id, x, (y + y_offset) - (thrust * lift_distance * base_sex_size), (image_xscale + bottom_breath) * (1 - (0.1 * insert_thrust)) * base_sex_size, (image_yscale - bottom_breath) * (1 + (0.1 * insert_thrust)) * base_sex_size, 0, top_skin, 1);
        draw_sprite_ext(func_get_reverse_cowgirl(top_sprite), 1, x, y + y_offset + (top_ass_jiggle * 2), (image_xscale + top_breath) * (1 + (top_ass_jiggle * 0.05)) * top_ass_size * base_sex_size, (image_yscale - top_breath) * (1 + (0.1 * insert_thrust)) * (1 - (top_ass_jiggle * 0.15)) * top_ass_size * base_sex_size, 0, top_skin, 1);
        if (insert == false && orgasm == false)
        {
            if (cum_outline == true)
            {
                scrOutlineSet(1, cum_color_back, outline_surface);
            }
            draw_surface(outline_surface, 0, 0);
            if (cum_outline == true)
            {
                shader_reset();
            }
            with (oCondom)
            {
                if (grab == false)
                {
                    draw_sprite_ext(sprite_index, image_index, x, y, (condom_size + condom_jiggle) * base_sex_size, (condom_size - condom_jiggle) * base_sex_size, 0, merge_color(oFutaMatingPress.cum_color, condom_color, 0.5), 1);
                }
            }
        }
        var penis_sprite = top_sprite;
        if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_2) != -1)
        {
            penis_sprite = sFutaMatingPressDevil;
        }
        if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_3) != -1)
        {
            penis_sprite = sFutaMatingFurry;
        }
        var penis_length = top_penis_length;
        if (insert == true)
        {
            penis_length = 0.85;
        }
        var penis_rotate = 0;
        if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_5) != -1)
        {
            if (insert == false)
            {
                penis_rotate = 5 - (5 * thrust);
            }
            draw_sprite_ext(func_get_reverse_cowgirl(penis_sprite), 2, x, (y - 8) + y_offset, (image_xscale + top_breath) * (1 - (0.1 * insert_thrust)) * top_penis_width * base_sex_size, (image_yscale - top_breath) * (1 + (0.1 * insert_thrust)) * penis_length * base_sex_size, -penis_rotate, top_skin, 1);
            if (condom == true || condom_broken == true)
            {
                var condom_id = 1;
                var condom_sprite = func_get_condom();
                draw_sprite_ext(condom_sprite, condom_id, x, (y - 8) + y_offset, (image_xscale + top_breath) * (1 - (0.1 * insert_thrust)) * top_penis_width * base_sex_size, (image_yscale - top_breath) * (1 + (0.1 * insert_thrust)) * penis_length * base_sex_size, -penis_rotate, condom_color, 1);
                if (condom_size > 0 && insert == false)
                {
                    var condomballoon_id = 0;
                    var condomballoon_size = condom_size;
                    if (condom_size > 1.25)
                    {
                        condomballoon_id = 1;
                        condomballoon_size = condom_size / 2;
                    }
                    draw_sprite_ext(sFutaCondomBalloon, condomballoon_id, x + (dsin(penis_rotate) * condom_offset), y - 8 - ((condom_offset / 2) * ((image_yscale - top_breath) * penis_length * base_sex_size)), (image_xscale - top_breath) * (min(1.25, condomballoon_size) + condom_jiggle) * base_sex_size, (image_yscale + top_breath) * (min(1.25, condomballoon_size) - condom_jiggle) * base_sex_size, penis_rotate, merge_color(cum_color, condom_color, 0.5), 1);
                }
            }
        }
        draw_sprite_ext(func_get_reverse_cowgirl(penis_sprite), 2, x, y + y_offset, (image_xscale + top_breath) * (1 - (0.1 * insert_thrust)) * top_penis_width * base_sex_size, (image_yscale - top_breath) * (1 + (0.1 * insert_thrust)) * penis_length * base_sex_size, penis_rotate, top_skin, 1);
        draw_sprite_ext(func_get_reverse_cowgirl(top_sprite), 3, x, y + y_offset, (image_xscale + top_breath) * (1 - (0.1 * insert_thrust)) * max(top_penis_width, ball_size) * base_sex_size, (image_yscale - top_breath) * (1 + (0.1 * insert_thrust)) * ball_size * (1 + balls_jiggle) * base_sex_size, 0, top_skin, 1);
        if (top_sprite == sFutaMatingPressDevil)
        {
            draw_sprite_ext(func_get_reverse_cowgirl(top_sprite), 5, x, y + y_offset, (image_xscale + top_breath) * (1 - (0.1 * insert_thrust)) * max(top_penis_width, ball_size) * base_sex_size, (image_yscale - top_breath) * (1 + (0.1 * insert_thrust)) * ball_size * (1 + balls_jiggle) * base_sex_size, 0, make_color_hsv(0, 0, 225 * (orgasm == true)), 0.25 + (0.75 * (orgasm_timer / 60)));
        }
        if (condom == true || condom_broken == true)
        {
            var condom_id = 1;
            var condom_sprite = func_get_condom();
            draw_sprite_ext(condom_sprite, condom_id, x, y + y_offset, (image_xscale + top_breath) * (1 - (0.1 * insert_thrust)) * top_penis_width * base_sex_size, (image_yscale - top_breath) * (1 + (0.1 * insert_thrust)) * penis_length * base_sex_size, penis_rotate, condom_color, 1);
            if (condom_size > 0 && insert == false)
            {
                var condomballoon_id = 0;
                var condomballoon_size = condom_size;
                if (condom_size > 1.25)
                {
                    condomballoon_id = 1;
                    condomballoon_size = condom_size / 2;
                }
                draw_sprite_ext(sFutaCondomBalloon, condomballoon_id, x - (dsin(penis_rotate) * condom_offset), y - ((condom_offset / 2) * ((image_yscale - top_breath) * penis_length * base_sex_size)), (image_xscale - top_breath) * (min(1.25, condomballoon_size) + condom_jiggle) * base_sex_size, (image_yscale + top_breath) * (min(1.25, condomballoon_size) - condom_jiggle) * base_sex_size, -penis_rotate, merge_color(cum_color, condom_color, 0.5), 1);
            }
        }
        if (insert == true)
        {
            var bulge_sprite = bottom_sprite;
            var bulge_id = 2;
            var bulge_width = top_penis_width + 0.2;
            var bulge_height = penis_length + 0.1;
            if (custom_lover_selected != -1)
            {
                bulge_width *= custom_bulge_width;
                bulge_height *= custom_bulge_height;
            }
            if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_5) != -1)
            {
                draw_sprite_ext(bulge_sprite, 2, x, ((y - 8) + y_offset) - (thrust * lift_distance * base_sex_size), (image_xscale + top_breath) * (1 - (0.1 * insert_thrust)) * bulge_width * base_sex_size, (image_yscale - top_breath) * (1 - (0.1 * insert_thrust)) * bulge_height * base_sex_size, 0, bottom_skin, 1);
            }
            draw_sprite_ext(bulge_sprite, 2, x, (y + y_offset) - (thrust * lift_distance * base_sex_size), (image_xscale + top_breath) * (1 - (0.1 * insert_thrust)) * bulge_width * base_sex_size, (image_yscale - top_breath) * (1 - (0.1 * insert_thrust)) * bulge_height * base_sex_size, 0, bottom_skin, 1);
            if (cum_outline == true)
            {
                scrOutlineSet(1, cum_color_back, outline_surface);
            }
            draw_surface(outline_surface, 0, 0);
            if (cum_outline == true)
            {
                shader_reset();
            }
            with (oCondom)
            {
                if (grab == false)
                {
                    draw_sprite_ext(sprite_index, image_index, x, y, (condom_size + condom_jiggle) * base_sex_size, (condom_size - condom_jiggle) * base_sex_size, 0, merge_color(oFutaMatingPress.cum_color, condom_color, 0.5), 1);
                }
            }
        }
        if (insert == true && belly_behind_bulge == false)
        {
            if (fill_amount > fill_max && cumflation == true)
            {
                var cumflation_id = 3;
                var max_cumflation_size = (ds_list_find_index(pill_effects_active, 24) != -1) ? ((ds_list_find_index(pill_effects_active, 19) != -1) ? 40 : 20) : ((ds_list_find_index(pill_effects_active, UnknownEnum.Value_12) != -1) ? 10 : 2.5);
                if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_12) != -1)
                {
                    max_cumflation_size = 5;
                }
                var cumflation_amount = median(0, (fill_amount / fill_max) - 0.5, max_cumflation_size);
                if (fill_amount >= (fill_max * 2.25))
                {
                    cumflation_id = 4;
                    cumflation_amount = median(0, ((fill_amount / fill_max) - 0.5) / 2.25, max_cumflation_size);
                }
                draw_sprite_ext(bottom_sprite, cumflation_id, x, y + (((((-32 + (16 * cumflation_amount)) - (32 * penis_length)) + y_offset) - (thrust * lift_distance)) * base_sex_size), (image_xscale + top_breath) * (1 - (0.1 * insert_thrust) - min(0.1, condom_jiggle)) * cumflation_amount * base_sex_size, (image_yscale - top_breath) * ((1 - (0.1 * insert_thrust)) + min(0.1, condom_jiggle)) * cumflation_amount * base_sex_size, 0, bottom_skin, 1);
            }
        }
        if (insert == false && orgasm == true)
        {
            if (cum_outline == true)
            {
                scrOutlineSet(1, cum_color_back, outline_surface);
            }
            draw_surface(outline_surface, 0, 0);
            if (cum_outline == true)
            {
                shader_reset();
            }
            with (oCondom)
            {
                if (grab == false)
                {
                    draw_sprite_ext(sprite_index, image_index, x, y, (condom_size + condom_jiggle) * base_sex_size, (condom_size - condom_jiggle) * base_sex_size, 0, merge_color(oFutaMatingPress.cum_color, condom_color, 0.5), 1);
                }
            }
        }
        break;
    case 2:
        var bottom_sprite = bottom_deepthroat;
        top_breath = ((dcos(current_time / 10) * 0.02) + body_jiggle) / 2;
        bottom_breath = ((dcos((current_time + 200) / 10) * 0.02) - body_jiggle) / 2;
        var y_offset = (32 + (20 * (5 * top_breath))) * base_sex_size;
        var y_offset_alt = (20 + (18 * (2 * bottom_breath))) * base_sex_size;
        var lift_distance = 16;
        y_offset += (oBackground.ground_y - 468);
        y_offset_alt += (oBackground.ground_y - 468);
        draw_sprite_ext(bottom_sprite, 0, x, (y + 128 + y_offset_alt) - (4 * insert_thrust), (image_xscale + bottom_breath) * base_sex_size * (1 - (0.05 * insert_thrust)), (image_yscale - bottom_breath) * base_sex_size * (1 + (0.05 * insert_thrust)), 0, bottom_skin, 1);
        if (insert == true)
        {
            draw_sprite_ext(bottom_sprite, 1, x, (y + 128 + y_offset_alt) - (lift_distance * insert_thrust), (image_xscale + bottom_breath) * base_sex_size * (1 - (0.05 * insert_thrust)), (image_yscale - bottom_breath) * base_sex_size * (1 + (0.05 * insert_thrust)), 0, bottom_skin, 1);
        }
        if (fill_amount > fill_max && cumflation == true)
        {
            var max_cumflation_size = (ds_list_find_index(pill_effects_active, 24) != -1) ? ((ds_list_find_index(pill_effects_active, 19) != -1) ? 40 : 20) : ((ds_list_find_index(pill_effects_active, UnknownEnum.Value_12) != -1) ? 10 : 2.5);
            if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_12) != -1)
            {
                max_cumflation_size = 5;
            }
            var cumflation_id = 3;
            var cumflation_amount = median(0, ((fill_amount / fill_max) - 1) / 1.5, max_cumflation_size);
            if (fill_amount >= (fill_max * 2.25))
            {
                cumflation_id = 4;
                cumflation_amount = median(0, ((fill_amount / fill_max) - 1.25) / 2.25, max_cumflation_size);
            }
            draw_sprite_ext(bottom_sprite, cumflation_id, x, (((y + 128 + y_offset_alt) - (4 * insert_thrust)) + 20) - (20 * cumflation_amount), (image_xscale + bottom_breath) * (1 - (0.1 * insert_thrust) - median(0, 0.1, condom_jiggle)) * min(2.25, cumflation_amount) * base_sex_size, (image_yscale - bottom_breath) * ((1 - (0.1 * insert_thrust)) + median(0, 0.1, condom_jiggle)) * cumflation_amount * base_sex_size, 0, bottom_skin, 1);
        }
        draw_sprite_ext(bottom_sprite, 2, x, ((y + 128 + y_offset_alt) - (4 * insert_thrust)) + (bottom_boob_jiggle * 2), (image_xscale + bottom_breath) * base_sex_size * (1 - (0.05 * insert_thrust)), (image_yscale - bottom_breath) * base_sex_size * (1 + (0.05 * insert_thrust)), 0, bottom_skin, 1);
        var heavy_boob_scale = 0;
        var boob_offset = (((lift_distance * thrust) + top_boob_jiggle) - 16) + (top_boob_size * 16);
        if (custom_lover_selected != -1 && custom_heavy_boobs == true)
        {
            boob_offset = 0;
            heavy_boob_scale = 1;
        }
        draw_sprite_ext(func_get_deepthroat(top_sprite), 0, x, y + y_offset + (boob_offset * base_sex_size), (image_xscale + top_breath) * top_boob_size * (1 + (thrust * 0.05 * heavy_boob_scale)) * base_sex_size, (image_yscale - top_breath) * top_boob_size * (1 - (thrust * 0.1 * heavy_boob_scale)) * base_sex_size, 0, top_skin, 1);
        draw_sprite_ext(func_get_deepthroat(top_sprite), 1, x, y + y_offset + ((lift_distance / 2) * thrust * base_sex_size), (image_xscale + top_breath) * base_sex_size, (image_yscale - top_breath) * base_sex_size, 0, top_skin, 1);
        draw_sprite_ext(func_get_deepthroat(top_sprite), 2, x, y + y_offset + ((lift_distance / 2) * thrust * base_sex_size), (image_xscale + top_breath) * base_sex_size, (image_yscale - top_breath) * base_sex_size, 0, top_skin, 1);
        if (top_sprite == sFutaMatingPressDevil)
        {
            draw_sprite_ext(func_get_deepthroat(top_sprite), 11, x, (y + y_offset) - ((lift_distance / 2) * thrust * base_sex_size), (image_xscale + top_breath) * base_sex_size, (image_yscale - top_breath) * (1 - (0.5 * thrust)) * base_sex_size, 0, top_skin, 1);
        }
        draw_sprite_ext(func_get_deepthroat(hair_sprite), 3, x, y + y_offset + ((lift_distance / 2) * thrust * base_sex_size), (image_xscale + top_breath) * base_sex_size, (image_yscale - top_breath) * base_sex_size, 0, top_hair, 1);
        if (cum_outline == true)
        {
            scrOutlineSet(1, cum_color_back, outline_surface);
        }
        draw_surface(outline_surface, 0, 0);
        if (cum_outline == true)
        {
            shader_reset();
        }
        with (oCondom)
        {
            if (grab == false)
            {
                draw_sprite_ext(sprite_index, image_index, x, y, (condom_size + condom_jiggle) * base_sex_size, (condom_size - condom_jiggle) * base_sex_size, 0, merge_color(oFutaMatingPress.cum_color, condom_color, 0.5), 1);
            }
        }
        draw_sprite_ext(func_get_deepthroat(top_sprite), 4, x, (y + y_offset) - (thrust * lift_distance * base_sex_size), (image_xscale + top_breath) * (1 - (0.1 * thrust)) * top_ass_size * base_sex_size, (image_yscale - top_breath) * (1 + (0.125 * thrust)) * base_sex_size, 0, top_skin, 1);
        draw_sprite_ext(func_get_deepthroat(top_sprite), 5, x, (y + y_offset) - (thrust * lift_distance * base_sex_size), (image_xscale + top_breath) * (1 - (0.1 * thrust)) * top_ass_size * base_sex_size, (image_yscale - top_breath) * (1 + (0.125 * thrust)) * base_sex_size, 0, top_skin, 1);
        draw_sprite_ext(func_get_deepthroat(top_sprite), 6, x, ((y + y_offset) - (thrust * lift_distance * base_sex_size)) + (top_ass_jiggle * 2), (image_xscale + top_breath) * ((1 - (0.1 * thrust)) + (top_ass_jiggle * 0.5)) * top_ass_size * base_sex_size, (image_yscale - top_breath) * (1 - top_ass_jiggle) * top_ass_size * base_sex_size, 0, top_skin, 1);
        if (top_sprite == sFutaMatingPressDevil)
        {
            draw_sprite_ext(func_get_deepthroat(top_sprite), 10, x, ((y + y_offset) - (thrust * lift_distance * base_sex_size)) + (top_ass_jiggle * 2), (image_xscale + top_breath) * ((1 - (0.1 * thrust)) + (top_ass_jiggle * 0.5)) * top_ass_size * base_sex_size, (image_yscale - top_breath) * (1 - top_ass_jiggle) * top_ass_size * base_sex_size, 0, top_skin, 1);
        }
        if (top_sprite == sFutaMatingFurry)
        {
            draw_sprite_ext(func_get_deepthroat(top_sprite), 9, x, ((y + y_offset) - (thrust * lift_distance * base_sex_size)) + (top_ass_jiggle * 2), (image_xscale + top_breath) * ((1 - (0.1 * thrust)) + (top_ass_jiggle * 0.5)) * top_ass_size * base_sex_size, (image_yscale - top_breath) * (1 - top_ass_jiggle) * top_ass_size * base_sex_size, 0, top_skin, 1);
        }
        var penis_offset = 2 * base_sex_size;
        if (insert == false)
        {
            var penis_sprite = func_get_deepthroat(top_sprite);
            if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_2) != -1)
            {
                penis_sprite = sFutaMatingPressDevil;
            }
            if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_3) != -1)
            {
                penis_sprite = sFutaMatingFurry;
            }
            var penis_rotate = 0;
            if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_5) != -1)
            {
                penis_rotate = 5 - (5 * thrust);
                draw_sprite_ext(penis_sprite, 7, x, (y + penis_offset + y_offset) - 16 - (thrust * lift_distance * base_sex_size), (image_xscale + top_breath) * top_penis_width * base_sex_size * (1 + (balls_jiggle * 0.25)), (image_yscale - top_breath) * top_penis_length * base_sex_size, -penis_rotate, top_skin, 1);
                if (condom == true || condom_broken == true)
                {
                    var condom_id = 0;
                    var condom_sprite = func_get_condom();
                    draw_sprite_ext(condom_sprite, condom_id, x, (y + penis_offset + y_offset) - 16 - (thrust * lift_distance * base_sex_size), (image_xscale + top_breath) * top_penis_width * base_sex_size * (1 + (balls_jiggle * 0.25)), (image_yscale - top_breath) * top_penis_length * base_sex_size, -penis_rotate, condom_color, 1);
                }
                if (condom_size > 0)
                {
                    var condomballoon_id = 0;
                    var condomballoon_size = condom_size;
                    if (condom_size > 1.25)
                    {
                        condomballoon_id = 1;
                        condomballoon_size = condom_size / 2;
                    }
                    draw_sprite_ext(sFutaCondomBalloon, condomballoon_id, x - (dsin(penis_rotate) * condom_offset * 2.5), (y - 16) + penis_offset + y_offset + (((condom_offset * ((image_yscale - top_breath) * top_penis_length)) - (thrust * lift_distance)) * base_sex_size), (image_xscale - top_breath) * (condomballoon_size + condom_jiggle) * base_sex_size, (image_yscale + top_breath) * (min(1, condomballoon_size) - condom_jiggle) * base_sex_size, -penis_rotate, merge_color(cum_color, condom_color, 0.5), 1);
                }
            }
            draw_sprite_ext(penis_sprite, 7, x, (y + penis_offset + y_offset) - (thrust * lift_distance * base_sex_size), (image_xscale + top_breath) * top_penis_width * base_sex_size * (1 + (balls_jiggle * 0.25)), (image_yscale - top_breath) * top_penis_length * base_sex_size, penis_rotate, top_skin, 1);
            if (condom == true || condom_broken == true)
            {
                var condom_id = 0;
                var condom_sprite = func_get_condom();
                draw_sprite_ext(condom_sprite, condom_id, x, (y + penis_offset + y_offset) - (thrust * lift_distance * base_sex_size), (image_xscale + top_breath) * top_penis_width * base_sex_size * (1 + (balls_jiggle * 0.25)), (image_yscale - top_breath) * top_penis_length * base_sex_size, penis_rotate, condom_color, 1);
                if (condom_size > 0)
                {
                    var condomballoon_id = 0;
                    var condomballoon_size = condom_size;
                    if (condom_size > 1.25)
                    {
                        condomballoon_id = 1;
                        condomballoon_size = condom_size / 2;
                    }
                    draw_sprite_ext(sFutaCondomBalloon, condomballoon_id, x + (dsin(penis_rotate) * condom_offset * 2.5), y + penis_offset + y_offset + (((condom_offset * ((image_yscale - top_breath) * top_penis_length)) - (thrust * lift_distance)) * base_sex_size), (image_xscale - top_breath) * (condomballoon_size + condom_jiggle) * base_sex_size, (image_yscale + top_breath) * (min(1, condomballoon_size) - condom_jiggle) * base_sex_size, penis_rotate, merge_color(cum_color, condom_color, 0.5), 1);
                }
            }
        }
        draw_sprite_ext(func_get_deepthroat(top_sprite), 8, x, (((y + y_offset) - (thrust * lift_distance * base_sex_size)) + penis_offset) - (ball_size * 8), (image_xscale + top_breath) * (1 + (balls_jiggle * 0.75)) * ball_size * base_sex_size, (image_yscale - top_breath) * (1 - (balls_jiggle * 0.5)) * ball_size * base_sex_size, 0, top_skin, 1);
        if (top_sprite == sFutaMatingPressDevil)
        {
            draw_sprite_ext(func_get_deepthroat(top_sprite), 9, x, (((y + y_offset) - (thrust * lift_distance * base_sex_size)) + penis_offset) - (ball_size * 8), (image_xscale + top_breath) * (1 + (balls_jiggle * 0.75)) * ball_size * base_sex_size, (image_yscale - top_breath) * (1 - (balls_jiggle * 0.5)) * ball_size * base_sex_size, 0, make_color_hsv(0, 0, 225 * (orgasm == true)), 0.25 + (0.75 * (orgasm_timer / 60)));
        }
        break;
}
if (foreground_front == true)
{
    draw_sprite_ext(oBackground.background_sprite, 2, oBackground.x, oBackground.y + (50 * background_breathe * 0.03), 2, 2, 0, c_white, 1);
}
var grab_offset = 0;
if (sex_position == 1)
{
    grab_offset = (-40 * top_penis_length) - 32;
}
if (sex_position == 2)
{
    grab_offset = 40;
}
var penis_grab = scrHitboxRectangle(x - (24 * base_sex_size), y + ((28 + grab_offset) * base_sex_size), x + (24 * base_sex_size), y + ((40 + (40 * top_penis_length) + grab_offset) * base_sex_size));
if (instance_exists(oCondom))
{
    with (oCondom)
    {
        if (grab == true)
        {
            penis_grab = false;
        }
    }
}
var thrust_set = 0;
if (title == false && title_scale < 0.1)
{
    thrust_set = mouse_check_button(mb_left) && penis_grab == true;
}
if ((auto_insert == true && auto_sex_timer < 1) && orgasm == false)
{
    if (insert == false && condom == true && condom_size > 0)
    {
        if (condom_size > 0.5)
        {
            var condom_numb = 1;
            if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_5) != -1)
            {
                condom_numb = 2;
            }
            repeat (condom_numb)
            {
                var condom_spawn = instance_create_depth(x + random_range(-360, 360), 496, depth - 1, oCondom);
                condom_spawn.condom_size = condom_size;
                if (top_sprite == sFutaMatingPressClown)
                {
                    condom_spawn.sprite_index = sFutaCondomBalloonAnimal;
                }
                if (condom_size > 1.25)
                {
                    condom_spawn.condom_size = condom_size / 2;
                    condom_spawn.image_index = 3;
                }
                condom_spawn.condom_color = condom_color;
                condom_spawn.stat_sperm_cell = stat_sperm_cell;
                condom_spawn.stat_liters = stat_liters;
                condom_spawn.stat_duration = stat_duration;
                condom_spawn.stat_pumps = stat_pumps;
                condom_spawn.stat_total_load = stat_total_orgasms;
                stat_total_condoms_filled += 1;
                audio_play_sound(choose(sndSlosh1, sndSlosh2, sndSlosh3), 0, false, 0.75, 0, max(0.75, 1.25 - (0.25 * condom_size)));
            }
        }
        audio_play_sound(sndCondomWrapper, 0, 0);
        condom_open = true;
        if (condom_strip > 0)
        {
            condom_strip -= 1;
            if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_5) != -1)
            {
                condom_strip -= 1;
            }
        }
        else
        {
            condom_strip = 5;
            condom_color = make_color_hsv(irandom(255), 50, 255);
            if (custom_lover_selected != -1)
            {
                condom_color = 16777215;
            }
            condom_break = irandom_range(2, 30);
        }
        audio_play_sound(sndCondomOn, 0, 0);
        condom_size = 0;
        condom_broken = false;
        condom_integrity = condom_integrity_max;
    }
    thrust_set = 1;
}
var thrust_lerp = 0.05;
if (insert == false)
{
    thrust_lerp = 0.035;
}
if (insert == true)
{
    thrust_set = thrust_middle + (dcos(thrust_time) * (0.25 * thrust_strength));
    thrust_set = median(1, thrust_set, 0);
    if ((penis_grab == true && mouse_check_button_pressed(mb_left) && (sex_progress > 0 || orgasm == true)) || (sex_progress >= round(sex_progress_max * 0.75) && ds_list_find_index(pill_effects_active, UnknownEnum.Value_15) != -1 && edge_boost < 10))
    {
        insert = false;
        if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_15) == -1)
        {
            auto_insert = false;
        }
        auto_sex_timer = 90;
        thrust = 0.5;
        slap_boost = 0;
        if (orgasm == true)
        {
            if (orgasm_pumps == orgasm_pumps_max)
            {
                top_dialogue_timer = 0;
                func_top_speak("pullout");
                func_add_combo_flair(func_set_lang(76, "PULL OUT GAME"), 10000);
            }
            if (condom_integrity < condom_integrity_max)
            {
                func_add_combo_flair(func_set_lang(77, "CLOSE CALL"), 20000);
            }
            if (impregnate == 1)
            {
                func_add_combo_flair(func_set_lang(78, "SO CLOSE..."), 1);
            }
        }
        var max_edge = (ds_list_find_index(pill_effects_active, 23) != -1 || ds_list_find_index(pill_effects_active, UnknownEnum.Value_15) != -1) ? 10 : 3;
        if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_8) != -1)
        {
            max_edge = 5;
        }
        if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_15) != -1)
        {
            max_edge = 10;
        }
        if (sex_progress >= (sex_progress_max * 0.6) && edge_boost < max_edge)
        {
            edge_boost += 0.5;
            orgasm_pumps_max *= 1.05;
            edge_boost = min(max_edge, edge_boost);
            sex_progress = sex_progress_max * 0.5;
        }
        if (condom == true)
        {
            condom_size = min((ds_list_find_index(pill_effects_active, 24) != -1) ? ((ds_list_find_index(pill_effects_active, 19) != -1) ? 20 : 10) : 6, stat_liters / 2.5);
            fill_amount = 0;
            womb_size = 1;
            womb_size_lerp = 1;
        }
    }
}
else if (mouse_check_button_pressed(mb_left) && penis_grab == true)
{
    if (condom_size > 0)
    {
        if (condom_size > 0.5)
        {
            var condom_numb = 1;
            if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_5) != -1)
            {
                condom_numb = 2;
            }
            repeat (condom_numb)
            {
                var condom_spawn = instance_create_depth(mouse_x + random_range(-16, 16), mouse_y + 48, depth - 1, oCondom);
                condom_spawn.condom_size = condom_size;
                if (top_sprite == sFutaMatingPressClown)
                {
                    condom_spawn.sprite_index = sFutaCondomBalloonAnimal;
                }
                if (condom_size > 1.25)
                {
                    condom_spawn.condom_size = condom_size / 2;
                    condom_spawn.image_index = 3;
                }
                condom_spawn.condom_color = condom_color;
                condom_spawn.stat_sperm_cell = stat_sperm_cell;
                condom_spawn.stat_liters = stat_liters;
                condom_spawn.stat_duration = stat_duration;
                condom_spawn.stat_pumps = stat_pumps;
                condom_spawn.stat_total_load = stat_total_orgasms;
                if (condom_numb == 1)
                {
                    condom_spawn.grab = true;
                }
                stat_total_condoms_filled += 1;
                audio_play_sound(choose(sndSlosh1, sndSlosh2, sndSlosh3), 0, false, 0.75, 0, max(0.75, 1.25 - (0.25 * condom_size)));
                if (orgasm == true)
                {
                    func_add_combo_flair(func_set_lang(79, "FILLED CONDOM"), round(1000 * condom_size));
                }
            }
        }
        audio_play_sound(sndCondomOff, 0, 0);
        condom_size = 0;
        condom = false;
        condom_open = false;
        func_top_speak("condom_remove");
        func_bottom_speak("condom_remove");
    }
}
if (orgasm == true && ds_list_find_index(pill_effects_active, UnknownEnum.Value_16) == -1 && !(penis_grab == true && mouse_check_button(mb_left)))
{
    thrust_set = 0;
    if (orgasm_timer > 30)
    {
        thrust_set = -0.1;
    }
    var pullout = 3;
    if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_10) != -1)
    {
        pullout = 1;
    }
    if (orgasm_pumps < pullout && insert == true)
    {
        thrust_set = 1;
        thrust_lerp = 0.01;
    }
}
if (sex_progress >= (sex_progress_max * 0.6))
{
    if (part_timer > 0)
    {
        part_timer -= 1;
    }
    else
    {
        part_timer = 15;
        part_particles_create(global.ps_back, x + random_range(-128, 128), (y - 40) + random_range(-64, 64), part_love, 1);
    }
}
if (condom_broken == true)
{
    condom = false;
    condom_size = 0;
}
if (insert == true)
{
    var knot = false;
    if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_3) != -1 || top_sprite == sFutaMatingFurry)
    {
        knot = true;
    }
    if (knot == true)
    {
        if (thrust_set < 0.5)
        {
            thrust_set = min(thrust_set, 0.1);
        }
        else
        {
            thrust_set = max(thrust_set, 0.8);
        }
    }
}
thrust += ((thrust_set - thrust) * (thrust_lerp * thrust_strength));
balls_jiggle -= ((thrust - thrust_prev) / 8);
thrust_prev = thrust;
womb_size = median(1, womb_size, 6);
if (insert == true)
{
    futa_score += (abs(thrust_set - thrust) * top_penis_length * top_penis_width * edge_boost);
    stat_distance_thrusted += (abs(thrust_set - thrust) * top_penis_length * 0.025);
}
if (thrust > 0.95 && loads < max_loads)
{
    if (insert == false)
    {
        womb_size = median(1, fill_amount / fill_max, 6);
        womb_size_lerp = womb_size;
        submenu = -1;
        if (edge_boost == 1)
        {
            if (loads > 0)
            {
                func_top_speak("sex_continue");
                func_bottom_speak("sex_continue");
            }
            else
            {
                func_top_speak("sex_start");
                func_bottom_speak("sex_start");
            }
        }
    }
    insert = true;
    if (tutorial == true)
    {
        tutorial = false;
        virgin = false;
    }
}
draw_set_halign(fa_center);
draw_set_font(global.custom_font_big);
var shadow_color = 0;
draw_text_color(plap_x, plap_y + 1 + (4 * plap_scale), plap_string, shadow_color, shadow_color, shadow_color, shadow_color, plap_scale);
draw_text_color(plap_x, plap_y + (4 * plap_scale), plap_string, c_white, c_white, c_white, c_white, plap_scale);
thrust_time += thrust_speed;
if (abs(thrust_set - thrust) > 0.25 && schlick_timer < 1 && insert == true && orgasm == false)
{
    audio_play_sound(choose(sndPlap1, sndPlap2, sndPlap3), 0, false, min(1, 0.05 + (abs(thrust_set - thrust) / 5)), 0, random_range(0.9, 1.1));
    schlick_timer = 60;
}
if (schlick_timer > 0)
{
    schlick_timer -= (thrust_strength + (abs(thrust_set - thrust) * 5));
}
if (insert == true && xray == true && bottom_enable_xray == true && title == false && start_timer < 1 && sex_position != 2)
{
    var xray_offset = 240;
    var xray_yoffset = 24 + (24 * max(0, womb_size - 1));
    var xray_sprite = func_get_xray();
    var xray_size = max(0.4, 2 - (max(0, womb_size - 1) * 0.12));
    var uterus_sprite = sUterusXray;
    if (bottom_xray != undefined && bottom_xray != sUterusXray)
    {
        uterus_sprite = bottom_xray;
    }
    draw_sprite_ext(uterus_sprite, 0, x + xray_offset, (y + xray_yoffset) - (8 * balls_jiggle), xray_size - (0.2 * insert_thrust), xray_size, 0, c_white, 1);
    draw_sprite_ext(uterus_sprite, 1, x + xray_offset, (y + xray_yoffset) - (8 * balls_jiggle), xray_size * womb_size_lerp, xray_size * womb_size_lerp, 0, c_white, 1);
    if (condom == true)
    {
        var inside_balloon = sUterusXray;
        if (custom_partner_selected != -1 && fill_amount >= fill_max)
        {
            inside_balloon = bottom_xray;
        }
        draw_sprite_ext(inside_balloon, 2, x + xray_offset, (y + xray_yoffset) - (8 * balls_jiggle), xray_size * (min(fill_max, fill_lerp) / fill_max) * womb_size_lerp, xray_size * (min(fill_max, fill_lerp) / fill_max) * womb_size_lerp, 0, merge_color(cum_color, condom_color, 0.5), 1);
        draw_sprite_ext(sEjaculationXray, 2, x + xray_offset, (y + xray_yoffset) - (8 * balls_jiggle), xray_size * (1.5 - pump_scale), xray_size * (1 * pump_scale), 0, merge_color(cum_color, condom_color, 0.5), pump_scale);
    }
    else
    {
        var fill = 0.5 - (0.5 * (min(fill_max, fill_lerp) / fill_max));
        draw_sprite_part_ext(uterus_sprite, 2, 0, 168 * fill, 160, 168, x + xray_offset + (((-160 * xray_size) + (80 * xray_size)) - (80 * (max(1, womb_size_lerp) - 1) * xray_size)), y + xray_yoffset + (((-84 * max(1, womb_size_lerp) * xray_size) + (168 * fill * max(1, womb_size_lerp) * 2)) - (8 * balls_jiggle)), xray_size * womb_size_lerp, xray_size * womb_size_lerp, cum_color, 1);
        draw_sprite_ext(sEjaculationXray, 2, x + xray_offset, (y + xray_yoffset) - (8 * balls_jiggle), (1.5 - pump_scale) * xray_size, 1 * pump_scale * xray_size, 0, cum_color, pump_scale);
    }
    if (top_sprite == sFutaMatingPressAndroid)
    {
        var android_flair = "";
        var status = "";
        if (orgasm == true)
        {
            status = func_set_lang(153, "PUMPING SPERM");
        }
        else
        {
            status = func_set_lang(153, "THRUSTING");
            if (sex_progress > (sex_progress_max * 0.5))
            {
                status = func_set_lang(154, "GENERATING SPERM");
            }
            if (sex_progress > (sex_progress_max * 0.9))
            {
                status = func_set_lang(155, "PREPARING TO ORGASM");
            }
        }
        android_flair += (func_set_lang(156, "STATUS:") + " " + string(status) + "\n");
        if (orgasm == true)
        {
            android_flair += ("\n" + func_set_lang(157, "LOAD") + " #" + string(loads) + "\n");
            android_flair += (func_set_lang(158, "SPERM STORED:") + " [" + string(round(max(0, (orgasm_pumps / orgasm_pumps_max) * 100))) + "%]\n");
            android_flair += (func_set_lang(159, "WOMB CAPACITY:") + " [" + string(round((fill_amount / fill_max) * 100)) + "%]\n");
            if (impregnate > 1)
            {
                android_flair += ("\n" + func_set_lang(160, "FERTILIZED EGG DETECTED") + "\n" + func_set_lang(161, "BREEDING SUCCESSFUL"));
            }
            else
            {
                android_flair += ("\n" + func_set_lang(162, "FERTILIZATION CHANCE:") + " " + string(fertility * (fill_amount / fill_max)) + "%");
            }
        }
        else
        {
            android_flair += (func_set_lang(163, "PROGRESS:") + " [" + string(round((sex_progress / sex_progress_max) * 100)) + "%]\n");
            android_flair += (func_set_lang(164, "THRUST DEPTH:") + " " + string(round(25 + (25 * (1 - insert_thrust) * top_penis_length))) + "cm\n");
        }
        if (edge_boost > 1)
        {
            android_flair += ("\n" + func_set_lang(165, "SPERM PRODUCTION:") + " " + string(round(edge_boost * 100)) + "%\n");
        }
        if (condom == true)
        {
            android_flair += ("\n" + func_set_lang(166, "WARNING: CONDOM DETECTED") + "\n" + func_set_lang(167, "PLEASE REMOVE TO ENSURE PROPER FERTILIZATION PROCESS"));
        }
        draw_set_font(global.custom_font_small);
        draw_text_ext(x + xray_offset + (110 + (2 * balls_jiggle)), y + xray_yoffset + 64 + (4 * thrust), android_flair, 7, 160);
        draw_set_font(global.custom_font_big);
    }
    if (top_sprite == sFutaMatingBunny)
    {
        var bunny_info = func_set_lang(122, "total:") + "\n$" + func_get_money(bunny_money);
        draw_sprite_ext(sButtonBack, 0, x + xray_offset + 110, y + xray_yoffset + 64 + (4 * thrust), max(6, string_width_ext(bunny_info, 15, 240) / 14), string_height_ext(bunny_info, 15, 240) / 14, 0, c_white, 0.25);
        draw_set_font(global.custom_font_handwriting);
        draw_text_ext(x + xray_offset + 110, y + xray_yoffset + 64 + (4 * thrust), bunny_info, 15, 240);
        draw_set_font(global.custom_font_big);
    }
    var xray_penis = xray_sprite;
    var xray_penis_id = 0;
    var xray_condom = 2;
    var xray_condom_draw = xray_penis;
    if (condom_broken == true)
    {
        xray_condom_draw = sFutaXrayCondomBroken;
        if (custom_sprite_loaded != -1 && top_sprite == top_mating_press)
        {
            xray_condom_draw = top_xray_broken;
        }
    }
    if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_5) != -1)
    {
        draw_sprite_ext(xray_penis, xray_penis_id, x + xray_offset, (y - 20) + xray_yoffset + (((24 * thrust) - (8 * balls_jiggle)) * xray_size), (1 + balls_jiggle) * top_penis_width * xray_size, top_penis_length * xray_size, 0, top_skin, 1);
        if (condom == true)
        {
            draw_sprite_ext(xray_penis, xray_condom, x + xray_offset, (y - 20) + xray_yoffset + (((24 * thrust) - (8 * balls_jiggle)) * xray_size), (1 + balls_jiggle) * top_penis_width * xray_size, top_penis_length * xray_size, 0, condom_color, 1);
        }
    }
    draw_sprite_ext(xray_penis, xray_penis_id, x + xray_offset, y + xray_yoffset + (((24 * thrust) - (8 * balls_jiggle)) * xray_size), (1 + balls_jiggle) * top_penis_width * xray_size, top_penis_length * xray_size, 0, top_skin, 1);
    if (top_sprite == top_mating_press)
    {
        draw_sprite_ext(xray_penis, xray_penis_id + 1, x + xray_offset, y + xray_yoffset + (((24 * thrust) - (8 * balls_jiggle)) * xray_size), (1 + (balls_jiggle * (1 + (0.75 * orgasm)))) * top_penis_width * xray_size, top_penis_length * xray_size, 0, top_skin, 1);
    }
    else
    {
        var urethra_width = (xray_size / 2) * (top_penis_width / 4) * (1 + balls_jiggle);
        var urethra_height = (xray_size / 2) * top_penis_length * 0.9;
        var urethra_distance = 54;
        var bulge_bottom = 1;
        var bulge_top = 1;
        switch (xray_penis)
        {
            case sFutaXrayHorse:
                urethra_height *= 0.85;
                urethra_distance *= 0.85;
                break;
        }
        if (orgasm == true)
        {
            if (orgasm_pumps == orgasm_pumps_max)
            {
                bulge_top = 0.8 + (0.4 - (0.4 * (orgasm_timer / 120)));
                bulge_bottom = 1.2;
            }
            else
            {
                bulge_top = 1 + (0.2 * dcos(((orgasm_timer / 60) * 360) + 90));
                bulge_bottom = 1 + (0.2 * dcos((orgasm_timer / 60) * 360));
            }
        }
        var urethra_center_x = x + xray_offset;
        var urethra_center_y = y + xray_yoffset + (((24 * thrust) - (8 * balls_jiggle)) * xray_size) + (urethra_height * urethra_distance);
        func_draw_sprite_pos_color(xray_penis, xray_penis_id + 1, urethra_center_x - ((sprite_get_width(xray_penis) / 2) * urethra_width * bulge_top), urethra_center_y - ((sprite_get_height(xray_penis) / 2) * urethra_height), urethra_center_x + ((sprite_get_width(xray_penis) / 2) * urethra_width * bulge_top), urethra_center_y - ((sprite_get_height(xray_penis) / 2) * urethra_height), urethra_center_x + ((sprite_get_width(xray_penis) / 2) * urethra_width * bulge_bottom), urethra_center_y + ((sprite_get_height(xray_penis) / 2) * urethra_height), urethra_center_x - ((sprite_get_width(xray_penis) / 2) * urethra_width * bulge_bottom), urethra_center_y + ((sprite_get_height(xray_penis) / 2) * urethra_height), top_skin);
    }
    if (condom == true || condom_broken == true)
    {
        draw_sprite_ext(xray_condom_draw, xray_condom, x + xray_offset, y + xray_yoffset + (((24 * thrust) - (8 * balls_jiggle)) * xray_size), (1 + balls_jiggle) * top_penis_width * xray_size, top_penis_length * xray_size, 0, condom_color, 1);
    }
    if (orgasm == true)
    {
        if (orgasm_pumps == orgasm_pumps_max)
        {
            draw_sprite_ext(sEjaculationXray, 0, x + xray_offset, y + xray_yoffset + (((24 * thrust) - (8 * balls_jiggle)) * xray_size), (1 + balls_jiggle) * top_penis_width * xray_size, top_penis_length * xray_size, 0, cum_color, 1);
            draw_sprite_ext(sEjaculationXray, 1, x + xray_offset, y + xray_yoffset + (((((24 * thrust) - 32) + (64 * (orgasm_timer / 120))) - (8 * balls_jiggle)) * xray_size), (1 + balls_jiggle) * top_penis_width * xray_size, top_penis_length * xray_size, 0, cum_color, 1);
        }
    }
    draw_sprite_ext(uterus_sprite, 3, x + xray_offset, (y + xray_yoffset) - (8 * balls_jiggle), (top_penis_width + (balls_jiggle * 1.5)) * xray_size, xray_size, 0, c_white, 1);
}
if (top_sprite == sFutaMatingBunny)
{
    if (insert == true)
    {
        switch (sex_position)
        {
            default:
                if (condom == true)
                {
                    bunny_money += ((20 * top_quality) / 60 / 60);
                    stat_total_bunny_money += ((20 * top_quality) / 60 / 60);
                }
                else
                {
                    bunny_money += ((100 * top_quality) / 60 / 60);
                    stat_total_bunny_money += ((100 * top_quality) / 60 / 60);
                }
                break;
            case 2:
                bunny_money += ((15 * top_quality) / 60 / 60);
                stat_total_bunny_money += ((15 * top_quality) / 60 / 60);
                break;
        }
    }
    else if (submenu == -1)
    {
        var money = func_get_money(bunny_money);
        var bunny_rates = func_set_lang(116, "Grope Boobs") + " - $" + string(round(10 * top_boob_size * top_quality)) + "\n" + func_set_lang(117, "Spank Ass") + " - $" + string(round(10 * top_ass_size * top_quality)) + "\n" + func_set_lang(118, "Oral") + " - $" + string(round(15 * top_quality)) + "/min\n" + func_set_lang(119, "Vaginal w/ Condom") + " - $" + string(round(20 * top_quality)) + "/min\n" + func_set_lang(120, "Vaginal Raw") + " - $" + string(round(100 * top_quality)) + "/min\n" + func_set_lang(121, "Creampie") + " - $" + string(round(10 * orgasm_pumps_max * top_quality)) + "\n~\n" + func_set_lang(122, "Total") + ": $" + string(money);
        draw_set_font(global.custom_font_handwriting);
        draw_sprite_ext(sButtonBack, 0, x + 240, y, string_width_ext(bunny_rates, 15, 240) / 14, string_height_ext(bunny_rates, 15, 240) / 14, 0, c_white, 0.25);
        draw_text_ext(x + 240, y, bunny_rates, 15, 240);
        draw_set_font(global.custom_font_big);
    }
}
if ((thrust < 0.15 && ((orgasm == false || ds_list_find_index(pill_effects_active, UnknownEnum.Value_16) != -1) && insert == true)) || orgasm_timer > 30)
{
    var ball_set = 0.1;
    if (orgasm_timer > 30)
    {
        ball_set = 0.2;
    }
    balls_jiggle += ((ball_set - balls_jiggle) * 0.1);
    if (plap == false && (orgasm == false || ds_list_find_index(pill_effects_active, UnknownEnum.Value_16) != -1))
    {
        if (ds_list_find_index(pill_effects_active, 39) != -1)
        {
            var _has_od_piston = ds_list_find_index(pill_effects_active, 19) != -1;
            var _p_grow = _has_od_piston ? 0.006 : 0.003;
            var _p_lim = _has_od_piston ? 3 : 2.8;
            if (top_penis_length < _p_lim)
            {
                top_penis_length = min(_p_lim, top_penis_length + _p_grow);
            }
            if (top_penis_width < _p_lim)
            {
                top_penis_width = min(_p_lim, top_penis_width + _p_grow);
            }
            if (top_ass_size < _p_lim)
            {
                top_ass_size = min(_p_lim, top_ass_size + _p_grow);
            }
            if (ball_size < _p_lim)
            {
                ball_size = min(_p_lim, ball_size + _p_grow);
            }
            if (top_boob_size < _p_lim)
            {
                top_boob_size = min(_p_lim, top_boob_size + _p_grow);
            }
        }
        var precum_y = 52;
        plap = true;
        plap_x = x + choose(-64, 64) + random_range(-8, 8);
        plap_y = y + irandom(32);
        if (sex_position == 1)
        {
            precum_y -= 48;
        }
        if (sex_position == 2)
        {
            plap_y += 80;
            precum_y += 72;
        }
        plap_scale = 2;
        plap_string = func_set_lang(110, "PLAP");
        part_particles_create_color(global.ps, x, y + precum_y, part_precum, 16777215, 5);
        stat_total_plaps += 1;
        if (rpg == true)
        {
            var rpg_damage = round(5 * power(1.05, rpg_enemy_level - 1));
            plap_string = "-" + string(rpg_damage) + " HP";
            rpg_hp -= rpg_damage;
            stat_rpg_damage += rpg_damage;
        }
        if (top_sprite == sFutaMatingPressClown)
        {
            audio_play_sound(choose(sndHonk1, sndHonk2, sndHonk3, sndHonk4), 0, false, 0.2);
            plap_string = func_set_lang(111, "HONK");
        }
        if (sex_progress >= (sex_progress_max * 0.6))
        {
            if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_6) != -1 && impregnate > 0 && bottom_fertile == true && sex_position != 2)
            {
                body_jiggle = 0.025;
                impregnation_timer = 120;
                sperm_jiggle = 0.15;
                impregnate = 0;
                for (var i = 0; i < array_length(sperm); i++)
                {
                    sperm[i] = 0;
                    sperm_speed[i] = 0;
                }
            }
        }
        top_boob_jiggle += 1;
        if (sex_position != 2)
        {
            oBackground.body_jiggle = 0.01;
        }
        if (edge_boost > 1)
        {
            body_jiggle = 0.025;
        }
        audio_play_sound(choose(sndSoftSlap, sndSoftSlap2, sndSoftSlap3), 0, false, min(1, (0.1 * thrust_strength) + abs(thrust_set - thrust)), 0, random_range(0.9, 1.1));
        if ((ds_list_find_index(pill_effects_active, UnknownEnum.Value_10) != -1 || ds_list_find_index(pill_effects_active, UnknownEnum.Value_1) != -1) && ball_size > 1.15)
        {
            audio_play_sound(choose(sndSlosh1, sndSlosh2, sndSlosh3), 0, false, 0.15, 0, random_range(0.9, 1.1));
        }
        if (moaning == true)
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
                    moan_chance = (ds_list_find_index(pill_effects_active, 19) != -1) ? 0 : ((irandom(99) < 95) ? 0 : 1);
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
        }
        if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_9) != -1 || ds_list_find_index(pill_effects_active, 35) != -1)
        {
            var _has_od = ds_list_find_index(pill_effects_active, 19) != -1;
            var _is_ex = ds_list_find_index(pill_effects_active, 35) != -1;
            var leak_chance = 1;
            if (_has_od)
            {
                leak_chance = 0;
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
                var _leak_vol = ((ds_list_find_index(pill_effects_active, 35) != -1) ? 8 : 5) * ball_size * edge_boost * ((ds_list_find_index(pill_effects_active, 19) != -1) ? 2 : 1);
                fill_amount += _leak_vol;
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
        }
        if (((title == false && start_timer < 1) || outside_wait_timer >= 900) && orgasm == false)
        {
            sex_progress += min(3, 1 * edge_boost);
            score_combo += ((20 + score_combo_mult) * ball_size);
            futa_score += ((20 + score_combo_mult) * ball_size);
            score_combo_mult += 1;
            score_combo_scale = 1.5;
            score_combo_timer = 120;
            if (sex_progress == round(sex_progress_max * 0.5))
            {
                func_top_speak("sex_halfway");
                func_bottom_speak("sex_halfway");
                bottom_dialogue_delay = top_dialogue_timer;
            }
        }
    }
}
else
{
    plap = false;
    balls_jiggle_move += (((((thrust * -0.1) - balls_jiggle) * 0.75) - balls_jiggle_move) * 0.05);
    top_boob_jiggle_move += (((((thrust * -0.1) - top_boob_jiggle) * 0.75) - top_boob_jiggle_move) * 0.05);
    balls_jiggle += balls_jiggle_move;
    balls_jiggle_move = median(-1, 1, balls_jiggle_move);
}
if (orgasm_timer > 0)
{
    if (orgasm_sec_timer > 0)
    {
        orgasm_sec_timer -= 1;
    }
    else
    {
        stat_duration += 1;
        stat_total_orgasm_duration += 1;
        if (stat_duration == 30)
        {
            func_add_combo_flair(func_set_lang(80, "HALF MINUTE ORGASM"), 5000);
        }
        if (stat_duration == 60)
        {
            func_add_combo_flair(func_set_lang(81, "FULL MINUTE ORGASM"), 10000);
        }
        orgasm_sec_timer = 60;
    }
    var orgasm_timer_boost = 1;
    orgasm_timer -= (1 + (min(orgasm_pumps, 12 * orgasm_timer_boost) * 0.1));
    if (orgasm_timer < 1)
    {
        if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_10) != -1)
        {
            audio_play_sound(choose(sndSlosh1, sndSlosh2, sndSlosh3), 0, false, 0.5);
        }
        if (orgasm_pumps > 0)
        {
            var condom_break_chance = irandom(condom_break);
            if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_1) != -1 || ds_list_find_index(pill_effects_active, UnknownEnum.Value_16) != -1)
            {
                condom_break_chance = -999;
            }
            if (insert == true)
            {
                var _leak_vol = ((ds_list_find_index(pill_effects_active, 35) != -1) ? 8 : 5) * ball_size * edge_boost * ((ds_list_find_index(pill_effects_active, 19) != -1) ? 2 : 1);
                fill_amount += _leak_vol;
                if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_10) != -1)
                {
                    fill_amount += (fill_max * 0.5 * edge_boost);
                    if (fill_amount >= fill_max)
                    {
                        womb_size += (0.5 * edge_boost);
                    }
                }
                fill_lerp = fill_amount + 3;
                if (fill_amount >= fill_max)
                {
                    womb_size += 0.05;
                    if (condom == false && ds_list_find_index(pill_effects_active, UnknownEnum.Value_12) == -1)
                    {
                        func_cum_splurt(true);
                        audio_play_sound(choose(sndCumSplurt1, sndCumSplurt2, sndCumSplurt3), 0, false, 0.5, 0, random_range(0.9, 1.1));
                    }
                    if (condom == true)
                    {
                        if (condom_break_chance <= 0 && condom_breaking == true && condom_breaking_override == false)
                        {
                            if (condom_integrity > 0)
                            {
                                condom_integrity -= 1;
                                audio_play_sound(sndCondomOn, 0, 0, 1 - (0.25 * condom_integrity), 0, random_range(0.9, 1.1));
                            }
                            else
                            {
                                condom = false;
                                condom_broken = true;
                                condom_open = false;
                                audio_play_sound(sndCondomBreak, 0, 0);
                                if (condom_break_chance == -999)
                                {
                                    func_add_combo_flair(func_set_lang(82, "CUMTAINMENT BREACH"), 15000);
                                }
                                else
                                {
                                    func_add_combo_flair(func_set_lang(83, "BROKEN CONDOM"), 5000);
                                }
                            }
                        }
                    }
                }
            }
            else if (condom == true)
            {
                var _c_cap = (ds_list_find_index(pill_effects_active, 24) != -1) ? ((ds_list_find_index(pill_effects_active, 19) != -1) ? 20 : 10) : 6;
                condom_size = min(_c_cap, (stat_liters / 2.5) + 0.1);
                if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_10) != -1)
                {
                    _c_cap = (ds_list_find_index(pill_effects_active, 24) != -1) ? ((ds_list_find_index(pill_effects_active, 19) != -1) ? 20 : 10) : 6;
                    condom_size = min(_c_cap, (stat_liters / 2.5) + (0.5 * edge_boost));
                }
                condom_jiggle = 0.1;
                condom_size = min((ds_list_find_index(pill_effects_active, 24) != -1) ? ((ds_list_find_index(pill_effects_active, 19) != -1) ? 20 : 10) : 6, condom_size);
                audio_play_sound(choose(sndCumInside1, sndCumInside2, sndCumInside3, sndCumInside4), 0, false, 0.15, 0, 1);
                if (condom_size > 1)
                {
                    if (condom_break_chance <= 0 && condom_breaking == true && condom_breaking_override == false)
                    {
                        if (condom_integrity > 0)
                        {
                            condom_integrity -= 1;
                            audio_play_sound(sndCondomOn, 0, 0, 1 - (0.25 * condom_integrity), 0, random_range(0.9, 1.1));
                        }
                        else
                        {
                            condom = false;
                            condom_broken = true;
                            condom_open = false;
                            condom_size = 0;
                            audio_play_sound(sndCondomBreak, 0, 0);
                            if (condom_break_chance == -999)
                            {
                                func_add_combo_flair(func_set_lang(84, "THIS PRISON? TO HOLD ME?"), 15000);
                            }
                            else
                            {
                                func_add_combo_flair(func_set_lang(83, "BROKEN CONDOM"), 5000);
                            }
                            var cum_offset = 96 * base_sex_size;
                            if (sex_position == 1)
                            {
                                cum_offset = -32 * base_sex_size;
                            }
                            repeat (30)
                            {
                                var cum = instance_create_depth(x + random_range(-24, 24), y + random_range(-24, 24) + cum_offset, depth, oCum);
                                cum.hsp = random_range(-5, 5);
                                cum.vsp = random_range(-5, 5);
                            }
                        }
                    }
                }
            }
            else
            {
                func_cum_splurt(false);
                audio_play_sound(choose(sndCumSplurt1, sndCumSplurt2, sndCumSplurt3), 0, false, 0.5, 0, random_range(0.9, 1.1));
            }
            orgasm_pumps -= 1;
            orgasm_timer = 60;
            stat_pumps += 1;
            stat_total_pumps += 1;
            var max_fill = (ds_list_find_index(pill_effects_active, 24) != -1) ? (fill_max * 50) : (fill_max * 3);
            if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_12) != -1)
            {
                max_fill = fill_max * 5;
            }
            fill_amount = min(fill_amount, max_fill);
            if (cumflation == false)
            {
                fill_amount = min(fill_amount, fill_max);
                womb_size = 1;
                womb_size_lerp = 1;
            }
            if (title == true && outside_wait_timer >= 900 && instance_number(oCum) > 0)
            {
                repeat (5)
                {
                    part_particles_create_color(global.ps_back, x + random_range(-110, 110), (room_height / 2) + 228, part_cum_leak, cum_color, 1);
                }
            }
            if (moaning == true)
            {
                if (moan_sound == -1 || !audio_is_playing(moan_sound))
                {
                    var moan_list = ds_list_create();
                    ds_list_copy(moan_list, moan_slow_list);
                    var moan_chance = irandom(5);
                    if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_10) != -1)
                    {
                        moan_chance = 0;
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
            }
            if (fill_amount >= (fill_max * 3))
            {
                func_add_combo_flair(func_set_lang(85, "CUMFLATED"), 5000);
                var slosh_chance = irandom(3);
                if (slosh_chance == 0)
                {
                    audio_play_sound(choose(sndWombSlosh1, sndWombSlosh2, sndWombSlosh3), 0, false, 0.75);
                }
            }
            if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_12) != -1 && fill_amount >= (fill_max * 8))
            {
                func_add_combo_flair(func_set_lang(86, "SUPER CUMFLATED"), 10000);
            }
            if (stat_pumps == 50)
            {
                func_add_combo_flair(func_set_lang(87, "50 PUMPS"), 2500);
            }
            if (stat_pumps == 100)
            {
                func_add_combo_flair(func_set_lang(88, "100 PUMPS"), 7500);
            }
            plap_x = x + choose(-64, 64) + random_range(-8, 8);
            plap_y = y + irandom(32);
            if (sex_position == 2)
            {
                plap_y += 80;
            }
            plap_scale = 2;
            plap_string = func_set_lang(89, "PUMP") + " x" + string(stat_pumps);
            if (rpg == true)
            {
                var rpg_damage = round(5 * power(1.05, rpg_enemy_level - 1) * edge_boost);
                plap_string = "-" + string(rpg_damage) + " HP";
                rpg_hp -= rpg_damage;
                stat_rpg_damage += rpg_damage;
            }
            body_jiggle = 0.025;
            condom_jiggle = 0.1;
            pump_scale = 1;
            if (top_sprite == sFutaMatingBunny && condom == false)
            {
                bunny_money += (10 * top_quality);
                stat_total_bunny_money += (10 * top_quality);
            }
            var amount_boost = ball_size * edge_boost;
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
            }
            var _od_active = ds_list_find_index(pill_effects_active, 19) != -1;
            if (ds_list_find_index(pill_effects_active, 24) != -1)
            {
                fill_amount += (_od_active ? 40 : 25);
                fill_lerp = fill_amount + 5;
                amount_boost *= (_od_active ? 3 : 2);
            }
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
                var _s_vol = _od_active ? min(1, 0.65 + (_p_done * 0.08)) : 0.85;
                var _s_pitch = _od_active ? min(1.5, 0.95 + (_p_done * 0.07)) : 1;
                audio_play_sound(choose(sndMoanOrgasm1, sndMoanOrgasm2, sndMoanOrgasm3, sndMoanOrgasm5), 0, false, _s_vol, 0, _s_pitch);
                part_particles_create(global.ps_back, x + random_range(-64, 64), (y - 40) + random_range(-32, 32), part_love, 8);
            }
            if (ds_list_find_index(pill_effects_active, 40) != -1)
            {
                var _pump_grow = _od_active ? 0.015 : 0.0075;
                var _pump_lim = _od_active ? 3 : 2.8;
                if (top_penis_length < _pump_lim)
                {
                    top_penis_length = min(_pump_lim, top_penis_length + _pump_grow);
                }
                if (top_penis_width < _pump_lim)
                {
                    top_penis_width = min(_pump_lim, top_penis_width + _pump_grow);
                }
                if (top_ass_size < _pump_lim)
                {
                    top_ass_size = min(_pump_lim, top_ass_size + _pump_grow);
                }
                if (ball_size < _pump_lim)
                {
                    ball_size = min(_pump_lim, ball_size + _pump_grow);
                }
                if (top_boob_size < _pump_lim)
                {
                    top_boob_size = min(_pump_lim, top_boob_size + _pump_grow);
                }
            }
            var liters = 0.25 * amount_boost;
            var sperm_increase = random_range(20, 100) * amount_boost;
            stat_liters += liters;
            stat_sperm_cell += sperm_increase;
            stat_total_liters += liters;
            stat_total_sperm_cell += sperm_increase;
            top_boob_jiggle += -1;
            top_ass_jiggle = 0.05;
            bottom_boob_jiggle += -1;
            if (sex_position != 2)
            {
                oBackground.body_jiggle = 0.01;
            }
            if (condom == false && bottom_fertile == true && insert == true && sex_position != 2)
            {
                var impregnation_chance = irandom(100);
                if (impregnation_chance <= (fertility * (fill_amount / fill_max)) && (impregnate == 0 || (ds_list_find_index(pill_effects_active, UnknownEnum.Value_6) != -1 && impregnation_timer < 1)))
                {
                    impregnation_timer = 300;
                    impregnation_scale = 0;
                    impregnate = 1;
                    sperm_choice = -1;
                    condom_jiggle = 0;
                    condom_jiggle_move = 0;
                    for (var i = 0; i < array_length(sperm); i++)
                    {
                        sperm[i] = 30 + choose(0, 45, 90, 135, 180) + irandom(45);
                        sperm_speed[i] = 0;
                    }
                }
            }
            var score_mult = 1;
            if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_10) != -1)
            {
                audio_play_sound(choose(sndBigCumInside1, sndBigCumInside2, sndBigCumInside3, sndBigCumInside4), 0, false, 0.5, 0, random_range(0.9, 1.1));
                score_mult = 20;
            }
            score_combo += ((100 + (5 * score_combo_mult)) * score_mult);
            futa_score += ((100 + (5 * score_combo_mult)) * score_mult);
            if (rpg == true)
            {
                rpg_xp += round(20 * power(1.05, rpg_enemy_level - 1) * score_mult);
                rpg_scale = 0.2;
            }
            score_combo_mult += 1;
            score_combo_timer = 120;
            score_combo_scale = 1.5;
            audio_play_sound(choose(sndCumInside1, sndCumInside2, sndCumInside3, sndCumInside4), 0, false, 0.5, 0, random_range(0.9, 1.1));
        }
        else
        {
            orgasm = false;
            orgasm_timer = 0;
            sex_progress = 0;
            encore = false;
            if (moaning == true && (moan_sound == -1 || !audio_is_playing(moan_sound)))
            {
                moan_sound = audio_play_sound(ds_list_find_value(moan_slow_list, irandom(ds_list_size(moan_slow_list) - 1)), 0, false, 0.5, 0, moan_pitch);
            }
            if (insert == true && condom_broken == true)
            {
                func_top_speak("condom_broken");
                func_bottom_speak("condom_broken");
            }
            else if (loads == max_loads)
            {
                func_top_speak("sex_exhausted");
                func_bottom_speak("sex_exhausted");
                bottom_dialogue_delay = top_dialogue_timer;
            }
            else
            {
                func_top_speak("sex_after");
                func_bottom_speak("sex_after");
                bottom_dialogue_delay = top_dialogue_timer;
            }
            if (bunny_money > 999999)
            {
                func_add_combo_flair(func_set_lang(90, "WORTH EVERY PENNY"), round(bunny_money / 1000));
            }
            if (insert == true)
            {
                audio_play_sound(choose(sndPlap1, sndPlap2, sndPlap3), 0, false, 0.5, 0, random_range(0.9, 1.1));
            }
            if (condom == true)
            {
                if (insert == true)
                {
                    condom_size = min((ds_list_find_index(pill_effects_active, 24) != -1) ? ((ds_list_find_index(pill_effects_active, 19) != -1) ? 20 : 10) : 6, stat_liters / 2.5);
                    fill_amount = 0;
                    condom_jiggle = -0.2;
                    womb_size = 1;
                    womb_size_lerp = 1;
                }
            }
            else if (insert == true && ds_list_find_index(pill_effects_active, UnknownEnum.Value_12) == -1 && ds_list_find_index(pill_effects_active, UnknownEnum.Value_16) == -1)
            {
                if (sex_position != 2)
                {
                    oBackground.cum = true;
                }
                womb_size = 1;
                womb_size_lerp = 1;
                audio_play_sound(choose(sndCumSplurt1, sndCumSplurt2, sndCumSplurt3), 0, false, 0.5, 0, random_range(0.9, 1.1));
                audio_play_sound(sndCumLeaking, 0, false, 0.5);
                if (top_sprite == sFutaMatingPressClown)
                {
                    audio_play_sound(sndGoofySplat, 0, false, 0.25);
                    if (condom_broken == true)
                    {
                        audio_play_sound(sndGoofyWompWomp, 0, false, 0.25);
                    }
                }
                repeat (10)
                {
                    var cum_offset = 36;
                    if (sex_position == 1)
                    {
                        cum_offset = -16;
                    }
                    if (sex_position == 2)
                    {
                        cum_offset = 64;
                    }
                    var cum = instance_create_depth(x, y + cum_offset, depth, oCum);
                    cum.hsp = random_range(-0.1, 0.1);
                }
            }
            if (condom_broken == true)
            {
                condom_size = 0;
            }
            if (ds_list_size(pill_effects_active) == 1 && ds_list_find_index(pill_effects_unlocked, ds_list_find_value(pill_effects_active, 0)) == -1)
            {
                ds_list_add(pill_effects_unlocked, ds_list_find_value(pill_effects_active, 0));
                banner_text = func_set_lang(169, "Pill Effect Unlocked:") + " " + string(pill_name);
                banner_timer = 300;
            }
            if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_16) == -1 || loads >= max_loads)
            {
                insert = false;
                auto_sex_timer = 90;
            }
            if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_14) != -1)
            {
                var _has_od_grow = ds_list_find_index(pill_effects_active, 19) != -1;
                var _growth_inc = _has_od_grow ? 0.3 : 0.15;
                var _growth_limit = _has_od_grow ? 3 : 2.8;
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
            }
            headpat = 0;
            edge_boost = 1;
            slap_boost = 0;
            func_save_game();
        }
    }
}
if (insert == false && ds_list_find_index(pill_effects_active, UnknownEnum.Value_12) == -1 && ds_list_find_index(pill_effects_active, 24) == -1)
{
    if (fill_amount > (fill_max * 0.5))
    {
        if (!audio_is_playing(sndCumLeaking))
        {
            audio_play_sound(sndCumLeaking, 0, true, 1);
        }
        fill_amount -= 1;
        var cum_offset = 32 * base_sex_size;
        if (sex_position == 1)
        {
            cum_offset = -32 * base_sex_size;
        }
        if (sex_position == 2)
        {
            cum_offset = 64 * base_sex_size;
        }
        var cum = instance_create_depth(x, y + cum_offset, depth, oCum);
        cum.hsp = random_range(-0.2, 0.2);
        cum.vsp = 0.5;
        auto_sex_timer = 90;
    }
    else if (audio_is_playing(sndCumLeaking))
    {
        audio_stop_sound(sndCumLeaking);
    }
}
womb_size_lerp += (((womb_size + (0.1 * (orgasm_timer > 30))) - womb_size_lerp) * 0.05);
if (top_dialogue_timer > 0)
{
    top_dialogue_timer -= 1;
}
if (bottom_dialogue_delay > 0)
{
    bottom_dialogue_delay -= 1;
    bottom_dialogue_timer = 180;
}
else if (bottom_dialogue_timer > 0)
{
    bottom_dialogue_timer -= 1;
}
draw_set_halign(fa_left);
draw_set_font(global.custom_font_big);
var ui_type = 0;
if (rpg == true)
{
    ui_type = 1;
}
if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_17) != -1)
{
    ui_type = 2;
}
switch (ui_type)
{
    case 0:
    case 1:
        var score_string = func_set_lang(26, "SCORE") + ": " + string(round(futa_score));
        if (title == false && start_timer < 1 && custom_menu == false)
        {
            if (rpg == true)
            {
                var level_string = "LVL. " + string(rpg_level);
                draw_text_color(24 + (24 * rpg_scale), 18, level_string, c_black, c_black, c_black, c_black, 1);
                draw_text(24 + (24 * rpg_scale), 16, level_string);
                rpg_hp = median(rpg_hp, 1, rpg_hp_max);
                rpg_hp_lerp = median(rpg_hp_lerp, 1, rpg_hp_max);
                draw_sprite_ext(sGradient, 0, 0, 37, 8, 1, 0, c_white, 1);
                draw_rectangle_color(24, 32, 192, 36, c_black, c_black, c_black, c_black, false);
                draw_rectangle_color(24, 32, 32 + (160 * (rpg_hp_lerp / rpg_hp_max)), 36, c_gray, c_gray, c_gray, c_gray, false);
                var health_color = 16777215;
                if (rpg_hp < (rpg_hp_max * 0.2))
                {
                    health_color = 12632256;
                }
                draw_rectangle_color(24, 32, 32 + (160 * (rpg_hp / rpg_hp_max)), 36, health_color, health_color, health_color, health_color, false);
                draw_set_font(global.custom_font_small);
                var xp_level_upgrade = 1000 * power(1.05, rpg_level - 1);
                if (rpg_xp >= xp_level_upgrade)
                {
                    rpg_xp -= xp_level_upgrade;
                    rpg_level += 1;
                    if (rpg_level > stat_rpg_level_highest)
                    {
                        stat_rpg_level_highest = rpg_level;
                    }
                    rpg_hp = rpg_hp_max * 2;
                    rpg_scale = 1;
                }
                rpg_hp_max = 250 * power(1.05, rpg_level - 1);
                rpg_hp_lerp += ((rpg_hp - rpg_hp_lerp) * 0.05);
                rpg_scale += ((0 - rpg_scale) * 0.1);
                draw_text(24, 41, "HP [" + string(round(rpg_hp)) + " / " + string(round(rpg_hp_max)) + "]");
                draw_text_color(48 + string_width(level_string) + (24 * rpg_scale), 17, "EXP [" + string(round(rpg_xp)) + " / " + string(round(xp_level_upgrade)) + "]", c_black, c_black, c_black, c_black, 1);
                draw_text(48 + string_width(level_string) + (24 * rpg_scale), 16, "EXP [" + string(round(rpg_xp)) + " / " + string(round(xp_level_upgrade)) + "]");
                draw_text(24, 78, "LOVER LV." + string(rpg_enemy_level));
                draw_set_font(global.custom_font_big);
            }
            else
            {
                draw_sprite_ext(sGradient, 0, 0, 32, 8, 1, 0, c_white, 1);
                draw_text(32, 32, score_string);
            }
            if (max_loads > 20)
            {
                draw_sprite_ext(sHearts, 2, 32, 64, 2, 2, 0, c_white, 1);
                draw_text(48, 64, string(loads) + "/" + string(max_loads));
            }
            else
            {
                var heart_size = 2;
                if (max_loads > 10)
                {
                    heart_size = 1;
                }
                for (var i = 0; i < max_loads; i++)
                {
                    draw_sprite_ext(sHearts, 2, 32 + (10 * heart_size * i), 64, heart_size, heart_size, 0, c_black, 0.75);
                    if (loads > i)
                    {
                        draw_sprite_ext(sHearts, 2, 32 + (10 * heart_size * i), 64, heart_size, heart_size, 0, c_white, 1);
                    }
                }
            }
            if (score_combo_timer > 0)
            {
                var combo_string = "+" + string(round(score_combo)) + "\nx" + string(score_combo_mult) + " " + func_set_lang(112, "COMBO");
                if (rpg == true)
                {
                    combo_string = "";
                }
                if (edge_boost > 1)
                {
                    combo_string += ("\n" + func_set_lang(113, "EDGE BOOST") + " x" + string(edge_boost));
                }
                if (slap_boost > 0)
                {
                    combo_string += ("\n+ " + func_set_lang(114, "SPANK BOOST"));
                }
                if (ds_list_size(score_combo_mods) > 0)
                {
                    for (var i = 0; i < ds_list_size(score_combo_mods); i++)
                    {
                        combo_string += ("\n+ " + string(ds_list_find_value(score_combo_mods, i)));
                    }
                    if (ds_list_size(score_combo_mods) > 8)
                    {
                        ds_list_delete(score_combo_mods, 0);
                    }
                }
                draw_set_valign(fa_top);
                shadow_color = make_color_hsv(0, 0, 100 * max(0, score_combo_scale - 0.5));
                draw_text_ext_color(32, 98 - (8 * score_combo_scale), combo_string, 16, 320, shadow_color, shadow_color, shadow_color, shadow_color, score_combo_scale);
                draw_text_ext_color(32, 96 - (8 * score_combo_scale), combo_string, 16, 320, c_white, c_white, c_white, c_white, score_combo_scale);
            }
        }
        break;
    case 2:
        var livestream_pos = 88;
        var livestream_height = 136;
        draw_sprite_ext(sLivestreamChat, 0, livestream_pos, livestream_height, base_sex_size, base_sex_size, 0, c_white, 1);
        draw_set_font(global.custom_font_big);
        draw_set_halign(fa_left);
        var viewer_string = string(round(livestream_viewers));
        if (livestream_viewers > 999)
        {
            viewer_string = string(livestream_viewers / 1000) + "K";
        }
        if (livestream_viewers > 999999)
        {
            viewer_string = string(livestream_viewers / 1000000) + "M";
        }
        if (livestream_viewers > stat_livestream_viewers)
        {
            stat_livestream_viewers = livestream_viewers;
        }
        draw_text(livestream_pos - (26 * base_sex_size) - 1, livestream_height - (56 * base_sex_size) - 1, string(viewer_string));
        draw_text((livestream_pos + (24 * base_sex_size)) - 1, livestream_height - (56 * base_sex_size) - 1, "LIVE");
        draw_set_valign(fa_bottom);
        draw_set_font(global.custom_font_small);
        var chat_string = "";
        for (var i = 0; i < min(26, ds_list_size(livestream_chat)); i++)
        {
            chat_string += (string_upper(ds_list_find_value(livestream_chat, i)) + "\n");
        }
        if (ds_list_size(livestream_chat) > 29)
        {
            ds_list_delete(livestream_chat, 0);
        }
        draw_text_ext(livestream_pos - (34 * base_sex_size), livestream_height + (57 * base_sex_size), chat_string, 7, 70 * base_sex_size);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_set_font(global.custom_font_big);
        livestream_hype = median(1, 50, livestream_hype);
        if (livestream_timer > 0)
        {
            livestream_timer -= livestream_hype;
        }
        else
        {
            livestream_timer = random_range(300, 450);
            var username_start = struct_get_from_hash(livestream_dialogue, variable_get_hash("username_start"));
            var username_end = struct_get_from_hash(livestream_dialogue, variable_get_hash("username_end"));
            var username = string(username_start[irandom(array_length(username_start) - 1)]) + choose("", "_") + string(username_end[irandom(array_length(username_end) - 1)]) + choose("", "", string(irandom(999)));
            var user_message = struct_get_from_hash(livestream_dialogue, variable_get_hash("message_normal"));
            if (insert == true)
            {
                livestream_hype += 0.01;
                user_message = array_concat(user_message, struct_get_from_hash(livestream_dialogue, variable_get_hash("message_sex")));
                if (sex_progress >= (sex_progress_max * 0.5))
                {
                    user_message = array_concat(user_message, struct_get_from_hash(livestream_dialogue, variable_get_hash("message_sex_halfway")));
                }
            }
            else
            {
                if (livestream_hype > 1)
                {
                    livestream_hype -= 0.01;
                }
                user_message = array_concat(user_message, struct_get_from_hash(livestream_dialogue, variable_get_hash("message_waiting")));
            }
            if (orgasm == true)
            {
                livestream_hype += 0.1;
                livestream_timer = random_range(30, 150);
                user_message = array_concat(user_message, struct_get_from_hash(livestream_dialogue, variable_get_hash("message_orgasm")));
            }
            ds_list_add(livestream_chat, string(username) + " : " + string(user_message[irandom(array_length(user_message) - 1)]));
        }
        if (livestream_new_viewer > 0)
        {
            livestream_new_viewer -= livestream_hype;
        }
        else
        {
            livestream_viewers += irandom(livestream_hype);
            livestream_new_viewer = random_range(240, 300);
            show_debug_message(livestream_hype);
        }
        break;
}
draw_set_valign(fa_middle);
draw_set_halign(fa_center);
if (((insert == false && orgasm == false) || show_portrait == true) && custom_menu == false)
{
    var hair_sprite_draw = hair_sprite;
    var top_sprite_draw = top_sprite;
    var mouth_sprite_draw = mouth_sprite;
    var bangs_sprite_draw = bangs_sprite;
    var face_sprite_draw = face_sprite;
    var boob_size = top_boob_size;
    var boob_index = 2;
    var boob_jiggle = top_boob_jiggle;
    var hair_color = top_hair;
    var skin_color = top_skin;
    var boob_sprite = func_get_portrait(top_sprite_draw);
    if (alt_portrait == true)
    {
        hair_sprite_draw = hair_sprite_alt;
        top_sprite_draw = bottom_mating_press;
        mouth_sprite_draw = mouth_sprite_alt;
        bangs_sprite_draw = bangs_sprite_alt;
        face_sprite_draw = face_sprite_alt;
        hair_color = 16777215;
        skin_color = 16777215;
        boob_size = 1;
        boob_sprite = func_get_portrait(top_sprite_draw);
        boob_jiggle = bottom_boob_jiggle;
    }
    else if (alt_boobs > -1)
    {
        boob_sprite = func_get_alt_boobs(top_sprite_draw);
        boob_index = alt_boobs;
    }
    var mouth_id = 4;
    if ((insert == false && loads > 0) || edge_boost > 2 || (insert == true && (sex_progress > (sex_progress_max * 0.5) || orgasm == true)))
    {
        mouth_id = 5;
    }
    var portrait_x = 120;
    var portrait_y = (room_height - ((sprite_get_height(func_get_portrait(top_sprite_draw)) - sprite_get_yoffset(func_get_portrait(top_sprite_draw))) * 2)) + 4 + (top_breath * 64);
    if (insert == true)
    {
        portrait_y += (12 * insert_thrust);
    }
    if (alt_portrait == false && top_boob_size > 1)
    {
        portrait_y += (64 - (64 * top_boob_size));
    }
    var head_offset_draw = head_offset;
    if (alt_portrait == true)
    {
        head_offset_draw = head_offset_alt;
    }
    headpat_press = scrHitboxRectangle(portrait_x - 64, portrait_y - 112 - head_offset_draw, portrait_x + 64, portrait_y - 72 - head_offset_draw);
    var face_x_set = 0;
    var face_y_set = 0;
    if (insert == true || orgasm == true)
    {
        face_y_set = 3;
        if (orgasm == true && orgasm_pumps > 3)
        {
            face_y_set = -3;
        }
    }
    if (point_distance(mouse_x, mouse_y, portrait_x, portrait_y) < 128)
    {
        face_x_set = median(-2, 2, (mouse_x - portrait_x) / 32) * base_sex_size;
        face_y_set = median(-2, 2, (mouse_y - portrait_y - head_offset_draw) / 64) * base_sex_size;
    }
    if (headpat_press == true && mouse_check_button(mb_left))
    {
        face_y_set = 2;
    }
    face_x += ((face_x_set - face_x) * 0.1);
    face_y += ((face_y_set - face_y) * 0.1);
    draw_sprite_ext(func_get_portrait(hair_sprite_draw), 0, portrait_x - face_x, portrait_y - face_y, 2, 2, 0, hair_color, 1);
    draw_sprite_ext(func_get_portrait(top_sprite_draw), 1, portrait_x, portrait_y, 2 * max(0.9, boob_size), 2, 0, skin_color, 1);
    draw_sprite_part_ext(func_get_portrait(top_sprite_draw), 1, 0, sprite_get_height(func_get_portrait(top_sprite_draw)) - 1, sprite_get_width(func_get_portrait(top_sprite_draw)), sprite_get_height(func_get_portrait(top_sprite_draw)), portrait_x - (sprite_get_xoffset(func_get_portrait(top_sprite_draw)) * 2 * max(0.9, boob_size)), portrait_y + ((sprite_get_height(func_get_portrait(top_sprite_draw)) - sprite_get_yoffset(func_get_portrait(top_sprite_draw))) * 2), 2 * max(0.9, boob_size), 8, skin_color, 1);
    draw_sprite_ext(boob_sprite, boob_index, portrait_x, ((portrait_y + 24) - (24 * boob_size)) + (boob_jiggle * 3), 2 * (1 + top_breath + (boob_jiggle / 64)) * boob_size, 2 * (1 - top_breath - (boob_jiggle / 64)) * boob_size, 0, skin_color, 1);
    draw_sprite_ext(func_get_portrait(top_sprite_draw), 3, portrait_x, portrait_y, 2, 2, 0, skin_color, 1);
    draw_sprite_ext(mouth_sprite_draw, mouth_id, portrait_x + (face_x / 1.5), portrait_y + (face_y / 1.5), 2, 2, 0, c_white, 1);
    draw_sprite_ext(bangs_sprite_draw, 6, portrait_x + face_x, portrait_y + face_y, 2, 2, 0, hair_color, 1);
    draw_sprite_ext(face_sprite_draw, 7, portrait_x + (face_x / 1.5), portrait_y + (face_y / 1.5), 2, 2, 0, c_white, 1);
    draw_sprite_ext(func_get_portrait(top_sprite_draw), 8, portrait_x + (face_x / 2), portrait_y + (face_y / 2), 2, 2, 0, skin_color, 1);
    draw_sprite_ext(bangs_sprite_draw, 9, portrait_x + face_x, portrait_y + face_y, 2, 2, 0, hair_color, 1);
    part_system_drawit(global.ps_ui);
    mouth_press = scrHitboxRectangle(portrait_x - 16, portrait_y - 16 - head_offset_draw, portrait_x + 16, (portrait_y + 16) - head_offset_draw);
    var milk_x_offset = nipple_offset[0] * base_sex_size * (1 + top_breath);
    var milk_y_offset = nipple_offset[1] * base_sex_size;
    var milk_color = cum_color;
    if (alt_portrait == true)
    {
        milk_x_offset = nipple_offset_alt[0] * base_sex_size * (1 + bottom_breath);
        milk_y_offset = nipple_offset_alt[1] * base_sex_size;
        milk_color = egg_color;
    }
    milk_x_offset *= top_boob_size;
    milk_y_offset *= top_boob_size;
    boob_press = scrHitboxRectangle((portrait_x + milk_x_offset) - (40 * top_boob_size), (portrait_y + milk_y_offset) - (40 * top_boob_size), portrait_x + milk_x_offset + 8, portrait_y + milk_y_offset + 8) || scrHitboxRectangle(portrait_x - milk_x_offset - 8, (portrait_y + milk_y_offset) - (40 * top_boob_size), (portrait_x - milk_x_offset) + (40 * top_boob_size), portrait_y + milk_y_offset + 8);
    if (lactate_timer > 0)
    {
        lactate_timer -= 1;
        part_particles_create_color(global.ps_ui, portrait_x + milk_x_offset, portrait_y + milk_y_offset, part_milk_leak, milk_color, 5);
        part_particles_create_color(global.ps_ui, portrait_x - milk_x_offset, portrait_y + milk_y_offset, part_milk_leak, milk_color, 5);
        if (top_sprite == sFutaMatingPressAlien && alt_portrait == false)
        {
            part_particles_create_color(global.ps_ui, portrait_x, portrait_y + 4 + milk_y_offset, part_milk_leak, cum_color, 5);
        }
    }
    if (boob_press == true && mouse_check_button_pressed(mb_left))
    {
        var milk_check = false;
        audio_play_sound(choose(sndSlosh1, sndSlosh2, sndSlosh3), 0, false, 0.5);
        if (alt_portrait == false)
        {
            if (top_sprite_draw == sFutaMatingPressClown)
            {
                audio_play_sound(choose(sndHonk1, sndHonk2, sndHonk3, sndHonk4), 0, false, 0.5);
            }
            top_boob_jiggle = 3;
            func_top_speak("touch_boobs");
            if (top_sprite == sFutaMatingBunny)
            {
                bunny_money += (10 * top_boob_size * top_quality);
                stat_total_bunny_money += (10 * top_boob_size * top_quality);
            }
            milk_check = lactate;
        }
        else
        {
            bottom_boob_jiggle = 3;
            func_bottom_speak("touch_boobs");
            milk_check = lactate_alt;
        }
        if (milk_check == true)
        {
            audio_play_sound(choose(sndCumSplurt1, sndCumSplurt2, sndCumSplurt3), 0, false, 0.5, 0, random_range(1.1, 1.2));
            part_particles_create_color(global.ps_ui, portrait_x + milk_x_offset, portrait_y + milk_y_offset, part_milk, milk_color, 10);
            part_particles_create_color(global.ps_ui, portrait_x - milk_x_offset, portrait_y + milk_y_offset, part_milk, milk_color, 10);
            if (top_sprite == sFutaMatingPressAlien && alt_portrait == false)
            {
                part_particles_create_color(global.ps_ui, portrait_x, portrait_y + 4 + milk_y_offset, part_milk, milk_color, 10);
            }
            lactate_timer = 60 * top_boob_size;
        }
    }
    if (submenu == -1)
    {
        if (custom_lover_selected == -1 && insert == false && orgasm == false)
        {
            var newlover_x = 280;
            var newlover_y = room_height - 24;
            var button_press = point_in_rectangle(mouse_x, mouse_y, newlover_x - 60, newlover_y - 16, newlover_x + 60, newlover_y + 16);
            draw_sprite_ext(sButtonBack, button_press, newlover_x, newlover_y, 8, 2, 0, c_white, 0.5 + (0.5 * button_press));
            draw_set_font(global.custom_font_big);
            draw_text(newlover_x, newlover_y, func_set_lang(16, "NEW LOVER"));
            if (button_press == true)
            {
                draw_set_font(global.custom_font_small);
                draw_set_halign(fa_right);
                draw_sprite_ext(sButtonBack, 0, newlover_x, newlover_y - 62, 9.5, 5.5, 0, c_white, 0.5);
                for (var i = 0; i < 7; i++)
                {
                    var anchor_x = newlover_x;
                    var anchor_y = ((newlover_y - 64) + 30) - (10 * i);
                    var futa_data = func_set_lang(171, "BREASTS:") + " ";
                    var futa_numb = func_get_rating(top_boob_size);
                    var stats = true;
                    switch (i)
                    {
                        case 1:
                            futa_data = func_set_lang(172, "ASS:") + " ";
                            futa_numb = func_get_rating(top_ass_size);
                            break;
                        case 2:
                            futa_data = func_set_lang(173, "PENIS LENGTH:") + " ";
                            futa_numb = func_get_rating(top_penis_length);
                            break;
                        case 3:
                            futa_data = func_set_lang(174, "PENIS WIDTH:") + " ";
                            futa_numb = func_get_rating(top_penis_width);
                            break;
                        case 4:
                            futa_data = func_set_lang(175, "BALLS:") + " ";
                            futa_numb = func_get_rating(ball_size);
                            break;
                        case 5:
                            futa_data = func_set_lang(176, "OVERALL:") + " ";
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
                                if (futa_numb >= 8)
                                {
                                    color = 65535;
                                }
                                if (futa_numb >= 10)
                                {
                                    color = 16738740;
                                }
                            }
                            draw_sprite_ext(sCum, 0, anchor_x + 2 + (j * 6), anchor_y, 0.16, 0.16, 0, color, 1);
                        }
                    }
                    else
                    {
                        draw_set_halign(fa_center);
                        draw_text_ext(anchor_x, anchor_y, futa_data, 7, 160);
                    }
                }
                draw_set_font(global.custom_font_big);
                draw_set_halign(fa_center);
                if (mouse_check_button_pressed(mb_left))
                {
                    func_randomize_top();
                    sex_progress = 0;
                    futa_score = 0;
                    loads = 0;
                    body_jiggle = 0.025;
                    condom_broken = false;
                    audio_play_sound(sndCloth, 0, 0, 0.6, 0, random_range(0.8, 1.2));
                }
            }
        }
        var custombutton_x = 280;
        if (custom_sprite_loaded == true && custom_lover_selected == -1)
        {
            custombutton_x = 415;
        }
        if (insert == true || orgasm == true)
        {
            custombutton_x = -56;
        }
        var custombutton_y = room_height - 24;
        var custom_swap = point_in_rectangle(mouse_x, mouse_y, (custombutton_x - 12) + 80, custombutton_y - 12, custombutton_x + 12 + 80, custombutton_y + 12);
        draw_sprite_ext(sButtons, 4, custombutton_x + 80, custombutton_y, 1, 1, 0, c_white, 0.5 + (0.5 * custom_swap));
        if (custom_swap == true)
        {
            draw_sprite_ext(sGradient, 0, custombutton_x + 96, custombutton_y, 8, 1, 0, c_white, 0.75);
            var swap_text = func_set_lang(135, "SWAP TO PARTNER PORTRAIT");
            if (alt_portrait == true)
            {
                swap_text = func_set_lang(136, "SWAP TO LOVER PORTRAIT");
            }
            draw_set_halign(fa_left);
            draw_text(custombutton_x + 100, custombutton_y, swap_text);
            draw_set_halign(fa_center);
            if (mouse_check_button_pressed(mb_left))
            {
                alt_portrait = !alt_portrait;
                body_jiggle = 0.025;
                audio_play_sound(sndCloth, 0, 0, 0.6, 0, random_range(0.8, 1.2));
            }
        }
        if (custom_sprite_loaded == true && insert == false && orgasm == false)
        {
            var custombutton_press = point_in_rectangle(mouse_x, mouse_y, custombutton_x - 64, custombutton_y - 16, custombutton_x + 64, custombutton_y + 16);
            draw_sprite_ext(sButtonBack, custombutton_press, custombutton_x, custombutton_y, 8, 2, 0, c_white, 0.5 + (0.5 * custombutton_press));
            draw_set_font(global.custom_font_big);
            draw_text_transformed(custombutton_x, custombutton_y, func_set_lang(17, "CUSTOM"), 1, 1, 0);
            if (custombutton_press == true && mouse_check_button_pressed(mb_left))
            {
                func_get_custom_info();
                custom_menu = true;
                custom_scale = 1;
                custom_tab = 0;
                custom_menu_pos = 0;
                if (custom_lover_selected != -1)
                {
                    custom_menu_pos = custom_lover_selected + 1;
                }
                custom_menu_pos_lerp = 0;
            }
        }
    }
}
if (title_scale > 0.01)
{
    draw_sprite_ext(sBackgroundBedroomOutside, 0, room_width / 2, room_height / 2, (1.2 - (0.2 * title_scale)) * 2, (1.2 - (0.2 * title_scale)) * 2, 0, c_white, title_scale);
    draw_sprite_ext(sBackgroundBedroomOutside, 1, ((room_width / 2) - 110) + (110 * title_scale), room_height / 2, ((1.2 - (0.2 * title_scale)) + (0.05 * plap_scale)) * title_scale * 2, ((1.2 - (0.2 * title_scale)) + (0.015 * plap_scale)) * 2, 0, c_white, title_scale);
}
if (title_timer < 1 && start_timer < 1 && custom_menu == false)
{
    var icon_list = ds_list_create();
    if (title == true && outside_wait_timer < 900)
    {
        if (ds_list_size(language_folders) > 0)
        {
            ds_list_add(icon_list, 13);
        }
    }
    else if (title == false)
    {
        if (insert == true || orgasm == true)
        {
            ds_list_add(icon_list, 2, 10);
            if (orgasm == true)
            {
                ds_list_add(icon_list, 14);
            }
        }
        else
        {
            ds_list_add(icon_list, 0, 12, 2, 5, 3, 6, 9, 10);
            if (oBackground.background_id == 0 && custom_bedroom_selected == -1)
            {
                ds_list_add(icon_list, 15);
            }
        }
    }
    if (submenu > -1)
    {
        var submenu_list = ds_list_create();
        switch (submenu)
        {
            case 0:
                ds_list_add(submenu_list, func_set_lang(18, "X-Ray View") + ": " + func_get_toggle_string(xray));
                if (condom_breaking_override == true)
                {
                    ds_list_add(submenu_list, func_set_lang(19, "Condom Breaking") + ": N/A");
                }
                else
                {
                    ds_list_add(submenu_list, func_set_lang(19, "Condom Breaking") + ": " + func_get_toggle_string(condom_breaking));
                }
                if (custom_lover_selected != -1)
                {
                    ds_list_add(submenu_list, func_set_lang(20, "Moaning") + ": " + func_set_lang(17, "CUSTOM"));
                }
                else
                {
                    ds_list_add(submenu_list, func_set_lang(20, "Moaning") + ": " + func_get_toggle_string(moaning_set));
                }
                ds_list_add(submenu_list, func_set_lang(21, "Cum Inflation") + ": " + func_get_toggle_string(cumflation));
                ds_list_add(submenu_list, func_set_lang(22, "Dialogue") + ": " + func_get_toggle_string(show_dialogue));
                ds_list_add(submenu_list, func_set_lang(23, "Fullscreen") + ": " + func_get_toggle_string(fullscreen));
                ds_list_add(submenu_list, func_set_lang(24, "BGM") + ": " + string(round(background_music_volume * 100)) + "%");
                ds_list_add(submenu_list, func_set_lang(25, "Volume") + ": " + string(round(master_volume * 100)) + "%");
                ds_list_add(submenu_list, func_set_lang(128, "Mid-Sex Portrait") + ": " + func_get_toggle_string(show_portrait));
                ds_list_add(submenu_list, func_set_lang(129, "Belly Behind Bulge") + ": " + func_get_toggle_string(belly_behind_bulge));
                ds_list_add(submenu_list, func_set_lang(185, "Cum Limit") + ": " + string(max(500, round(max_particles * 10000))));
                ds_list_add(submenu_list, func_set_lang(186, "Cum Outline") + ": " + func_get_toggle_string(cum_outline));
                break;
            case 1:
                ds_list_add(submenu_list, func_set_lang(27, "Mating Pess"));
                ds_list_add(submenu_list, func_set_lang(28, "Reverse Cowgirl"));
                if (max_position > 1)
                {
                    ds_list_add(submenu_list, func_set_lang(29, "Deepthroat"));
                }
                break;
            case 2:
                ds_list_add(submenu_list, func_set_lang(31, "Default"));
                ds_list_add(submenu_list, func_set_lang(32, "Bubblegum"));
                ds_list_add(submenu_list, func_set_lang(33, "Lemon Lime"));
                ds_list_add(submenu_list, func_set_lang(34, "Sunset"));
                ds_list_add(submenu_list, func_set_lang(35, "Forest"));
                ds_list_add(submenu_list, func_set_lang(36, "Cherry"));
                ds_list_add(submenu_list, func_set_lang(37, "Valentine"));
                ds_list_add(submenu_list, func_set_lang(38, "Caramel"));
                ds_list_add(submenu_list, func_set_lang(39, "Red Velvet"));
                ds_list_add(submenu_list, func_set_lang(40, "Rusty"));
                ds_list_add(submenu_list, func_set_lang(41, "Vintage"));
                ds_list_add(submenu_list, func_set_lang(42, "Lavender"));
                ds_list_add(submenu_list, func_set_lang(43, "Mint"));
                break;
            case 3:
                if (ds_list_size(pill_effects_active) > 0)
                {
                    ds_list_add(submenu_list, ["Reset Effects", UnknownEnum.Value_0]);
                }
                else
                {
                    ds_list_add(submenu_list, [func_set_lang(45, "Mystery Pill"), UnknownEnum.Value_0]);
                }
                ds_list_add(submenu_list, [func_set_lang(46, "Mega Sperm"), UnknownEnum.Value_1]);
                ds_list_add(submenu_list, [func_set_lang(47, "Equine Penis"), UnknownEnum.Value_2]);
                ds_list_add(submenu_list, [func_set_lang(48, "Knotted Penis"), UnknownEnum.Value_3]);
                ds_list_add(submenu_list, [func_set_lang(49, "Extra Thick"), UnknownEnum.Value_4]);
                ds_list_add(submenu_list, [func_set_lang(50, "Diphallia"), UnknownEnum.Value_5]);
                ds_list_add(submenu_list, [func_set_lang(51, "Ovulation"), UnknownEnum.Value_6]);
                ds_list_add(submenu_list, [func_set_lang(52, "Hyper Breeding"), UnknownEnum.Value_7]);
                ds_list_add(submenu_list, [func_set_lang(53, "Stamina"), UnknownEnum.Value_8]);
                ds_list_add(submenu_list, [func_set_lang(54, "Leaky"), UnknownEnum.Value_9]);
                ds_list_add(submenu_list, [func_set_lang(55, "Three Pump Champ"), UnknownEnum.Value_10]);
                ds_list_add(submenu_list, [func_set_lang(56, "Color Chaos"), UnknownEnum.Value_11]);
                ds_list_add(submenu_list, [func_set_lang(57, "Stretchy Womb"), UnknownEnum.Value_12]);
                ds_list_add(submenu_list, [func_set_lang(130, "Dungeoneer"), UnknownEnum.Value_13]);
                ds_list_add(submenu_list, [func_set_lang(131, "Growth Cascade"), UnknownEnum.Value_14]);
                ds_list_add(submenu_list, [func_set_lang(132, "Gooner"), UnknownEnum.Value_15]);
                ds_list_add(submenu_list, [func_set_lang(133, "Pound Town"), UnknownEnum.Value_16]);
                ds_list_add(submenu_list, [func_set_lang(188, "Livestream"), UnknownEnum.Value_17]);
                ds_list_add(submenu_list, [func_set_lang(215, "Petite Titan"), 18]);
                ds_list_add(submenu_list, [func_set_lang(216, "Overdose"), 19]);
                ds_list_add(submenu_list, [func_set_lang(217, "Turbo Drive"), 20]);
                ds_list_add(submenu_list, [func_set_lang(218, "Honey Nectar"), 21]);
                ds_list_add(submenu_list, [func_set_lang(219, "Siren Milk"), 22]);
                ds_list_add(submenu_list, [func_set_lang(220, "Edge Meister"), 23]);
                ds_list_add(submenu_list, [func_set_lang(221, "Full Container"), 24]);
                ds_list_add(submenu_list, [func_set_lang(222, "Endless Drip"), 25]);
                ds_list_add(submenu_list, [func_set_lang(223, "Quick Egg"), 26]);
                ds_list_add(submenu_list, [func_set_lang(224, "Magma Core"), 27]);
                ds_list_add(submenu_list, [func_set_lang(225, "Crystal Semen"), 28]);
                ds_list_add(submenu_list, [func_set_lang(226, "Phantom Reach"), 29]);
                ds_list_add(submenu_list, [func_set_lang(227, "Casino Lucky"), 30]);
                ds_list_add(submenu_list, [func_set_lang(228, "Time Delay"), 31]);
                ds_list_add(submenu_list, [func_set_lang(229, "Royal Genesis"), 32]);
                ds_list_add(submenu_list, [func_set_lang(230, "Epilogue Dream"), 33]);
                ds_list_add(submenu_list, [func_set_lang(231, "Sensual Moan"), 34]);
                ds_list_add(submenu_list, [func_set_lang(232, "Leaky EX"), 35]);
                ds_list_add(submenu_list, [func_set_lang(233, "Titan Rubber"), 36]);
                ds_list_add(submenu_list, [func_set_lang(234, "Sync Heart"), 37]);
                ds_list_add(submenu_list, [func_set_lang(235, "Titan Thrust"), 38]);
                ds_list_add(submenu_list, [func_set_lang(236, "Thrust Surge"), 39]);
                ds_list_add(submenu_list, [func_set_lang(237, "Pump Surge"), 40]);
                if (ds_list_find_index(pill_effects_unlocked, UnknownEnum.Value_0) == -1)
                {
                    ds_list_add(pill_effects_unlocked, UnknownEnum.Value_0);
                }
                break;
            case 4:
                for (var i = 0; i < ds_list_size(language_folders); i++)
                {
                    ds_list_add(submenu_list, language_names[i]);
                }
                break;
        }
        for (var i = 0; i < ds_list_size(submenu_list); i++)
        {
            var submenu_x = room_width - 140 - (160 * floor(i / 15));
            var submenu_y = (room_height - 32 - (32 * i)) + (480 * floor(i / 15));
            var submenu_check = point_in_rectangle(mouse_x, mouse_y, submenu_x - 72, submenu_y - 12, submenu_x + 72, submenu_y + 12);
            var submenu_alpha = 0.5 + (submenu_check * 0.5);
            var submenu_string = "";
            var disabled = false;
            var draw_bar = false;
            var value_set = median(0, 104, mouse_x - (submenu_x - 52)) / 104;
            var value_get = 0.5;
            draw_sprite_ext(sButtonBack, 0, submenu_x, submenu_y, 10, 2, 0, c_white, submenu_alpha);
            var draw_string = ds_list_find_value(submenu_list, i);
            if (is_array(draw_string) == true)
            {
                if (submenu == 3 && ds_list_find_index(pill_effects_active, draw_string[1]) != -1)
                {
                    disabled = true;
                }
                if (submenu == 3 && ds_list_find_index(pill_effects_unlocked, draw_string[1]) == -1)
                {
                    draw_string = "???";
                    disabled = true;
                }
                else
                {
                    draw_string = draw_string[0];
                }
            }
            draw_text_color(submenu_x, submenu_y, draw_string, c_white, c_white, c_white, c_white, submenu_alpha * (1 - (0.5 * disabled)));
            if (submenu == 0)
            {
                switch (i)
                {
                    case 6:
                        value_get = background_music_volume;
                        draw_bar = true;
                        break;
                    case 7:
                        value_get = master_volume;
                        draw_bar = true;
                        break;
                    case 10:
                        value_get = max_particles;
                        draw_bar = true;
                        break;
                }
            }
            if (draw_bar == true)
            {
                draw_rectangle_color(submenu_x - 52, submenu_y + 8, submenu_x + 52, submenu_y + 9, c_black, c_black, c_black, c_black, false);
                draw_rectangle_color(submenu_x - 52, submenu_y + 8, (submenu_x - 52) + (104 * value_get), submenu_y + 9, c_white, c_white, c_white, c_white, false);
            }
            if (submenu_check == true && (mouse_check_button_pressed(mb_left) || keyboard_check(vk_space)) && disabled == false)
            {
                switch (submenu)
                {
                    case 0:
                        switch (i)
                        {
                            case 0:
                                xray = !xray;
                                break;
                            case 1:
                                condom_breaking = !condom_breaking;
                                break;
                            case 2:
                                if (custom_lover_selected == -1)
                                {
                                    moaning_set = !moaning_set;
                                    moaning = moaning_set;
                                }
                                break;
                            case 3:
                                cumflation = !cumflation;
                                break;
                            case 4:
                                show_dialogue = !show_dialogue;
                                break;
                            case 5:
                                fullscreen = !fullscreen;
                                window_set_fullscreen(fullscreen);
                                break;
                            case 6:
                                background_music_volume = value_set;
                                break;
                            case 7:
                                master_volume = value_set;
                                break;
                            case 8:
                                show_portrait = !show_portrait;
                                break;
                            case 9:
                                belly_behind_bulge = !belly_behind_bulge;
                                break;
                            case 10:
                                max_particles = value_set;
                                break;
                            case 11:
                                cum_outline = !cum_outline;
                                break;
                        }
                        audio_play_sound(sndSelect, 0, 0);
                        break;
                    case 1:
                        sex_position = i;
                        body_jiggle = 0.025;
                        audio_play_sound(sndCloth, 0, 0);
                        break;
                    case 2:
                        global.palette = i;
                        if (global.palette == 0)
                        {
                            application_surface_draw_enable(true);
                        }
                        audio_play_sound(sndSelect, 0, 0);
                        break;
                    case 3:
                        if (pill_effect_random == false)
                        {
                            var pill_effect_set = UnknownEnum.Value_0;
                            var clear = false;
                            if (i == 0)
                            {
                                if (ds_list_size(pill_effects_active) > 0)
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
                                }
                                else
                                {
                                    var effect_list = ds_list_create();
                                    ds_list_add(effect_list, UnknownEnum.Value_1, UnknownEnum.Value_5, UnknownEnum.Value_4, UnknownEnum.Value_6, UnknownEnum.Value_8, UnknownEnum.Value_9, UnknownEnum.Value_10, UnknownEnum.Value_16, UnknownEnum.Value_15, UnknownEnum.Value_14, UnknownEnum.Value_13, UnknownEnum.Value_17);
                                    if (top_sprite != top_mating_press)
                                    {
                                        ds_list_add(effect_list, UnknownEnum.Value_2, UnknownEnum.Value_3, UnknownEnum.Value_11);
                                    }
                                    if (cumflation == true)
                                    {
                                        ds_list_add(effect_list, UnknownEnum.Value_12);
                                    }
                                    ds_list_shuffle(effect_list);
                                    pill_effect_set = ds_list_find_value(effect_list, irandom(ds_list_size(effect_list) - 1));
                                    pill_effect_random = true;
                                    if (impregnate > 0 && loads == 0)
                                    {
                                        pill_effect_set = UnknownEnum.Value_7;
                                    }
                                    if (keyboard_check(ord("Q")))
                                    {
                                        pill_effect_set = UnknownEnum.Value_1;
                                    }
                                    if (keyboard_check(ord("W")))
                                    {
                                        pill_effect_set = UnknownEnum.Value_5;
                                    }
                                    if (keyboard_check(ord("E")))
                                    {
                                        pill_effect_set = UnknownEnum.Value_4;
                                    }
                                    if (keyboard_check(ord("R")))
                                    {
                                        pill_effect_set = UnknownEnum.Value_6;
                                    }
                                    if (keyboard_check(ord("T")))
                                    {
                                        pill_effect_set = UnknownEnum.Value_8;
                                    }
                                    if (keyboard_check(ord("Y")))
                                    {
                                        pill_effect_set = UnknownEnum.Value_9;
                                    }
                                    if (keyboard_check(ord("U")))
                                    {
                                        pill_effect_set = UnknownEnum.Value_10;
                                    }
                                    if (keyboard_check(ord("I")))
                                    {
                                        pill_effect_set = UnknownEnum.Value_16;
                                    }
                                    if (keyboard_check(ord("O")))
                                    {
                                        pill_effect_set = UnknownEnum.Value_15;
                                    }
                                    if (keyboard_check(ord("P")))
                                    {
                                        pill_effect_set = UnknownEnum.Value_13;
                                    }
                                    if (keyboard_check(ord("A")))
                                    {
                                        pill_effect_set = UnknownEnum.Value_2;
                                    }
                                    if (keyboard_check(ord("S")))
                                    {
                                        pill_effect_set = UnknownEnum.Value_3;
                                    }
                                    if (keyboard_check(ord("D")))
                                    {
                                        pill_effect_set = UnknownEnum.Value_11;
                                    }
                                    if (keyboard_check(ord("F")))
                                    {
                                        pill_effect_set = UnknownEnum.Value_12;
                                    }
                                    if (keyboard_check(ord("G")))
                                    {
                                        pill_effect_set = UnknownEnum.Value_7;
                                    }
                                    if (keyboard_check(ord("H")))
                                    {
                                        pill_effect_set = UnknownEnum.Value_17;
                                    }
                                }
                            }
                            else
                            {
                                pill_effect_set = array_get(ds_list_find_value(submenu_list, i), 1);
                                pill_effect_random = false;
                            }
                            if (ds_list_find_index(pill_effects_active, pill_effect_set) == -1 && clear == false)
                            {
                                ds_list_add(pill_effects_active, pill_effect_set);
                            }
                            if (pill_effect_set != UnknownEnum.Value_0)
                            {
                                func_top_speak("mystery_effect");
                            }
                            audio_play_sound(sndPillEffect, 0, 0);
                            pill_name = array_get(ds_list_find_value(submenu_list, pill_effect_set), 0);
                            plap_x = x;
                            plap_y = y;
                            plap_scale = 2;
                            plap_string = pill_name;
                            func_set_pill_effect(array_get(ds_list_find_value(submenu_list, pill_effect_set), 1));
                            submenu = -1;
                        }
                        break;
                    case 4:
                        audio_play_sound(sndSelect, 0, 0);
                        language_selected = i;
                        func_load_language(ds_list_find_value(language_folders, language_selected));
                        break;
                }
                func_save_game();
            }
        }
    }
    draw_set_font(global.custom_font_big);
    for (var i = 0; i < ds_list_size(icon_list); i++)
    {
        var icon = ds_list_find_value(icon_list, i);
        var disabled = false;
        var button_press = point_in_rectangle(mouse_x, mouse_y, room_width - 32 - 12, room_height - 32 - (32 * i) - 12, (room_width - 32) + 12, (room_height - 32 - (32 * i)) + 12);
        switch (icon)
        {
            case 5:
                if (pill_effect_random == true)
                {
                    disabled = true;
                }
                break;
        }
        draw_sprite_ext(sButtons, icon, room_width - 32, room_height - 32 - (32 * i), 1, 1, 0, c_white, 0.5 + (0.5 * (button_press == true && disabled == false)));
        if (button_press == true)
        {
            var button_name = "";
            switch (icon)
            {
                case 0:
                    button_name = func_set_lang(141, "Clean Up");
                    break;
                case 2:
                    button_name = func_set_lang(142, "Condom:") + " " + func_get_toggle_string(condom);
                    break;
                case 3:
                    button_name = func_set_lang(143, "Sex Position");
                    break;
                case 5:
                    button_name = func_set_lang(144, "Pill Effects");
                    if (pill_effect_random == true)
                    {
                        button_name = func_set_lang(145, "Pill Effect:") + " " + string(pill_name);
                    }
                    break;
                case 6:
                    button_name = func_set_lang(146, "Change Bedroom");
                    break;
                case 9:
                    button_name = func_set_lang(147, "Color Palette");
                    break;
                case 10:
                    button_name = func_set_lang(148, "Auto Sex:") + " " + func_get_toggle_string(auto_insert);
                    break;
                case 12:
                    button_name = func_set_lang(149, "Settings");
                    break;
                case 13:
                    button_name = func_set_lang(150, "Language");
                    break;
                case 14:
                    button_name = func_set_lang(151, "Skip");
                    break;
                case 15:
                    button_name = func_set_lang(152, "Exit");
                    break;
            }
            if (submenu == -1)
            {
                draw_set_halign(fa_right);
                draw_sprite_ext(sGradient, 0, room_width - 46, room_height - 32 - (32 * i), (string_width(button_name) + 32) / 24, 1, 180, c_white, 1);
                draw_text(room_width - 48, room_height - 32 - (32 * i), button_name);
                draw_set_halign(fa_left);
            }
            if (mouse_check_button_pressed(mb_left))
            {
                switch (icon)
                {
                    default:
                        submenu = -1;
                        break;
                    case 3:
                    case 5:
                    case 9:
                    case 12:
                    case 13:
                        break;
                }
                switch (icon)
                {
                    case 0:
                        audio_play_sound(sndPop, 0, 0);
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
                        condom_strip = 0;
                        condom_open = false;
                        condom_broken = false;
                        stat_duration = 0;
                        stat_sperm_cell = 0;
                        stat_liters_lerp = 0;
                        stat_sperm_cell_lerp = 0;
                        stat_liters = 0;
                        if (rpg == true)
                        {
                            rpg_hp = rpg_hp_max;
                        }
                        if (condom == true && condom_size > 0)
                        {
                            condom = false;
                            condom_size = 0;
                        }
                        if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_6) == -1)
                        {
                            impregnate = 0;
                            fertilizations = 0;
                        }
                        func_top_speak("cleanup");
                        break;
                    case 12:
                        if (submenu != 0)
                        {
                            submenu = 0;
                        }
                        else
                        {
                            submenu = -1;
                        }
                        audio_play_sound(sndSelect, 0, 0);
                        break;
                    case 13:
                        if (submenu != 4)
                        {
                            submenu = 4;
                        }
                        else
                        {
                            submenu = -1;
                        }
                        audio_play_sound(sndSelect, 0, 0);
                        break;
                    case 14:
                        if (orgasm_pumps > 1)
                        {
                            orgasm_pumps = 1;
                        }
                        break;
                    case 15:
                        if (title == false && oBackground.background_id == 0 && custom_bedroom_selected == -1)
                        {
                            title = true;
                            title_scale = 0;
                            title_alpha = 0;
                            outside_wait_timer = 900;
                            auto_insert = true;
                            audio_play_sound(sndDoorClose, 0, 0);
                            audio_bus_main.effects[0] = effect_muffled;
                            audio_bus_main.effects[1] = effect_gain;
                        }
                        break;
                    case 10:
                        auto_insert = !auto_insert;
                        audio_play_sound(sndSelect, 0, 0);
                        break;
                    case 9:
                        if (submenu != 2)
                        {
                            submenu = 2;
                        }
                        else
                        {
                            submenu = -1;
                        }
                        audio_play_sound(sndSelect, 0, 0);
                        break;
                    case 2:
                        condom = !condom;
                        condom_broken = false;
                        if (condom == true)
                        {
                            audio_play_sound(sndCondomOn, 0, 0);
                            func_top_speak("condom_on");
                            func_bottom_speak("condom_on");
                            fill_amount = 0;
                            womb_size = 1;
                            if (condom_open == false || condom_broken == true)
                            {
                                audio_play_sound(sndCondomWrapper, 0, 0);
                                condom_open = true;
                                if (condom_strip > 0)
                                {
                                    condom_strip -= 1;
                                    if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_5) != -1)
                                    {
                                        condom_strip -= 1;
                                    }
                                }
                                else
                                {
                                    condom_strip = 5;
                                    condom_color = make_color_hsv(irandom(255), 50, 255);
                                    if (custom_lover_selected != -1)
                                    {
                                        condom_color = 16777215;
                                    }
                                    condom_break = irandom_range(2, 30);
                                }
                                condom_integrity = condom_integrity_max;
                            }
                        }
                        else
                        {
                            audio_play_sound(sndCondomOff, 0, 0);
                            func_top_speak("condom_off");
                            func_bottom_speak("condom_off");
                        }
                        var condom_numb = 1;
                        if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_5) != -1)
                        {
                            condom_numb = 2;
                        }
                        repeat (condom_numb)
                        {
                            if (condom_size > 0.25)
                            {
                                var condom_spawn = instance_create_depth(x + random_range(-360, 360), 496, depth - 1, oCondom);
                                condom_spawn.condom_size = condom_size;
                                if (top_sprite == sFutaMatingPressClown)
                                {
                                    condom_spawn.sprite_index = sFutaCondomBalloonAnimal;
                                }
                                if (condom_size > 1.25)
                                {
                                    condom_spawn.condom_size = condom_size / 2;
                                    condom_spawn.image_index = 3;
                                }
                                condom_spawn.condom_color = condom_color;
                                condom_spawn.stat_sperm_cell = stat_sperm_cell;
                                condom_spawn.stat_liters = stat_liters;
                                condom_spawn.stat_duration = stat_duration;
                                condom_spawn.stat_pumps = stat_pumps;
                                condom_spawn.stat_total_load = stat_total_orgasms;
                                audio_play_sound(choose(sndSlosh1, sndSlosh2, sndSlosh3), 0, false);
                                stat_total_condoms_filled += 1;
                                condom_open = false;
                            }
                        }
                        condom_size = 0;
                        body_jiggle = 0.025;
                        insert = false;
                        break;
                    case 3:
                        if (submenu != 1)
                        {
                            submenu = 1;
                        }
                        else
                        {
                            submenu = -1;
                        }
                        audio_play_sound(sndSelect, 0, 0);
                        break;
                    case 5:
                        if (pill_effect_random == false)
                        {
                            if (submenu != 3)
                            {
                                submenu = 3;
                            }
                            else
                            {
                                submenu = -1;
                            }
                            audio_play_sound(sndSelect, 0, 0);
                        }
                        break;
                    case 6:
                        func_get_custom_info();
                        custom_menu = true;
                        custom_scale = 1;
                        custom_tab = 2;
                        break;
                }
                func_save_game();
            }
        }
    }
}
if (custom_menu == true)
{
    var info_text = "";
    var info_id = -1;
    draw_sprite_ext(sButtonBack, 0, room_width / 2, (room_height - 32) + (32 * custom_scale), (room_width / 16) + 1, 5, 0, c_white, 0.5 * (1 - custom_scale));
    var max_rooms = 6;
    var tab_size = array_length(custom_lover_portraits) + 1;
    if (custom_tab == 1)
    {
        tab_size = array_length(custom_partner_portraits) + 1;
    }
    if (custom_tab == 2)
    {
        tab_size = array_length(custom_bedroom_thumbnails) + max_rooms;
    }
    for (var i = 0; i < tab_size; i++)
    {
        var draw_x = (440 + (96 * i)) - (96 * custom_menu_pos_lerp);
        var draw_y = (room_height - 64) + (32 * custom_scale);
        var portrait_select = point_in_rectangle(mouse_x, mouse_y, draw_x - 40, draw_y - 64, draw_x + 40, draw_y + 64);
        switch (custom_tab)
        {
            case 0:
                if (i == 0)
                {
                    draw_sprite_ext(sCustomNone, 0, draw_x, draw_y, 1, 1, 0, c_white, 0.5 + (0.5 * portrait_select));
                }
                else
                {
                    draw_y = (room_height - (sprite_get_height(custom_lover_portraits[i - 1][0]) - sprite_get_yoffset(custom_lover_portraits[i - 1][0]))) + (32 * custom_scale);
                    var offset = 0;
                    if (array_length(custom_lover_portraits[i - 1]) > 1)
                    {
                        offset = 24;
                        for (var j = 0; j < sprite_get_number(custom_lover_portraits[i - 1][1]); j++)
                        {
                            var draw = true;
                            if (j == 5)
                            {
                                draw = false;
                            }
                            if (draw == true)
                            {
                                draw_sprite_ext(custom_lover_portraits[i - 1][1], j, draw_x + offset, draw_y, 1, 1, 0, make_color_hsv(0, 0, 255 * (0.5 + (0.5 * (custom_lover_selected == (i - 1) || portrait_select == true)))), 1);
                            }
                        }
                    }
                    for (var j = 0; j < sprite_get_number(custom_lover_portraits[i - 1][0]); j++)
                    {
                        var draw = true;
                        if (j == 5)
                        {
                            draw = false;
                        }
                        if (draw == true)
                        {
                            draw_sprite_ext(custom_lover_portraits[i - 1][0], j, draw_x - offset, draw_y, 1, 1, 0, make_color_hsv(0, 0, 255 * (0.5 + (0.5 * (custom_lover_selected == (i - 1) || portrait_select == true)))), 1);
                        }
                    }
                    if (portrait_select == true)
                    {
                        info_text = custom_lover_info[i - 1];
                        info_id = i;
                    }
                }
                break;
            case 1:
                if (i == 0)
                {
                    for (var j = 0; j < sprite_get_number(sWifeCanonPortrait); j++)
                    {
                        var draw = true;
                        if (j == 5)
                        {
                            draw = false;
                        }
                        if (draw == true)
                        {
                            draw_sprite_ext(sWifeCanonPortrait, j, draw_x, draw_y, 1, 1, 0, make_color_hsv(0, 0, 255 * (0.5 + (0.5 * (custom_partner_selected == -1 || portrait_select == true)))), 1);
                        }
                    }
                    if (portrait_select == true)
                    {
                        info_text = func_set_lang(178, "The Wife") + "\n\n" + func_set_lang(179, "A plain and simple woman. Pansexual and polyamorous. Default Option.");
                        info_id = i;
                    }
                }
                else
                {
                    draw_y = (room_height - (sprite_get_height(custom_partner_portraits[i - 1]) - sprite_get_yoffset(custom_partner_portraits[i - 1]))) + (32 * custom_scale);
                    for (var j = 0; j < sprite_get_number(custom_partner_portraits[i - 1]); j++)
                    {
                        var draw = true;
                        if (j == 5)
                        {
                            draw = false;
                        }
                        if (draw == true)
                        {
                            draw_sprite_ext(custom_partner_portraits[i - 1], j, draw_x, draw_y, 1, 1, 0, make_color_hsv(0, 0, 255 * (0.5 + (0.5 * (custom_partner_selected == (i - 1) || portrait_select == true)))), 1);
                        }
                    }
                    if (portrait_select == true)
                    {
                        info_text = custom_partner_info[i - 1];
                        info_id = i;
                    }
                }
                break;
            case 2:
                draw_x = (440 + (144 * i)) - (144 * custom_menu_pos_lerp);
                portrait_select = point_in_rectangle(mouse_x, mouse_y, draw_x - 40, draw_y - 64, draw_x + 40, draw_y + 64);
                if (ds_list_size(custom_bedroom_folders) > 0)
                {
                    draw_set_font(global.custom_font_small);
                    draw_text_transformed(440 - (144 * custom_menu_pos_lerp) - 72, (room_height - 64) + (32 * custom_scale), string_upper(func_set_lang(31, "DEFAULT")), 1, 1, 90);
                    draw_text_transformed(((440 - (144 * custom_menu_pos_lerp)) + (144 * max_rooms)) - 72, (room_height - 64) + (32 * custom_scale), func_set_lang(17, "CUSTOM"), 1, 1, 90);
                }
                draw_set_font(global.custom_font_big);
                if (i < max_rooms)
                {
                    var default_room_thumbnail = sThumbnailBedroom;
                    var default_room_info = "";
                    switch (i)
                    {
                        case 0:
                            default_room_info = func_set_lang(59, "Wife's Bedroom") + "\n\n" + func_set_lang(60, "A spare bedroom for when you have company over. The walls are pretty thin, so you can hear the action from the other side of the house.");
                            break;
                        case 1:
                            default_room_thumbnail = sThumbnailBeach;
                            default_room_info = func_set_lang(62, "The Beach") + "\n\n" + func_set_lang(63, "It's a beautiful, sunny day in paradise! Thankfully this is a nude beach and there's nobody around, so you could probably get a few rounds in. Just make sure you keep off the sand, sex on the beach itself isn't as fun as it seems.");
                            break;
                        case 2:
                            default_room_thumbnail = sThumbnailOffice;
                            default_room_info = func_set_lang(65, "The Office") + "\n\n" + func_set_lang(66, "Time for your employee evaluations! Our company only wants the best of the best, so give it 110% and get to work!");
                            break;
                        case 3:
                            default_room_thumbnail = sThumbnailStarship;
                            default_room_info = func_set_lang(68, "Alien Starship") + "\n\n" + func_set_lang(69, "Oh no! You've been abducted! Better watch out for aliens, or else they'll probe you!") + "\n\n" + func_set_lang(70, "Aliens have an increased chance of appearing here.");
                            break;
                        case 4:
                            default_room_thumbnail = sThumbnailVIPLounge;
                            default_room_info = func_set_lang(72, "VIP Lounge") + "\n\n" + func_set_lang(73, "A private area for special guests at a fancy nightclub. There's drinks, gambling, and lots of beautiful women eager to satisfy your every need.") + "\n\n" + func_set_lang(74, "Bunny Girls and Clowns have an increased chance of appearing here.");
                            break;
                        case 5:
                            default_room_thumbnail = sThumbnailDungeon;
                            default_room_info = func_set_lang(124, "Dungeon") + "\n\n" + func_set_lang(125, "A dark, mysterious dungeon infested with monsters that are hungry for human flesh! Perhaps one of your party members can keep them busy while you search for loot?") + "\n\n" + func_set_lang(126, "Succubi and Slimes have an increased chance of appearing here.");
                            break;
                    }
                    draw_sprite_ext(default_room_thumbnail, 0, draw_x, draw_y, 1, 1, 0, make_color_hsv(0, 0, 255 * (0.5 + (0.5 * (oBackground.background_id == i || portrait_select == true)))), 1);
                    if (portrait_select == true)
                    {
                        info_text = default_room_info;
                        info_id = i;
                    }
                }
                else
                {
                    draw_sprite_ext(custom_bedroom_thumbnails[i - max_rooms], 0, draw_x, draw_y, 1, 1, 0, make_color_hsv(0, 0, 255 * (0.5 + (0.5 * (custom_bedroom_selected == (i - max_rooms) || portrait_select == true)))), 1);
                    if (portrait_select == true)
                    {
                        info_text = custom_bedroom_info[i - max_rooms];
                        info_id = i;
                    }
                }
                break;
        }
        if ((mouse_wheel_up() || mouse_wheel_down()) && abs(custom_menu_pos - custom_menu_pos_lerp) < 0.3)
        {
            custom_menu_pos += (mouse_wheel_down() - mouse_wheel_up());
            custom_menu_pos = median(custom_menu_pos, 0, tab_size - 1);
        }
        if (portrait_select == true && mouse_check_button_pressed(mb_left) && custom_scale < 0.1)
        {
            custom_menu_pos = i;
            top_dialogue_timer = 0;
            top_dialogue_scale = 0;
            bottom_dialogue_timer = 0;
            bottom_dialogue_scale = 0;
            switch (custom_tab)
            {
                case 0:
                    if (i == 0)
                    {
                        custom_lover_selected = -1;
                        func_randomize_top();
                        if (custom_partner_selected == -1 && bottom_mating_press != sWifeMatingPress)
                        {
                            func_reset_partner();
                        }
                    }
                    else
                    {
                        custom_lover_selected = i - 1;
                        func_set_custom_lover();
                        func_top_speak("intro");
                        func_bottom_speak("intro");
                        bottom_dialogue_delay = top_dialogue_timer;
                    }
                    break;
                case 1:
                    if (custom_partner_selected == -1 && bottom_mating_press != sWifeMatingPress)
                    {
                        func_randomize_top();
                    }
                    if (i == 0)
                    {
                        custom_partner_selected = -1;
                        func_reset_partner();
                    }
                    else
                    {
                        custom_partner_selected = i - 1;
                        func_set_custom_partner();
                    }
                    break;
                case 2:
                    background_audio_effect = 0;
                    foreground_front = false;
                    background_breathe = false;
                    if (background_music != -1 && audio_is_playing(background_music))
                    {
                        audio_stop_sound(background_music);
                    }
                    if (custom_music != -1)
                    {
                        var destroy = audio_destroy_stream(custom_music);
                        show_debug_message(destroy);
                        custom_music = -1;
                    }
                    if (i < max_rooms)
                    {
                        oBackground.background_id = i;
                        custom_bedroom_selected = -1;
                        switch (oBackground.background_id)
                        {
                            case 1:
                                background_music = audio_play_sound(musAmbianceBeach, 0, true);
                                break;
                            case 2:
                            case 3:
                                background_audio_effect = 1;
                                break;
                            case 4:
                                background_music = audio_play_sound(musAmbianceVIP, 0, true);
                                break;
                        }
                    }
                    else
                    {
                        oBackground.background_id = 0;
                        oBackground.animated_background_frame = 0;
                        show_debug_message(i - max_rooms);
                        custom_bedroom_selected = i - max_rooms;
                        func_load_custom(ds_list_find_value(custom_bedroom_folders, custom_bedroom_selected));
                        custom_bedroom = custom_background;
                        background_breathe = custom_background_breathe;
                        background_audio_effect = custom_background_audio_effect;
                        foreground_front = custom_foreground_front;
                        background_allow_condom_strip = custom_allow_condom_strip;
                        custom_bedroom_animated = custom_background_animated;
                        background_animation_speed = custom_animation_speed;
                        if (custom_music != -1)
                        {
                            background_music = audio_play_sound(custom_music, 0, true);
                        }
                    }
                    audio_bus_main.effects[0] = undefined;
                    audio_bus_main.effects[1] = undefined;
                    switch (background_audio_effect)
                    {
                        case 1:
                            var effect_reverb = audio_effect_create(UnknownEnum.Value_5, 
                            {
                                size: 0.65,
                                damp: 0.65
                            });
                            audio_bus_main.effects[0] = effect_reverb;
                            break;
                        case 2:
                            audio_bus_main.effects[0] = effect_muffled;
                            audio_bus_main.effects[1] = effect_gain;
                            break;
                    }
                    break;
            }
            sex_progress = 0;
            futa_score = 0;
            loads = 0;
            condom_broken = false;
            audio_play_sound(sndSelect, 0, 0);
        }
    }
    draw_set_font(global.custom_font_big);
    if (info_text != "" && abs(custom_menu_pos - custom_menu_pos_lerp) < 0.1)
    {
        draw_sprite_ext(sButtonBack, 0, (440 + (string_width_ext(info_text, 14, 240) / 2) + 96 + (96 * info_id)) - (96 * custom_menu_pos_lerp), room_height - (string_height_ext(info_text, 14, 240) / 2) - 16, (string_width_ext(info_text, 14, 240) / 16) + 2, (string_height_ext(info_text, 14, 240) / 16) + 2, 0, c_white, 0.5);
        draw_text_ext((440 + (string_width_ext(info_text, 14, 240) / 2) + 96 + (96 * info_id)) - (96 * custom_menu_pos_lerp), room_height - (string_height_ext(info_text, 14, 240) / 2) - 16, string(info_text), 14, 240);
    }
    else
    {
        var close_x = room_width - 24;
        var close_y = room_height - 148;
        var close_button = point_in_rectangle(mouse_x, mouse_y, close_x - 24, close_y - 24, close_x + 24, close_y + 24);
        draw_sprite_ext(sButtonBack, 0, close_x, close_y, 2, 2, 0, c_white, 0.5 + (0.5 * close_button));
        draw_text(close_x, close_y, "X");
        if (close_button == true && mouse_check_button_pressed(mb_left))
        {
            custom_menu = false;
            audio_play_sound(sndSelect, 0, 0);
        }
        var tab_x = room_width - 110;
        var tab_y = room_height - 148;
        var tab_button = point_in_rectangle(mouse_x, mouse_y, tab_x - 64, tab_y - 24, tab_x + 64, tab_y + 24);
        var custom_tab_list = ds_list_create();
        if (ds_list_size(custom_lover_folders) > 0)
        {
            ds_list_add(custom_tab_list, 0);
        }
        if (ds_list_size(custom_partner_folders) > 0)
        {
            ds_list_add(custom_tab_list, 1);
        }
        if (ds_list_size(custom_bedroom_folders) > 0)
        {
            ds_list_add(custom_tab_list, 2);
        }
        var tab_name = func_set_lang(181, "LOVERS");
        switch (custom_tab)
        {
            case 1:
                tab_name = func_set_lang(182, "PARTNERS");
                break;
            case 2:
                tab_name = func_set_lang(183, "BEDROOMS");
                break;
        }
        if (ds_list_size(custom_tab_list) > 0)
        {
            draw_sprite_ext(sButtonBack, 0, tab_x, tab_y, 8, 2, 0, c_white, 0.5 + (0.5 * tab_button));
            draw_text(tab_x, tab_y, tab_name);
            if (tab_button == true && mouse_check_button_pressed(mb_left))
            {
                var tab_get = ds_list_find_index(custom_tab_list, custom_tab);
                tab_get += 1;
                if (tab_get > (ds_list_size(custom_tab_list) - 1))
                {
                    tab_get = 0;
                }
                audio_play_sound(sndSelect, 0, 0);
                custom_tab = ds_list_find_value(custom_tab_list, tab_get);
                switch (custom_tab)
                {
                    case 0:
                        if (custom_lover_selected == -1)
                        {
                            custom_menu_pos = 0;
                        }
                        else
                        {
                            custom_menu_pos = custom_lover_selected + 1;
                        }
                        break;
                    case 1:
                        if (custom_partner_selected == -1)
                        {
                            custom_menu_pos = 0;
                        }
                        else
                        {
                            custom_menu_pos = custom_partner_selected + 1;
                        }
                        break;
                    case 2:
                        if (custom_bedroom_selected == -1)
                        {
                            custom_menu_pos = oBackground.background_id;
                        }
                        else
                        {
                            custom_menu_pos = custom_bedroom_selected;
                        }
                        break;
                }
                custom_scale = 0.5;
            }
        }
    }
    custom_menu_pos_lerp += ((custom_menu_pos - custom_menu_pos_lerp) * 0.1);
    custom_scale += ((0 - custom_scale) * 0.2);
}
draw_set_font(global.custom_font_big);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
if ((orgasm == true || ((ds_list_find_index(pill_effects_active, UnknownEnum.Value_9) != -1 || ds_list_find_index(pill_effects_active, 35) != -1) && insert == true)) && title == false)
{
    var stat_x = 32;
    if (show_portrait == true)
    {
        stat_x = 256;
    }
    var max_icon = 3;
    if ((ds_list_find_index(pill_effects_active, UnknownEnum.Value_9) != -1 || ds_list_find_index(pill_effects_active, 35) != -1) && orgasm == false)
    {
        max_icon = 2;
    }
    for (var i = 0; i < max_icon; i++)
    {
        draw_sprite_ext(sGradient, 0, stat_x, room_height - 48 - (48 * i), 6, 2, 0, c_white, 1);
        draw_sprite_ext(sIcons, i, stat_x, room_height - 48 - (48 * i), 2, 2, 0, c_white, 1);
        switch (i)
        {
            case 0:
                var amount = string(stat_sperm_cell_lerp) + "M";
                if (stat_sperm_cell_lerp > 1000)
                {
                    amount = string(stat_sperm_cell_lerp / 1000) + "B";
                }
                if (stat_sperm_cell_lerp > 1000000)
                {
                    amount = string(stat_sperm_cell_lerp / 1000000) + "T";
                }
                draw_text(stat_x + 32, room_height - 48 - (48 * i), amount);
                if (stat_sperm_cell_lerp > 1000000)
                {
                    func_add_combo_flair(func_set_lang(91, "TRILLION SPERM"), 20000);
                }
                break;
            case 1:
                draw_text(stat_x + 32, room_height - 48 - (48 * i), string(stat_liters_lerp) + " L");
                break;
            case 2:
                draw_text(stat_x + 32, room_height - 48 - (48 * i), string(stat_duration) + " SEC");
                break;
        }
    }
}
draw_sprite_ext(sImpregnation, 0, x - 128, y - 32, 2, 2, 0, c_white, impregnation_scale);
draw_sprite_ext(sImpregnation, 1 + (impregnate == 2), x - 128, y - 32, 2 * (1 + sperm_jiggle), 2 * (1 - sperm_jiggle), 0, egg_color, impregnation_scale);
draw_set_halign(fa_center);
if (tutorial == true)
{
    var tutorial_text = func_set_lang(93, "HOLD LMB");
    if (mobile == true)
    {
        tutorial_text = func_set_lang(94, "TAP AND HOLD");
    }
    draw_sprite_ext(sButtonBack, 0, x - 80, ((room_height / 2) + 48) - (48 * thrust), 6, 2, 0, c_white, 0.75);
    draw_text(x - 80, ((room_height / 2) + 48) - (48 * thrust), tutorial_text);
}
if (impregnate > 0)
{
    for (var i = 0; i < array_length(sperm); i++)
    {
        var sperm_squish = 0;
        if (sperm[i] < 1)
        {
            sperm_squish = sperm_jiggle * 4;
        }
        var sperm_sprite = sImpregnationSperm;
        if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_1) != -1)
        {
            sperm_sprite = sImpregnationSpermBig;
        }
        draw_sprite_ext(sperm_sprite, (current_time / 100) + i, (x - 128) + (dcos((30 * i) - 45) * ((2 * sperm[i]) + sperm_squish)), y - 32 - (dsin((30 * i) - 45) * ((2 * sperm[i]) + sperm_squish)), 2, 2, 30 * i, cum_color, impregnation_scale * (1 - (sperm[i] / 30)));
        if (sperm[i] > 0)
        {
            if (sperm[i] < 1)
            {
                if (sperm_speed[i] > 0.5)
                {
                    futa_score += 500;
                    score_combo += 500;
                    if (rpg == true)
                    {
                        rpg_xp += round(50 * power(1.05, rpg_enemy_level - 1));
                        rpg_scale = 0.5;
                    }
                    score_combo_scale = 1.5;
                    score_combo_timer = 120;
                    sperm_jiggle = choose(0.2, -0.2);
                    audio_play_sound(sndPop, 0, false, 0.15, 0, random_range(0.4, 0.6));
                    if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_1) != -1)
                    {
                        sperm_jiggle = choose(0.5, -0.5);
                        futa_score += 500;
                        score_combo += 500;
                        if (sperm_choice == -1)
                        {
                            sperm_choice = i;
                            func_add_combo_flair(func_set_lang(96, "MEGA FERTILIZED"), 5000);
                            fertilizations += 1;
                            impregnate = 2;
                        }
                    }
                }
                sperm_speed[i] = 0;
            }
            else
            {
                sperm[i] -= sperm_speed[i];
                sperm_speed[i] += 0.02;
            }
        }
        if (sperm_choice == i)
        {
            sperm[i] += (-8 - sperm[i]) * 0.1;
        }
    }
}
if (impregnation_timer < 90 && impregnation_timer > 60 && sperm_choice == -1 && impregnate > 0)
{
    sperm_choice = irandom(11);
    sperm_jiggle += 0.2;
    func_add_combo_flair(func_set_lang(97, "FERTILIZED"), 2500);
    audio_play_sound(sndPop, 0, false, 0.25, 0, 0.8);
    stat_total_fertilizations += 1;
    impregnate = 2;
    if (top_sprite == sFutaMatingPressClown)
    {
        audio_play_sound(sndHonk1, 0, false, 0.2);
    }
    fertilizations += 1;
}
if (impregnate == 2)
{
    var impregnate_string = "";
    if (rpg == true)
    {
        impregnate_string += "CRITICAL HIT!";
        if (fertilizations > 1)
        {
            impregnate_string += (" [x" + string(fertilizations) + "]");
        }
    }
    else if (fertilizations > 1)
    {
        impregnate_string += ("x" + string(fertilizations));
    }
    draw_text_color(x - 128, y - 86 - (4 * sperm_jiggle) - (4 * impregnation_scale), impregnate_string, c_black, c_black, c_black, c_black, impregnation_scale);
    draw_text_color(x - 128, y - 88 - (4 * sperm_jiggle) - (4 * impregnation_scale), impregnate_string, c_white, c_white, c_white, c_white, impregnation_scale);
}
draw_set_halign(fa_right);
if (show_dialogue == true && title == false)
{
    if (top_dialogue != "")
    {
        var dialogue_height = 96;
        var dialogue_width = 72;
        if (sex_position == 1)
        {
            dialogue_height = -16;
            dialogue_width = 128;
        }
        if (sex_position == 2)
        {
            dialogue_height = 16;
        }
        var text_top_color = merge_color(c_white, top_dialogue_color, 0.5);
        var text_bottom_color = merge_color(c_black, top_dialogue_color, 0.5);
        draw_sprite_ext(sDialogueBubble, 0, x - dialogue_width, y - dialogue_height - (16 * top_dialogue_scale) - (8 * insert_thrust), 1, 1, 0, top_dialogue_color, top_dialogue_scale);
        draw_sprite_ext(sDialogueBubble, 1, x - dialogue_width, y - dialogue_height - (16 * top_dialogue_scale) - (8 * insert_thrust), 1, 1 + ((string_height_ext(top_dialogue, 16, 128) / 24) * top_dialogue_scale), 0, top_dialogue_color, top_dialogue_scale);
        draw_text_ext_color(x - dialogue_width - 18, ((y - dialogue_height) + 2) - (16 * top_dialogue_scale) - (8 * insert_thrust), top_dialogue, 16, 128, text_bottom_color, text_bottom_color, text_bottom_color, text_bottom_color, top_dialogue_scale);
        draw_text_ext_color(x - dialogue_width - 18, y - dialogue_height - (16 * top_dialogue_scale) - (8 * insert_thrust), top_dialogue, 16, 128, c_white, c_white, text_top_color, text_top_color, top_dialogue_scale);
    }
    if (bottom_dialogue != "" && !(sex_position == 2 && insert == true))
    {
        var dialogue_height = -32;
        var dialogue_width = 128;
        if (sex_position == 1)
        {
            dialogue_height = 72;
            dialogue_width = 72;
        }
        if (sex_position == 2)
        {
            dialogue_height = -96;
            dialogue_width = 72;
        }
        var text_top_color = merge_color(c_white, bottom_dialogue_color, 0.5);
        var text_bottom_color = merge_color(c_black, bottom_dialogue_color, 0.5);
        draw_sprite_ext(sDialogueBubble, 0, x - dialogue_width, y - dialogue_height - (16 * bottom_dialogue_scale) - (8 * insert_thrust), 1, 1, 0, bottom_dialogue_color, bottom_dialogue_scale);
        draw_sprite_ext(sDialogueBubble, 1, x - dialogue_width, y - dialogue_height - (16 * bottom_dialogue_scale) - (8 * insert_thrust), 1, 1 + ((string_height_ext(bottom_dialogue, 16, 128) / 24) * bottom_dialogue_scale), 0, bottom_dialogue_color, bottom_dialogue_scale);
        draw_text_ext_color(x - dialogue_width - 18, ((y - dialogue_height) + 2) - (16 * bottom_dialogue_scale) - (8 * insert_thrust), bottom_dialogue, 16, 128, text_bottom_color, text_bottom_color, text_bottom_color, text_bottom_color, bottom_dialogue_scale);
        draw_text_ext_color(x - dialogue_width - 18, y - dialogue_height - (16 * bottom_dialogue_scale) - (8 * insert_thrust), bottom_dialogue, 16, 128, c_white, c_white, text_top_color, text_top_color, bottom_dialogue_scale);
    }
}
draw_set_halign(fa_center);
var cursor_id = 0;
var cursor_size = 1;
if (title_scale > 0.01)
{
    part_system_drawit(global.ps_back);
    draw_set_valign(fa_top);
    draw_set_halign(fa_left);
    if (outside_wait_timer >= 900)
    {
        if (scrHitboxRectangle(80, 268, 144, 332))
        {
            var total_stats_string = "";
            total_stats_string += (func_set_lang(190, "TOTAL SEX DURATION") + ": " + string(round(stat_total_sex_hour)) + "HR " + string(round(stat_total_sex_min)) + "MIN " + string(round(stat_total_sex_sec)) + "SEC\n");
            var amount = string(stat_total_sperm_cell) + "M";
            if (stat_total_sperm_cell > 1000)
            {
                amount = string(stat_total_sperm_cell / 1000) + "B";
            }
            if (stat_total_sperm_cell > 1000000)
            {
                amount = string(stat_total_sperm_cell / 1000000) + "T";
            }
            total_stats_string += (func_set_lang(191, "DISTANCE THRUSTED") + ": " + string(stat_distance_thrusted) + " " + func_set_lang(192, "METERS") + "\n");
            total_stats_string += (func_set_lang(193, "PLAPS") + ": " + string(stat_total_plaps) + "\n\n");
            total_stats_string += (func_set_lang(194, "ORGASMS") + ": " + string(stat_total_orgasms) + "\n");
            total_stats_string += (func_set_lang(195, "ORGASM PUMPS") + ": " + string(stat_total_pumps) + "\n");
            total_stats_string += (func_set_lang(196, "SPERM EJACULATED") + ": " + string(amount) + "\n");
            total_stats_string += (func_set_lang(197, "LITERS OF SEMEN EJACULATED") + ": " + string(stat_total_liters) + "L\n");
            total_stats_string += (func_set_lang(198, "SECONDS SPENT EJACULATING") + ": " + string(stat_total_orgasm_duration) + "\n");
            total_stats_string += (func_set_lang(199, "FERTILIZATIONS") + ": " + string(stat_total_fertilizations) + "\n\n");
            total_stats_string += (func_set_lang(200, "CONDOMS USED") + ": " + string(stat_total_condoms_filled) + "\n");
            total_stats_string += (func_set_lang(201, "MONEY SPENT ON BUNNY GIRLS") + ": $" + func_get_money(stat_total_bunny_money) + "\n");
            total_stats_string += (func_set_lang(202, "HIGHEST DUNGEON LEVEL") + ": " + string(stat_rpg_level_highest) + "\n");
            total_stats_string += (func_set_lang(203, "TOTAL DUNGEON DAMAGE") + ": " + string(stat_rpg_damage) + "\n");
            var viewer_string = string(round(stat_livestream_viewers));
            if (stat_livestream_viewers > 999)
            {
                viewer_string = string(stat_livestream_viewers / 1000) + "K";
            }
            if (stat_livestream_viewers > 999999)
            {
                viewer_string = string(stat_livestream_viewers / 1000000) + "M";
            }
            total_stats_string += (func_set_lang(204, "MOST LIVESTREAM VIEWERS") + ": " + string(viewer_string) + "\n");
            draw_sprite_ext(sGradient, 0, 0, room_height / 2, 8, room_height / 16, 0, c_white, 1);
            draw_text_ext_color(32, 33, total_stats_string, 16, 320, c_black, c_black, c_black, c_black, 1);
            draw_text_ext_color(32, 32, total_stats_string, 16, 320, c_white, c_white, c_white, c_white, 1);
        }
    }
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text_color(plap_x, plap_y + (4 * plap_scale), plap_string, c_white, c_white, c_white, c_white, plap_scale * 0.35);
    if (start_timer == -1)
    {
        draw_sprite_ext(sAplove, 0, room_width / 2, ((room_height / 2) + 8) - (8 * logo_scale), 4, 4, 0, c_white, logo_scale * title_scale);
        draw_sprite_ext(sTitle, 0, room_width / 2, ((room_height / 2) + 8) - (8 * title_scale), 2, 2, 0, c_white, title_alpha * title_scale);
    }
    var continue_string = func_set_lang(14, "CLICK TO BEGIN");
    if (mobile == true)
    {
        continue_string = func_set_lang(15, "TAP TO BEGIN");
    }
    draw_sprite_ext(sButtonBack, 0, room_width / 2, room_height - 24, 16, 2, 0, c_white, 0.5 * title_alpha * title_scale);
    draw_text_color(room_width / 2, room_height - 24, continue_string, c_white, c_white, c_white, c_white, title_alpha * title_scale);
    draw_sprite_ext(sButtonBack, 0, room_width / 2, room_height / 2, 500, 500, 0, c_white, 0.5 * disclaimer_scale * title_scale);
    draw_set_font(global.custom_font_big);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    var version_string = "";
    var modded = false;
    if (modded == true)
    {
        version_string += "Modded v1.4.0.4";
    }
    else
    {
        version_string += "Vanilla v1.4.0.4";
    }
    draw_text_color(8, 8, version_string, c_white, c_white, c_white, c_white, title_scale * title_alpha);
    var loaded_string = "";
    if (custom_sprite_loaded == true)
    {
        loaded_string += ("CUSTOM ASSETS LOADED\nLOVERS - " + string(ds_list_size(custom_lover_folders)) + "\nPARTNERS - " + string(ds_list_size(custom_partner_folders)) + "\nBEDROOMS - " + string(ds_list_size(custom_bedroom_folders)));
    }
    if (ds_list_size(custom_warning) > 0)
    {
        loaded_string += "\n\nWARNING! -- DETECTED MISSING SPRITES FOR:\n";
        for (var i = 0; i < ds_list_size(custom_warning); i++)
        {
            loaded_string += ("-" + string_upper(ds_list_find_value(custom_warning, i)) + "\n");
        }
    }
    draw_set_font(global.custom_font_small);
    draw_text_ext_color(8, 32, loaded_string, 8, 160, c_white, c_white, c_white, c_white, title_scale * title_alpha);
    draw_set_font(global.custom_font_big);
    var credits = func_set_lang(4, "Created by Aplove (@aplovestudio)") + "\n\n" + func_set_lang(5, "Sound Effects from OpenNSFWSP & Freesound.org") + "\n" + func_set_lang(6, "Moaning Voice by SwitchyValAudio");
    var credit_button = point_in_rectangle(mouse_x, mouse_y, 48, room_height - 32 - 8, 112, (room_height - 32) + 8);
    draw_set_halign(fa_left);
    draw_set_valign(fa_bottom);
    if (credit_button == true)
    {
        draw_sprite_ext(sButtonBack, 0, 32 + (string_width_ext(credits, 16, 320) / 2), room_height - 58 - (string_height_ext(credits, 16, 320) / 2), string_width_ext(credits, 16, 320) / 14, string_height_ext(credits, 16, 320) / 14, 0, c_white, 0.5 * title_scale * title_alpha);
        draw_text_ext_color(32, room_height - 64, credits, 16, 320, c_white, c_white, c_white, c_white, title_scale * title_alpha);
    }
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_sprite_ext(sButtonBack, 0, 80, room_height - 32, 8, 2, 0, c_white, (0.5 + (0.5 * credit_button)) * (title_scale * title_alpha));
    draw_text_color(80, room_height - 32, func_set_lang(7, "CREDITS"), c_white, c_white, c_white, c_white, title_scale * title_alpha);
    var warning_string = func_set_lang(9, "WARNING:") + "\n\n" + func_set_lang(10, "This game contains explicit content intended for adults only. It contains fetish content (i.e. futanari, excessive liquids, cum inflation) that may not be suitable for everyone.") + "\n\n" + func_set_lang(11, "This game's content is also intended to display a polyamorous relationship, but may come across as NTR/cuckolding depending on how you interact with it. There is an option to disable the dialogue if you would like a more vanilla experience. Player discretion is advised.") + "\n\n";
    if (true && mobile == false)
    {
        warning_string += "The PC version also supports customization such as custom characters, dialogue, and backgrounds. If you're interested, download the Custom Assets Folder at aplovestudio.itch.io/wifes-bedroom to get started!\n\n";
    }
    warning_string += func_set_lang(12, "CLICK ANYWHERE TO BEGIN");
    draw_sprite_ext(sButtonBack, 0, room_width / 2, room_height / 2, string_width_ext(warning_string, 16, 400) / 14, string_height_ext(warning_string, 16, 400) / 14, 0, c_white, 0.5 * disclaimer_scale * title_scale);
    draw_text_ext_color(room_width / 2, room_height / 2, warning_string, 16, 400, c_white, c_white, c_white, c_white, disclaimer_scale * title_scale);
}
if (title == true)
{
    if (mouse_check_button_pressed(mb_left) && title_timer < 1 && scrHitboxRectangle(128, 0, room_width - 128, room_height))
    {
        if (disclaimer == false && virgin == true && outside_wait_timer < 900)
        {
            disclaimer = true;
        }
        else
        {
            title = false;
            title_scale = 1;
            title_alpha = 0;
            disclaimer = false;
            outside_wait_timer = 0;
            audio_play_sound(sndDoorOpen, 0, 0);
            audio_bus_main.effects[0] = undefined;
            audio_bus_main.effects[1] = undefined;
            audio_bus_main.effects[2] = undefined;
            if (start_timer == -1)
            {
                start_timer = 90;
                var finished = false;
                var finish_chance = irandom(15);
                if (keyboard_check(vk_space))
                {
                    finish_chance = 1;
                }
                if (virgin == false && loads < max_loads && finish_chance == 0)
                {
                    finished = true;
                }
                if (finished == true)
                {
                    sex_progress = sex_progress_max;
                    loads = max_loads - 1;
                    repeat (max_loads)
                    {
                        stat_total_orgasms += 1;
                        futa_score += random_range(3500, 15000);
                        stat_total_sex_sec += random_range(45, 75);
                        stat_distance_thrusted += random_range(5, 15);
                        stat_total_plaps += sex_progress_max;
                        var amount_boost = ball_size * random_range(0.8, 1.2);
                        if (instance_number(oCondom) < 5)
                        {
                            var condom_spawn = instance_create_depth(x + random_range(-360, 360), 496, depth - 1, oCondom);
                            condom_spawn.condom_size = 2 * amount_boost;
                            condom_spawn.condom_jiggle = 0;
                            if ((2 * amount_boost) > 1.25)
                            {
                                condom_spawn.condom_size *= 0.5;
                                condom_spawn.image_index = 3;
                            }
                            condom_spawn.condom_color = make_color_hsv(irandom(255), 50, 255);
                            condom_spawn.stat_sperm_cell = 50 * amount_boost * orgasm_pumps_max;
                            condom_spawn.stat_liters = 0.25 * amount_boost * orgasm_pumps_max;
                            condom_spawn.stat_duration = round(orgasm_pumps_max) / 2;
                            condom_spawn.stat_pumps = round(orgasm_pumps_max);
                            condom_spawn.stat_total_load = stat_total_orgasms;
                        }
                        stat_total_condoms_filled += 1;
                        stat_total_sperm_cell += (50 * amount_boost * orgasm_pumps_max);
                        stat_total_liters += (0.25 * amount_boost * orgasm_pumps_max);
                        stat_total_orgasm_duration += (round(orgasm_pumps_max) / 2);
                        stat_total_pumps += round(orgasm_pumps_max);
                    }
                }
            }
        }
    }
}
else
{
    if (custom_menu == false && start_timer < 1)
    {
        var ass_offset = 0;
        if (sex_position == 1)
        {
            ass_offset = 80;
        }
        if (sex_position == 2)
        {
            ass_offset = 72;
        }
        if (scrHitboxRectangle(x - (64 * base_sex_size), (y - (24 * base_sex_size)) + ass_offset, x + (64 * base_sex_size), y + (24 * base_sex_size) + ass_offset))
        {
            cursor_id = 1;
            cursor_size = 2;
            if (mouse_check_button_pressed(mb_left) && (abs(top_ass_jiggle) < 0.01 || (orgasm == true && orgasm_pumps < 3)))
            {
                top_ass_jiggle = -0.1;
                body_jiggle = -0.05;
                audio_play_sound(sndAssSlap, 0, false);
                plap_x = x;
                plap_y = y + ass_offset;
                plap_scale = 2;
                plap_string = choose(func_set_lang(100, "SMACK!"), func_set_lang(101, "SPANK!"));
                if (top_sprite == sFutaMatingBunny)
                {
                    bunny_money += (10 * top_ass_size * top_quality);
                    stat_total_bunny_money += (10 * top_ass_size * top_quality);
                }
                func_top_speak("spank");
                if (orgasm == true && orgasm_pumps < 5)
                {
                    func_add_combo_flair(func_set_lang(98, "ENCORGASM"), 2500);
                    top_ass_jiggle = -0.2;
                    body_jiggle = -0.1;
                    func_top_speak("sex_encorgasm");
                    orgasm = true;
                    orgasm_pumps = orgasm_pumps_max;
                    orgasm_timer = 120;
                    encore = false;
                    if (moaning == true && ds_list_find_index(pill_effects_active, UnknownEnum.Value_10) == -1)
                    {
                        audio_stop_sound(moan_sound);
                        moan_sound = audio_play_sound(ds_list_find_value(orgasm_list, irandom(ds_list_size(orgasm_list) - 1)), 0, false, 0.5, 0, moan_pitch);
                    }
                }
                if (moaning == true && (moan_sound == -1 || !audio_is_playing(moan_sound)) && ds_list_size(moan_fast_list) > 0)
                {
                    moan_sound = audio_play_sound(ds_list_find_value(moan_fast_list, irandom(ds_list_size(moan_fast_list) - 1)), 0, false, 0.5, 0, moan_pitch);
                }
                if (insert == false && (ds_list_find_index(pill_effects_active, UnknownEnum.Value_9) != -1 || ds_list_find_index(pill_effects_active, 35) != -1))
                {
                    if (condom == true)
                    {
                        var _c_cap = (ds_list_find_index(pill_effects_active, 24) != -1) ? ((ds_list_find_index(pill_effects_active, 19) != -1) ? 20 : 10) : 6;
                        condom_size = min(_c_cap, (stat_liters / 2.5) + 0.1);
                        condom_jiggle = 0.1;
                        condom_size = min((ds_list_find_index(pill_effects_active, 24) != -1) ? ((ds_list_find_index(pill_effects_active, 19) != -1) ? 20 : 10) : 6, condom_size);
                        audio_play_sound(choose(sndCumInside1, sndCumInside2, sndCumInside3, sndCumInside4), 0, false, 0.15, 0, 1);
                    }
                    else
                    {
                        func_cum_splurt(false);
                        audio_play_sound(choose(sndCumSplurt1, sndCumSplurt2, sndCumSplurt3), 0, false, 0.5, 0, random_range(0.9, 1.1));
                    }
                }
                if (insert == true)
                {
                    slap_boost = 5;
                    alarm[0] = 60;
                }
            }
        }
        if (penis_grab == true)
        {
            cursor_size = 2;
            cursor_id = 2;
        }
    }
    if (boob_press == true)
    {
        cursor_id = 2;
        cursor_size = 2;
    }
    if (mouth_press == true)
    {
        cursor_id = 4;
        cursor_size = 1;
        if (mouse_check_button(mb_left))
        {
            if (!audio_is_playing(sndKiss))
            {
                audio_play_sound(sndKiss, 0, false, 0.25, 0, random_range(0.95, 1.05));
            }
            if (alt_portrait == true)
            {
                func_bottom_speak("kiss");
            }
            else
            {
                func_top_speak("kiss");
            }
        }
    }
    if (headpat_press == true)
    {
        cursor_id = 5;
        cursor_size = 2;
        if (mouse_check_button(mb_left))
        {
            cursor_id = 3;
            if (headpat_delay > 0)
            {
                headpat_delay -= 1;
            }
            if (point_distance(mouse_x, mouse_y, mouse_x_prev, mouse_y_prev) > 12 && headpat_delay < 1)
            {
                if (headpat < 20)
                {
                    headpat += 1;
                    if (headpat == 20)
                    {
                        if (alt_portrait == true)
                        {
                            func_bottom_speak("headpat");
                        }
                        else
                        {
                            func_top_speak("headpat");
                        }
                    }
                }
                mouse_x_prev = mouse_x;
                mouse_y_prev = mouse_y;
                headpat_delay = 3;
                audio_play_sound(sndHeadpat, 0, false, 0.25, 0, random_range(0.95, 1.05));
            }
        }
    }
}
with (oCondom)
{
    if (grab == true)
    {
        cursor_id = 2;
        cursor_size = 2;
    }
    else if (scrHitboxRectangle(x - 32, y - 32 - (64 * condom_size), x + 32, (y + 32) - (64 * condom_size)) && instance_nearest(mouse_x, mouse_y, oCondom) == id)
    {
        cursor_id = 1;
        cursor_size = 2;
        draw_set_font(global.custom_font_big);
        draw_set_valign(fa_middle);
        draw_set_halign(fa_center);
        var amount = string(stat_sperm_cell) + "M";
        if (stat_sperm_cell > 1000)
        {
            amount = string(stat_sperm_cell / 1000) + "B";
        }
        var data_string = "";
        with (other)
        {
            data_string = func_set_lang(104, "LOAD") + " #" + string(loads) + "\n" + func_set_lang(105, "SPERM") + ": " + string(amount) + "\n" + func_set_lang(106, "LITERS") + ": " + string(other.stat_liters) + "L\n" + func_set_lang(107, "DURATION") + ": " + string(other.stat_duration) + " SEC" + "\n" + func_set_lang(108, "PUMPS") + ": x" + string(other.stat_pumps);
        }
        draw_sprite_ext(sButtonBack, 0, x, y - (128 * condom_size), (string_width_ext(data_string, 14, 240) + 16) / 16, (string_height_ext(data_string, 14, 240) + 16) / 16, 0, c_white, 0.5);
        draw_text_ext(x, y - (128 * condom_size), data_string, 14, 240);
        if (mouse_check_button_pressed(mb_left) && penis_grab == false && oFutaMatingPress.custom_menu == false)
        {
            with (oCondom)
            {
                grab = false;
            }
            grab = true;
            audio_play_sound(choose(sndSlosh1, sndSlosh2, sndSlosh3), 0, false, 0.75, 0, 1.25 - (0.25 * condom_size));
        }
    }
}
draw_set_valign(fa_middle);
with (oCondom)
{
    if (grab == true)
    {
        draw_sprite_ext(sprite_index, image_index, x, y, (condom_size + condom_jiggle) * base_sex_size, (condom_size - condom_jiggle) * base_sex_size, 0, merge_color(oFutaMatingPress.cum_color, condom_color, 0.5), 1);
    }
}
var mouse_draw_x = mouse_x;
var mouse_draw_y = mouse_y;
if (mouse_check_button(mb_left) && penis_grab == true)
{
    mouse_draw_x = x;
    mouse_draw_y = y + (((64 - (24 * thrust)) + grab_offset) * base_sex_size);
}
var draw_cursor = true;
if (mobile == true && (mouse_check_button(mb_left) == false || cursor_id == 0))
{
    draw_cursor = false;
}
if (draw_cursor == true)
{
    draw_sprite_ext(sCursor, cursor_id, mouse_draw_x, mouse_draw_y, cursor_size, cursor_size, 0, c_white, 1);
}
if (keyboard_check_pressed(vk_escape) && title == false && oBackground.background_id == 0 && custom_bedroom_selected == -1)
{
    title = true;
    title_scale = 0;
    title_alpha = 0;
    outside_wait_timer = 900;
    auto_insert = true;
    audio_play_sound(sndDoorClose, 0, 0);
    audio_bus_main.effects[0] = effect_muffled;
    audio_bus_main.effects[1] = effect_gain;
}
if (banner_scale > 0.01)
{
    draw_sprite_ext(sButtonBack, 0, room_width / 2, 32 * banner_scale, 24, 2, 0, c_white, banner_scale * 0.75);
    draw_text_color(room_width / 2, 32 * banner_scale, banner_text, c_white, c_white, c_white, c_white, banner_scale);
}
mouse_x_prev = mouse_x;
mouse_y_prev = mouse_y;
if (orgasm == true && custom_clench_toggle == true)
{
    var _bc_frame = floor(power(clamp(1 - (orgasm_timer / 50), 0, 1), 0.4) * 4);
    var _bc_spr = global.sBallsClenching;
    if (top_sprite == sFutaMatingPressAndroid)
    {
        _bc_spr = global.sBallsClenchingAndroid;
    }
    else if (top_sprite == sFutaMatingPressSlime)
    {
        _bc_spr = global.sBallsClenchingSlime;
    }
    if (sex_position == 1 || sex_position == 2)
    {
        _bc_spr = global.sBallsClenchingCow;
        if (top_sprite == sFutaMatingPressAndroid)
        {
            _bc_spr = global.sBallsClenchingCowAndroid;
        }
        else if (top_sprite == sFutaMatingPressSlime)
        {
            _bc_spr = global.sBallsClenchingCowSlime;
        }
    }
    if (sprite_exists(_bc_spr))
    {
        var _clench_y = (y - (thrust * 32 * base_sex_size)) + (ball_size * 12);
        draw_sprite_ext(_bc_spr, _bc_frame, x, _clench_y, (image_xscale + top_breath) * (1 + balls_jiggle) * ball_size * base_sex_size, (image_yscale - top_breath) * (1 - balls_jiggle) * ball_size * base_sex_size, 0, top_skin, 1);
    }
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4,
    Value_5,
    Value_6,
    Value_7,
    Value_8,
    Value_9,
    Value_10,
    Value_11,
    Value_12,
    Value_13,
    Value_14,
    Value_15,
    Value_16,
    Value_17
}
