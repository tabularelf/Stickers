/// feather ignore all

/// @func Stickers(maxStickers, [distribute])
/// @param {Real} maxStickers
/// @param {Bool} distribute
function Stickers(_max, _distribute = false) constructor {
	static __global = __StickersGlobal();
	if (_max <= 0) {
		__StickersError("Max stickers cannot be less than 1!");
	}
	__maxStickers = _max;
	__maxSize = _max*__STICKERS_VFORMAT_VERTICES_SIZE;
	__regions = [];
	__freeze = false;
	__distribute = _distribute;
	__maxDistributeSize = __maxSize;
	__update = false;
	__regionWidth = 1024;
	__regionHeight = 1024;
	__paddingWidth = 128;
	__paddingHeight = 128;
	__debug = false;
	__autoUpdate = true;
	__destroyed = false;
	
	static GetSize = function() {
		return array_length(__regions)*__maxDistributeSize;	
	}
	
	/// @param {Bool} freeze
	static SetFreeze = function(_freeze) {
		if (__destroyed) return;
		if (__freeze = _freeze) return self;
		__freeze = _freeze;	
		var _i = 0;
		repeat(array_length(__regions)) {
			__regions[_i].__ForceUpdate();
			++_i;
		}
		return self;
	}
	
	/// @param {Bool} autoUpdate
	static SetAutoUpdate = function(_autoUpdate) {
		if (__destroyed) return;
		__autoUpdate = _autoUpdate;	
		return self;
	}
	
	/// @param {Bool} autoUpdate
	static GetAutoUpdate = function() {
		if (__destroyed) return;
		return __autoUpdate;
	}
	
	
	/// @param {Real} width
	/// @param {Real} height
	static SetPadding = function(_width, _height) {
		if (__destroyed) return;
		__paddingWidth = __paddingWidth;
		__paddingHeight = __paddingHeight;
		return self;
	}
	
	/// @param {Bool} debug
	static SetDebug = function(_bool) {
		if (__destroyed) return;
		__debug = _bool;
		return self;
	}
	
	static GetDebug = function() {
		return __debug;	
	}
	
	/// @param {Real} width
	/// @param {Real} height
	static SetRegion = function(_width, _height) {
		if (__destroyed) return;
		if (__regionWidth == _width) && (__regionHeight == _height) return self;
		var _oldWidth = __regionWidth;
		var _oldHeight = __regionHeight;
		__regionWidth = _width;
		__regionHeight = _height;
		var _i = 0;
		repeat(array_length(__regions)) {
			var _entry = __regions[_i];
			var _x = (_entry.__x div _width) * _width;
			var _y = (_entry.__y div _height) * _height;
			_entry.__x = _x;
			_entry.__y = _y;
			++_i;
		}
		 return self;
	}
	
	static GetRegionWidth = function() {
		return __regionWidth;
	}
	
	static GetRegionHeight = function() {
		return __regionHeight;
	}
	
	static GetMax = function() {
		return __maxStickers;	
	}
	
	/// @param {Real} maxStickers
	static SetMax = function(_max) {
		if (__maxStickers == _max) return self;
		if (_max <= 0) {
			__StickersError("Max stickers cannot be less than 1!");
		}
		__maxStickers = _max;	
		__maxSize = __maxStickers*__STICKERS_VFORMAT_VERTICES_SIZE;
		__maxDistributeSize = __distribute ? (max(ceil(__maxStickers / array_length(__regions)), 1))*__STICKERS_VFORMAT_VERTICES_SIZE : __maxSize;
		var _i = 0;
		repeat(array_length(__regions)) {
			__regions[_i].__SetMax(__maxDistributeSize);
			++_i;	
		}
	}
	
	/// @param {Asset.GMSprite} sprite
	/// @param {Real} image
	/// @param {Real} x
	/// @param {Real} y
	static AddSimple = function(_spr, _img, _x, _y) {
		if (__destroyed) return;
		
		if (!ds_map_exists(__global.spriteCache, _spr)) {
			StickersPrecacheSprite(_spr);
		}
		
		var _struct = __global.spriteCache[? _spr];
		var _imgID = _img % _struct.numFrames;
		var _texID = _struct.uvs[_imgID].texture;
		var _vb = __GetBufferClass(_x, _y, _spr, _texID, _imgID);
		 
		if (__STICKERS_STORE_IMAGE_DATA) {
			var _undefinedImageData = _vb.__imageData[_vb.__imageDataPos] == undefined;
			_vb.__imageData[_vb.__imageDataPos] ??= new __StickersImageDataClass(_vb, _bufferPos, _vb.__imageDataPos, _spr, _img, _x, _y, _xscale, _yscale, _ang, _col, _alpha, _depth);
			_vb.__imageData[_vb.__imageDataPos].__UpdateSprite(_spr, _img, _x, _y, _xscale, _yscale, _ang, _col, _alpha, _depth);
			_vb.__imageDataPos = (_vb.__imageDataPos + 1) % __maxStickers;
			if (_undefinedImageData) && (_vb.__stickerCount < __maxDistributeSize div __STICKERS_VFORMAT_VERTICES_SIZE) {
				_vb.__stickerCount++;
			}
		}
		__StickersSpritePrepSimple(_vb.__buffer, _struct, _imgID, _x, _y);
		if (!__STICKERS_STORE_IMAGE_DATA) {
			if (_vb.__stickerCount < __maxDistributeSize div __STICKERS_VFORMAT_VERTICES_SIZE) {
				_vb.__stickerCount++;
			}
		}
		_vb.__cacheDirty = true;
		__update = true;
		return self;	
	}
	
	/// @param {Asset.GMSprite} sprite
	/// @param {Real} image
	/// @param {Real} x
	/// @param {Real} y
	/// @param {Real} xScale
	/// @param {Real} yScale
	/// @param {Constant.Colour} color
	/// @param {Real} alpha
	/// @param {Real} depth
	static Add = function(_spr, _img, _x, _y, _xscale = 1, _yscale = 1, _ang = 0, _col = c_white, _alpha = 1, _depth = 0) {
		if (__destroyed) return;
		
		if (!ds_map_exists(__global.spriteCache, _spr)) {
			StickersPrecacheSprite(_spr);
		}
		
		var _struct = __global.spriteCache[? _spr];
		var _imgID = _img % _struct.numFrames;
		var _texID = _struct.uvs[_imgID].texture;
		var _vb = __GetBufferClass(_x, _y, _spr, _texID, _imgID);
		 
		if (__STICKERS_STORE_IMAGE_DATA) {
			var _undefinedImageData = _vb.__imageData[_vb.__imageDataPos] == undefined;
			_vb.__imageData[_vb.__imageDataPos] ??= new __StickersImageDataClass(_vb, _bufferPos, _vb.__imageDataPos, _spr, _img, _x, _y, _xscale, _yscale, _ang, _col, _alpha, _depth);
			_vb.__imageData[_vb.__imageDataPos].__UpdateSprite(_spr, _img, _x, _y, _xscale, _yscale, _ang, _col, _alpha, _depth);
			_vb.__imageDataPos = (_vb.__imageDataPos + 1) % __maxStickers;
		}
		
		__StickersSpritePrep(_vb.__buffer, _struct, _imgID, _x, _y, _depth, _xscale, _yscale, _ang, _col, _alpha);
		_vb.__stickerCount++;
		_vb.__cacheDirty = true;
		__update = true;
		return self;
	}
	
	static GetImageData = function(_x, _y, _leftPad = -128, _topPad = -128, _rightPad = 128, _bottomPad = 128, _sortByDepth = false) {
		if (!__STICKERS_STORE_IMAGE_DATA) return __StickersError("Image data unavailable! Please set \"__STICKERS_STORE_IMAGE_DATA\" to true in __StickersConfig!");
		//show_debug_message([_x, _y]);	
		var _signX = sign(_x);
		var _signY = sign(_y);
		var _xCell = ((_x div __regionWidth) * __regionWidth) - (_signX != -1 ? 0 : __regionWidth);
		var _yCell = ((_y div __regionHeight) * __regionHeight) - (_signY != -1 ? 0 : __regionHeight);
		var _region = undefined;
		var _results = [];
		
		var _i = 0;
		repeat(array_length(__regions)) {
			if (__regions[_i].__x == _xCell) && (__regions[_i].__y == _yCell) {
				_region = __regions[_i];	
				var _j = 0;
				repeat(array_length(_region.__entries)) {
					var _k = 0;
					var _vb = _region.__entries[_j];
					repeat(array_length(_vb.__imageData)) {
						if (_vb.__imageData[_k] != undefined) {
							var _imageData = _vb.__imageData[_k];
							if (point_in_rectangle(_x, _y, _imageData.__x+_leftPad, _imageData.__y+_topPad, _imageData.__x+_rightPad, _imageData.__y+_bottomPad)) {
								array_push(_results, _imageData);	
							} 
						}
						++_k;
					}	
					++_j;
				}
			}
			
			++_i;
		}
		
		if (_sortByDepth) {
			array_sort(_results, function(_elmA, _elmB) {
				return _elmA.__depth - _elmB.__depth;
			});
		}
		
		return _results;
	}
	
	static Clear = function() {
		var _i = 0;
		var _j = 0;
		repeat(array_length(__regions)) {
			__regions[_i].__Destroy();
			++_i;
		}
		array_resize(__regions, 0);
		return self;
	}
	
	// @param {Real} x
	// @param {Real} y
	static ClearRegion = function(_x, _y) {
		var _signX = sign(_x);
		var _signY = sign(_y);
		var _xCell = ((_x div __regionWidth) * __regionWidth) - (_signX != -1 ? 0 : __regionWidth);
		var _yCell = ((_y div __regionHeight) * __regionHeight) - (_signY != -1 ? 0 : __regionHeight);
		var _i = 0;
		repeat(array_length(__regions)) {
			if (__regions[_i].__x == _xCell) && (__regions[_i].__y == _yCell) {
				__regions[_i].__Destroy();
				array_delete(__regions, _i, 1);
				break;
			}
			++_i;
		}
		return self;
	}
	
	static Destroy = function() {
		Clear();
		__destroy = true;
	}
	
	static Update = function() {
		if (!__update) || (__destroyed) return;
		
		var _i = 0;
		var _j = 0;
		repeat(array_length(__regions)) {
			_j = 0;
			repeat(array_length(__regions[_i].__entries)) {
				__regions[_i].__entries[_j].__Update();	
				++_j;
			}
			++_i;
		}
		__update = false;
	}	
	
	/// @param {Real} x
	/// @param {Real} y
	/// @param {Real} width
	/// @param {Real} height
	static Draw = function(_x = camera_get_view_x(view_camera[view_current]), _y = camera_get_view_y(view_camera[view_current]), _width = camera_get_view_width(view_camera[view_current]), _height = camera_get_view_height(view_camera[view_current])) {
		if (__autoUpdate) Update();
		var _i = 0;
		var _xCell = ((_x div __regionWidth) * __regionWidth);
		var _yCell = ((_y div __regionHeight) * __regionHeight);
		var _wCell = _xCell + _width + (__regionWidth div 2)  + __paddingWidth;
		var _hCell = _yCell + _height + (__regionHeight div 2)  + __paddingHeight;
		_xCell -= __regionWidth;
		_yCell -= __regionHeight;
		repeat(array_length(__regions)) {
			var _entry = __regions[_i];
			if ((_entry.__x >= _xCell) && (_entry.__x-__paddingWidth <= _wCell)) && ((_entry.__y >= _yCell) && (_entry.__y-__paddingHeight <= _hCell)) {
				_entry.__Draw();
			}
			++_i;
		}
	}
	
	static __GetBufferClass = function(_x, _y, _spr, _texID, _imgID) {
		static _cacheX = 0;
		static _cacheY = 0;
		static _cacheTexID = -1;
		static _cacheRegion = undefined;	
		var _signX = sign(_x);
		var _signY = sign(_y);
		var _xCell = ((_x div __regionWidth) * __regionWidth) - (_signX != -1 ? 0 : __regionWidth);
		var _yCell = ((_y div __regionHeight) * __regionHeight) - (_signY != -1 ? 0 : __regionHeight);
		var _i =0;
		var _j = 0;
		var _vb = undefined;
		var _region = undefined;
		
		if (_cacheTexID == _texID) && (_cacheX == _xCell) && (_cacheY == _xCell) && (_cacheRegion != undefined) {
			if (!_cacheRegion.__destroyed) {
				_i = 0;
				repeat(array_length(_cacheRegion.__entries)) {
					if (_cacheRegion.__entries[_i].__texID == _texID) {
						_vb = _cacheRegion.__entries[_i];	
						_region = _cacheRegion;
						break;
					}
					++_i;
				}
			}
		}
		
		if (_vb == undefined) && (_region == undefined) {
			_i = 0;
			repeat(array_length(__regions)) {
				if (__regions[_i].__x == _xCell) && (__regions[_i].__y == _yCell) {
					_region = __regions[_i];	
					_j = 0;
					repeat(array_length(_region.__entries)) {
						if (_region.__entries[_j].__texID == _texID) {
							_vb = _region.__entries[_j];	
							break;
						}
						++_j;
					}
					break;
				}
				++_i;
			}
			
			if (_region == undefined) {
				_region = new __StickersRegionClass(_xCell, _yCell, self);	
				array_push(__regions, _region);
			}
			
			if (_vb == undefined) {
				_vb = _region.__AddEntry(__distribute ? 1 : __maxSize, _texID, sprite_get_texture(_spr, _imgID));
				//array_push(_region.__entries, _vb);
				if (__distribute) {
					__maxDistributeSize = (max(ceil(__maxStickers / array_length(__regions)), 1))*__STICKERS_VFORMAT_VERTICES_SIZE;
					_i = 0;
					repeat(array_length(__regions)) {
						__regions[_i].__SetMax(__maxDistributeSize);
						++_i;	
					}
				}
			}
		}
		
		_cacheX = _xCell;
		_cacheY = _yCell;
		_cacheTexID = _texID;
		_cacheRegion = _region;
		
		var _bufferPos = _vb.__stickerCount*__STICKERS_VFORMAT_VERTICES_SIZE % __maxDistributeSize;
		buffer_seek(_vb.__buffer, buffer_seek_start, _bufferPos);	
		return _vb;
	}
}