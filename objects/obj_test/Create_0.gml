decals = new Stickers(1024, true);
repeat(128) {
	decals.Add(spr_smile, 0, irandom(512), irandom(512));	
}
//decals.SetFreeze(false);
//decals.Update();
gpu_set_zwriteenable(true);
gpu_set_ztestenable(true);
gpu_set_alphatestenable(true);
gpu_set_alphatestref(128);
//z = 0;
show_debug_overlay(true);