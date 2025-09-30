/// @description Clears all vertex buffers that are in the recycling bin!
// Feather ignore all
function StickersClearRecycling() {
	if (!__STICKERS_RECYCLE_VERTEX_BUFFERS) {
		__StickersTrace($"Recycler is not enabled! Please enable it under \"{nameof(__STICKERS_RECYCLE_VERTEX_BUFFERS)}\" in \"{nameof(__StickersConfig)}\"");
		return;
	}

	var _recycler = __StickersGlobal().vBuffRecycler;
	array_foreach(_recycler, function(_elm, _index) {
		_elm.__Cleanup();
	});
	array_resize(_recycler, 0);
}