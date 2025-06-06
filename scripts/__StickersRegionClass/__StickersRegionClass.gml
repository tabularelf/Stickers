/// @ignore
/// feather ignore all
function __StickersRegionClass(_x, _y, _owner) constructor {
	__owner = _owner;
	__x = _x;
	__y = _y;
	__entries = [];
	__destroyed = false;
	__forceRefresh = false;
	
	static __AddEntry = function(_max, _texID, _texPtr) {
		var _entry = new __StickersBufferClass(_max, _texID, _texPtr, __x, __y, __owner, self);
		array_push(__entries, _entry);
		return _entry;
	}
	
	static __ForceUpdate = function() {
		var _i = 0;
		repeat(array_length(__entries)) {
			__entries[_i].__cacheDirty = true;
			__entries[_i].__Update();
			++_i;
		}
	}
	
	static __SetMax = function(_max) {
		var _i = 0;
		repeat(array_length(__entries)) {
			var _oldSize = buffer_get_size(__entries[_i].__buffer);
			buffer_resize(__entries[_i].__buffer, _max);
			__entries[_i].__maxSize = _max;
			
			if (_max > _oldSize) {
				__entries[_i].__cacheDirty = true;	
				__entries[_i].__Update();
			}
			++_i;	
		}	
	}
	
	static __Clear = function() {
		var _i = 0;
		repeat(array_length(__entries)) {
			__entries[_i].__Destroy();	
			++_i;
		}
	}
	
	static __Destroy = function() {
		__Clear();
		__destroyed = true;	
	}
	
	
	static __Draw = function() {
		if (__destroyed) return;
		if (__owner.__debug) {
			draw_text(8+__x, 8+__y, "X: " + string(__x) + " Y: " + string(__y));
			var _col = frac(sin((__x + (__y*__owner.__regionWidth)) * 0.132716) * 43758.5453)*255;
			_col = make_color_hsv(_col, 255, 100);
			draw_rectangle_colour(__x, __y, __x+__owner.__regionWidth, __y+__owner.__regionHeight, _col, _col, _col, _col, true);
		}	
		
		var _i = 0;
		repeat(array_length(__entries)) {
			if (__forceRefresh) {
				var _entry = __entries[_i];
				var _size = buffer_get_size(_entry.__buffer);
				buffer_resize(_entry.__buffer, 0);
				buffer_resize(_entry.__buffer, _size);
				var _j = 0;
				repeat(array_length(_entry.__imageData)) {
					if (_entry.__imageData[_i] != undefined) {
						_entry.__imageData[_i].Update();
					}
					++_j;
				}
				__ForceUpdate();
			}
			__entries[_i].__Draw();
			++_i;
		}
		__forceRefresh = false;
	}
}