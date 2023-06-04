// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function StickersPrecacheSprite() {
	var _i = 0;
	repeat(argument_count) {
		var _spr = argument[_i];
		__spriteCache[_spr] = __StickersCacheSprite(_spr);
		++_i;
	}
}