/// @ignore
/// feather ignore all
function __StickersCacheSpriteClass(_spr) constructor {
	static _global = __StickersGlobal();
	var _info = sprite_get_info(_spr);
	numFrames = _info.num_subimages;
	//texIDs = array_create(_info.num_subimages);
	uvs = array_create(_info.num_subimages);
	//xoffset = -sprite_get_xoffset(_spr);
	//yoffset = -sprite_get_yoffset(_spr);
	//width = sprite_get_width(_spr);
	//height = sprite_get_height(_spr);
	
	var _i = 0;
	repeat(numFrames) {
		var _uvs = sprite_get_uvs(_spr, _i);
		uvs[_i] = {
			xoffset: -sprite_get_xoffset(_spr) + _uvs[4],
			yoffset: -sprite_get_yoffset(_spr) + _uvs[5],
			width: sprite_get_width(_spr) * _uvs[6],
			height: sprite_get_height(_spr) * _uvs[7],
			left: _uvs[0],
			top: _uvs[1],
			right: _uvs[2],
			bottom: _uvs[3],
			texture: _info.frames[_i].texture,
			leftWidth: 0,
			rightHeight: 0,
		};
		uvs[_i].leftWidth = -uvs[_i].xoffset + uvs[_i].width;
		uvs[_i].rightHeight = -uvs[_i].yoffset + uvs[_i].height;
		++_i;
	}
}