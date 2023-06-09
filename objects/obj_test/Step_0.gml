if (mouse_check_button(mb_left)) {
	repeat(1 + (keyboard_check(vk_shift)*10)) {
		var _scale = random_range(.3, 3);
		var _x = mouse_x + irandom_range(-100, 100);
		var _y = mouse_y + irandom_range(-100, 100);
		decals.AddExt(spr_a, irandom(image_number-1), _x, _y, _scale, _scale, random(360), make_color_hsv(irandom(255), irandom(255), irandom_range(100, 255)), random_range(.2, .6), 0);	
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

if (mouse_check_button_pressed(mb_right)) {
	decals.Clear();
}

if (keyboard_check_released(ord("R"))) {
	StickersClearCache();	
}

if (keyboard_check_released(ord("Q"))) {
	decals.SetDebug(!decals.GetDebug());	
}