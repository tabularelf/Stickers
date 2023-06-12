#macro __STICKERS_VFORMAT_SIZE 24*6
#macro __STICKERS_CREDITS "@TabularElf - https://tabelf.link/"
#macro __STICKERS_VERSION "v1.0.0"

/// @ignore
function __StickersGlobal() {
	static _inst = undefined;
	
	if (_inst == undefined) {
		_inst = {
			spriteCache: ds_map_create()
		}	
		
		var _tags = tag_get_asset_ids("StickerDecal", asset_sprite);
		script_execute_ext(StickersPrecacheSprite, _tags);
	}
	
	return _inst;
}
global.StickersGlobal = __StickersGlobal();

show_debug_message("Stickers: " + __STICKERS_VERSION + " initialized! By " + __STICKERS_CREDITS);