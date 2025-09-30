// Feather ignore all
/// @ignore
function __StickersSpriteCacheClass(_spr) constructor {
	var _info = sprite_get_info(_spr);
	numFrames = _info.num_subimages;
	uvs = array_create(_info.num_subimages);
	sprite = _spr;
	
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
			texturePtr: sprite_get_texture(_spr, _i),
			leftWidth: 0,
			topHeight: 0,
		};
		uvs[_i].leftWidth = uvs[_i].xoffset + uvs[_i].width;
		uvs[_i].topHeight = uvs[_i].yoffset + uvs[_i].height;
		++_i;
	}

	static GetUVs = function(_index) {
		if (__STICKERS_IMAGE_INDEX_MODULO == 2) {
			var _remainder = _index % numFrames;
			return uvs[_remainder + (numFrames & (-(_remainder < 0)))];
		} else if (__STICKERS_IMAGE_INDEX_MODULO == 1) {
			return uvs[_index % numFrames];
		} else if (__STICKERS_IMAGE_INDEX_MODULO == 0) {
			return uvs[_index];
		} else {
			__StickersError($"Please set \"{nameof(__STICKERS_IMAGE_INDEX_MODULO)}\" to a valid value in \"{nameof(__StickersConfig)}\"... (See Comments.)");
			return;
		}
	}
}