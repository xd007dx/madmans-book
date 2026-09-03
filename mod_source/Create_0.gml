insert = false;
mobile = false;
window_set_cursor(cr_none);
custom_sprite_storage = ds_map_create();
custom_audio_storage = ds_map_create();
thrust = 0;
thrust_prev = 0;
thrust_speed = 2;
thrust_strength = 3;
thrust_middle = 0.5;
mouse_x_prev = 0;
mouse_y_prev = 0;
headpat = 0;
headpat_delay = 0;
xray = true;
tutorial = false;
submenu = -1;
submenu_swap = false;
thrust_time = 0;
plap = false;
plap_scale = 0;
plap_x = 0;
plap_y = 0;
plap_string = "PLAP";
pump_scale = 0;
schlick_timer = 0;
ball_size = 1;
womb_size = 1;
womb_size_lerp = 1;
balls_jiggle = 0;
balls_jiggle_move = 0;
top_ass_jiggle = 0;
top_ass_jiggle_move = 0;
top_boob_jiggle = 0;
top_boob_jiggle_move = 0;
bottom_boob_jiggle = 0;
bottom_boob_jiggle_move = 0;
show_dialogue = true;
top_dialogue = "";
top_dialogue_timer = 300;
top_dialogue_scale = 0;
top_dialogue_color = 16777215;
bottom_dialogue = "";
bottom_dialogue_timer = 300;
bottom_dialogue_delay = 0;
bottom_dialogue_scale = 0;
bottom_dialogue_color = 16777215;
loads = 0;
max_loads = 3;
body_jiggle = 0;
body_jiggle_move = 0;
condom_jiggle = 0;
condom_jiggle_move = 0;
sperm_jiggle = 0;
sperm_jiggle_move = 0;
slap_boost = 0;
sex_position = 0;
orgasm = false;
orgasm_pumps = 0;
orgasm_pumps_max = 25;
orgasm_timer = 0;
orgasm_sec_timer = 60;
encore = false;
fertility = 10;
edge_boost = 1;
condom = false;
condom_open = false;
condom_breaking = true;
condom_breaking_override = false;
condom_size = 0;
condom_color = make_color_hsv(irandom(255), 50, 255);
condom_strip = 0;
condom_broken = false;
condom_integrity = 2;
condom_integrity_max = 2;
condom_break = 20;
futa_score = 0;
score_combo = 0;
score_combo_timer = 0;
score_combo_scale = 0;
score_combo_mult = 0;
score_combo_mods = ds_list_create();
impregnate = 0;
impregnation_timer = 0;
impregnation_scale = 0;
fertilizations = 0;
sperm_choice = -1;
moan_sound = -1;
moaning = true;
moaning_set = true;
moan_pitch = 1;
moan_previous = -1;
moan_slow_list = ds_list_create();
moan_fast_list = ds_list_create();
orgasm_list = ds_list_create();
custom_moan_slow_list = ds_list_create();
custom_moan_fast_list = ds_list_create();
custom_orgasm_list = ds_list_create();
cumflation = true;
fullscreen = false;
show_portrait = false;
belly_behind_bulge = false;
rpg = false;
rpg_level = 1;
rpg_hp = 250;
rpg_hp_lerp = 250;
rpg_hp_max = 250;
rpg_xp = 0;
rpg_scale = 0;
rpg_enemy_level = 1;
for (var i = 0; i < 12; i++)
{
    sperm[i] = 0;
    sperm_speed[i] = 0;
}
alarm[0] = 120 + irandom(120);
top_skin = 16777215;
top_hair = 16776960;
top_stockings = 8421504;
bottom_skin = 16777215;
face_sprite = sFutaPortrait1;
mouth_sprite = sFutaPortrait1;
hair_sprite = sFutaPortrait1;
bangs_sprite = sFutaPortrait1;
top_mating_press = sFutaMatingPress;
top_cowgirl = sFutaCowgirl;
top_deepthroat = sFutaDeepthroat;
top_portrait = sFutaPortrait1;
top_condom = sFutaCondomNormal;
top_condom_broken = sFutaCondomNormal;
top_xray = sFutaXray;
top_xray_broken = sFutaXrayCondomBroken;
face_sprite_alt = sWifeCanonPortrait;
mouth_sprite_alt = sWifeCanonPortrait;
hair_sprite_alt = sWifeCanonPortrait;
bangs_sprite_alt = sWifeCanonPortrait;
alt_portrait = false;
x = room_width / 2;
face_x = 0;
face_y = 0;
cum_color = 16777215;
egg_color = 16777215;
top_ass_size = 1;
top_penis_width = 1;
top_penis_length = 1;
top_boob_size = 1;
alt_boobs = -1;
top_name = "Lover";
bottom_name = "Wife";
custom_top_name = "";
custom_bottom_name = "";
base_ass_size = 1;
base_penis_width = 1;
base_penis_length = 1;
base_boob_size = 1;
base_ball_size = 1;
base_max_loads = 3;
base_pumps_max = 20;
rare_guarantee = 0;
bunny_money = 0;
bunny_money_lerp = 0;
top_sprite = choose(sFutaMatingPress, sFutaMatingPress2, sFutaMatingPress3, sFutaMatingPress4);
hair_sprite = choose(sFutaMatingPress, sFutaMatingPress2, sFutaMatingPress3, sFutaMatingPress4, sFutaMatingPressAndroid, sFutaMatingPressDevil);
condom_offset = 78;
nipple_offset = [30, 54];
nipple_offset_alt = [36, 56];
head_offset = 0;
head_offset_alt = 0;
lactate = false;
lactate_alt = true;
dialogue_set_top = -1;
dialogue_set_bottom = -1;
custom_sprite_loaded = false;
custom_portrait = sFutaPortrait1;
custom_mating_press = sFutaMatingPress;
custom_cowgirl = sFutaCowgirl;
custom_deepthroat = sFutaDeepthroat;
custom_condom = sFutaCondomNormal;
custom_condom_broken = sFutaCondomBrokenNormal;
custom_condom_broken_xray = sFutaXrayCondomBroken;
custom_xray = sFutaXray;
custom_nipple = [28, 56];
custom_nipple_alt = [28, 56];
custom_condom_offset = 78;
custom_head_offset = 0;
custom_head_offset_alt = 0;
custom_default_moans = false;
custom_portrait_alt = sWifeCanonPortrait;
custom_mating_press_alt = sWifeMatingPress;
custom_cowgirl_alt = sWifeCowgirl;
custom_deepthroat_alt = sWifeDeepthroat;
custom_xray_alt = sUterusXray;
custom_max_loads = 5;
custom_max_pumps = 30;
custom_bulge_width = 1;
custom_bulge_height = 1;
custom_heavy_boobs = false;
custom_lactate = false;
custom_lactate_alt = false;
custom_cum_color = 13497599;
custom_egg_color = 16777215;
custom_fertile = true;
custom_enable_xray = true;
custom_lover_folders = ds_list_create();
custom_partner_folders = ds_list_create();
custom_bedroom_folders = ds_list_create();
custom_warning = ds_list_create();
custom_dialogue_set_top = -1;
custom_dialogue_color_top = 16777215;
custom_dialogue_set_bottom = -1;
custom_dialogue_color_bottom = 16777215;
custom_background = sBackgroundBedroom;
custom_background_animated = -1;
custom_bedroom = sBackgroundBedroom;
custom_bedroom_animated = -1;
custom_thumbnail = sCustomNoneBackground;
custom_background_breathe = false;
custom_background_audio_effect = 0;
custom_foreground_front = false;
custom_allow_condom_strip = false;
custom_animation_speed = false;
custom_music = -1;
background_breathe = false;
background_audio_effect = 0;
foreground_front = false;
background_allow_condom_strip = false;
background_animation_speed = 0.3;
background_music = -1;
background_music_volume = 0.25;
master_volume = 1;
max_particles = 1;
custom_name = "";
custom_desc = "";
custom_author = "";
custom_load_type = UnknownEnum.Value_0;
custom_folder = "/";
if (directory_exists(working_directory + "/custom"))
{
    show_debug_message("custom folder detected");
    custom_folder = "/custom/";
}
if (true && mobile == false)
{
    show_debug_message("checking " + working_directory);
    var _file_load = file_find_first(working_directory + string(custom_folder) + "*", 16);
    var _file = working_directory + string(custom_folder) + string(_file_load);
    while (_file != (working_directory + string(custom_folder) + ""))
    {
        show_debug_message(_file);
        if (directory_exists(_file) && _file != "language")
        {
            func_load_custom(_file);
            switch (custom_load_type)
            {
                case UnknownEnum.Value_1:
                    ds_list_add(custom_lover_folders, _file);
                    if (custom_portrait == sFutaPortrait1 || custom_mating_press == sFutaMatingPress || custom_cowgirl == sFutaCowgirl || custom_condom == sFutaCondomNormal || custom_xray == sFutaXray)
                    {
                        ds_list_add(custom_warning, string(_file_load));
                        show_debug_message("missing files: " + string(_file_load));
                    }
                    break;
                case UnknownEnum.Value_2:
                    ds_list_add(custom_partner_folders, _file);
                    if (custom_portrait == sWifeCanonPortrait || custom_mating_press == sWifeMatingPress || custom_cowgirl == sWifeCowgirl)
                    {
                        ds_list_add(custom_warning, string(_file_load));
                        show_debug_message("missing files: " + string(_file_load));
                    }
                    break;
                case UnknownEnum.Value_3:
                    ds_list_add(custom_bedroom_folders, _file);
                    break;
            }
        }
        _file_load = file_find_next();
        _file = working_directory + string(custom_folder) + string(_file_load);
    }
    file_find_close();
    if (ds_list_size(custom_lover_folders) > 0 || ds_list_size(custom_partner_folders) > 0 || ds_list_size(custom_bedroom_folders) > 0)
    {
        custom_sprite_loaded = true;
        tutorial = false;
    }
}

function func_check_custom_dialogue(arg0, arg1 = false)
{
    var return_array = [];
    var tag_check = "dialogue";
    if (arg1 == true)
    {
        tag_check = "dialogue_alt";
    }
    if (ini_key_exists(tag_check, string(arg0) + "_0"))
    {
        for (var check_value = 0; ini_key_exists(tag_check, string(arg0) + "_" + string(check_value)); check_value += 1)
        {
            return_array[check_value] = ini_read_string(tag_check, string(arg0) + "_" + string(check_value), "");
        }
    }
    return return_array;
}

