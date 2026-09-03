if (insert == true && orgasm == false)
{
    thrust_strength = random_range(1, 3);
    thrust_speed = random_range(3, 8);
    thrust_middle = random_range(0.15, 0.75);
    var dialogue_chance = irandom(5);
    if (dialogue_chance == 0)
    {
        func_top_speak("moan");
    }
    if (slap_boost > 0 || sex_progress >= (sex_progress_max * 0.6) || edge_boost > 1.5 || title == true || ds_list_find_index(pill_effects_active, UnknownEnum.Value_16) != -1)
    {
        if (slap_boost > 0)
        {
            slap_boost -= 1;
        }
        thrust_strength = random_range(3, 5);
        thrust_speed = random_range(10, 16);
        if (title == true)
        {
            thrust_speed = random_range(3, 8);
        }
        thrust_middle = random_range(0.15, 0.35);
    }
}
alarm[0] = 160 + irandom(160);

enum UnknownEnum
{
    Value_16 = 16
}
