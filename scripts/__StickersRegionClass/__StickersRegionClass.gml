// Feather ignore all
/// @ignore
function __StickersRegionClass(_x, _y, _owner) constructor {
	static __staticSpriteCache = __StickersGlobal().spriteCache;
	__spriteCache = __staticSpriteCache;
	__owner = _owner;
	__x = _x;
	__y = _y;
	__regionWidth = _owner.__regionWidth;
	__regionHeight = _owner.__regionHeight;
	__width = __x + __regionWidth;
	__height = __y + __regionHeight;
	__entries = [];
	__destroyed = false;
	__cacheVBuffer = undefined;
	__col = make_color_hsv(frac(sin((__x + (__y*__owner.__regionWidth)) * 0.132716) * 43758.5453)*255, 255, 100);
	
	/// @ignore
	static __AddEntry = function(_texId, _texPtr) {
		var _entry = __StickersGetVBuffer(__owner.__frozen, __owner.__size, _texId, _texPtr, __owner, self)		
		array_push(__entries, _entry);
		return _entry;
	}

	/// @description Returns if the region instance is alive or not.
	static Alive = function() {
		return !__destroyed;
	}

	/// @description Returns the width of the region, as setup by the Stickers instance.
	/// @return {Real}
	static GetWidth = function() {
		return __regionWidth;
	}

	/// @description Returns the height of the region, as setup by the Stickers instance.
	/// @return {Real}
	static GetHeight = function() {
		return __regionHeight;
	}

	/// @description Returns the x coordinate of the region.
	/// @return {Real}
	static GetX = function() {
		return __x;
	}

	/// @description Returns the y coordinate of the region.
	/// @return {Real}
	static GetY = function() {
		return __y;
	}

	/// @description Returns the Sticker instance it belongs to.
	/// @return {Struct.Stickers}
	static GetOwner = function() {
		if (__destroyed) return;
		return __owner;
	}

	/// @description Clears all vertex buffers from the region instance.
	static Clear = function() {
		__Clear();
	}
	
	/// @ignore
	static __Clear = function() {
		var _i = 0;
		repeat(array_length(__entries)) {
			__entries[_i].__Destroy();	
			++_i;
		}
	}
	
	/// @ignore
	static __Destroy = function() {
		__Clear();
		__entries = undefined;
		__destroyed = true;	
	}

	/// @description Destroys the region instance, and removing it from the Stickers instance.
	static Destroy = function() {
		if (__destroyed) return;
		__Destroy();
		array_delete(__owner.__regions, array_get_index(__owner.__regions, self), 1);
	}

	/// @param {Asset.Sprite} sprite_index The sprite to use.
	/// @param {Real} image_index The image index to use.
	/// @param {Real} x The x coordinate to place the sprite.
	/// @param {Real} y	The y coordinate to place the sprite.
	/// @param {Real, Undefined} xscale The x scale of the sprite. Default is 1.
	/// @param {Real, Undefined} yscale The y scale of the sprite. Default is 1.
	/// @param {Real, Undefined} angle The angle of the sprite. Default is 0.
	/// @param {Real, Constant.Colour, Undefined} colour The colour of the sprite. Default is c_white.
	/// @param {Real, Undefined} alpha The alpha of the sprite. Default is 1.
	/// @param {Real, Undefined} z The depth (or z) of the sprite. Default is 0.
 	static Add = function(_sprite, _index, _x, _y, _xScale = undefined, _yScale = undefined, _angle = undefined, _col = c_white, _alpha = 1, _z = undefined) {
		if (__destroyed) return;
		_x = clamp(_x, __x, __width);
		_y = clamp(_y, __y, __height);
		__Add(_sprite, _index, _x, _y, _xScale, _yScale, _angle, _col, _alpha, _z);
		return self;
	}

	/// @ignore
	static __Add = function(_sprite, _index, _x, _y, _xScale, _yScale, _angle, _col, _alpha, _z) {
		if (__destroyed) return;
		if (__STICKERS_AUTO_PRECACHE) StickersPrecacheSprite(_sprite);
		var _spriteInfo = __StickersCacheGetSprite(_sprite);
		var _uvs = _spriteInfo.GetUVs(_index);
		var _buffer = undefined;
		var _i = 0;
		if (!is_undefined(__cacheVBuffer)) {
			if (__cacheVBuffer.__texId == _uvs.texture) {
				_buffer = __cacheVBuffer;
			}
		}

		if (is_undefined(_buffer)) {
			repeat(array_length(__entries)) {
				if (__entries[_i].__texId = _uvs.texture) {
					_buffer = __entries[_i];
					break;
				}
				++_i;
			}

			_buffer ??= __AddEntry(_uvs.texture, _uvs.texturePtr);
			__cacheVBuffer = _buffer;
		}

		__STICKERS_PADDING_HANDLE;

		if (__STICKERS_FLOOR_VERTEX_BUFFER_COORDS) {
			_x = floor(_x);
			_y = floor(_y);
			if (is_numeric(_z)) _z = floor(_z);
		}

		if (__STICKERS_STORE_IMAGE_DATA) && (_buffer.__hasImageData) { 
			_buffer.__imageData[_buffer.__pos % _buffer.__size] ??= new __StickersImageDataClass(_buffer, _buffer.__pos, _sprite, _index, _x, _y, _xScale ?? 1, _yScale ?? 1, _angle ?? 0, _col, _alpha, _z ?? 0); 
			_buffer.__imageData[_buffer.__pos % _buffer.__size].__UpdateSprite(_sprite, _index, _x, _y, _xScale ?? 1, _yScale ?? 1, _angle ?? 0, _col, _alpha, _z ?? 0); 
		} 
		
		if (__STICKERS_ALLOW_EXPORT) {
			_buffer.__imageIndex[_buffer.__pos % _buffer.__size] = _index;
		}

		if (is_undefined(_z)) {
			if (is_undefined(_xScale) && is_undefined(_yScale)) {
				if (is_undefined(_angle)) {
					if (is_undefined(_col) && is_undefined(_alpha)) {
						__StickersSpriteAddBasic(_buffer, _uvs, _x, _y);
						return self;
					}
					_col ??= c_white;
					_alpha ??= 1;
					__StickersSpriteAddSimple(_buffer, _uvs, _x, _y, _col, _alpha);
					return self;
				}	
				_col ??= c_white;
				_alpha ??= 1;

				__StickersSpriteAddSimpleAngle(_buffer, _uvs, _x, _y, _angle, _col, _alpha);
				return self;
			}
		}
	
		_xScale ??= 1;
		_yScale ??= 1;
		_z ??= 0;
		_col ??= c_white;
		_alpha ??= 1;
		_angle ??= 0;

		__StickersSpriteAddFull(_buffer, _uvs, _x, _y, _xScale, _yScale, _angle, _col, _alpha, _z);
		return self;
	}	 

	/// @param {Asset.Sprite} sprite_index The sprite to use.
	/// @param {Real} image_index The image index to use.
	/// @param {Real} x The x coordinate to place the sprite.
	/// @param {Real} y	The y coordinate to place the sprite.
	/// @param {Real, Constant.Colour} colour The colour of the sprite. Default is c_white.
	/// @param {Real} alpha The alpha of the sprite. Default is 1.
	static AddSimple = function(_sprite, _index, _x, _y, _col = c_white, _alpha = 1) {
		if (__destroyed) return;
		_x = clamp(_x, __x, __width);
		_y = clamp(_y, __y, __height);
		__AddSimple(_sprite, _index, _x, _y, _col, _alpha);
		return self;
	}

	/// @ignore
	static __AddSimple = function(_sprite, _index, _x, _y, _col, _alpha) {
		if (__destroyed) return;
		if (__STICKERS_AUTO_PRECACHE) StickersPrecacheSprite(_sprite);
		var _spriteInfo = __StickersCacheGetSprite(_sprite);
		var _uvs = _spriteInfo.GetUVs(_index);
		var _buffer = undefined;
		var _i = 0;
		if (!is_undefined(__cacheVBuffer)) {
			if (__cacheVBuffer.__texId == _uvs.texture) {
				_buffer = __cacheVBuffer;
			}
		}

		if (is_undefined(_buffer)) {
			repeat(array_length(__entries)) {
				if (__entries[_i].__texId = _uvs.texture) {
					_buffer = __entries[_i];
					break;
				}
				++_i;
			}

			_buffer ??= __AddEntry(_uvs.texture, _uvs.texturePtr);
			__cacheVBuffer = _buffer;
		}

		__STICKERS_PADDING_HANDLE;

		if (__STICKERS_FLOOR_VERTEX_BUFFER_COORDS) {
			_x = floor(_x);
			_y = floor(_y);
		}

		if (__STICKERS_STORE_IMAGE_DATA) && (_buffer.__hasImageData) { 
			_buffer.__imageData[_buffer.__pos % _buffer.__size] ??= new __StickersImageDataClass(_buffer, _buffer.__pos, _sprite, _index, _x, _y, 1, 1, 0, _col, _alpha, 0); 
			_buffer.__imageData[_buffer.__pos % _buffer.__size].__UpdateSprite(_sprite, _index, _x, _y, 1, 1, 0, _col, _alpha, 0); 
		} 
		if (__STICKERS_ALLOW_EXPORT) {
			_buffer.__imageIndex[_buffer.__pos % _buffer.__size] = _index;
		}

		__StickersSpriteAddSimple(_buffer, _uvs, _x, _y, _col, _alpha);
		return self;
	}
	
	/// @param {Asset.Sprite} sprite_index The sprite to use.
	/// @param {Real} image_index The image index to use.
	/// @param {Real} x The x coordinate to place the sprite.
	/// @param {Real} y	The y coordinate to place the sprite.
	static AddBasic = function(_sprite, _index, _x, _y) {
		if (__destroyed) return;
		_x = clamp(_x, __x, __width);
		_y = clamp(_y, __y, __height);
		__AddBasic(_sprite, _index, _x, _y);
		return self;
	}

	/// @ignore
	static __AddBasic = function(_sprite, _index, _x, _y) {
		if (__destroyed) return;
		if (__STICKERS_AUTO_PRECACHE) StickersPrecacheSprite(_sprite);
		var _spriteInfo = __StickersCacheGetSprite(_sprite);
		var _uvs = _spriteInfo.GetUVs(_index);
		var _buffer = undefined;
		var _i = 0;
		if (!is_undefined(__cacheVBuffer)) {
			if (__cacheVBuffer.__texId == _uvs.texture) {
				_buffer = __cacheVBuffer;
			}
		}

		if (is_undefined(_buffer)) {
			repeat(array_length(__entries)) {
				if (__entries[_i].__texId = _uvs.texture) {
					_buffer = __entries[_i];
					break;
				}
				++_i;
			}

			_buffer ??= __AddEntry(_uvs.texture, _uvs.texturePtr);
			__cacheVBuffer = _buffer;
		}

		__STICKERS_PADDING_HANDLE;

		if (__STICKERS_FLOOR_VERTEX_BUFFER_COORDS) {
			_x = floor(_x);
			_y = floor(_y);
		}

		if (__STICKERS_STORE_IMAGE_DATA) && (_buffer.__hasImageData) { 
			_buffer.__imageData[_buffer.__pos % _buffer.__size] ??= new __StickersImageDataClass(_buffer, _buffer.__pos, _sprite, _index, _x, _y, 1, 1, 0, c_white, 1, 0); 
			_buffer.__imageData[_buffer.__pos % _buffer.__size].__UpdateSprite(_sprite, _index, _x, _y, 1, 1, 0, c_white, 1, 0); 
		} 

		if (__STICKERS_ALLOW_EXPORT) {
			_buffer.__imageIndex[_buffer.__pos % _buffer.__size] = _index;
		}

		__StickersSpriteAddBasic(_buffer, _uvs, _x, _y);
	}

	/// @param {Asset.Sprite} sprite_index The sprite to use.
	/// @param {Real} image_index The image index to use.
	/// @param {Real} x The x coordinate to place the sprite.
	/// @param {Real} y	The y coordinate to place the sprite.
	/// @param {Real} angle The angle of the sprite. Default is 0.
	/// @param {Real, Constant.Colour} colour The colour of the sprite. Default is c_white.
	/// @param {Real} alpha The alpha of the sprite. Default is 1.
	static AddSimpleAngle = function(_sprite, _index, _x, _y, _angle = 0, _col = c_white, _alpha = 1) {
		if (__destroyed) return;
		_x = clamp(_x, __x, __width);
		_y = clamp(_y, __y, __height);
		__AddSimpleAngle(_sprite, _index, _x, _y, _angle, _col, _alpha);
		return self;
	}

	/// @ignore
	static __AddSimpleAngle = function(_sprite, _index, _x, _y, _angle, _col, _alpha) {
		if (__destroyed) return;
		if (__STICKERS_AUTO_PRECACHE) StickersPrecacheSprite(_sprite);
		var _spriteInfo = __StickersCacheGetSprite(_sprite);
		var _uvs = _spriteInfo.GetUVs(_index);
		var _buffer = undefined;
		var _i = 0;
		repeat(array_length(__entries)) {
			if (__entries[_i].__texId = _uvs.texture) {
				_buffer = __entries[_i];
				break;
			}
			++_i;
		}
		
		_buffer ??= __AddEntry(_uvs.texture, _uvs.texturePtr);

		__STICKERS_PADDING_HANDLE;

		if (__STICKERS_FLOOR_VERTEX_BUFFER_COORDS) {
			_x = floor(_x);
			_y = floor(_y);
		}

		if (__STICKERS_STORE_IMAGE_DATA) && (_buffer.__hasImageData) { 
			_buffer.__imageData[_buffer.__pos % _buffer.__size] ??= new __StickersImageDataClass(_buffer, _buffer.__pos, _sprite, _index, _x, _y, 1, 1, 0, _col, _alpha, 0); 
			_buffer.__imageData[_buffer.__pos % _buffer.__size].__UpdateSprite(_sprite, _index, _x, _y, 1, 1, _angle, _col, _alpha, 0); 
		} 

		if (__STICKERS_ALLOW_EXPORT) {
			_buffer.__imageIndex[_buffer.__pos % _buffer.__size] = _index;
		}

		__StickersSpriteAddSimpleAngle(_buffer, _uvs, _x, _y, _angle, _col, _alpha);
		return self;
	}

	/// @param {Asset.Sprite} sprite_index The sprite to use.
	/// @param {Real} image_index The image index to use.
	/// @param {Real} x The x coordinate to place the sprite.
	/// @param {Real} y	The y coordinate to place the sprite.
	/// @param {Real} xscale The x scale of the sprite. Default is 1.
	/// @param {Real} yscale The y scale of the sprite. Default is 1.
	/// @param {Real} angle The angle of the sprite. Default is 0.
	/// @param {Real, Constant.Colour} colour The colour of the sprite. Default is c_white.
	/// @param {Real} alpha The alpha of the sprite. Default is 1.
	/// @param {Real} z The depth (or z) of the sprite. Default is 0.
 	static AddFull = function(_sprite, _index, _x, _y, _xScale = 1, _yScale = 1, _angle = 0, _col = c_white, _alpha = 1, _z = 0) {
		if (__destroyed) return;
		_x = clamp(_x, __x, __width);
		_y = clamp(_y, __y, __height);
		__AddFull(_sprite, _index, _x, _y, _xScale, _yScale, _angle, _col, _alpha, _z);
		return self;
	}

	/// #ignore
	static __AddFull = function(_sprite, _index, _x, _y, _xScale, _yScale, _angle, _col, _alpha, _z) {
		if (__destroyed) return;
		if (__STICKERS_AUTO_PRECACHE) StickersPrecacheSprite(_sprite);
		var _spriteInfo = __StickersCacheGetSprite(_sprite);
		var _uvs = _spriteInfo.GetUVs(_index);
		var _buffer = undefined;
		var _i = 0;
		repeat(array_length(__entries)) {
			if (__entries[_i].__texId = _uvs.texture) {
				_buffer = __entries[_i];
				break;
			}
			++_i;
		}
		
		_buffer ??= __AddEntry(_uvs.texture, _uvs.texturePtr);

		__STICKERS_PADDING_HANDLE_EXT;

		if (__STICKERS_FLOOR_VERTEX_BUFFER_COORDS) {
			_x = floor(_x);
			_y = floor(_y);
			_z = floor(_z);
		}

		if (__STICKERS_STORE_IMAGE_DATA) && (_buffer.__hasImageData) { 
			_buffer.__imageData[_buffer.__pos % _buffer.__size] ??= new __StickersImageDataClass(_buffer, _buffer.__pos, _sprite, _index, _x, _y, 1, 1, 0, _col, _alpha, 0); 
			_buffer.__imageData[_buffer.__pos % _buffer.__size].__UpdateSprite(_sprite, _index, _x, _y, _xScale, _yScale, _angle, _col, _alpha, 0); 
		} 

		if (__STICKERS_ALLOW_EXPORT) {
			_buffer.__imageIndex[_buffer.__pos % _buffer.__size] = _index;
		}

		__StickersSpriteAddFull(_buffer, _uvs, _x, _y, _xScale, _yScale, _angle, _col, _alpha, _z);
		return self;
	}

	static Draw = function() {
		__Draw();
	}
	
	/// @ignore
	static __Draw = function() {
		if (__destroyed) return;
		if (__owner.__debug) {
			draw_text(8+__x, 8+__y, "X: " + string(__x) + " Y: " + string(__y));
			draw_rectangle_colour(__x, __y, __x+__owner.__regionWidth, __y+__owner.__regionHeight, __col, __col, __col, __col, true);
		}	

		var _i = 0;
		repeat(array_length(__entries)) {
			__entries[_i].__Draw();
			++_i;
		}
	}
}