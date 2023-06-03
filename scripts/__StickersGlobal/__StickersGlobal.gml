#macro __STICKERS_VFORMAT_SIZE 24*6

function __StickersGlobal() {
	static _inst = {
		__StickersSpriteList: []
	}
	
	return _inst;
}