function __StickersGetSpriteStruct() {
	static _global = __StickersGlobal();
	if (array_length(_global.__StickersSpriteList) > 0) {
		var _inst = _global.__StickersSpriteList[0];
		array_delete(_global.__StickersSpriteList, 0, 1);
		return _inst;
	}
	
	return new __StickersSpriteStruct(-1, 0, 0, 0, 0, 0, 0, 0, 0, 0);
}