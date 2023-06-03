function __StickersBuffer(_max, _texID) constructor {
	static __vFormat = __StickerVFormat();
	__texID = _texID;
	__cacheDirty = false;
	__buffer = buffer_create(_max, buffer_fixed, 1);
	__vbuffer = -1;
	
	static __Destroy = function() {
		if (buffer_exists(__buffer)) {
			buffer_delete(__buffer);
			__buffer = -1;
		}
		
		if (__vbuffer != -1) {
			vertex_delete_buffer(__vbuffer);
			__vbuffer = -1;
		}
	}
	
	static __Update = function(_freeze = true) {
		if (__cacheDirty) {
			if (__vbuffer != -1) {
				vertex_delete_buffer(__vbuffer);
			}
			
			__vbuffer = vertex_create_buffer_from_buffer(__buffer, __vFormat);
			__cacheDirty = false;
			if (_freeze) {
				vertex_freeze(__vbuffer);	
			}
		}
	}
	
	static __Draw = function() {
		if (__vbuffer != -1) vertex_submit(__vbuffer, pr_trianglelist, __texID);	
	}
}