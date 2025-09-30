/// @ignore
// Feather ignore all
function __StickersSpriteAddSimple(_buffer, _uvs, _x, _y, _col, _alpha) {
	gml_pragma("forceinline");
	var _pLeft = _uvs.xoffset, _pTop = _uvs.yoffset, _pBottom = _uvs.topHeight, _pRight = _uvs.leftWidth;
    
    var _x0 = _x + (_pLeft);
    var _y0 = _y + (_pTop);
    var _x1 = _x + (_pRight);
    var _y1 = _y0;
    var _x2 = _x1;
    var _y2 = _y + (_pBottom);
    var _x3 = _x0;
    var _y3 = _y2;
    
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