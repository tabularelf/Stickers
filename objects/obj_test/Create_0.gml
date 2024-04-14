show_debug_overlay(true);
decals = new Stickers(1024);
//repeat(decals.GetMax()/10) {
//	decals.Add(spr_a, 0, irandom(decals.GetRegionWidth()), irandom(decals.GetRegionHeight()));	
//}

decals.Add(spr_a, 0, 512, 512);
data = decals.GetImageData(512, 512);

view_enabled = true;
view_visible[0] = true;