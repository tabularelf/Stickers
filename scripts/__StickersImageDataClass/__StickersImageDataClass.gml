/// @feather ignore all

/// @ignore
function __StickersImageDataClass(_owner, _pos, _spr, _img, _x, _y, _xscale, _yscale, _ang, _col, _alpha, _depth) constructor {
	static __spriteCache = __StickersGlobal().spriteCache;
	__struct = __spriteCache[? _spr];
	sprite_index = _spr;
	image_index = _img;
	x = _x;
	y = _y;
	xscale = _xscale;
	yscale = _yscale;
	angle = _ang;
	color = _col;
	alpha = _alpha;
	depth = _depth;
	__owner = _owner;
	__pos = _pos;
	
	static __UpdateSprite = function(_sprite, _img, _x, _y, _xscale, _yscale,  _ang, _col, _alpha, _depth) {
		//if (sprite_index != _sprite) {
			StickersPrecacheSprite(_sprite);
			__struct = __spriteCache[? _sprite];
		//}
		sprite_index = _sprite;
		image_index = _img;
		x = _x;
		y = _y;
		xscale = _xscale;
		yscale = _yscale;
		angle = _ang;
		color = _col;
		alpha = _alpha;
		depth = _depth;
	}
	
	static Update = function(_sprite = sprite_index, _img = image_index, _x = x, _y = y, _xscale = xscale, _yscale = yscale,  _ang = angle, _col = color, _alpha = alpha, _depth = depth) {
		__UpdateSprite(_sprite, _img, _x, _y, _xscale, _yscale, _ang, _col, _alpha, _depth);
		var _seek = buffer_tell(__owner.__buffer);
		buffer_seek(__owner.__buffer, buffer_seek_start, __pos);
		__StickersSpritePrep(__owner.__buffer, __struct, _img, _x, _y, _depth, _xscale, _yscale, _ang, _col, _alpha);
		buffer_seek(__owner.__buffer, buffer_seek_start, _seek);
		__owner.__owner.__update = true;
		__owner.__cacheDirty = true;
	}
	
	static DebugDraw = function() {
		draw_sprite_ext(sprite_index, image_index, x, y, xscale, yscale, angle, color, alpha);	
	}
}