// Feather ignore all
/// @ignore
function __StickersGetVBuffer(_frozen, _size, _texId, _texPtr, _owner, _regionOwner) {
	static _recycler = __StickersGlobal().vBuffRecycler;
	if (__STICKERS_RECYCLE_VERTEX_BUFFERS) && (array_length(_recycler) > 0) {
		var _i = 0;
		repeat(array_length(_recycler)) {
			if (_recycler[_i].__size == _size) {
				var _vBuffer = _recycler[_i].__HardReset(_frozen, _size, _texId, _texPtr, _owner, _regionOwner);
				array_delete(_recycler, _i, 1);
				return _vBuffer;
			}
			++_i;
		}
	}
	return new __StickersBufferClass(_frozen, _size, _texId, _texPtr, _owner, _regionOwner);
}