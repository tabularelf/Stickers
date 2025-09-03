// Feather ignore all

#macro __STICKERS_VERSION "2.0.6"

#macro __STICKERS_DATE "31th July 2025"

#macro __STICKERS_CREDITS "@TabularElf - https://tabelf.link/"

#macro __STICKERS_FILE_HEADER "__STICKERS__"

#macro __STICKERS_VERTICE_COUNT 6

#macro __STICKERS_INCREMENT_POS with(_buffer) { \
	if (__destroyed) return; \
		if (__pos >= __size) { \ 
			__TryUpdate(); \
			__pos = 0; \
			if (__STICKERS_STACK_ON_TOP) { \
				__loopedOnce = true; \
			} \
		} \
		if (!__dirty) { \
			vertex_begin(__writeVBuff, __format); \
			__dirty = true; \
			__startPos = __pos*__STICKERS_VERTICE_COUNT; \
		} \
		__pos++; \
	}

#macro __STICKERS_PADDING_HANDLE if (__STICKERS_PADDING_DYNAMIC) { \
			var _width = (sprite_get_width(_sprite) div 2); \
			var _height = (sprite_get_height(_sprite) div 2); \
			if (_width > __owner.__paddingWidth) { \
				if (__STICKERS_VERBOSE) __StickersTrace($"{__owner.GetName()} - Padding width \"{__owner.__paddingWidth}\" too small, new size \"{_width}\""); \
				__owner.__paddingWidth = _width; \
				__owner.__regionWCell = (__owner.__regionWidth div 2)  + __owner.__paddingWidth; \
			} \
			if (_height > __owner.__paddingHeight) { \
				if (__STICKERS_VERBOSE) __StickersTrace($"{__owner.GetName()} - Padding height \"{__owner.__paddingHeight}\" too small, new size \"{_height}\""); \
				__owner.__paddingHeight = _height; \
				__owner.__regionHCell = (__owner.__regionHeight div 2)  + __owner.__paddingHeight; \
			} \
		}

#macro __STICKERS_PADDING_HANDLE_EXT if (__STICKERS_PADDING_DYNAMIC) { \
			var _width = ((sprite_get_width(_sprite)*_xScale) div 2); \
			var _height = ((sprite_get_height(_sprite)*_yScale) div 2); \
			if (_width > __owner.__paddingWidth) { \
				if (__STICKERS_VERBOSE) __StickersTrace($"{__owner.GetName()} - Padding width \"{__owner.__paddingWidth}\" too small, new size \"{_width}\""); \
				__owner.__paddingWidth = _width; \
				__owner.__regionWCell = (__owner.__regionWidth div 2)  + __owner.__paddingWidth; \
			} \
			if (_height > __owner.__paddingHeight) { \
				if (__STICKERS_VERBOSE) __StickersTrace($"{__owner.GetName()} - Padding height \"{__owner.__paddingHeight}\" too small, new size \"{_height}\""); \
				__owner.__paddingHeight = _height; \
				__owner.__regionHCell = (__owner.__regionHeight div 2)  + __owner.__paddingHeight; \
			} \
		}

/// @ignore
function __StickersGlobal() {
 	static _inst = undefined;
	if (is_struct(_inst)) return _inst;

	_inst = {
		spriteCache: ds_map_create(),
		vBuffRecycler: __STICKERS_RECYCLE_VERTEX_BUFFERS ? [] : undefined,
	};

	var _tags = tag_get_asset_ids("StickerDecal", asset_sprite);
	StickersPrecacheSpriteExt(_tags);

	return _inst;
}
__StickersGlobal();
show_debug_message($"Stickers: Initialized with verson v{__STICKERS_VERSION}, {__STICKERS_DATE}! Created by {__STICKERS_CREDITS}!");