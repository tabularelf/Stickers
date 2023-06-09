/// @ignore
/// feather ignore all
function __StickersBufferClass(_max, _texID, _texPtr, _x, _y, _owner) constructor {
	static __vFormat = __StickersVFormat();
	__owner = _owner;
	// We need to store two versions of the texture ID... All because of HTML5. This is utterly stupid. Thanks YYG! /s
	__texID = _texID;
	__texPtr = _texPtr;
	__cacheDirty = false;
	__buffer = buffer_create(_max, buffer_fixed, 1);
	__vbuffer = -1;
	__stickerCount = 0;
	
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
		// Dynamic texture pages seem to do just fine as long as you at least prefetch before submitting a vertex buffer.
		// As it'll invoke the fallback sprite in place for a frame. Interesting nonetheless!
		
		if (!texture_is_ready(__texID)) {
			texture_prefetch(__texID);
		}
		
		if (__vbuffer != -1) vertex_submit(__vbuffer, pr_trianglelist, __texPtr);	
	}
}