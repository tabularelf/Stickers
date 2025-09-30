/// @param {Asset.GMSprite} sprite The sprite/s to clear from the cache.
// Feather ignore all
function StickersClearCacheSprite() {
	static _spriteCache = __StickersGlobal().spriteCache;
	var _cache = _spriteCache;
	var _i = 0;
	repeat(argument_count) {
		if (__STICKERS_PRECACHE_VALIDATE_SPRITE) && ((!is_handle(_spr)) || (!sprite_exists(_spr))) {
			__StickersError($"Received an invalid type from argument {_i}. Got \"{typeof(_spr)}\", expected, \"ref sprite\".")
		}
		ds_map_delete(_cache, argument[_i]);
		++_i;
	}
}