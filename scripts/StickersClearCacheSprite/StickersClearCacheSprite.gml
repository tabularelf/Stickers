/// feather ignore all
/// @func StickersClearCacheSprite(...)
/// @param {Asset.GMSprite} sprite
function StickersClearCacheSprite() {
	static __global = __StickersGlobal();
	var _i = 0;
	repeat(argument_count) {
		ds_map_delete(__global.spriteCache, argument[_i]);
		++_i;
	}
}