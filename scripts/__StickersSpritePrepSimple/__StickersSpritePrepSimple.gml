/// @ignore
/// feather ignore all
function __StickersSpritePrepSimple(_buffer, _struct, _index, _x, _y) {
	var _uvs = _struct.uvs[_index];
	
	if (__STICKERS_FLOOR_VERTEX_BUFFER_COORDS) {
		_x = floor(_x);
		_y = floor(_y);
	}
	
	// Get UV info
	var _left =	_uvs.left; 
	var _top = _uvs.top;
	var _right = _uvs.right;
	var _bottom = _uvs.bottom; 
    
    var _pLeft = _uvs.xoffset, _pTop = _uvs.yoffset, _pBottom = _uvs.leftWidth, _pRight = _uvs.rightHeight;
    
    var _x0 = _x + (_pLeft);
    var _y0 = _y + (_pTop);
    var _x1 = _x + (_pRight);
    var _y1 = _y0;
    var _x2 = _x1;
    var _y2 = _y + (_pBottom);
    var _x3 = _x0;
    var _y3 = _y2;
	
	#region Buffer Writes
	buffer_write(_buffer, buffer_f32, _x0);
	buffer_write(_buffer, buffer_f32, _y0);
	buffer_write(_buffer, buffer_f32, 0);
	
	buffer_write(_buffer, buffer_u32, __STICKERS_RBGA_DEFAULT);
	
	buffer_write(_buffer, buffer_f32, _left);
	buffer_write(_buffer, buffer_f32, _top);
	
	buffer_write(_buffer, buffer_f32, _x1);
	buffer_write(_buffer, buffer_f32, _y1);
	buffer_write(_buffer, buffer_f32, 0);
	
	buffer_write(_buffer, buffer_u32, __STICKERS_RBGA_DEFAULT);
	
	buffer_write(_buffer, buffer_f32, _right);
	buffer_write(_buffer, buffer_f32, _top);
	
	buffer_write(_buffer, buffer_f32, _x2);
	buffer_write(_buffer, buffer_f32, _y2);
	buffer_write(_buffer, buffer_f32, 0);
	
	buffer_write(_buffer, buffer_u32, __STICKERS_RBGA_DEFAULT);
	
	buffer_write(_buffer, buffer_f32, _right);
	buffer_write(_buffer, buffer_f32, _bottom);
	
	buffer_write(_buffer, buffer_f32, _x0);
	buffer_write(_buffer, buffer_f32, _y0);
	buffer_write(_buffer, buffer_f32, 0);
	
	buffer_write(_buffer, buffer_u32, __STICKERS_RBGA_DEFAULT);
	
	buffer_write(_buffer, buffer_f32, _left);
	buffer_write(_buffer, buffer_f32, _top);


	buffer_write(_buffer, buffer_f32, _x2);
	buffer_write(_buffer, buffer_f32, _y2);
	buffer_write(_buffer, buffer_f32, 0);
	
	buffer_write(_buffer, buffer_u32, __STICKERS_RBGA_DEFAULT);
	
	buffer_write(_buffer, buffer_f32, _right);
	buffer_write(_buffer, buffer_f32, _bottom);

	buffer_write(_buffer, buffer_f32, _x3);
	buffer_write(_buffer, buffer_f32, _y3);
	buffer_write(_buffer, buffer_f32, 0);
	
	buffer_write(_buffer, buffer_u32, __STICKERS_RBGA_DEFAULT);
	
	buffer_write(_buffer, buffer_f32, _left);
	buffer_write(_buffer, buffer_f32, _bottom);
	#endregion
}