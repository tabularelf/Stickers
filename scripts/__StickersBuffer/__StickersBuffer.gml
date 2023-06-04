function __StickersBuffer(_max, _texID, _x, _y, _owner) constructor {
	static __vFormat = __StickersVFormat();
	__owner = _owner;
	__texID = _texID;
	__x = _x;
	__y = _y;
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
	
	static __Update = function() {
		if (__cacheDirty) {
			if (__vbuffer != -1) {
				vertex_delete_buffer(__vbuffer);
			}
			
			__vbuffer = vertex_create_buffer_from_buffer(__buffer, __vFormat);
			__cacheDirty = false;
			if (__owner.__freeze) {
				vertex_freeze(__vbuffer);	
			}
		}
	}
	
	static __Draw = function() {
		if (__vbuffer != -1) vertex_submit(__vbuffer, pr_trianglelist, __texID);	
	}
}