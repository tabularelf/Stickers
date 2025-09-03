// Feather ignore all
// @ignore
function __StickersCacheGetSprite(_sprite) {
	gml_pragma("forceinline");
	if (__STICKERS_CACHE_CHECK_EXISTENCE) {
		if (!ds_map_exists(__spriteCache, _sprite)) {
			__StickersError($"Sprite \"{(is_handle(_sprite) && (sprite_exists(_sprite))) ? sprite_get_name(_sprite) : typeof(_sprite)}\" not found! Please call \"{nameof(StickersPrecacheSprite)}()\", \"{nameof(StickersPrecacheSpriteExt)}()\",\nor set \"{nameof(__STICKERS_AUTO_PRECACHE)}\" to \"true\" in \"{nameof(__StickersConfig)}\"!")
			return;
		}
	}
	return __spriteCache[? _sprite];
}