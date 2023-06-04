/// @func StickersClearCache
function StickersClearCache() {
	static __global = __StickersGlobal();
	__global.spriteCache = {};
}