// Feather ignore all
/// @ignore
function __StickersFindRegion(_x, _y) {
	gml_pragma("forceinline");
	var _xCell = ((_x div __regionWidth) * __regionWidth) - (_x >= 0 ? 0 : __regionWidth);
	var _yCell = ((_y div __regionHeight) * __regionHeight) - (_y >= 0 ? 0 : __regionHeight);
	var _i =0;
	var _j = 0;
	var _region = undefined;
	
	if (__cacheX == _xCell) && (__cacheY == _yCell) && (!is_undefined(__cacheRegion)) {
		if (!__cacheRegion.__destroyed) {
            return __cacheRegion;
		}
	}

	_i = 0;
	repeat(array_length(__regions)) {
		if (__regions[_i].__x == _xCell) && (__regions[_i].__y == _yCell) {
			_region = __regions[_i];	
			break;
		}
		++_i;
	}
	
	if (is_undefined(_region)) {
		if (__STICKERS_VERBOSE) __StickersTrace($"{GetName()} - Region at x cell \"{_xCell}\", y cell \"{_yCell}\" doesn't exist. Creating a new one...");
		_region = new __StickersRegionClass(_xCell, _yCell, self);	
		array_push(__regions, _region);
	}
	
	var _oldXCell = __cacheX;
	var _oldYCell = __cacheY;
	__cacheX = _xCell;
	__cacheY = _yCell;
	__cacheRegion = _region;
       
	if (__STICKERS_OPTIMIZE_APPEND) && (__lastSortTime < get_timer()) && (array_length(__regions) > 1) {
		__lastSortTime = get_timer() + __STICKERS_OPTIMIZE_APPEND_TIME_MS;
		if (abs(_oldXCell - _xCell) > __regionWidth-(__paddingWidth div 2)) || (abs(_oldYCell - _yCell) > __regionHeight-(__paddingHeight div 2)) {
			if (__STICKERS_VERBOSE) __StickersTrace($"{GetName()} - Sorting regions at {_xCell}, {_yCell}!");
			SortRegions(_xCell, _yCell);
		}
	}
	
	return _region;
}