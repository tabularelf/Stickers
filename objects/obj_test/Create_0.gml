decals = new Stickers(1024).SetRegion(1024, 1024);
repeat(decals.GetMax()/10) {
	decals.Add(spr_a, 0, irandom(decals.GetRegionWidth()), irandom(decals.GetRegionHeight()));	
}

view_enabled = true;
view_visible[0] = true;