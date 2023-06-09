decals = new Stickers(1024).SetRegion(1024, 1024);
repeat(decals.GetMax()/10) {
	decals.Add(spr_a, 0, irandom(decals.GetRegionWidth()), irandom(decals.GetRegionHeight()));	
}
//decals.SetFreeze(false);
//decals.Update();
gpu_set_zwriteenable(true);
gpu_set_ztestenable(true);
gpu_set_alphatestenable(true);
gpu_set_alphatestref(5);
//z = 0;
show_debug_overlay(true);

view_enabled = true;
view_visible[0] = true;