function func_get_custom_audio(arg0, arg1)
{
    if (directory_exists(arg1) == true)
    {
        ds_list_clear(arg0);
        custom_default_moans = true;
        var _file = file_find_first(string(arg1) + "/*.ogg", 0);
        show_debug_message(string(arg1) + "/" + string(_file));
        while (_file != "")
        {
            var moan_file = string(arg1) + "/" + string(_file);
            if (file_exists(moan_file))
            {
                ds_list_add(arg0, func_get_moan_audio(moan_file));
            }
            _file = file_find_next();
        }
        file_find_close();
    }
}

function func_replace_custom_sprite(arg0, arg1, arg2, arg3, arg4)
{
    show_debug_message(ds_map_find_value(custom_sprite_storage, arg1));
    if (ds_map_find_value(custom_sprite_storage, arg1) == undefined)
    {
        arg0 = sprite_add(arg1, arg2, false, false, arg3, arg4);
        ds_map_add(custom_sprite_storage, arg1, arg0);
    }
    return ds_map_find_value(custom_sprite_storage, arg1);
}

function func_get_moan_audio(arg0)
{
    if (ds_map_find_value(custom_audio_storage, arg0) == undefined)
    {
        var audio_add = audio_create_stream(arg0);
        ds_map_add(custom_audio_storage, arg0, audio_add);
        show_debug_message("added " + string(arg0));
    }
    return ds_map_find_value(custom_audio_storage, arg0);
}

function func_read_dialogue_json(arg0)
{
    var _data = "";
    if (file_exists(arg0))
    {
        var _file = file_text_open_read(arg0);
        var _json_string = "";
        while (!file_text_eof(_file))
        {
            _json_string += file_text_read_string(_file);
            file_text_readln(_file);
        }
        file_text_close(_file);
        _data = json_parse(_json_string);
    }
    return _data;
}

