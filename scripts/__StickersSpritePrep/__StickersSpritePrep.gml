// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function __StickersSpritePrep(_vbuffer, _imageData, _index, _x, _y, _z, _widthValue, _heightValue, _angleValue, _colourValue, _alpha) {
	var _uvs = sprite_get_uvs(_imageData, _index);
	
	// Get UV info
	var _left, _right, _top, _bottom;
	_left =			_uvs[0]; 
	_top =			_uvs[1];
	_right =		_uvs[2];
	_bottom =	_uvs[3]; 
    var _c = dcos(_angleValue+90);
    var _s = dsin(_angleValue+90);
    
    var _colour;
	static _colArray = array_create(4);
	if (is_array(_colourValue)) {
		_colour = _colourValue;	
	} else if (is_real(_colourValue)) {
		_colArray[0] =_colourValue;
		_colArray[1] =_colourValue;
		_colArray[2] =_colourValue;
		_colArray[3] =_colourValue;
		_colour = _colArray;
    }
	
	var _xPos = -sprite_get_xoffset(_imageData);
	var _yPos = -sprite_get_yoffset(_imageData);
	var _widthScale = _widthValue*_uvs[6];
	var _heightScale = _heightValue*_uvs[7];
	var _width = sprite_get_width(_imageData)*_widthScale;
	var _height = sprite_get_height(_imageData)*_heightScale;
    
    var _pLeft = _xPos*_widthScale, _pTop = _yPos*_heightScale, _pBottom = (_pTop + _height), _pRight = (_pLeft + _width);
    
    var _x0 = _x + (-_pTop *  _c + _pLeft * _s);
    var _y0 = _y + (-_pTop * -_s + _pLeft * _c);
    var _x1 = _x + (-_pTop *  _c + _pRight * _s);
    var _y1 = _y + (-_pTop * -_s + _pRight * _c);
    var _x2 = _x + (-_pBottom *  _c + _pRight * _s);
    var _y2 = _y + (-_pBottom * -_s + _pRight * _c);
    var _x3 = _x + (-_pBottom *  _c + _pLeft * _s);
    var _y3 = _y + (-_pBottom * -_s + _pLeft * _c);
	
	static _xy = array_create(4);
	_xy[0][0] = _x0;
	_xy[0][1] = _y0;
	
	_xy[1][0] = _x1;
	_xy[1][1] = _y1;
	
	_xy[2][0] = _x2;
	_xy[2][1] = _y2;
	
	_xy[3][0] = _x3;
	_xy[3][1] = _y3;
	
	__StickersBufferWrite(_vbuffer, _xy, _z, _left, _top, _right, _bottom, _colour, _alpha);
}