decals = new Stickers(1);
decals.Add(spr_smile, 0, 128, 128);
decals.SetFreeze(true);
//decals.Update();
gpu_set_zwriteenable(true);
gpu_set_ztestenable(true);
gpu_set_alphatestenable(true);
gpu_set_alphatestref(128);
//z = 0;
show_debug_overlay(true);