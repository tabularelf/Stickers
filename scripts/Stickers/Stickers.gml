/// @func Stickers(max_stickers)
function Stickers(_max = 1024) constructor {
	static _global = __StickersGlobal();
	if (_max <= 0) {
		__StickersError("Max stickers cannot be less than 1!");
	}
	__maxStickers = _max;
	__maxSize = _max*__STICKERS_VFORMAT_SIZE;
	__vbArray = [];
	__stickers = array_create(_max); // Initial Buffer
	__freeze = true;
	__distribute = false;
	__maxDistributeSize = __maxSize;
	__update = false;
	array_resize(__stickers, 0);
	static __spriteCache = [];
	
	static GetSize = function() {
		return array_length(__vbArray)*__maxDistributeSize;	
	}
	
	static GetMax = function() {
		return __maxStickers;	
	}
	
	static SetMax = function(_max) {
		if (__maxStickers == _max) return self;
		if (_max <= 0) {
			__StickersError("Max stickers cannot be less than 1!");
		}
		__maxStickers = max(_max, array_length(__vbArray));	
		__maxSize = __maxStickers*__STICKERS_VFORMAT_SIZE;
		__maxDistributeSize = __distribute ? (max(ceil(__maxSize / array_length(__vbArray)), __STICKERS_VFORMAT_SIZE)) : __maxSize;
		var _i = 0;
		repeat(array_length(__vbArray)) {
			buffer_resize(__vbArray[_i].__buffer, __maxDistributeSize);
			__vbArray[_i].__cacheDirty = true;
			__vbArray[_i].__Update();
			++_i;	
		}
	}
	
	static SetFreeze = function(_freeze) {
		__freeze = _freeze;	
		return self;
	}
	
	static Add = function(_spr, _img, _x, _y, _depth = 0) {
		var _inst = __StickersGetSpriteStruct();
		_inst.Update(_spr, _img, _x, _y, 1, 1, 0, c_white, 1, _depth);
		array_push(__stickers, _inst);
		__update = true;
		return self;
	}
	
	static AddExt = function(_spr, _img, _x, _y, _xscale, _yscale, _ang, _col, _alpha, _depth = 0) {
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
			array_push(_global.__StickersSpriteList, __stickers[_i]);
			++_i;
		}
		array_resize(__stickers, 0);
		return self;
	}
	
	static Update = function() {
		if (!__update) return;
		var _i = 0;
		repeat(array_length(__stickers)) {
			var _inst = __stickers[_i];
			var _spr = _inst.sprite;
			if (_spr > array_length(__spriteCache)-1) {
				__spriteCache[_spr] = sprite_get_info(_spr);	
			}
			
			var _struct = __spriteCache[_spr];
			var _texID = _struct.frames[_inst.image].texture;
			var _j = 0;
			var _vb = undefined;
			repeat(array_length(__vbArray)) {
				if (__vbArray[_j].__texID == _texID) {
					_vb = __vbArray[_j];
					break;
				}
				++_j;
			}
			
			if (_vb == undefined) {
				_vb = new __StickersBuffer(__distribute ? 1 : __maxSize, _texID);
				array_push(__vbArray, _vb);
				if (__distribute) {
					__maxDistributeSize = max(ceil(__maxSize div array_length(__vbArray)), __maxSize);
					var _k = 0;
					repeat(array_length(__vbArray)) {
						buffer_resize(__vbArray[_k].__buffer, __maxDistributeSize);
						++_k;	
					}
				}
			}
			
			if (buffer_tell(_vb.__buffer) >= __maxDistributeSize) {
				buffer_seek(_vb.__buffer, buffer_seek_start, 0);	
			}
			__StickersSpritePrep(_vb.__buffer, _inst.sprite, _inst.image, _inst.x, _inst.y, _inst.depth, _inst.xScale, _inst.yScale, _inst.angle, _inst.colour, _inst.alpha);
			_vb.__cacheDirty = true;
			array_push(_global.__StickersSpriteList, __stickers[_i]);
			++_i;
		}
		
		array_resize(__stickers, 0);
		
		_i = 0;
		repeat(array_length(__vbArray)) {
			__vbArray[_i].__Update(__freeze);
			++_i;
		}
		__update = false;
	}	
	
	static Draw = function() {
		var _i = 0;
		repeat(array_length(__vbArray)) {
			__vbArray[_i].__Draw();
			++_i;
		}
	}
}