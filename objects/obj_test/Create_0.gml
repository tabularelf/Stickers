decals = new Stickers(1024).SetRegionSize(32, 32).SetFreeze(false);
repeat(decals.GetMax()/10) {
	decals.Add(spr_smile, 0, irandom(decals.GetRegionWidth()*500), irandom(decals.GetRegionHeight()*500));	
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