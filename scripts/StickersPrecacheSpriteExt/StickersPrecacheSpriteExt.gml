/// @param {Array<Asset.GMSprite>} array The array of sprites to cache ahead of time.
/// @param {Real} offset The offset of the array where you'd like to start from. The default is 0.
/// @param {Real} length The length of the array you'd like to end at. The default is the length of the array.
/// @self
/// @description Caches an entire array of sprite refs.
// Feather ignore all
function StickersPrecacheSpriteExt(_array, _offset = 0, _length = array_length(_array)) {
	script_execute_ext(StickersPrecacheSprite, _array, _offset, _length);
}