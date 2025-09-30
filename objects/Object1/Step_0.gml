if (keyboard_check_released(vk_space)) {
	var _t = get_timer();
	decals.Import(buff);
	show_debug_message($"Time: {(get_timer() - _t) / 1000}ms")
}

if (keyboard_check(ord("U"))) {
	var _xOffset = region.GetX();
	var _yOffset = region.GetY();
	repeat(keyboard_check(vk_shift) ? 1024 : 1) {
		var _col = make_color_rgb(irandom(255), irandom(255), irandom(255));
		var _x = _xOffset + irandom_range(0, room_width);
		var _y = _yOffset + irandom_range(0, room_height);
		//data[1] = _x;
		//data[2] = _y;
		//decals.AddExt(spr_test_uwu, args);
		region.AddBasic(spr_test_uwu, irandom(sprite_get_number(spr_test_uwu)-1), _x, _y);
	}
}


if (keyboard_check_released(ord("P"))) {
	releaseMode = !releaseMode;
	gml_release_mode(releaseMode);
}

if (mouse_check_button(mb_left)) {
	var _scale = random_range(0.1, 2);
	var _alpha = 1;
	


	
	var _t = get_timer();
	repeat(keyboard_check(vk_shift) ? 1024 : 1) {
		var _col = make_color_rgb(irandom(255), irandom(255), irandom(255));
		var _x = mouse_x + irandom_range(-room_width, room_width);
		var _y = mouse_y + irandom_range(-room_height, room_height);
		//data[1] = _x;
		//data[2] = _y;
		//decals.AddExt(spr_test_uwu, args);
		decals.Add(spr_test_uwu, 0, _x, _y, undefined, undefined, undefined, _col, _alpha);
	}
	show_debug_message($"Time: {(get_timer() - _t) / 1000}ms")
}

if (mouse_check_button(mb_middle)) {
	
	var _scale = random_range(0.1, 2);
	var _alpha = 1;
	repeat(keyboard_check(vk_shift) ? 1024 : 1) {
		frame++;
		var _x = mouse_x + (keyboard_check(vk_shift) ? irandom_range(-256, 256) : 0);
		var _y = mouse_y + (keyboard_check(vk_shift) ? irandom_range(-256, 256) : 0);
		
		decals.AddBasic(spr_test_uwu, 0, _x, _y);
	}
} else frame =0;
 
if (keyboard_check(vk_alt)) {
	data = decals.GetImageData(mouse_x, mouse_y);
	array_foreach(data, function(_elm) {
		_elm.Remove();
	});

	data = [];
}

if (mouse_check_button_released(mb_right)) {
	decals.Clear();
}

var _hspd = -keyboard_check(ord("A")) + keyboard_check(ord("D"));
var _vspd = -keyboard_check(ord("W")) + keyboard_check(ord("S"));

x += _hspd*128;
y += _vspd*128;
camera_set_view_pos(view_camera[0], x, y);

if (keyboard_check_released(vk_control)) {
	if (buffer_exists(buff)) buffer_delete(buff);
	var _t = get_timer();
	buff = decals.Export();
	show_debug_message($"Time: {(get_timer() - _t) / 1000}ms")
}

if (keyboard_check_released(vk_escape)) {
	decals.Destroy();
	game_end();
}