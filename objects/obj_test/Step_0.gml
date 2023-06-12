if (mouse_check_button(mb_left)) {
	repeat(keyboard_check(vk_shift) ? 10 : 1) {
		var _scale = random_range(.3, 3);
		var _x = mouse_x + irandom_range(-100, 100);
		var _y = mouse_y + irandom_range(-100, 100);
		var _spr = choose(spr_a, spr_smile, spr_sad);
		decals.Add(_spr, irandom(sprite_get_number(_spr)), _x, _y, _scale, _scale, irandom(360), make_color_hsv(irandom(255), irandom(255), irandom_range(100, 255)));
	}
}

if (mouse_check_button(mb_right)) {
	repeat(keyboard_check(vk_shift) ? 10 : 1) {
		var _scale = random_range(.3, 3);
		var _x = mouse_x + irandom_range(-100, 100);
		var _y = mouse_y + irandom_range(-100, 100);
		decals.Add(spr_a, 0, _x, _y, _scale, _scale, irandom(360), make_color_hsv(irandom(255), irandom(255), irandom_range(100, 255)));
	}
}


var _hspd = -keyboard_check(ord("A")) + keyboard_check(ord("D"));
var _vspd = -keyboard_check(ord("W")) + keyboard_check(ord("S"));

x += _hspd*16;
y += _vspd*16;
camera_set_view_pos(view_camera[0], x, y);

if (mouse_wheel_up()) {
	decals.SetMax(decals.GetMax()+1);
}

if (mouse_wheel_down()) {
	decals.SetMax(max(decals.GetMax()-1, 1));
}

if (keyboard_check_released(ord("R"))) {
	decals.Clear();
}

if (keyboard_check_released(ord("Q"))) {
	decals.SetDebug(!decals.GetDebug());	
}

if (keyboard_check_released(ord("E"))) {
	decals.ClearRegion(mouse_x, mouse_y);	
}