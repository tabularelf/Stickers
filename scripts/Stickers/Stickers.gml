/// @func Stickers(maxStickers, [distribute])
/// @param {Real} maxStickers
/// @param {Bool} distribute
function Stickers(_max, _distribute = false) constructor {
	static _global = __StickersGlobal();
	if (_max <= 0) {
		__StickersError("Max stickers cannot be less than 1!");
	}
	__maxStickers = _max;
	__maxSize = _max*__STICKERS_VFORMAT_SIZE;
	__vbArray = [];
	__stickers = array_create(_max); // Initial Buffer
	__freeze = false;
	__distribute = _distribute;
	__maxDistributeSize = __maxSize;
	__update = false;
	__regionWidth = 1024;
	__regionHeight = 1024;
	__paddingWidth = 128;
	__paddingHeight = 128;
	__spritesLoading = [];
	__debug = false;
	__autoUpdate = true;
	__destroyed = false;
	array_resize(__stickers, 0);
	static __global = __StickersGlobal();
	
	static GetSize = function() {
		return array_length(__vbArray)*__maxDistributeSize;	
	}
	
	/// @param {Bool} freeze
	static SetFreeze = function(_freeze) {
		if (__destroyed) return;
		if (__freeze = _freeze) return self;
		__freeze = _freeze;	
		var _i = 0;
		repeat(array_length(__vbArray)) {
			var _entry = __vbArray[_i];
			_entry.__cacheDirty = true;
			_entry.__Update();
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
		repeat(array_length(__vbArray)) {
			var _entry = __vbArray[_i];
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
		__maxSize = __maxStickers*__STICKERS_VFORMAT_SIZE;
		__maxDistributeSize = __distribute ? (max(ceil(__maxStickers / array_length(__vbArray)), 1))*__STICKERS_VFORMAT_SIZE : __maxSize;
		var _i = 0;
		repeat(array_length(__vbArray)) {
			buffer_resize(__vbArray[_i].__buffer, __maxDistributeSize);
			__vbArray[_i].__cacheDirty = true;
			__vbArray[_i].__Update();
			++_i;	
		}
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
		var _inst = __StickersGetSpriteStruct();
		_inst.Update(_spr, _img, _x, _y, _xscale, _yscale, _ang, _col, _alpha, _depth);
		array_push(__stickers, _inst);
		__update = true;
		return self;
	}
	
	static Clear = function() {
		var _i = 0;
		repeat(array_length(__vbArray)) {
			__vbArray[_i].__Destroy();
			++_i;
		}
		array_resize(__vbArray, 0);
		
		_i = 0;
		repeat(array_length(__stickers)) {
			array_push(_global.spriteList, __stickers[_i]);
			++_i;
		}
		array_resize(__stickers, 0);
		return self;
	}
	
	static ClearRegion = function(_x, _y) {
		var _signX = sign(_x);
		var _signY = sign(_y);
		var _xCell = ((_x div __regionWidth) * __regionWidth) - (_signX != -1 ? 0 : __regionWidth);
		var _yCell = ((_y div __regionHeight) * __regionHeight) - (_signY != -1 ? 0 : __regionHeight);
		var _i = 0;
		repeat(array_length(__vbArray)) {
			if (__vbArray[_i].__x == _xCell) && (__vbArray[_i].__y == _yCell) {
				__vbArray[_i].__Destroy();
				array_delete(__vbArray, _i, 1);
				--_i;
			}
			++_i;
		}	
	}
	
	static Destroy = function() {
		Clear();
		__destroy = true;
	}
	
	static Update = function() {
		if (!__update) || (__destroyed) return;
		var _i = 0;
		repeat(array_length(__stickers)) {
			var _inst = __stickers[_i];
			var _spr = _inst.sprite;
			if (!ds_map_exists(__global.spriteCache, _spr)) {
				__global.spriteCache[? _spr] = __StickersCacheSprite(_spr);
			}
			
			var _struct = __global.spriteCache[? _spr];
			var _imgID = _inst.image % _struct.numFrames;
			var _texID = _struct.texIDs[_imgID];
			var _signX = sign(_inst.x);
			var _signY = sign(_inst.y);
			var _x = ((_inst.x div __regionWidth) * __regionWidth) - (_signX != -1 ? 0 : __regionWidth);
			var _y = ((_inst.y div __regionHeight) * __regionHeight) - (_signY != -1 ? 0 : __regionHeight);
			var _j = 0;
			var _vb = undefined;
			repeat(array_length(__vbArray)) {
				if (__vbArray[_j].__texID == _texID) && (__vbArray[_j].__x = _x) && (__vbArray[_j].__y = _y) {
					_vb = __vbArray[_j];
					break;
				}
				++_j;
			}
			
			if (_vb == undefined) {
				_vb = new __StickersBufferClass(__distribute ? 1 : __maxSize, _texID, sprite_get_texture(_spr, _imgID), _x, _y, self);
				array_push(__vbArray, _vb);
				if (__distribute) {
					__maxDistributeSize = (max(ceil(__maxStickers / array_length(__vbArray)), 1))*__STICKERS_VFORMAT_SIZE;
					var _k = 0;
					repeat(array_length(__vbArray)) {
						buffer_resize(__vbArray[_k].__buffer, __maxDistributeSize);
						++_k;	
					}
				}
			}
			
			buffer_seek(_vb.__buffer, buffer_seek_start, _vb.__stickerCount*__STICKERS_VFORMAT_SIZE % __maxSize);	
			__StickersSpritePrep(_vb.__buffer, _struct, _imgID, _inst.x, _inst.y, _inst.depth, _inst.xScale, _inst.yScale, _inst.angle, _inst.colour, _inst.alpha);
			++_vb.__stickerCount;
			_vb.__cacheDirty = true;
			array_push(_global.spriteList, __stickers[_i]);
			++_i;
		}
		
		array_resize(__stickers, 0);
		
		_i = 0;
		repeat(array_length(__vbArray)) {
			__vbArray[_i].__Update();
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
		var _wCell = _xCell + _width + (__regionWidth div 2) /*((_width div __regionWidth) * __regionWidth)*/ + __paddingWidth;
		var _hCell = _yCell + _height + (__regionHeight div 2) /**((_height div __regionWidth) * __regionWidth)*/ + __paddingHeight;
		_xCell -= __regionWidth;
		_yCell -= __regionHeight;
		repeat(array_length(__vbArray)) {
			var _entry = __vbArray[_i];
			if ((_entry.__x >= _xCell) && (_entry.__x-__paddingWidth <= _wCell)) && ((_entry.__y >= _yCell) && (_entry.__y-__paddingHeight <= _hCell)) {
				_entry.__Draw();
			}
			++_i;
		}
	}
}