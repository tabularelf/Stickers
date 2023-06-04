if (mouse_check_button(mb_left)) {
	repeat(1 + (keyboard_check(vk_shift)*10)) {
		var _scale = random_range(.3, 3);
		var _x = mouse_x + irandom_range(-100, 100);
		var _y = mouse_y + irandom_range(-100, 100);
		decals.AddExt(choose(spr_smile, spr_sad, spr_a), irandom(image_number-1), _x, _y, _scale, _scale, random(360), make_color_hsv(irandom(255), irandom(255), irandom_range(100, 255)), random_range(.5, 1), 0);	
	}
}

if (mouse_wheel_up()) {
	decals.SetMax(decals.GetMax()+1);
}

if (mouse_wheel_down()) {
	decals.SetMax(max(decals.GetMax()-1, 1));
}

if (mouse_check_button_pressed(mb_right)) {
	decals.Clear();	
}

decals.Update();