// Feather ignore all
/// @ignore
function __StickersBufferClass(_frozened, _size, _texId, _texPtr, _owner, _regionOwner) constructor {
	static _recycler = __StickersGlobal().vBuffRecycler;
	static _copyVBuff = __STICKERS_STACK_ON_TOP ? vertex_create_buffer() : undefined;
	__format = __StickersVFormat();
	__writeVBuff = vertex_create_buffer_ext(144);
	__mainVBuff = vertex_create_buffer_ext(_size*144);
	__freezeVBuff = undefined;
	__HardReset(_frozened, _size, _texId, _texPtr, _owner, _regionOwner);
	if (__STICKERS_ALLOW_EXPORT) {
		__imageIndex = array_create(_size);
	}
	
	if (__STICKERS_STORE_IMAGE_DATA) {
		__imageData = array_create(_size, undefined);
	}

	static __HardReset = function(_frozened, _size, _texId, _texPtr, _owner, _regionOwner) {
		__owner = _owner;
		__regionOwner = _regionOwner;
		__destroyed = false;
		__texId = _texId;
		__texPtr = _texPtr;
		__size = _size;
		__verticeSize = __size * __STICKERS_VERTICE_COUNT;
		__frozened = _frozened;
		__dirty = false;
		__pos = 0;
		__startPos = 0;
		__loopedOnce = false;
		vertex_begin(__mainVBuff, __format);
		vertex_position_3d(__mainVBuff, 0, 0, 0);
		vertex_color(__mainVBuff, 0, 0);
		vertex_texcoord(__mainVBuff, 0, 0);
		
		vertex_position_3d(__mainVBuff, 0, 0, 0);
		vertex_color(__mainVBuff, 0, 0);
		vertex_texcoord(__mainVBuff, 0, 0);
		
		vertex_position_3d(__mainVBuff, 0, 0, 0);
		vertex_color(__mainVBuff, 0, 0);
		vertex_texcoord(__mainVBuff, 0, 0);
		vertex_end(__mainVBuff);

		vertex_begin(__writeVBuff, __format);
		vertex_position_3d(__writeVBuff, 0, 0, 0);
		vertex_color(__writeVBuff, 0, 0);
		vertex_texcoord(__writeVBuff, 0, 0);
		
		vertex_position_3d(__writeVBuff, 0, 0, 0);
		vertex_color(__writeVBuff, 0, 0);
		vertex_texcoord(__writeVBuff, 0, 0);
		
		vertex_position_3d(__writeVBuff, 0, 0, 0);
		vertex_color(__writeVBuff, 0, 0);
		vertex_texcoord(__writeVBuff, 0, 0);
		vertex_end(__writeVBuff);

		return self;
	}

	static __TryUpdate = function() {
		if (__destroyed) return;
		if (__dirty) {
			vertex_end(__writeVBuff);
			__dirty = false;

			if (!is_undefined(__freezeVBuff)) {
				vertex_delete_buffer(__freezeVBuff);
				__freezeVBuff = undefined;
			}

			if (__STICKERS_STACK_ON_TOP) && (__loopedOnce) {
				// Doing a lot of vertex buffer trickery to allow stacking decals on top of one another...
				// Wow!
				var _offset = ((__pos*__STICKERS_VERTICE_COUNT)-__startPos);
				var _offsetWithSize = max(__verticeSize - _offset, 0);
				vertex_update_buffer_from_vertex(_copyVBuff, 0, __mainVBuff, 0, __verticeSize);
				
				if (_offsetWithSize != 0) vertex_update_buffer_from_vertex(__mainVBuff, 0, _copyVBuff, _offset, _offsetWithSize);


				vertex_update_buffer_from_vertex(__mainVBuff, _offsetWithSize, __writeVBuff);
			} else {
				vertex_update_buffer_from_vertex(__mainVBuff, __startPos, __writeVBuff);
			}
			
		}
	}

	static __Cleanup = function() {
		vertex_delete_buffer(__writeVBuff);
		vertex_delete_buffer(__mainVBuff);
	}

	static __Destroy = function() {
		if (__regionOwner.__cacheVBuffer == self) {
			__regionOwner.__cacheVBuffer = undefined;
		}
		__regionOwner = undefined;
		__owner = undefined;
		if (!__STICKERS_RECYCLE_VERTEX_BUFFERS) {
			__Cleanup();
		} else {
			array_push(_recycler, self);
		}
		if (!is_undefined(__freezeVBuff)) {
			vertex_delete_buffer(__freezeVBuff);
			__freezeVBuff = undefined;
		}
		
		__destroyed = true;
	}

	static __Draw = function() {
		if (__destroyed) return;
		__TryUpdate();

		if (__STICKERS_AUTO_FETCH_TEXTURE) {
			if (!texture_is_ready(__texId)) {
				texture_prefetch(__texId);
			}
		}

		if (__frozened) {
			if (is_undefined(__freezeVBuff)) {
				__freezeVBuff = vertex_create_buffer();
				vertex_update_buffer_from_vertex(__freezeVBuff, 0, __mainVBuff);
				vertex_freeze(__freezeVBuff);
			}
			
			vertex_submit(__freezeVBuff, pr_trianglelist, __texPtr);
		} else {
			vertex_submit(__mainVBuff, pr_trianglelist, __texPtr);
		}
	}
}