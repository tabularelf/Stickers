/// feather ignore all
/// @func StickersPrecacheSprite(...)
/// @param {Asset.GMSprite} sprite
function StickersPrecacheSprite() {
	static __global = __StickersGlobal();
	var _i = 0;
	repeat(argument_count) {
		var _spr = argument[_i];
		if (!ds_map_exists(__global.spriteCache, _spr)) {
			__global.spriteCache[? _spr] = new __StickersCacheSpriteClass(_spr);
		}
		++_i;
	}
}