/// @ignore
/// feather ignore all
function __StickersSpritePrep(_buffer, _struct, _index, _x, _y, _z, _xScale, _yScale, _angle, _colour, _alpha) {
	var _uvs = _struct.uvs[_index];
	var _rgba = (_colour & 0xFFFFFF) | ((0xFF*_alpha) << 24);
	
	// Get UV info
	var _left, _right, _top, _bottom;
	_left =			_uvs[0]; 
	_top =			_uvs[1];
	_right =		_uvs[2];
	_bottom =	_uvs[3]; 
	
	var _sin = dsin(_angle+90);
    var _cos = dcos(_angle+90);
	
	var _xPos = _struct.xoffset;
	var _yPos = _struct.yoffset;
	var _widthScale = _xScale*_uvs[6];
	var _heightScale = _yScale*_uvs[7];
	var _width = _struct.width*_widthScale;
	var _height = _struct.height*_heightScale;
    
    var _pLeft = _xPos*_widthScale, _pTop = _yPos*_heightScale, _pBottom = (_pTop + _height), _pRight = (_pLeft + _width);
    
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