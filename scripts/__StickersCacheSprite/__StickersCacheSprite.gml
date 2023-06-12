/// @ignore
function __StickersCacheSprite(_spr) constructor {
	static _global = __StickersGlobal();
	var _info = sprite_get_info(_spr);
	numFrames = _info.num_subimages;
	texIDs = array_create(_info.num_subimages);
	uvs = array_create(_info.num_subimages);
	xoffset = -sprite_get_xoffset(_spr);
	yoffset = -sprite_get_yoffset(_spr);
	width = sprite_get_width(_spr);
	height = sprite_get_height(_spr);
	
	var _i = 0;
	repeat(_info.num_subimages) {
		texIDs[_i] = _info.frames[_i].texture;	
		uvs[_i] = sprite_get_uvs(_spr, _i);
		++_i;
	}
}