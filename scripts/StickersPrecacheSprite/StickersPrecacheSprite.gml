/// @param {Asset.GMSprite} sprite The sprite to precache ahead of time.
/// @param {Asset.GMSprite} ...
// Feather ignore all
function StickersPrecacheSprite(_sprite) {
	static _spriteCache = __StickersGlobal().spriteCache;
	var _cache = _spriteCache;
	var _i = 0;
	repeat(argument_count) {
		_sprite = argument[_i];
		if (__STICKERS_PRECACHE_VALIDATE_SPRITE) && ((!is_handle(_sprite)) || (!sprite_exists(_sprite))) {
			__StickersError($"Received an invalid type from argument {_i}. Got \"{typeof(_sprite)}\", expected, \"ref sprite\".")
		}
		if (!ds_map_exists(_cache, _sprite)) {
			_cache[? _sprite] = new __StickersSpriteCacheClass(_sprite);
		}
		++_i;
	}
}