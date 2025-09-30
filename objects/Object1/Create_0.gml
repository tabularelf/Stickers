decals = new Stickers(1024, , , false, "Generic").SetDebug(true);
//decals.SetImageData(true);
frame = 0;
texturegroup_set_mode(false);
show_debug_overlay(true, true);
var _winScale = 2;
releaseMode = false;
repeat(10) {
	decals.Add(spr_test_uwu, 0, irandom_range(0, 128), irandom_range(0, 48), 1, 1);
}

	repeat(10000) {
		var _col = make_color_rgb(irandom(255), irandom(255), irandom(255));
		var _x = irandom_range(0, room_width);
		var _y = irandom_range(0, room_height);
		var _scale = 0.5;
		var _alpha = 1;
		
		decals.AddFull(spr_test_uwu, 0, _x, _y, _scale, _scale, 0, _col, _alpha);
	}

//repeat(10) {
//	var _col = make_color_rgb(irandom(255), irandom(255), irandom(255))
//	decals.Add(spr_test_uwu, 0, irandom_range(0, room_width), irandom_range(0, room_height), undefined, undefined, undefined, _col);
//}
//*/
data = [];//decals.GetImageData(128, 48);


buff = -1;

/*
var _t = get_timer();
buff = decals.Export()
cBuff = buffer_compress(buff, 0, buffer_get_size(buff));
str = buffer_base64_encode(cBuff, 0 , buffer_get_size(cBuff));
show_debug_message([buffer_get_size(buff), buffer_get_size(cBuff), string_byte_length(str)]);

show_debug_message($"Time: {(get_timer() - _t) / 1000}ms")
//buffer_save(buff, "test.buff");
//*/
//buff = buffer_load("test.buff");

view_enabled = true;
view_visible[0] = true;
width = room_width * _winScale;
height = room_height * _winScale;
camera_set_view_size(view_camera[view_current], width, height)

args = array_create(1025);
var _args = args;
data = [
		0,
		mouse_x,
		mouse_y,
		1,
		1,
		0,
		c_white,
		1,
		0,
	];
with {data} array_map_ext(_args, function() {
	return data;
});

region = decals.GetRegion(4096, 4096);