function func_load_custom(arg0)
{
    var sprite_origin_x = 80;
    var sprite_origin_y = 84;
    var portrait_origin_x = 64;
    var portrait_origin_y = 64;
    var deepthroat_origin_y = 150;
    var xray_origin_x = 80;
    var xray_origin_y = 84;
    custom_load_type = UnknownEnum.Value_0;
    show_debug_message("loading " + string(arg0));
    if (file_exists(string(arg0) + "/custom_data.futa"))
    {
        custom_load_type = UnknownEnum.Value_1;
    }
    if (file_exists(string(arg0) + "/custom_data.spouse"))
    {
        custom_load_type = UnknownEnum.Value_2;
    }
    if (file_exists(string(arg0) + "/custom_data.bedroom"))
    {
        custom_load_type = UnknownEnum.Value_3;
    }
    custom_portrait = sFutaPortrait1;
    custom_mating_press = sFutaMatingPress;
    custom_cowgirl = sFutaCowgirl;
    custom_deepthroat = sFutaDeepthroat;
    custom_condom = sFutaCondomNormal;
    custom_condom = sFutaCondomBrokenNormal;
    custom_xray = sFutaXray;
    custom_condom_offset = 78;
    custom_default_moans = false;
    custom_dialogue_set_top = -1;
    custom_dialogue_set_bottom = -1;
    custom_portrait_alt = sWifeCanonPortrait;
    custom_mating_press_alt = sWifeMatingPress;
    custom_cowgirl_alt = sWifeCowgirl;
    custom_deepthroat_alt = sWifeDeepthroat;
    custom_xray_alt = sUterusXray;
    custom_background = sBackgroundBedroom;
    custom_thumbnail = sThumbnailBedroom;
    custom_background_animated = -1;
    ds_list_clear(custom_moan_slow_list);
    ds_list_clear(custom_moan_fast_list);
    ds_list_clear(custom_orgasm_list);
    switch (custom_load_type)
    {
        case UnknownEnum.Value_1:
            condom_breaking_override = true;
            ini_open(string(arg0) + "/custom_data.futa");
            sprite_origin_x = ini_read_real("sprite", "origin_x", 80);
            sprite_origin_y = ini_read_real("sprite", "origin_y", 84);
            deepthroat_origin_y = ini_read_real("sprite", "deepthroat_origin_y", 150);
            custom_condom_offset = ini_read_real("sprite", "condom_y", 78);
            portrait_origin_x = ini_read_real("portrait", "origin_x", 64);
            portrait_origin_y = ini_read_real("portrait", "origin_y", 64);
            xray_origin_x = ini_read_real("sprite", "xray_x", 80);
            xray_origin_y = ini_read_real("sprite", "xray_y", 84);
            custom_nipple = [ini_read_real("portrait", "nipple_x", 28), ini_read_real("stats", "nipple_y", 56)];
            custom_nipple_alt = [ini_read_real("portrait", "nipple_x_alt", 28), ini_read_real("stats", "nipple_y_alt", 56)];
            custom_head_offset = ini_read_real("portrait", "head_offset", 0);
            custom_head_offset_alt = ini_read_real("portrait", "head_offset_alt", 0);
            custom_max_loads = ini_read_real("stats", "max_orgasms", 5);
            custom_max_pumps = ini_read_real("stats", "max_pumps", 30);
            custom_default_moans = ini_read_real("stats", "default_moans", false);
            custom_cum_color = make_color_rgb(ini_read_real("stats", "cum_r", 255), ini_read_real("stats", "cum_g", 244), ini_read_real("stats", "cum_b", 205));
            custom_egg_color = make_color_rgb(ini_read_real("stats", "egg_r", 255), ini_read_real("stats", "egg_g", 255), ini_read_real("stats", "egg_b", 255));
            custom_fertile = ini_read_real("stats", "fertile", true);
            custom_lactate = ini_read_real("stats", "lactate", false);
            custom_lactate_alt = ini_read_real("stats", "lactate_alt", false);
            custom_enable_xray = ini_read_real("stats", "enable_xray", true);
            custom_dialogue_color_top = make_color_rgb(ini_read_real("stats", "dialogue_r", 255), ini_read_real("stats", "dialogue_g", 255), ini_read_real("stats", "dialogue_b", 255));
            custom_dialogue_color_bottom = make_color_rgb(ini_read_real("stats", "dialogue_alt_r", 255), ini_read_real("stats", "dialogue_alt_g", 255), ini_read_real("stats", "dialogue_alt_b", 255));
            custom_name = ini_read_string("info", "name", "Untitled");
            custom_desc = ini_read_string("info", "desc", "???");
            custom_author = ini_read_string("info", "author", "???");
            custom_bulge_width = ini_read_real("sprite", "bulge_width", 1);
            custom_bulge_height = ini_read_real("sprite", "bulge_height", 1);
            custom_heavy_boobs = ini_read_real("sprite", "heavy_boobs", false);
            custom_dialogue_set_top = 
            {
                intro: func_check_custom_dialogue("intro"),
                intro_return: func_check_custom_dialogue("intro_return"),
                sex_start: func_check_custom_dialogue("sex_start"),
                sex_continue: func_check_custom_dialogue("sex_continue"),
                sex_halfway: func_check_custom_dialogue("sex_halfway"),
                sex_orgasm: func_check_custom_dialogue("sex_orgasm"),
                sex_after: func_check_custom_dialogue("sex_after"),
                sex_exhausted: func_check_custom_dialogue("sex_exhausted"),
                spank: func_check_custom_dialogue("spank"),
                mystery_effect: func_check_custom_dialogue("mystery_effect"),
                pullout: func_check_custom_dialogue("pullout"),
                condom_on: func_check_custom_dialogue("condom_on"),
                condom_off: func_check_custom_dialogue("condom_off"),
                condom_remove: func_check_custom_dialogue("condom_remove"),
                condom_break: func_check_custom_dialogue("condom_break"),
                cleanup: func_check_custom_dialogue("cleanup"),
                touch_boobs: func_check_custom_dialogue("touch_boobs"),
                moan: func_check_custom_dialogue("moan"),
                kiss: func_check_custom_dialogue("kiss"),
                headpat: func_check_custom_dialogue("headpat")
            };
            if (ini_section_exists("dialogue_alt"))
            {
                custom_dialogue_set_bottom = 
                {
                    intro: func_check_custom_dialogue("intro", true),
                    intro_return: func_check_custom_dialogue("intro_return", true),
                    sex_start: func_check_custom_dialogue("sex_start", true),
                    sex_continue: func_check_custom_dialogue("sex_continue", true),
                    sex_halfway: func_check_custom_dialogue("sex_halfway", true),
                    sex_orgasm: func_check_custom_dialogue("sex_orgasm", true),
                    sex_after: func_check_custom_dialogue("sex_after", true),
                    sex_exhausted: func_check_custom_dialogue("sex_exhausted", true),
                    cleanup: func_check_custom_dialogue("cleanup", true),
                    touch_boobs: func_check_custom_dialogue("touch_boobs", true),
                    moan: func_check_custom_dialogue("moan", true),
                    kiss: func_check_custom_dialogue("kiss", true),
                    headpat: func_check_custom_dialogue("headpat", true),
                    condom_on: func_check_custom_dialogue("condom_on", true),
                    condom_off: func_check_custom_dialogue("condom_off", true),
                    condom_remove: func_check_custom_dialogue("condom_remove", true),
                    condom_break: func_check_custom_dialogue("condom_break", true)
                };
            }
            ini_close();
            if (custom_sprite_loaded == true)
            {
                func_get_custom_audio(custom_moan_slow_list, string(arg0) + "/moan_slow");
                func_get_custom_audio(custom_moan_fast_list, string(arg0) + "/moan_fast");
                func_get_custom_audio(custom_orgasm_list, string(arg0) + "/orgasm");
                if (file_exists(string(arg0) + "/dialogue.json"))
                {
                    custom_dialogue_set_top = func_read_dialogue_json(string(arg0) + "/dialogue.json");
                }
                if (file_exists(string(arg0) + "/dialogue_alt.json"))
                {
                    custom_dialogue_set_bottom = func_read_dialogue_json(string(arg0) + "/dialogue_alt.json");
                }
            }
            var file_check = string(arg0) + "/custom_portrait.png";
            if (file_exists(file_check))
            {
                custom_portrait = func_replace_custom_sprite(custom_portrait, file_check, 10, portrait_origin_x, portrait_origin_y);
            }
            file_check = string(arg0) + "/custom_mating_press.png";
            if (file_exists(file_check))
            {
                custom_mating_press = func_replace_custom_sprite(custom_mating_press, file_check, 9, sprite_origin_x, sprite_origin_y);
            }
            file_check = string(arg0) + "/custom_reverse_cowgirl.png";
            if (file_exists(file_check))
            {
                var file_frames = 5;
                var temp_sprite = sprite_add(file_check, 1, false, false, sprite_origin_x, sprite_origin_y);
                if (sprite_exists(temp_sprite) && temp_sprite != -1)
                {
                    if (sprite_get_width(temp_sprite) > (sprite_origin_x * 10))
                    {
                        file_frames = 7;
                    }
                    sprite_delete(temp_sprite);
                }
                custom_cowgirl = func_replace_custom_sprite(custom_cowgirl, file_check, file_frames, sprite_origin_x, sprite_origin_y);
            }
            file_check = string(arg0) + "/custom_deepthroat.png";
            if (file_exists(file_check))
            {
                custom_deepthroat = func_replace_custom_sprite(custom_deepthroat, file_check, 9, sprite_origin_x, sprite_origin_y);
            }
            file_check = string(arg0) + "/custom_condom.png";
            if (file_exists(file_check))
            {
                custom_condom = func_replace_custom_sprite(custom_condom, file_check, 2, sprite_origin_x, sprite_origin_y);
            }
            file_check = string(arg0) + "/custom_condom_broken.png";
            if (file_exists(file_check))
            {
                condom_breaking_override = false;
                custom_condom_broken = func_replace_custom_sprite(custom_condom_broken, file_check, 2, sprite_origin_x, sprite_origin_y);
            }
            file_check = string(arg0) + "/custom_xray.png";
            if (file_exists(file_check))
            {
                custom_xray = func_replace_custom_sprite(custom_xray, file_check, 3, xray_origin_x, xray_origin_y);
            }
            file_check = string(arg0) + "/custom_xray_broken.png";
            if (file_exists(file_check))
            {
                condom_breaking_override = false;
                custom_condom_broken_xray = func_replace_custom_sprite(custom_condom_broken_xray, file_check, 1, xray_origin_x, xray_origin_y);
            }
            var mp_check = string(arg0) + "/custom_mating_press_alt.png";
            if (file_exists(mp_check))
            {
                custom_mating_press_alt = func_replace_custom_sprite(custom_mating_press_alt, mp_check, 4, sprite_origin_x, sprite_origin_y);
                file_check = string(arg0) + "/custom_portrait_alt.png";
                if (file_exists(file_check))
                {
                    custom_portrait_alt = func_replace_custom_sprite(custom_portrait_alt, file_check, 10, portrait_origin_x, portrait_origin_y);
                }
                file_check = string(arg0) + "/custom_reverse_cowgirl_alt.png";
                if (file_exists(file_check))
                {
                    custom_cowgirl_alt = func_replace_custom_sprite(custom_cowgirl_alt, file_check, 5, sprite_origin_x, sprite_origin_y);
                }
                file_check = string(arg0) + "/custom_deepthroat_alt.png";
                if (file_exists(file_check))
                {
                    custom_deepthroat_alt = func_replace_custom_sprite(custom_deepthroat_alt, file_check, 5, sprite_origin_x, deepthroat_origin_y);
                }
                file_check = string(arg0) + "/custom_xray_alt.png";
                if (file_exists(file_check))
                {
                    custom_xray_alt = func_replace_custom_sprite(custom_xray_alt, file_check, 4, 80, 84);
                }
            }
            break;
        case UnknownEnum.Value_2:
            ini_open(string(arg0) + "/custom_data.spouse");
            sprite_origin_x = ini_read_real("sprite", "origin_x", 80);
            sprite_origin_y = ini_read_real("sprite", "origin_y", 84);
            deepthroat_origin_y = ini_read_real("sprite", "deepthroat_origin_y", 150);
            portrait_origin_x = ini_read_real("portrait", "origin_x", 64);
            portrait_origin_y = ini_read_real("portrait", "origin_y", 64);
            xray_origin_x = ini_read_real("sprite", "xray_x", 80);
            xray_origin_y = ini_read_real("sprite", "xray_y", 84);
            custom_name = ini_read_string("info", "name", "Untitled");
            custom_desc = ini_read_string("info", "desc", "???");
            custom_author = ini_read_string("info", "author", "???");
            custom_dialogue_set_bottom = 
            {
                intro: func_check_custom_dialogue("intro"),
                intro_return: func_check_custom_dialogue("intro_return"),
                sex_start: func_check_custom_dialogue("sex_start"),
                sex_continue: func_check_custom_dialogue("sex_continue"),
                sex_halfway: func_check_custom_dialogue("sex_halfway"),
                sex_orgasm: func_check_custom_dialogue("sex_orgasm"),
                sex_after: func_check_custom_dialogue("sex_after"),
                sex_exhausted: func_check_custom_dialogue("sex_exhausted"),
                cleanup: func_check_custom_dialogue("cleanup"),
                touch_boobs: func_check_custom_dialogue("touch_boobs"),
                moan: func_check_custom_dialogue("moan"),
                kiss: func_check_custom_dialogue("kiss"),
                headpat: func_check_custom_dialogue("headpat"),
                condom_on: func_check_custom_dialogue("condom_on"),
                condom_off: func_check_custom_dialogue("condom_off"),
                condom_remove: func_check_custom_dialogue("condom_remove"),
                condom_break: func_check_custom_dialogue("condom_break")
            };
            custom_egg_color = make_color_rgb(ini_read_real("stats", "egg_r", 255), ini_read_real("stats", "egg_g", 255), ini_read_real("stats", "egg_b", 255));
            custom_dialogue_color_bottom = make_color_rgb(ini_read_real("stats", "dialogue_r", 255), ini_read_real("stats", "dialogue_g", 255), ini_read_real("stats", "dialogue_b", 255));
            custom_fertile = ini_read_real("stats", "fertile", true);
            custom_enable_xray = ini_read_real("stats", "enable_xray", true);
            custom_nipple_alt = [ini_read_real("portrait", "nipple_x", 28), ini_read_real("stats", "nipple_y", 56)];
            custom_lactate_alt = ini_read_real("stats", "lactate", false);
            custom_head_offset_alt = ini_read_real("portrait", "head_offset", 0);
            ini_close();
            if (custom_sprite_loaded == true)
            {
                if (file_exists(string(arg0) + "/dialogue.json"))
                {
                    custom_dialogue_set_bottom = func_read_dialogue_json(string(arg0) + "/dialogue.json");
                }
            }
            var file_check = string(arg0) + "/custom_portrait.png";
            if (file_exists(file_check))
            {
                custom_portrait_alt = func_replace_custom_sprite(custom_portrait_alt, file_check, 10, portrait_origin_x, portrait_origin_y);
            }
            file_check = string(arg0) + "/custom_mating_press.png";
            if (file_exists(file_check))
            {
                custom_mating_press_alt = func_replace_custom_sprite(custom_mating_press_alt, file_check, 4, sprite_origin_x, sprite_origin_y);
            }
            file_check = string(arg0) + "/custom_reverse_cowgirl.png";
            if (file_exists(file_check))
            {
                custom_cowgirl_alt = func_replace_custom_sprite(custom_cowgirl_alt, file_check, 5, sprite_origin_x, sprite_origin_y);
            }
            file_check = string(arg0) + "/custom_deepthroat.png";
            if (file_exists(file_check))
            {
                custom_deepthroat_alt = func_replace_custom_sprite(custom_deepthroat_alt, file_check, 5, sprite_origin_x, deepthroat_origin_y);
            }
            file_check = string(arg0) + "/custom_xray.png";
            if (file_exists(file_check))
            {
                custom_xray_alt = func_replace_custom_sprite(custom_xray_alt, file_check, 4, xray_origin_x, xray_origin_y);
            }
            break;
        case UnknownEnum.Value_3:
            ini_open(string(arg0) + "/custom_data.bedroom");
            custom_name = ini_read_string("info", "name", "Untitled");
            custom_desc = ini_read_string("info", "desc", "???");
            custom_author = ini_read_string("info", "author", "???");
            custom_background_breathe = ini_read_real("background", "foreground_breathe", false);
            custom_foreground_front = ini_read_real("background", "foreground_front", false);
            custom_background_audio_effect = ini_read_real("background", "audio_effect", 0);
            custom_allow_condom_strip = ini_read_real("background", "condom_strip", false);
            custom_animation_speed = ini_read_real("background", "animation_speed", 0.3);
            ini_close();
            var file_check = string(arg0) + "/background.png";
            show_debug_message(file_check);
            if (file_exists(file_check))
            {
                custom_background = func_replace_custom_sprite(custom_background, file_check, 4, 220, 128);
            }
            file_check = string(arg0) + "/thumbnail.png";
            if (file_exists(file_check))
            {
                custom_thumbnail = func_replace_custom_sprite(custom_thumbnail, file_check, 1, 64, 64);
            }
            file_check = string(arg0) + "/background_animated.png";
            if (file_exists(file_check))
            {
                var file_frames = 0;
                var temp_sprite = sprite_add(file_check, 1, false, false, 220, 128);
                if (sprite_exists(temp_sprite) && temp_sprite != -1)
                {
                    file_frames = round(sprite_get_width(temp_sprite) / 440);
                    sprite_delete(temp_sprite);
                }
                custom_background_animated = func_replace_custom_sprite(custom_background_animated, file_check, file_frames, 220, 128);
            }
            file_check = string(arg0) + "/music.ogg";
            show_debug_message(file_check);
            if (file_exists(file_check))
            {
                custom_music = audio_create_stream(file_check);
            }
            break;
    }
}

custom_menu = false;
custom_menu_pos = 0;
custom_menu_pos_lerp = 0;
custom_lover_selected = -1;
custom_lover_portraits = -1;
custom_lover_info = -1;
custom_partner_selected = -1;
custom_partner_portraits = -1;
custom_partner_info = -1;
custom_bedroom_selected = -1;
custom_bedroom_thumbnails = -1;
custom_bedroom_info = -1;
custom_scale = 0;
custom_tab = 0;
personality_name = "";
randomize();

