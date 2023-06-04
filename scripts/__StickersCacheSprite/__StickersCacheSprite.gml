/// @ignore
function __StickersCacheSprite(_spr) {
	static _global = __StickersGlobal();
	var _info = sprite_get_info(_spr);
	var _struct = {
		numFrames: _info.num_subimages,
		texIDs: array_create(_info.num_subimages)
	}
	
	var _i = 0;
	repeat(_info.num_subimages) {
		_struct.texIDs[_i] = _info.frames[_i].texture;	
		++_i;
	}
	
	return _struct;
}