/// @ignore
// Feather ignore all
function __StickersSpriteAddSimpleAngle(_buffer, _uvs, _x, _y, _angle, _col, _alpha) {
	gml_pragma("forceinline");
	var _sin = dsin(_angle+90);
    var _cos = dcos(_angle+90);
	var _pLeft = _uvs.xoffset, _pTop = _uvs.yoffset, _pBottom = _uvs.topHeight, _pRight = _uvs.leftWidth;
    
    var _x0 = _x + (-_pTop *  _cos + _pLeft * _sin);
    var _y0 = _y + (-_pTop * -_sin + _pLeft * _cos);
    var _x1 = _x + (-_pTop *  _cos + _pRight * _sin);
    var _y1 = _y + (-_pTop * -_sin + _pRight * _cos);
    var _x2 = _x + (-_pBottom *  _cos + _pRight * _sin);
    var _y2 = _y + (-_pBottom * -_sin + _pRight * _cos);
    var _x3 = _x + (-_pBottom *  _cos + _pLeft * _sin);
    var _y3 = _y + (-_pBottom * -_sin + _pLeft * _cos);
    
	__STICKERS_INCREMENT_POS;
	var _writeVBuff = _buffer.__writeVBuff;

	var _left = _uvs.left;
	var _top = _uvs.top;
	var _right = _uvs.right;
	var _bottom = _uvs.bottom;
		
	vertex_position_3d(_writeVBuff, _x0, _y0, 0);
	vertex_color(_writeVBuff, _col, _alpha);
	vertex_texcoord(_writeVBuff, _left, _top);
    
	vertex_position_3d(_writeVBuff, _x1, _y1, 0);
	vertex_color(_writeVBuff, _col, _alpha);
	vertex_texcoord(_writeVBuff, _right, _top);
    
	vertex_position_3d(_writeVBuff, _x2, _y2, 0);
	vertex_color(_writeVBuff, _col, _alpha);
	vertex_texcoord(_writeVBuff, _right, _bottom);
    
	vertex_position_3d(_writeVBuff, _x0, _y0, 0);
	vertex_color(_writeVBuff, _col, _alpha);
	vertex_texcoord(_writeVBuff, _left, _top);
    
	vertex_position_3d(_writeVBuff, _x2, _y2, 0);
	vertex_color(_writeVBuff, _col, _alpha);
	vertex_texcoord(_writeVBuff, _right, _bottom);
      
	vertex_position_3d(_writeVBuff, _x3, _y3, 0);
	vertex_color(_writeVBuff, _col, _alpha);
	vertex_texcoord(_writeVBuff, _left, _bottom);
}