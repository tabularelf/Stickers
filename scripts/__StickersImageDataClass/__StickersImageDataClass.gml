/// @feather ignore all

/// @ignore
function __StickersImageDataClass(_owner, _pos, _arrayPos, _spr, _img, _x, _y, _xscale, _yscale, _ang, _col, _alpha, _depth) constructor {
	static __spriteCache = __StickersGlobal().spriteCache;
	__struct = __spriteCache[? _spr];
	__sprite_index = _spr;
	__image_index = _img;
	__x = _x;
	__y = _y;
	__xscale = _xscale;
	__yscale = _yscale;
	__angle = _ang;
	__color = _col;
	__alpha = _alpha;
	__depth = _depth;
	__owner = _owner;
	__pos = _pos;
	__destroyed = false;
	__arrayPos = _arrayPos;
	
	static __UpdateSprite = function(_sprite, _img, _x, _y, _xscale, _yscale,  _ang, _col, _alpha, _depth) {
		if (__destroyed) return;
		if (__sprite_index != _sprite) {
			StickersPrecacheSprite(_sprite);
			__struct = __spriteCache[? _sprite];
		}
		__sprite_index = _sprite;
		__image_index = _img;
		__x = _x;
		__y = _y;
		__xscale = _xscale;
		__yscale = _yscale;
		__angle = _ang;
		__color = _col;
		__alpha = _alpha;
		__depth = _depth;
	}
	
	static Update = function(_sprite = __sprite_index, _img = __image_index, _x = __x, _y = __y, _xscale = __xscale, _yscale = __yscale,  _ang = __angle, _col = __color, _alpha = __alpha, _depth = __depth) {
		if (__destroyed) return;
		__UpdateSprite(_sprite, _img, _x, _y, _xscale, _yscale, _ang, _col, _alpha, _depth);
		var _seek = buffer_tell(__owner.__buffer);
		buffer_seek(__owner.__buffer, buffer_seek_start, __pos);
		__StickersSpritePrep(__owner.__buffer, __struct, _img, _x, _y, _depth, _xscale, _yscale, _ang, _col, _alpha);
		buffer_seek(__owner.__buffer, buffer_seek_start, _seek);
		
		// Lol
		__owner.__owner.__update = true;
		__owner.__cacheDirty = true;
	}
	
	static Remove = function() {
		// Current method is undesirable, as it leaves gaps in the vertex buffer
		// But this should be desirable enough that it won't be as problematic... Hopefully!
		// TODO: Replace with much better method
		
		__owner.__owner.__update = true;
		__owner.__imageData[__arrayPos] = undefined;
		// CLEAR
		var _i = 0;
		
		// We're fetching xyz here to reset on every spot
		var _x = buffer_peek(__owner.__buffer, __pos, buffer_f32);
		var _y = buffer_peek(__owner.__buffer, __pos+4, buffer_f32);
		var _z = buffer_peek(__owner.__buffer, __pos+8, buffer_f32);
		repeat(6) {
			buffer_poke(__owner.__buffer, __pos+(__STICKERS_VFORMAT_SIZE*_i), buffer_f32, _x);
			buffer_poke(__owner.__buffer, __pos+4+(__STICKERS_VFORMAT_SIZE*_i), buffer_f32, _y);
			buffer_poke(__owner.__buffer, __pos+8+(__STICKERS_VFORMAT_SIZE*_i), buffer_f32, _z);
			buffer_fill(__owner.__buffer, __pos+12+(__STICKERS_VFORMAT_SIZE*_i), buffer_u8, 0, 4);
			_i++;
		}
		
		
		__owner.__stickerCount--;
		
		__owner.__cacheDirty = true;
		__destroyed = true;
		
		//if (_forceRefresh) {
		//	__owner.__regionOwner.__forceRefresh = true;	
		//}
	}
	
	static DebugDraw = function() {
		if (__destroyed) return;
		draw_sprite_ext(__sprite_index, __image_index, __x, __y, __xscale, __yscale, __angle, __color, __alpha);	
	}
}