function func_get_rating(arg0)
{
    var rating_numb = 0;
    if (arg0 >= 0.7)
    {
        rating_numb = 1;
    }
    if (arg0 >= 0.9)
    {
        rating_numb = 2;
    }
    if (arg0 >= 1)
    {
        rating_numb = 3;
    }
    if (arg0 >= 1.1)
    {
        rating_numb = 4;
    }
    if (arg0 >= 1.25)
    {
        rating_numb = 5;
    }
    if (arg0 >= 1.5)
    {
        rating_numb = 6;
    }
    if (arg0 >= 1.8)
    {
        rating_numb = 7;
    }
    if (arg0 >= 2.2)
    {
        rating_numb = 8;
    }
    if (arg0 >= 2.5)
    {
        rating_numb = 9;
    }
    if (arg0 >= 2.8)
    {
        rating_numb = 10;
    }
    return rating_numb;
}

function func_get_dialogue_json(arg0)
{
    var root_string = working_directory + "/";
    if (mobile == true)
    {
        root_string = "";
    }
    if (file_exists(string(root_string) + "dialogue/" + string(arg0)))
    {
        dialogue_set_top = func_read_dialogue_json(string(root_string) + "dialogue/" + string(arg0));
    }
}

function func_randomize_top()
{
    var temp_color = -1;
    for (var i = 0; i < 5; i++)
    {
        temp_color[i] = make_color_hsv(30, 0, min(255, 100 + (50 * i) + random_range(-25, 25)));
    }
    temp_color = array_shuffle(temp_color);
    top_skin = temp_color[0];
    top_hair = temp_color[1];
    top_stockings = temp_color[2];
    ds_list_clear(pill_effects_active);
    pill_effect_random = false;
    top_name = "Lover";
    ball_size = random_range(0.8, 1.2);
    top_ass_size = random_range(0.8, 1.2);
    top_penis_width = random_range(0.8, 1.2);
    top_penis_length = random_range(0.8, 1.2);
    top_boob_size = random_range(0.8, 1.2);
    cum_color = 13497599;
    condom_offset = 78;
    head_offset = 0;
    condom = false;
    condom_size = 0;
    condom_breaking_override = false;
    bottom_skin = 16777215;
    egg_color = 16777215;
    if (custom_partner_selected != -1)
    {
        egg_color = custom_egg_color;
    }
    moaning = moaning_set;
    moan_pitch = random_range(0.9, 1.1);
    rpg_enemy_level = round(max(rpg_level, rpg_level * top_penis_width * top_penis_length * ball_size * top_boob_size * top_ass_size) + irandom(20));
    ds_list_clear(moan_slow_list);
    ds_list_clear(moan_fast_list);
    ds_list_clear(orgasm_list);
    ds_list_add(moan_slow_list, sndMoanOpenSlow1, sndMoanOpenSlow2, sndMoanOpenSlow3, sndMoanClosedSlow4, sndMoanClosedSlow1, sndMoanClosedSlow2, sndMoanClosedSlow3, sndMoanClosedSlow4, sndMoanExtra1, sndMoanExtra2, sndMoanExtra3, sndMoanExtra4);
    ds_list_add(moan_fast_list, sndMoanOpenFast1, sndMoanOpenFast2, sndMoanOpenFast3, sndMoanClosedFast4, sndMoanClosedFast1, sndMoanClosedFast2, sndMoanClosedFast3, sndMoanClosedFast4);
    ds_list_add(orgasm_list, sndMoanOrgasm1, sndMoanOrgasm2, sndMoanOrgasm3, sndMoanOrgasm5);
    orgasm_pumps_max = 20 * (top_penis_length * top_penis_width);
    max_loads = choose(3, 4, 5);
    rare_guarantee += 1;
    var background = oBackground;
    if (variable_instance_exists(background.id, "background_id") == false)
    {
        background = -4;
    }
    if (instance_exists(background) && background.background_id > 0)
    {
        rare_guarantee += 1;
    }
    top_sprite = choose(sFutaMatingPress, sFutaMatingPress2, sFutaMatingPress3, sFutaMatingPress4);
    hair_sprite = choose(sFutaMatingPress, sFutaMatingPress2, sFutaMatingPress3, sFutaMatingPress4, sFutaMatingPressAndroid, sFutaMatingPressDevil, sFutaMatingPressAlien, sFutaMatingPressClown);
    face_sprite = choose(sFutaPortrait1, sFutaPortrait2, sFutaPortrait3, sFutaPortrait4);
    mouth_sprite = choose(sFutaPortrait1, sFutaPortrait2, sFutaPortrait3, sFutaPortrait4);
    bangs_sprite = choose(sFutaPortrait1, sFutaPortrait2, sFutaPortrait3, sFutaPortrait4, sFutaPortraitAndroid, sFutaPortraitDevil, sFutaPortraitClown);
    alt_boobs = -1;
    lactate = false;
    if (top_boob_size >= 1)
    {
        alt_boobs = choose(-1, 0, 1, 2);
        var milk_chance = irandom(3);
        if (milk_chance == 0)
        {
            lactate = true;
        }
    }
    nipple_offset = [28, 56];
    if (alt_boobs == 2)
    {
        nipple_offset = [34, 62];
    }
    var rare_chance = irandom(10);
    if ((rare_chance == 0 || rare_guarantee > 10) && tutorial == false && title == false)
    {
        audio_play_sound(sndRare, 0, 0);
        rare_guarantee = 0;
        var rare_list = ds_list_create();
        ds_list_add(rare_list, sFutaMatingPressDevil, sFutaMatingPressSlime, sFutaMatingPressAndroid, sFutaMatingFurry, sFutaMatingPressAlien, sFutaMatingPressClown, sFutaMatingBunny);
        if (instance_exists(background))
        {
            switch (background.background_id)
            {
                case 3:
                    ds_list_add(rare_list, sFutaMatingPressAlien, sFutaMatingPressAlien, sFutaMatingPressAlien);
                    break;
                case 4:
                    ds_list_add(rare_list, sFutaMatingBunny, sFutaMatingBunny, sFutaMatingBunny, sFutaMatingPressClown, sFutaMatingPressClown);
                    break;
                case 5:
                    ds_list_add(rare_list, sFutaMatingPressDevil, sFutaMatingPressDevil, sFutaMatingPressDevil, sFutaMatingPressSlime, sFutaMatingPressSlime, sFutaMatingPressSlime);
                    break;
            }
        }
        top_sprite = ds_list_find_value(rare_list, irandom(ds_list_size(rare_list) - 1));
    }
    dialogue_set_top = -1;
    personality_name = func_set_lang(206, "NORMAL");
    var personality_set = choose(-1, -1, 0, 1, 2);
    switch (personality_set)
    {
        case 0:
            personality_name = func_set_lang(207, "TOMBOY");
            func_get_dialogue_json("dialogue_tomboy.json");
            break;
        case 1:
            personality_name = func_set_lang(208, "BRATTY");
            func_get_dialogue_json("dialogue_bratty.json");
            break;
        case 2:
            personality_name = func_set_lang(209, "SUBMISSIVE");
            func_get_dialogue_json("dialogue_submissive.json");
            break;
    }
    if (keyboard_check(vk_numpad1) || keyboard_check(ord("1")))
    {
        top_sprite = sFutaMatingBunny;
    }
    if (keyboard_check(vk_numpad2) || keyboard_check(ord("2")))
    {
        top_sprite = sFutaMatingFurry;
    }
    if (keyboard_check(vk_numpad3) || keyboard_check(ord("3")))
    {
        top_sprite = sFutaMatingPressAlien;
    }
    if (keyboard_check(vk_numpad4) || keyboard_check(ord("4")))
    {
        top_sprite = sFutaMatingPressAndroid;
    }
    if (keyboard_check(vk_numpad5) || keyboard_check(ord("5")))
    {
        top_sprite = sFutaMatingPressClown;
    }
    if (keyboard_check(vk_numpad6) || keyboard_check(ord("6")))
    {
        top_sprite = sFutaMatingPressDevil;
    }
    if (keyboard_check(vk_numpad7) || keyboard_check(ord("7")))
    {
        top_sprite = sFutaMatingPressSlime;
    }
    switch (top_sprite)
    {
        case sFutaMatingPressSlime:
            hair_sprite = sFutaMatingPressSlime;
            top_skin = make_color_hsv(irandom(255), 100, 255);
            top_hair = top_skin;
            cum_color = top_skin;
            face_sprite = sFutaPortraitSlime;
            mouth_sprite = sFutaPortraitSlime;
            bangs_sprite = sFutaPortraitSlime;
            top_penis_length = random_range(1, 1.35);
            top_penis_width = random_range(1, 1.35);
            ball_size = random_range(1, 1.35);
            orgasm_pumps_max = 30 * (top_penis_length * top_penis_width);
            max_loads = choose(6, 7, 8);
            personality_name = func_set_lang(210, "SLIME");
            func_get_dialogue_json("dialogue_slime.json");
            break;
        case sFutaMatingPressAndroid:
            cum_color = make_color_hsv(irandom(255), 100, 255);
            top_hair = merge_color(cum_color, top_skin, 0.5);
            top_skin = 16777215;
            top_penis_length = random_range(1, 1.35);
            top_penis_width = random_range(1, 1.35);
            ball_size = random_range(1, 1.35);
            orgasm_pumps_max = 30 * (top_penis_length * top_penis_width);
            max_loads = choose(6, 7, 8);
            personality_name = func_set_lang(211, "ANDROID");
            func_get_dialogue_json("dialogue_android.json");
            break;
        case sFutaMatingPressClown:
            top_hair = make_color_hsv(irandom(255), 100, 255);
            top_skin = 16777215;
            mouth_sprite = sFutaPortraitClown;
            top_penis_length = random_range(1, 1.35);
            top_penis_width = random_range(1, 1.35);
            ball_size = random_range(1, 1.35);
            orgasm_pumps_max = 30 * (top_penis_length * top_penis_width);
            max_loads = choose(6, 7, 8);
            audio_play_sound(sndHonk1, 0, false);
            personality_name = func_set_lang(212, "CLOWN");
            func_get_dialogue_json("dialogue_clown.json");
            break;
        case sFutaMatingBunny:
            mouth_sprite = sFutaPortraitBunny;
            top_penis_length = random_range(1, 1.35);
            top_penis_width = random_range(1, 1.35);
            ball_size = random_range(1, 1.35);
            orgasm_pumps_max = 30 * (top_penis_length * top_penis_width);
            max_loads = choose(6, 7, 8);
            bunny_money = 0;
            bunny_money_lerp = 0;
            personality_name = func_set_lang(213, "BUNNY GIRL");
            func_get_dialogue_json("dialogue_bunny.json");
            break;
        case sFutaMatingFurry:
            top_skin = make_color_hsv(choose(random_range(0, 25), random_range(150, 170)), random_range(0, 150), random_range(200, 255));
            top_hair = merge_color(c_white, top_skin, 0.5);
            face_sprite = sFutaPortraitFurry;
            mouth_sprite = sFutaPortraitFurry;
            top_penis_length = random_range(1, 1.35);
            top_penis_width = random_range(1, 1.35);
            ball_size = random_range(1, 1.35);
            orgasm_pumps_max = 30 * (top_penis_length * top_penis_width);
            max_loads = choose(6, 7, 8);
            break;
        case sFutaMatingPressDevil:
            var devil_color = make_color_hsv(random_range(200, 255), 225, 255);
            top_skin = merge_color(top_skin, devil_color, 0.5);
            top_hair = 16777215;
            face_sprite = sFutaPortraitDevil;
            mouth_sprite = sFutaPortraitDevil;
            top_penis_length = random_range(1, 1.35);
            top_penis_width = random_range(1, 1.35);
            ball_size = random_range(1, 1.35);
            orgasm_pumps_max = 30 * (top_penis_length * top_penis_width);
            max_loads = choose(6, 7, 8);
            break;
        case sFutaMatingPressAlien:
            var devil_color = make_color_hsv(random_range(100, 125), 225, 255);
            top_skin = merge_color(top_skin, devil_color, 0.5);
            top_hair = 16777215;
            cum_color = merge_color(top_skin, c_white, 0.5);
            face_sprite = sFutaPortraitAlien;
            mouth_sprite = sFutaPortraitAlien;
            top_penis_length = random_range(1, 1.35);
            top_penis_width = random_range(1, 1.35);
            ball_size = random_range(1, 1.35);
            orgasm_pumps_max = 30 * (top_penis_length * top_penis_width);
            max_loads = choose(6, 7, 8);
            nipple_offset = [36, 56];
            if (alt_boobs == 2)
            {
                nipple_offset = [40, 62];
            }
            personality_name = func_set_lang(214, "ALIEN");
            func_get_dialogue_json("dialogue_alien.json");
            break;
    }
    if (keyboard_check(vk_numpad0))
    {
        ball_size = 1.35;
        top_ass_size = 1.2;
        top_penis_width = 1.35;
        top_penis_length = 1.35;
        top_boob_size = 1.2;
    }
    base_ass_size = top_ass_size;
    base_penis_width = top_penis_width;
    base_penis_length = top_penis_length;
    base_boob_size = top_boob_size;
    base_ball_size = ball_size;
    base_max_loads = max_loads;
    base_pumps_max = orgasm_pumps_max;
    top_dialogue_color = 16777215;
    if (color_get_saturation(top_hair) > 0)
    {
        top_dialogue_color = top_hair;
    }
    if (color_get_saturation(top_skin) > 0)
    {
        top_dialogue_color = top_skin;
    }
    top_dialogue_scale = 0;
    top_dialogue_timer = 0;
    var intro_chance = irandom(3);
    if (intro_chance == 0)
    {
        func_top_speak("intro");
        func_bottom_speak("intro");
        bottom_dialogue_delay = top_dialogue_timer;
    }
}

