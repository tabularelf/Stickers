function StickersPrecacheSprite() {
	var _i = 0;
	repeat(argument_count) {
		var _spr = argument[_i];
		__spriteCache[_spr] = __StickersCacheSprite(_spr);
		++_i;
	}
}