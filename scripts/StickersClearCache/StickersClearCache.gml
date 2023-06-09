/// @func StickersClearCache
function StickersClearCache() {
	static __global = __StickersGlobal();
	ds_map_clear(__global.spriteCache);
}