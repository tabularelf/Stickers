/// @ignore
/// feather ignore all
function __StickersSpritePrep(_buffer, _struct, _index, _x, _y, _z, _xScale, _yScale, _angle, _colour, _alpha) {
	var _uvs = _struct.uvs[_index];
	var _rgba = (_colour & 0xFFFFFF) | ((0xFF*_alpha) << 24);
	
	if (__STICKERS_FLOOR_VERTEX_BUFFER_COORDS) {
		_x = floor(_x);
		_y = floor(_y);
		_z = floor(_z);
	}
	
	// Get UV info
	var _left =	_uvs.left; 
	var _top = _uvs.top;
	var _right = _uvs.right;
	var _bottom = _uvs.bottom; 
	
	var _sin = dsin(_angle+90);
    var _cos = dcos(_angle+90);
	
	var _xPos = _uvs.xoffset;
	var _yPos = _uvs.yoffset;
	var _width = (_uvs.width)*_xScale;
	var _height = (_uvs.height)*_yScale;
    
    var _pLeft = _xPos*_xScale, _pTop = _yPos*_yScale, _pBottom = (_pTop + _height), _pRight = (_pLeft + _width);
    
    var _x0 = _x + (-_pTop *  _cos + _pLeft * _sin);
    var _y0 = _y + (-_pTop * -_sin + _pLeft * _cos);
    var _x1 = _x + (-_pTop *  _cos + _pRight * _sin);
    var _y1 = _y + (-_pTop * -_sin + _pRight * _cos);
    var _x2 = _x + (-_pBottom *  _cos + _pRight * _sin);
    var _y2 = _y + (-_pBottom * -_sin + _pRight * _cos);
    var _x3 = _x + (-_pBottom *  _cos + _pLeft * _sin);
    var _y3 = _y + (-_pBottom * -_sin + _pLeft * _cos);
	
	#region Buffer Writes
	buffer_write(_buffer, buffer_f32, _x0);
	buffer_write(_buffer, buffer_f32, _y0);
	buffer_write(_buffer, buffer_f32, _z);
	
	buffer_write(_buffer, buffer_u32, _rgba);
	
	buffer_write(_buffer, buffer_f32, _left);
	buffer_write(_buffer, buffer_f32, _top);
	
	buffer_write(_buffer, buffer_f32, _x1);
	buffer_write(_buffer, buffer_f32, _y1);
	buffer_write(_buffer, buffer_f32, _z);
	
	buffer_write(_buffer, buffer_u32, _rgba);
	
	buffer_write(_buffer, buffer_f32, _right);
	buffer_write(_buffer, buffer_f32, _top);
	
	buffer_write(_buffer, buffer_f32, _x2);
	buffer_write(_buffer, buffer_f32, _y2);
	buffer_write(_buffer, buffer_f32, _z);
	
	buffer_write(_buffer, buffer_u32, _rgba);
	
	buffer_write(_buffer, buffer_f32, _right);
	buffer_write(_buffer, buffer_f32, _bottom);
	
	buffer_write(_buffer, buffer_f32, _x0);
	buffer_write(_buffer, buffer_f32, _y0);
	buffer_write(_buffer, buffer_f32, _z);
	
	buffer_write(_buffer, buffer_u32, _rgba);
	
	buffer_write(_buffer, buffer_f32, _left);
	buffer_write(_buffer, buffer_f32, _top);


	buffer_write(_buffer, buffer_f32, _x2);
	buffer_write(_buffer, buffer_f32, _y2);
	buffer_write(_buffer, buffer_f32, _z);
	
	buffer_write(_buffer, buffer_u32, _rgba);
	
	buffer_write(_buffer, buffer_f32, _right);
	buffer_write(_buffer, buffer_f32, _bottom);

	buffer_write(_buffer, buffer_f32, _x3);
	buffer_write(_buffer, buffer_f32, _y3);
	buffer_write(_buffer, buffer_f32, _z);
	
	buffer_write(_buffer, buffer_u32, _rgba);
	
	buffer_write(_buffer, buffer_f32, _left);
	buffer_write(_buffer, buffer_f32, _bottom);
	#endregion
}