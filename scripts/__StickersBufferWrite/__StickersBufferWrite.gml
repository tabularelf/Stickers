/// @ignore
function __StickersBufferWrite(_buffer, _xy, _z, _left, _top, _right, _bottom, _colour, _alphaValue) {
	var _red = color_get_red(_colour[0]), _green = color_get_green(_colour[0]), _blue = color_get_blue(_colour[0]);
	var _alpha = _alphaValue*255;
	
	buffer_write(_buffer, buffer_f32, _xy[0][0]);
	buffer_write(_buffer, buffer_f32, _xy[0][1]);
	buffer_write(_buffer, buffer_f32, _z);
	
	buffer_write(_buffer, buffer_u8, _red);
	buffer_write(_buffer, buffer_u8, _green);
	buffer_write(_buffer, buffer_u8, _blue);
	buffer_write(_buffer, buffer_u8, _alpha);
	
	buffer_write(_buffer, buffer_f32, _left);
	buffer_write(_buffer, buffer_f32, _top);
	
	buffer_write(_buffer, buffer_f32, _xy[1][0]);
	buffer_write(_buffer, buffer_f32, _xy[1][1]);
	buffer_write(_buffer, buffer_f32, _z);
	
	buffer_write(_buffer, buffer_u8, _red);
	buffer_write(_buffer, buffer_u8, _green);
	buffer_write(_buffer, buffer_u8, _blue);
	buffer_write(_buffer, buffer_u8, _alpha);
	
	buffer_write(_buffer, buffer_f32, _right);
	buffer_write(_buffer, buffer_f32, _top);
	
	buffer_write(_buffer, buffer_f32, _xy[2][0]);
	buffer_write(_buffer, buffer_f32, _xy[2][1]);
	buffer_write(_buffer, buffer_f32, _z);
	
	buffer_write(_buffer, buffer_u8, _red);
	buffer_write(_buffer, buffer_u8, _green);
	buffer_write(_buffer, buffer_u8, _blue);
	buffer_write(_buffer, buffer_u8, _alpha);
	
	buffer_write(_buffer, buffer_f32, _right);
	buffer_write(_buffer, buffer_f32, _bottom);
	
	buffer_write(_buffer, buffer_f32, _xy[0][0]);
	buffer_write(_buffer, buffer_f32, _xy[0][1]);
	buffer_write(_buffer, buffer_f32, _z);
	
	buffer_write(_buffer, buffer_u8, _red);
	buffer_write(_buffer, buffer_u8, _green);
	buffer_write(_buffer, buffer_u8, _blue);
	buffer_write(_buffer, buffer_u8, _alpha);
	
	buffer_write(_buffer, buffer_f32, _left);
	buffer_write(_buffer, buffer_f32, _top);


	buffer_write(_buffer, buffer_f32, _xy[2][0]);
	buffer_write(_buffer, buffer_f32, _xy[2][1]);
	buffer_write(_buffer, buffer_f32, _z);
	
	buffer_write(_buffer, buffer_u8, _red);
	buffer_write(_buffer, buffer_u8, _green);
	buffer_write(_buffer, buffer_u8, _blue);
	buffer_write(_buffer, buffer_u8, _alpha);
	
	buffer_write(_buffer, buffer_f32, _right);
	buffer_write(_buffer, buffer_f32, _bottom);

	buffer_write(_buffer, buffer_f32, _xy[3][0]);
	buffer_write(_buffer, buffer_f32, _xy[3][1]);
	buffer_write(_buffer, buffer_f32, _z);
	
	buffer_write(_buffer, buffer_u8, _red);
	buffer_write(_buffer, buffer_u8, _green);
	buffer_write(_buffer, buffer_u8, _blue);
	buffer_write(_buffer, buffer_u8, _alpha);
	
	buffer_write(_buffer, buffer_f32, _left);
	buffer_write(_buffer, buffer_f32, _bottom);
}