fill_amount = 0;
fill_lerp = 0;
fill_max = 50;
global.ps = part_system_create();
part_system_automatic_draw(global.ps, false);
global.ps_back = part_system_create();
part_system_automatic_draw(global.ps_back, false);
global.ps_ui = part_system_create();
part_system_automatic_draw(global.ps_ui, false);
cum_outline = true;
outline_surface = surface_create(room_width, room_height);
scrOutlineInit();
stat_sperm_cell = 0;
stat_liters = 0;
stat_duration = 0;
stat_pumps = 0;
stat_total_sex_sec = 0;
stat_total_sex_min = 0;
stat_total_sex_hour = 0;
stat_total_sperm_cell = 0;
stat_total_liters = 0;
stat_total_orgasm_duration = 0;
stat_total_pumps = 0;
stat_total_plaps = 0;
stat_distance_thrusted = 0;
stat_total_orgasms = 0;
stat_total_fertilizations = 0;
stat_total_condoms_filled = 0;
stat_total_bunny_money = 0;
stat_rpg_level_highest = 0;
stat_rpg_damage = 0;
stat_livestream_viewers = 0;
stat_high_score = 0;
stat_liters_lerp = 0;
stat_sperm_cell_lerp = 0;
sex_progress = 0;
sex_progress_max = 50;
sex_timer = 60;
auto_insert = false;
auto_sex_timer = 0;
pill_effects_active = ds_list_create();
pill_effects_unlocked = ds_list_create();
pill_name = "";
pill_effect_random = false;
banner_text = "";
banner_scale = 0;
banner_timer = 0;
livestream_chat = ds_list_create();
livestream_timer = 180;
livestream_viewers = random_range(4, 12);
livestream_new_viewer = 180;
livestream_hype = 1;
livestream_dialogue = 
{
    username_start: ["juicy", "milky", "big", "cock", "pussy", "boob", "yummy", "slutty", "cum", "thick", "goth", "hung", "huge", "tiny", "sperm", "dommy"],
    username_end: ["cock", "daddy", "mommy", "lover", "futa", "femboy", "bimbo", "slut", "succubus", "kitty", "bunny", "machine", "tits", "booty", "cow"],
    message_normal: ["hello", "hey guys", "jerking off rn", "stroking it", "<3", "woah :O", "haaiii", ":3", "yummers", "brb", "i love boobs", "i'm gay", "subscribed"],
    message_sex: ["faster!!", "i wish that was me...", "such a great view", "move the camera closer", "i wish my cock was that big", "so deep...", "plap plap plap"],
    message_sex_halfway: ["orgasm incoming!!", "almost there"],
    message_orgasm: ["god yes", "oughh", "cumming!!", "yessssss", "keep pumping!!", "more!!", "so much cum", "get pregnant!!", "POG", "LESS GOOOO!!!", "YEAHHH"],
    message_waiting: ["drooling", "such a huge cock!!", "stop teasing us and put it in!!", "guys how do i install modroom in 1.4", "i wanna suck it so bad", "8======D"]
};
var root_string = working_directory + "/";
if (mobile == true)
{
    root_string = "";
}
if (file_exists(string(root_string) + "dialogue/livestream.json"))
{
    livestream_dialogue = func_read_dialogue_json(string(root_string) + "dialogue/livestream.json");
}
bottom_portrait = sWifeCanonPortrait;
bottom_mating_press = sWifeMatingPress;
bottom_cowgirl = sWifeCowgirl;
bottom_deepthroat = sWifeDeepthroat;
bottom_fertile = true;
bottom_enable_xray = true;
bottom_xray = sUterusXray;
part_love = part_type_create();
part_type_sprite(part_love, sHearts, true, true, false);
part_type_direction(part_love, 90, 90, 0, 0);
part_type_speed(part_love, 0.1, 0.1, 0, 0);
part_type_life(part_love, 60, 180);
part_cum_leak = part_type_create();
part_type_sprite(part_cum_leak, sCum, false, false, false);
part_type_life(part_cum_leak, 120, 180);
part_type_size(part_cum_leak, 0.5, 1, -0.01, 0);
part_type_direction(part_cum_leak, 180, 360, 0, 0);
part_cum = part_type_create();
part_type_sprite(part_cum, sCum, false, false, false);
part_type_life(part_cum, 45, 90);
part_type_size(part_cum, 0.25, 1, -0.025, 0);
part_type_speed(part_cum, 2, 5, -0.05, 0);
part_type_direction(part_cum, 180, 360, 0, 0);
part_type_gravity(part_cum, 0.15, 270);
part_milk = part_type_create();
part_type_sprite(part_milk, sCum, false, false, false);
part_type_life(part_milk, 45, 90);
part_type_size(part_milk, 0.1, 0.5, -0.01, 0);
part_type_speed(part_milk, 0.5, 3, -0.05, 0);
part_type_direction(part_milk, 0, 360, 0, 0);
part_type_gravity(part_milk, 0.1, 270);
part_milk_leak = part_type_create();
part_type_sprite(part_milk_leak, sCum, false, false, false);
part_type_life(part_milk_leak, 45, 90);
part_type_size(part_milk_leak, 0.1, 0.3, -0.01, 0);
part_type_gravity(part_milk_leak, 0.1, 270);
part_precum = part_type_create();
part_type_sprite(part_precum, sCum, false, false, false);
part_type_alpha1(part_precum, 0.1);
part_type_life(part_precum, 60, 120);
part_type_size(part_precum, 0.25, 1, -0.025, 0);
part_type_speed(part_precum, 2, 5, -0.1, 0);
part_type_direction(part_precum, 180, 360, 0, 0);
part_type_gravity(part_precum, 0.15, 270);
part_timer = 0;
title = true;
title_scale = 1;
title_timer = 240;
disclaimer = false;
disclaimer_scale = 0;
logo_scale = 0;
title_alpha = 0;
outside_wait_timer = 0;
start_timer = -1;
lactate_timer = 0;

function func_get_portrait(arg0)
{
    var return_port = sFutaPortrait1;
    switch (arg0)
    {
        case sFutaMatingPress:
            return_port = sFutaPortrait1;
            break;
        case sFutaMatingPress2:
            return_port = sFutaPortrait2;
            break;
        case sFutaMatingPress3:
            return_port = sFutaPortrait3;
            break;
        case sFutaMatingPress4:
            return_port = sFutaPortrait4;
            break;
        case sFutaMatingPressDevil:
            return_port = sFutaPortraitDevil;
            break;
        case sFutaMatingPressSlime:
            return_port = sFutaPortraitSlime;
            break;
        case sFutaMatingPressAndroid:
            return_port = sFutaPortraitAndroid;
            break;
        case sFutaMatingFurry:
            return_port = sFutaPortraitFurry;
            break;
        case sFutaMatingBunny:
            return_port = sFutaPortraitBunny;
            break;
        case sFutaMatingPressAlien:
            return_port = sFutaPortraitAlien;
            break;
        case sFutaMatingPressClown:
            return_port = sFutaPortraitClown;
            break;
        case top_mating_press:
            return_port = top_portrait;
            break;
        case bottom_mating_press:
            return_port = bottom_portrait;
            break;
    }
    return return_port;
}

