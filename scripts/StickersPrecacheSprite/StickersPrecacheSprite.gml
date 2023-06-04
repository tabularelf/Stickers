/// @func StickersPrecacheSprite
/// @param {Asset.GMSprite} sprites...
function StickersPrecacheSprite() {
	static __global = __StickersGlobal();
	var _i = 0;
	repeat(argument_count) {
		var _spr = argument[_i];
		__global.spriteCache[$ sprite_get_name(_spr)] = __StickersCacheSprite(_spr);
		++_i;
	}
}