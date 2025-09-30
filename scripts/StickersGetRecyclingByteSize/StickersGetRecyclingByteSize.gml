// Feather ignore all
/// @description Returns the vertex buffers recycling bin byte size
function StickersGetRecyclingByteSize(){
	if (!__STICKERS_RECYCLE_VERTEX_BUFFERS) return 0;
	
	with{_size: 0, __recycler: __StickersGlobal().vBuffRecycler} {
		array_foreach(__recycler, function(_elm, _index) {
			_size += vertex_get_buffer_size(_elm.__mainVBuff); 
			_size += vertex_get_buffer_size(_elm.__writeVBuff);
			if (_elm.__frozened) && (!is_undefined(_elm.__freezeVBuff)) {
				_size += vertex_get_buffer_size(_elm.__freezeVBuff);
			}
		});
		
		return _size;
	}
}