function func_get_alt_boobs(arg0)
{
    var return_port = sFutaPortraitAltBoobs1;
    switch (arg0)
    {
        case sFutaMatingPress:
            return_port = sFutaPortraitAltBoobs1;
            break;
        case sFutaMatingPress2:
            return_port = sFutaPortraitAltBoobs2;
            break;
        case sFutaMatingPress3:
            return_port = sFutaPortraitAltBoobs3;
            break;
        case sFutaMatingPress4:
            return_port = sFutaPortraitAltBoobs4;
            break;
        case sFutaMatingPressDevil:
            return_port = sFutaPortraitAltBoobsDevil;
            break;
        case sFutaMatingPressSlime:
            return_port = sFutaPortraitAltBoobsSlime;
            break;
        case sFutaMatingPressAndroid:
            return_port = sFutaPortraitAltBoobsAndroid;
            break;
        case sFutaMatingFurry:
            return_port = sFutaPortraitAltBoobs1;
            break;
        case sFutaMatingBunny:
            return_port = sFutaPortraitAltBoobsBunny;
            break;
        case sFutaMatingPressAlien:
            return_port = sFutaPortraitAltBoobsAlien;
            break;
        case sFutaMatingPressClown:
            return_port = sFutaPortraitAltBoobsClown;
            break;
    }
    return return_port;
}

function func_set_custom_lover()
{
    func_load_custom(ds_list_find_value(custom_lover_folders, custom_lover_selected));
    top_mating_press = custom_mating_press;
    top_cowgirl = custom_cowgirl;
    top_deepthroat = custom_deepthroat;
    top_condom = custom_condom;
    top_condom_broken = custom_condom_broken;
    top_xray = custom_xray;
    top_xray_broken = custom_condom_broken_xray;
    top_portrait = custom_portrait;
    top_sprite = top_mating_press;
    face_sprite = top_portrait;
    mouth_sprite = top_portrait;
    hair_sprite = top_mating_press;
    bangs_sprite = top_portrait;
    top_hair = 16777215;
    top_skin = 16777215;
    top_name = custom_top_name;
    ball_size = 1;
    top_ass_size = 1;
    top_penis_width = 1;
    top_penis_length = 1;
    top_boob_size = 1;
    alt_boobs = -1;
    cum_color = custom_cum_color;
    base_ass_size = 1;
    base_penis_width = 1;
    base_penis_length = 1;
    base_boob_size = 1;
    base_ball_size = 1;
    dialogue_set_top = custom_dialogue_set_top;
    top_dialogue_color = custom_dialogue_color_top;
    top_dialogue_timer = 0;
    top_dialogue_scale = 0;
    condom_offset = custom_condom_offset;
    max_loads = custom_max_loads;
    orgasm_pumps_max = custom_max_pumps;
    base_max_loads = max_loads;
    base_pumps_max = orgasm_pumps_max;
    moaning = custom_default_moans;
    ds_list_clear(pill_effects_active);
    pill_effect_random = false;
    edge_boost = 1;
    slap_boost = 0;
    moan_pitch = 1;
    head_offset = custom_head_offset;
    nipple_offset = custom_nipple;
    lactate = custom_lactate;
    condom = false;
    condom_size = 0;
    ds_list_clear(moan_slow_list);
    if (ds_list_size(custom_moan_slow_list) > 0)
    {
        ds_list_copy(moan_slow_list, custom_moan_slow_list);
    }
    else
    {
        ds_list_add(moan_slow_list, sndMoanOpenSlow1, sndMoanOpenSlow2, sndMoanOpenSlow3, sndMoanClosedSlow4, sndMoanClosedSlow1, sndMoanClosedSlow2, sndMoanClosedSlow3, sndMoanClosedSlow4, sndMoanExtra1, sndMoanExtra2, sndMoanExtra3, sndMoanExtra4);
    }
    ds_list_clear(moan_fast_list);
    if (ds_list_size(custom_moan_fast_list) > 0)
    {
        ds_list_copy(moan_fast_list, custom_moan_fast_list);
    }
    else
    {
        ds_list_add(moan_fast_list, sndMoanOpenFast1, sndMoanOpenFast2, sndMoanOpenFast3, sndMoanClosedFast4, sndMoanClosedFast1, sndMoanClosedFast2, sndMoanClosedFast3, sndMoanClosedFast4);
    }
    ds_list_clear(orgasm_list);
    if (ds_list_size(custom_orgasm_list) > 0)
    {
        ds_list_copy(orgasm_list, custom_orgasm_list);
    }
    else
    {
        ds_list_add(orgasm_list, sndMoanOrgasm1, sndMoanOrgasm2, sndMoanOrgasm3, sndMoanOrgasm5);
    }
    if (custom_mating_press_alt != sWifeMatingPress || (custom_mating_press_alt == sWifeMatingPress && bottom_mating_press != sWifeMatingPress && custom_partner_selected == -1))
    {
        bottom_mating_press = custom_mating_press_alt;
        bottom_cowgirl = custom_cowgirl_alt;
        bottom_deepthroat = custom_deepthroat_alt;
        bottom_portrait = custom_portrait_alt;
        bottom_skin = 16777215;
        egg_color = custom_egg_color;
        bottom_fertile = custom_fertile;
        bottom_xray = custom_xray_alt;
        bottom_enable_xray = custom_enable_xray;
        lactate_alt = custom_lactate_alt;
        nipple_offset_alt = custom_nipple_alt;
        head_offset_alt = custom_head_offset_alt;
        dialogue_set_bottom = custom_dialogue_set_bottom;
        bottom_dialogue_color = custom_dialogue_color_bottom;
        bottom_dialogue = "";
        bottom_dialogue_timer = 0;
        bottom_dialogue_delay = 0;
        bottom_dialogue_scale = 0;
        face_sprite_alt = custom_portrait_alt;
        mouth_sprite_alt = custom_portrait_alt;
        hair_sprite_alt = custom_mating_press_alt;
        bangs_sprite_alt = custom_portrait_alt;
        custom_partner_selected = -1;
    }
}

function func_reset_partner()
{
    bottom_portrait = sWifeCanonPortrait;
    bottom_mating_press = sWifeMatingPress;
    bottom_cowgirl = sWifeCowgirl;
    bottom_deepthroat = sWifeDeepthroat;
    face_sprite_alt = sWifeCanonPortrait;
    mouth_sprite_alt = sWifeCanonPortrait;
    hair_sprite_alt = sWifeCanonPortrait;
    bangs_sprite_alt = sWifeCanonPortrait;
    bottom_xray = sUterusXray;
    bottom_name = "Wife";
    bottom_skin = 16777215;
    egg_color = 16777215;
    lactate_alt = true;
    nipple_offset_alt = [36, 56];
    head_offset_alt = 0;
    dialogue_set_bottom = -1;
    bottom_dialogue = "";
    bottom_dialogue_color = 16777215;
    bottom_dialogue_timer = 0;
    bottom_dialogue_delay = 0;
    bottom_dialogue_scale = 0;
    bottom_fertile = true;
    bottom_enable_xray = true;
}

function func_set_custom_partner()
{
    func_load_custom(ds_list_find_value(custom_partner_folders, custom_partner_selected));
    bottom_mating_press = custom_mating_press_alt;
    bottom_cowgirl = custom_cowgirl_alt;
    bottom_deepthroat = custom_deepthroat_alt;
    bottom_portrait = custom_portrait_alt;
    bottom_name = custom_bottom_name;
    bottom_skin = 16777215;
    egg_color = custom_egg_color;
    bottom_fertile = custom_fertile;
    bottom_xray = custom_xray_alt;
    bottom_enable_xray = custom_enable_xray;
    lactate_alt = custom_lactate_alt;
    nipple_offset_alt = custom_nipple_alt;
    head_offset_alt = custom_head_offset_alt;
    dialogue_set_bottom = custom_dialogue_set_bottom;
    bottom_dialogue_color = custom_dialogue_color_bottom;
    bottom_dialogue_timer = 0;
    bottom_dialogue_delay = 0;
    bottom_dialogue_scale = 0;
    face_sprite_alt = custom_portrait_alt;
    mouth_sprite_alt = custom_portrait_alt;
    hair_sprite_alt = custom_mating_press_alt;
    bangs_sprite_alt = custom_portrait_alt;
}

function func_cum_splurt(arg0)
{
    var base_sex_size = 2;
    var cum_amount = round(random_range(3, 5));
    if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_1) != -1)
    {
        cum_amount *= 2;
    }
    if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_10) != -1)
    {
        cum_amount *= 20;
    }
    repeat (cum_amount)
    {
        var cum_offset = 80 * top_penis_length * (1 - (thrust * 0.5));
        var cum_dir = 1;
        var cum_distance = 0;
        if (arg0 == true)
        {
            cum_offset = 32;
        }
        else
        {
            if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_5) != -1)
            {
                cum_distance = 20 * top_penis_length;
            }
            if (custom_lover_selected != -1)
            {
                cum_offset *= custom_bulge_height;
            }
        }
        switch (sex_position)
        {
            case 1:
                cum_offset = -40 * top_penis_length;
                cum_dir = -1;
                if (arg0 == true)
                {
                    cum_offset = -16 * thrust;
                    cum_dir = 1;
                }
                else
                {
                    if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_5) != -1)
                    {
                        cum_distance = 20 * top_penis_length;
                    }
                    if (custom_lover_selected != -1)
                    {
                        cum_offset *= custom_bulge_height;
                    }
                }
                break;
            case 2:
                cum_offset = 90 + (20 * top_penis_length);
                if (arg0 == true)
                {
                    cum_offset = 40;
                }
                break;
        }
        var cum = instance_create_depth(x + cum_distance, y + (cum_offset * base_sex_size), depth, oCum);
        cum.hsp = random_range(-0.5, 0.5) * edge_boost;
        cum.vsp = (3 + random_range(0, 0.5)) * min(3, edge_boost) * cum_dir;
        part_particles_create_color(global.ps, x + cum_distance, y + (cum_offset * base_sex_size), part_cum, cum_color, 3);
        if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_5) != -1)
        {
            cum = instance_create_depth(x - cum_distance, (y + (cum_offset * base_sex_size)) - 16, depth, oCum);
            cum.hsp = random_range(-0.5, 0.5) * edge_boost;
            cum.vsp = (3 + random_range(0, 0.5)) * edge_boost * cum_dir;
            part_particles_create_color(global.ps, x - cum_distance, y + (cum_offset * base_sex_size), part_cum, cum_color, 3);
        }
    }
}

