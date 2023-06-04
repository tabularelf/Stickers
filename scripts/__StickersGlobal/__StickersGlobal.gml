#macro __STICKERS_VFORMAT_SIZE 24*6
#macro __STICKERS_CREDITS "@TabularElf - https://tabelf.link/"
#macro __STICKERS_VERSION "v0.0.2"

function __StickersGlobal() {
	static _inst = {
		__StickersSpriteList: []
	}
	
	return _inst;
}


show_debug_message("Stickers: " + __STICKERS_VERSION + " initialized! By " + __STICKERS_CREDITS);