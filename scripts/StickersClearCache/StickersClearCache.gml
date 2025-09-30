// Feather ignore all

/// @description Clears all sprites from the cache.
function StickersClearCache() {
	static _spriteCache = __StickersGlobal().spriteCache;
	ds_map_clear(_spriteCache);
}