function func_get_reverse_cowgirl(arg0)
{
    var return_sprite = sFutaCowgirl;
    switch (arg0)
    {
        case sFutaMatingPress:
            return_sprite = sFutaCowgirl;
            break;
        case sFutaMatingPress2:
            return_sprite = sFutaCowgirl2;
            break;
        case sFutaMatingPress3:
            return_sprite = sFutaCowgirl3;
            break;
        case sFutaMatingPress4:
            return_sprite = sFutaCowgirl4;
            break;
        case sFutaMatingPressDevil:
            return_sprite = sFutaCowgirlDevil;
            break;
        case sFutaMatingPressSlime:
            return_sprite = sFutaCowgirlSlime;
            break;
        case sFutaMatingPressAndroid:
            return_sprite = sFutaCowgirlAndroid;
            break;
        case sFutaMatingFurry:
            return_sprite = sFutaCowgirlFurry;
            break;
        case sFutaMatingBunny:
            return_sprite = sFutaCowgirlBunny;
            break;
        case sFutaMatingPressAlien:
            return_sprite = sFutaCowgirlAlien;
            break;
        case sFutaMatingPressClown:
            return_sprite = sFutaCowgirlClown;
            break;
        case top_mating_press:
            return_sprite = top_cowgirl;
            break;
        case bottom_mating_press:
            return_sprite = bottom_cowgirl;
            break;
    }
    return return_sprite;
}

function func_get_deepthroat(arg0)
{
    var return_sprite = sFutaDeepthroat;
    switch (arg0)
    {
        case sFutaMatingPress:
            return_sprite = sFutaDeepthroat;
            break;
        case sFutaMatingPress2:
            return_sprite = sFutaDeepthroat2;
            break;
        case sFutaMatingPress3:
            return_sprite = sFutaDeepthroat3;
            break;
        case sFutaMatingPress4:
            return_sprite = sFutaDeepthroat4;
            break;
        case sFutaMatingPressDevil:
            return_sprite = sFutaDeepthroatDevil;
            break;
        case sFutaMatingPressSlime:
            return_sprite = sFutaDeepthroatSlime;
            break;
        case sFutaMatingPressAndroid:
            return_sprite = sFutaDeepthroatAndroid;
            break;
        case sFutaMatingFurry:
            return_sprite = sFutaDeepthroatFurry;
            break;
        case sFutaMatingBunny:
            return_sprite = sFutaDeepthroatBunny;
            break;
        case sFutaMatingPressAlien:
            return_sprite = sFutaDeepthroatAlien;
            break;
        case sFutaMatingPressClown:
            return_sprite = sFutaDeepthroatClown;
            break;
        case top_mating_press:
            return_sprite = top_deepthroat;
            break;
        case bottom_mating_press:
            return_sprite = bottom_deepthroat;
            break;
    }
    return return_sprite;
}

function func_get_condom()
{
    var condom_sprite = sFutaCondomNormal;
    switch (top_sprite)
    {
        case sFutaMatingPressDevil:
            condom_sprite = sFutaCondomHorse;
            break;
        case sFutaMatingFurry:
            condom_sprite = sFutaCondomKnotted;
            break;
        case sFutaMatingPressAlien:
            condom_sprite = sFutaCondomAlien;
            break;
    }
    if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_2) != -1)
    {
        condom_sprite = sFutaCondomHorse;
    }
    if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_3) != -1)
    {
        condom_sprite = sFutaCondomKnotted;
    }
    if (condom_broken == true)
    {
        condom_sprite = sFutaCondomBrokenNormal;
    }
    if (custom_sprite_loaded != -1 && top_sprite == top_mating_press)
    {
        condom_sprite = top_condom;
        if (condom_broken == true)
        {
            condom_sprite = top_condom_broken;
        }
    }
    return condom_sprite;
}

function func_get_xray()
{
    var xray_sprite = sFutaXray;
    switch (top_sprite)
    {
        case sFutaMatingPressDevil:
            xray_sprite = sFutaXrayHorse;
            break;
        case sFutaMatingFurry:
            xray_sprite = sFutaXrayKnotted;
            break;
        case sFutaMatingPressAlien:
            xray_sprite = sFutaXrayAlien;
            break;
    }
    if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_2) != -1)
    {
        xray_sprite = sFutaXrayHorse;
    }
    if (ds_list_find_index(pill_effects_active, UnknownEnum.Value_3) != -1)
    {
        xray_sprite = sFutaXrayKnotted;
    }
    if (custom_sprite_loaded != -1 && top_sprite == top_mating_press)
    {
        xray_sprite = top_xray;
    }
    return xray_sprite;
}

effect_muffled = audio_effect_create(UnknownEnum.Value_4, 
{
    cutoff: 300,
    q: 1
});
effect_gain = audio_effect_create(UnknownEnum.Value_2, 
{
    gain: 2
});
audio_bus_main.effects[0] = effect_muffled;
audio_bus_main.effects[1] = effect_gain;

function func_add_combo_flair(arg0, arg1)
{
    if (rpg == true)
    {
        arg1 /= 10;
    }
    if (ds_list_find_index(score_combo_mods, string(arg0) + " [+" + string(round(arg1)) + "]") == -1)
    {
        ds_list_add(score_combo_mods, string(arg0) + " [+" + string(round(arg1)) + "]");
        if (rpg == true)
        {
            rpg_xp += round(arg1);
            rpg_scale = 0.5;
        }
        else
        {
            futa_score += arg1;
            score_combo += arg1;
            score_combo_scale = 1.5;
            score_combo_timer = 120;
        }
    }
}

function func_replace_tags(arg0)
{
    if (string_pos("[LOADS]", arg0) != 0)
    {
        arg0 = string_replace_all(arg0, "[LOADS]", string(loads));
    }
    if (string_pos("[ROUND]", arg0) != 0)
    {
        arg0 = string_replace_all(arg0, "[ROUND]", string(loads + 1));
    }
    if (string_pos("[PARTNER]", arg0) != 0)
    {
        if (custom_partner_selected == -1)
        {
            arg0 = string_replace_all(arg0, "[PARTNER]", "wife");
        }
        else
        {
            arg0 = string_replace_all(arg0, "[PARTNER]", "friend");
        }
    }
    return arg0;
}

function func_top_speak(arg0)
{
    if (top_dialogue_timer < 1 && struct_get(dialogue_set_top, arg0) != undefined)
    {
        var speak_array = struct_get(dialogue_set_top, arg0);
        if (array_length(speak_array) > 0)
        {
            top_dialogue = speak_array[irandom(array_length(speak_array) - 1)];
            top_dialogue_timer = 180;
            top_dialogue = func_replace_tags(top_dialogue);
        }
    }
}

function func_bottom_speak(arg0)
{
    if (bottom_dialogue_timer < 1 && struct_get(dialogue_set_bottom, arg0) != undefined)
    {
        var speak_array = struct_get(dialogue_set_bottom, arg0);
        if (array_length(speak_array) > 0)
        {
            bottom_dialogue = speak_array[irandom(array_length(speak_array) - 1)];
            bottom_dialogue_timer = 180;
            bottom_dialogue = func_replace_tags(bottom_dialogue);
        }
    }
}

global.palette = 0;
virgin = true;

function func_save_game()
{
    ini_open(working_directory + "/save_data.sav");
    ini_write_real("options", "virgin", virgin);
    ini_write_real("options", "xray", xray);
    ini_write_real("options", "moaning", moaning_set);
    ini_write_real("options", "cumflation", cumflation);
    ini_write_real("options", "palette", global.palette);
    ini_write_real("options", "dialogue", show_dialogue);
    ini_write_real("options", "condom_breaking", condom_breaking);
    ini_write_real("options", "fullscreen", fullscreen);
    ini_write_real("options", "sex_portrait", show_portrait);
    ini_write_real("options", "belly_behind_bulge", belly_behind_bulge);
    ini_write_real("options", "master_volume", master_volume);
    ini_write_real("options", "bgm_volume", background_music_volume);
    ini_write_real("options", "max_particles", max_particles);
    ini_write_real("options", "cum_outline", cum_outline);
    var pill_save_string = ds_list_write(pill_effects_unlocked);
    ini_write_string("stats", "pill_effects_unlocked", pill_save_string);
    ini_write_real("stats", "total_sex_sec", stat_total_sex_sec);
    ini_write_real("stats", "total_sex_min", stat_total_sex_min);
    ini_write_real("stats", "total_sex_hour", stat_total_sex_hour);
    ini_write_real("stats", "total_sperm_cell", stat_total_sperm_cell);
    ini_write_real("stats", "total_liters", stat_total_liters);
    ini_write_real("stats", "total_orgasm_duration", stat_total_orgasm_duration);
    ini_write_real("stats", "total_pumps", stat_total_pumps);
    ini_write_real("stats", "total_plaps", stat_total_plaps);
    ini_write_real("stats", "total_distance_thrust", stat_distance_thrusted);
    ini_write_real("stats", "total_orgasms", stat_total_orgasms);
    ini_write_real("stats", "total_fertilizations", stat_total_fertilizations);
    ini_write_real("stats", "total_condoms", stat_total_condoms_filled);
    ini_write_real("stats", "total_bunny_money", stat_total_bunny_money);
    ini_write_real("stats", "total_rpg_level_highest", stat_rpg_level_highest);
    ini_write_real("stats", "total_rpg_damage", stat_rpg_damage);
    ini_write_real("stats", "total_livestream_viewers", stat_livestream_viewers);
    ini_close();
    show_debug_message("saved game");
}

