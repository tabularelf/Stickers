/// feather ignore all
/// @func StickersClearCacheSprite
/// @param {Asset.GMSprite} sprite
function StickersClearCacheSprite(_spr) {
	static __global = __StickersGlobal();
	ds_map_delete(__global.spriteCache, _spr);
}