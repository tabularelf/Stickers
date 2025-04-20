show_debug_overlay(true);
decals = new Stickers(1024);
//repeat(decals.GetMax()/10) {
//	decals.Add(spr_a, 0, irandom(decals.GetRegionWidth()), irandom(decals.GetRegionHeight()));	
//}

//decals.Add(spr_a, 0, 512, 512);
//data = decals.GetImageData(512, 512);

view_enabled = true;
view_visible[0] = true;

if (true) {
	var _t = get_timer();
	repeat(10000) {
		decals.AddSimple(spr_a, 0, 32, 32);
	}
	show_debug_message("Results Simple: " + string((get_timer() - _t) / 1000));
	
	var _t = get_timer();
	repeat(10000) {
		decals.Add(spr_a, 0, 32, 32);
	}
	show_debug_message("Results Max but only partially filled: " + string((get_timer() - _t) / 1000));
	
	var _t = get_timer();
	repeat(10000) {
		decals.Add(spr_a, 0, 32, 32);
	}
	show_debug_message("Results Max: " + string((get_timer() - _t) / 1000));	
}