if (file_exists(working_directory + "/save_data.sav"))
{
    ini_open(working_directory + "/save_data.sav");
    virgin = ini_read_real("options", "virgin", true);
    xray = ini_read_real("options", "xray", true);
    oBackground.background_id = ini_read_real("options", "background", 0);
    moaning_set = ini_read_real("options", "moaning", true);
    cumflation = ini_read_real("options", "cumflation", true);
    global.palette = ini_read_real("options", "palette", 0);
    show_dialogue = ini_read_real("options", "dialogue", true);
    fullscreen = ini_read_real("options", "fullscreen", false);
    show_portrait = ini_read_real("options", "sex_portrait", false);
    belly_behind_bulge = ini_read_real("options", "belly_behind_bulge", false);
    master_volume = ini_read_real("options", "master_volume", 1);
    background_music_volume = ini_read_real("options", "bgm_volume", 0.25);
    max_particles = ini_read_real("options", "max_particles", 1);
    cum_outline = ini_read_real("options", "cum_outline", true);
    window_set_fullscreen(fullscreen);
    var load_str = ini_read_string("stats", "pill_effects_unlocked", "");
    if (load_str != "")
    {
        ds_list_read(pill_effects_unlocked, load_str);
    }
    stat_total_sex_sec = ini_read_real("stats", "total_sex_sec", 0);
    stat_total_sex_min = ini_read_real("stats", "total_sex_min", 0);
    stat_total_sex_hour = ini_read_real("stats", "total_sex_hour", 0);
    stat_total_sperm_cell = ini_read_real("stats", "total_sperm_cell", 0);
    stat_total_liters = ini_read_real("stats", "total_liters", 0);
    stat_total_orgasm_duration = ini_read_real("stats", "total_orgasm_duration", 0);
    stat_total_pumps = ini_read_real("stats", "total_pumps", 0);
    stat_total_plaps = ini_read_real("stats", "total_plaps", 0);
    stat_distance_thrusted = ini_read_real("stats", "total_distance_thrust", 0);
    stat_total_orgasms = ini_read_real("stats", "total_orgasms", 0);
    stat_total_fertilizations = ini_read_real("stats", "total_fertilizations", 0);
    stat_total_condoms_filled = ini_read_real("stats", "total_condoms", 0);
    stat_total_bunny_money = ini_read_real("stats", "total_bunny_money", 0);
    stat_rpg_level_highest = ini_read_real("stats", "total_rpg_level_highest", 0);
    stat_rpg_damage = ini_read_real("stats", "total_rpg_damage", 0);
    stat_livestream_viewers = ini_read_real("stats", "total_livestream_viewers", 0);
    ini_close();
    show_debug_message("loaded save");
}
else
{
    func_save_game();
}

function func_get_money(arg0)
{
    var money = string(round(arg0));
    var i = string_length(money) - 2;
    while (i > 1)
    {
        money = string_insert(",", money, i);
        i -= 3;
    }
    money += string_delete(string(arg0 % 1), 0, 1);
    return money;
}

function func_draw_sprite_pos_color(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
{
    var sprite_draw = sprite_get_texture(arg0, arg1);
    draw_primitive_begin_texture(pr_trianglestrip, sprite_draw);
    draw_vertex_texture_color(arg2, arg3, 0, 0, arg10, 1);
    draw_vertex_texture_color(arg4, arg5, 1, 0, arg10, 1);
    draw_vertex_texture_color(arg8, arg9, 0, 1, arg10, 1);
    draw_vertex_texture_color(arg6, arg7, 1, 1, arg10, 1);
    draw_primitive_end();
}

custom_info_loaded = false;

function func_get_custom_info()
{
    if (custom_info_loaded == false)
    {
        custom_lover_portraits = -1;
        custom_lover_info = -1;
        custom_partner_portraits = -1;
        custom_partner_info = -1;
        custom_bedroom_thumbnails = -1;
        custom_bedroom_info = -1;
        for (var i = 0; i < ds_list_size(custom_lover_folders); i++)
        {
            func_load_custom(ds_list_find_value(custom_lover_folders, i));
            custom_lover_portraits[i][0] = custom_portrait;
            custom_lover_info[i] = string(custom_name) + "\n\n" + string(custom_desc) + "\n\nCreated by " + string(custom_author);
            if (custom_portrait_alt != sWifeCanonPortrait)
            {
                custom_lover_portraits[i][1] = custom_portrait_alt;
            }
        }
        for (var i = 0; i < ds_list_size(custom_partner_folders); i++)
        {
            func_load_custom(ds_list_find_value(custom_partner_folders, i));
            custom_partner_portraits[i] = custom_portrait_alt;
            custom_partner_info[i] = string(custom_name) + "\n\n" + string(custom_desc) + "\n\nCreated by " + string(custom_author);
        }
        for (var i = 0; i < ds_list_size(custom_bedroom_folders); i++)
        {
            func_load_custom(ds_list_find_value(custom_bedroom_folders, i));
            custom_bedroom_thumbnails[i] = custom_thumbnail;
            custom_bedroom_info[i] = string(custom_name) + "\n\n" + string(custom_desc) + "\n\nCreated by " + string(custom_author);
        }
        if (custom_lover_selected > -1)
        {
            func_set_custom_lover();
        }
        if (custom_partner_selected > -1)
        {
            func_set_custom_partner();
        }
        custom_info_loaded = true;
    }
}

language_folders = ds_list_create();
language_names = [];
language_selected = 0;
language_text = -1;
if (true && mobile == false)
{
    var _file_load = file_find_first(working_directory + "/language/" + "*.txt", 16);
    var _file = working_directory + "/language/" + string(_file_load);
    var file_pos = 0;
    while (_file != (working_directory + "/language/" + ""))
    {
        if (file_exists(_file))
        {
            ds_list_add(language_folders, _file);
            show_debug_message(_file);
            var file_read = file_text_open_read(string(_file));
            language_names[file_pos] = file_text_readln(file_read);
            file_text_close(file_read);
            file_pos += 1;
        }
        _file_load = file_find_next();
        _file = working_directory + "/language/" + string(_file_load);
    }
    file_find_close();
}

function func_load_language(arg0)
{
    var file = file_text_open_read(string(arg0));
    var text_pos = 0;
    if (file != -1)
    {
        while (!file_text_eof(file))
        {
            language_text[text_pos] = file_text_readln(file);
            text_pos += 1;
        }
        file_text_close(file);
    }
}

func_load_language(ds_list_find_value(language_folders, language_selected));

function func_set_lang(arg0, arg1)
{
    var string_set = arg1;
    if (language_text != -1 && is_array(language_text) == true && array_length(language_text) >= arg0)
    {
        string_set = string_trim_end(array_get(language_text, arg0 - 1));
    }
    return string_set;
}

function func_get_toggle_string(arg0)
{
    if (arg0 == true)
    {
        return "ON";
    }
    else
    {
        return "OFF";
    }
}

function func_set_pill_effect(arg0)
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
            for (var i = 0; i < 12; i++)
            {
                sperm[i] = 0;
                sperm_speed[i] = 0;
            }
            body_jiggle = 0.025;
            impregnation_timer = 120;
            sperm_jiggle = 0.15;
            impregnate = 0;
            break;
    }
    top_penis_length = median(0.7, top_penis_length, 3);
    top_penis_width = median(0.7, top_penis_width, 3);
    ball_size = median(0.7, ball_size, 3);
    top_boob_size = median(0.7, top_boob_size, 2.8);
    top_ass_size = median(0.7, top_ass_size, 2.8);
}

func_randomize_top();
var custom_chance = irandom(3);
if (custom_sprite_loaded == true && custom_chance == 0)
{
    if (ds_list_size(custom_lover_folders) > 0)
    {
        custom_lover_selected = irandom(ds_list_size(custom_lover_folders) - 1);
        func_set_custom_lover();
    }
}
global.custom_font_big = 100663296;
global.custom_font_handwriting = 100663297;
global.custom_font_small = 100663298;
var _fpath = working_directory + "language/font.ttf";
if (!file_exists(_fpath))
{
    _fpath = "language/font.ttf";
}
if (file_exists(_fpath))
{
    var _fbig = font_add(_fpath, 14, false, false, 32, 65535);
    var _fhand = font_add(_fpath, 12, false, false, 32, 65535);
    var _fsmall = font_add(_fpath, 8, false, false, 32, 65535);
    if (_fbig != -1)
    {
        global.custom_font_big = _fbig;
    }
    if (_fhand != -1)
    {
        global.custom_font_handwriting = _fhand;
    }
    if (_fsmall != -1)
    {
        global.custom_font_small = _fsmall;
    }
}
else if (file_exists("C:/Windows/Fonts/msgothic.ttc"))
{
    var _fbig = font_add("C:/Windows/Fonts/msgothic.ttc", 14, false, false, 32, 65535);
    var _fhand = font_add("C:/Windows/Fonts/msgothic.ttc", 12, false, false, 32, 65535);
    var _fsmall = font_add("C:/Windows/Fonts/msgothic.ttc", 8, false, false, 32, 65535);
    if (_fbig != -1)
    {
        global.custom_font_big = _fbig;
    }
    if (_fhand != -1)
    {
        global.custom_font_handwriting = _fhand;
    }
    if (_fsmall != -1)
    {
        global.custom_font_small = _fsmall;
    }
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
var _clench_dir = working_directory + "clench_sprites/";
if (file_exists(_clench_dir + "sBallsClenching.png"))
{
    global.sBallsClenching = sprite_add(_clench_dir + "sBallsClenching.png", 5, false, false, 20, 3);
    global.sBallsClenchingCow = sprite_add(_clench_dir + "sBallsClenchingCow.png", 5, false, false, 20, 3);
    global.sBallsClenchingDeepthroat = sprite_add(_clench_dir + "sBallsClenchingDeepthroat.png", 5, false, false, 20, 3);
    global.sBallsClenchingAndroid = sprite_add(_clench_dir + "sBallsClenchingAndroid.png", 5, false, false, 20, 3);
    global.sBallsClenchingCowSlime = sprite_add(_clench_dir + "sBallsClenchingCowSlime.png", 5, false, false, 20, 3);
    global.sBallsClenchingDeepthroatAndroid = sprite_add(_clench_dir + "sBallsClenchingDeepthroatAndroid.png", 5, false, false, 20, 3);
    global.sBallsClenchingDeepthroatSlime = sprite_add(_clench_dir + "sBallsClenchingDeepthroatSlime.png", 5, false, false, 20, 3);
    global.sBallsClenchingSlime = sprite_add(_clench_dir + "sBallsClenchingSlime.png", 5, false, false, 20, 3);
    global.sBallsClenchingCowAndroid = sprite_add(_clench_dir + "sBallsClenchingCowAndroid.png", 5, false, false, 20, 3);
}
var _subfolders = ["custom_futas", "custom_wives", "custom_bedrooms"];
for (var _s = 0; _s < array_length(_subfolders); _s++)
{
    var _s_dir = working_directory + "custom/" + _subfolders[_s] + "/";
    if (directory_exists(_s_dir))
    {
        var _s_file_load = file_find_first(_s_dir + "*", 16);
        while (_s_file_load != "")
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
    Value_15 = 15,
    Value_16
}
