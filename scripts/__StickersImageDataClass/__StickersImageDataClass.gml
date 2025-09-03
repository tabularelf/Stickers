// Feather ignore all
/// @ignore
function __StickersImageDataClass(_owner, _arrayPos, _spr, _img, _x, _y, _xscale, _yscale, _ang, _col, _alpha, _depth) constructor {
	static __staticSpriteCache = __StickersGlobal().spriteCache;
	__spriteCache = __staticSpriteCache;
	var _spriteInfo = __StickersCacheGetSprite(_sprite);
	__uvs = _spriteInfo.GetUvs(_img);
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
	__destroyed = false;
	__arrayPos = _arrayPos;

	/// @description Exports the image data as a struct.
	static Export = function() {
		return {
			sprite_index: sprite_get_name(__sprite_index),
			image_index: __image_index,
			x: __x,
			y: __y,
			xscale: __xscale,
			yscale: __yscale,
			angle: __angle,
			colour: __color,
			alpha: __alpha,
			depth: __depth,
		};
	}
	
	/// @ignore
	static __UpdateSprite = function(_sprite, _img, _x, _y, _xScale, _yScale,  _ang, _col, _alpha, _depth) {
		if (__sprite_index != _sprite) {
			if (__STICKERS_AUTO_PRECACHE) StickersPrecacheSprite(_sprite);
			var _spriteInfo = __StickersCacheGetSprite(_sprite);
			__uvs = _spriteInfo.GetUvs(_img);
		}
		__sprite_index = _sprite;
		__image_index = _img;
		__x = _x;
		__y = _y;
		__xscale = _xScale;
		__yscale = _yScale;
		__angle = _ang;
		__color = _col;
		__alpha = _alpha;
		__depth = _depth;
		__destroyed = false;
	}
	
	static Update = function(_sprite = __sprite_index, _img = __image_index, _x = __x, _y = __y, _xScale = __xscale, _yScale = __yscale,  _ang = __angle, _col = __color, _alpha = __alpha, _depth = __depth) {
		if (__destroyed) return;
		if (__owner.__destroyed) return;
		__UpdateSprite(_sprite, _img, _x, _y, _xScale, _yScale, _ang, _col, _alpha, _depth);
		__owner.__TryUpdate();
		var _oldPos = __owner.__pos;
		__owner.__pos = __arrayPos;
		__StickersSpriteAddFull(__owner, __uvs, _x, _y, _xScale, _yScale, _ang, _col, _alpha, _depth);
		__owner.__pos = _oldPos;
		__owner.__TryUpdate();
	}
	
	static Remove = function() {
		if (__destroyed) return;
		if (__owner.__destroyed) return;
		__owner.__imageData[__arrayPos] = undefined;
		__owner.__TryUpdate();
		var _oldPos = __owner.__pos;
		__owner.__pos = __arrayPos;
		__StickersSpriteAddFull(__owner, __uvs, 0, 0, 0, 0, 0, 0, 0, 0);
		__owner.__TryUpdate();
		__owner.__pos = _oldPos;
		__destroyed = true;
	}
	
	static DebugDraw = function() {
		if (__destroyed) return;
		draw_sprite_ext(__sprite_index, __image_index, __x, __y, __xscale, __yscale, __angle, __color, __alpha);	
	}
}