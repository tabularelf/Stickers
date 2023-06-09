/// @ignore
function __StickersCacheSprite(_spr) {
	static _global = __StickersGlobal();
	var _info = sprite_get_info(_spr);
	var _struct = {
		numFrames: _info.num_subimages,
		texIDs: array_create(_info.num_subimages),
		uvs: array_create(_info.num_subimages),
		xoffset: -sprite_get_xoffset(_spr),
		yoffset: -sprite_get_yoffset(_spr),
		width: sprite_get_width(_spr),
		height: sprite_get_height(_spr)
	}
	
	var _i = 0;
	repeat(_info.num_subimages) {
		_struct.texIDs[_i] = _info.frames[_i].texture;	
		_struct.uvs[_i] = sprite_get_uvs(_spr, _i);
		++_i;
	}
	
	return _struct;
}