/// @param {Real} maxDecals Max number of decals per region.
/// @param {Real} regionWidth The width of each region. Default is 1024.
/// @param {Real} regionHeight The height of each region. Default is 1024.
/// @param {Bool} freeze Whether vertex buffers should be frozened or not. (Recommended for a extremely large sticker count.) Default is false.
/// @param {String} name The name of the Stickers instance. Used explicitly for debugging purposes.
/// @self
// Feather ignore all
function Stickers(_size, _regionWidth = 1024, _regionHeight = 1024, _frozen = false, _name = "") constructor {
	__size = _size;
	__regions = [];
	__debug = false;
	__regionWidth = floor(_regionWidth);
	__regionHeight = floor(_regionHeight);
	__paddingWidth = 128;
	__paddingHeight = 128;
	__frozen = _frozen;
	__cacheX = 0;
	__cacheY = 0;
	__cacheTexId = -1;
	__cacheRegion = undefined;
	__regionWCell = (__regionWidth div 2)  + __paddingWidth;
	__regionHCell = (__regionHeight div 2)  + __paddingHeight;
	__lastSortTime = 0;
	__destroyed = false;
	__name = _name;

	/// @param {Bool} value The state of debug mode you wish to set.
	/// @self
	static SetDebug = function(_value) {
		__debug = _value;
		return self;
	}

	static Alive = function() {
		return !__destroyed;
	}

	static GetName = function() {
		return __name;
	}
	
	/// @description The state of debug mode that is currently set.
	/// @return {Bool}
	static GetDebug = function() {
		return __debug;
	}

	/// @description Destroys the Sticker instance.
	static Destroy = function() {
		if (__destroyed) return;
		Clear();
		__destroyed = true;
	}

	/// @param {Real} width width of padding.
	/// @param {Real} height height of padding.
	/// @description Sets the padding in which Stickers uses to include regions that are out of the current view, as provided to .Draw() and .DrawCamera().
	/// @self
	static SetPadding = function(_width, _height) {
		if (__destroyed) return;
		__paddingWidth = floor(_width);
		__padingHeight = floor(_height);
		__regionWCell = (__regionWidth div 2)  + __paddingWidth;
		__regionHCell = (__regionHeight div 2)  + __paddingHeight;
		return self;
	}

	/// @return {Real}
	/// @description Gets the region count.
	/// @self
	static GetRegionCount = function() {
		if (__destroyed) return 0;
		return array_length(__regions);
	}

	/// @return {Real}
	/// @description Gets the vertex buffer count.
	/// @self
	static GetVBufferCount = function() {
		if (__destroyed) return 0;
		with {__regions, count: 0} {
			array_foreach(__regions, function(_elm, _index) {
				count += array_length(_elm.__entries);
			});
			return count;
		}
	}

	/// @return {Real}
	/// @description Gets the region width.
	static GetRegionWidth = function() {
		return __regionWidth;
	}
	
	/// @description Gets the region height.
	/// @return {Real}
	static GetRegionHeight = function() {
		return __regionHeight;
	}

	/// @return {Real}
	/// @description Gets the current byte size of every vertex buffer.
	/// @self
	static GetByteSize = function() {
		if (__destroyed) return 0;
		with {_size: 0, __regions} {
			array_foreach(__regions, function(_elm, _index) {
				array_foreach(_elm.__entries, function(_elm, _index) {
					if (_elm.__destroyed) return;
					_size += vertex_get_buffer_size(_elm.__mainVBuff); 
					_size += vertex_get_buffer_size(_elm.__writeVBuff);
					if (_elm.__frozened) && (!is_undefined(_elm.__freezeVBuff)) {
						_size += vertex_get_buffer_size(_elm.__freezeVBuff);
					}
				});
			});
			
			return _size;
		}
	}

	/// @return {Real}
	static GetSize = function() {
		if (__destroyed) return 0;
		return array_length(__regions)*__size;
	}
	
	/// @param {Real} x The x coordinate to fetch from.
	/// @param {Real} x The y coordinate to fetch from.
	/// @description Fetches the nearest region from the provided coordinates. Even if that region doesn't exist, it will generate a new region.
	/// @return {Struct.__StickersRegionClass}
	/// @self
	static GetRegion = function(_x, _y) {
		if (__destroyed) return;
		return __StickersFindRegion(_x, _y);
	}

	/// @param {Array} Array the array to use. Default is a new array.S
	/// @return {Array<Struct.__StickersRegionClass>}
	static GetRegions = function(_array = undefined) {
		if (__destroyed) return;
		_array ??= [];
		array_copy(_array, array_length(_array), __regions, 0, array_length(__regions));
		return _array;
	}

	/// @param {Asset.Sprite} sprite_index The sprite to use.
	/// @param {Real} image_index The image index to use.
	/// @param {Real} x The x coordinate to place the sprite.
	/// @param {Real} y	The y coordinate to place the sprite.
	/// @param {Real, Undefined} xscale The x scale of the sprite. Default is 1.
	/// @param {Real, Undefined} yscale The y scale of the sprite. Default is 1.
	/// @param {Real, Undefined} angle The angle of the sprite. Default is 0.
	/// @param {Real, Constant.Colour, Undefined} colour The colour of the sprite. Default is c_white.
	/// @param {Real, Undefined} alpha The alpha of the sprite. Default is 1.
	/// @param {Real, Undefined} z The depth (or z) of the sprite. Default is 0.
	static Add = function(_sprite, _index, _x, _y, _xScale = undefined, _yScale = undefined, _ang = undefined, _col = c_white, _alpha = 1, _z = undefined) {
		if (__destroyed) return;
		var _region = __StickersFindRegion(_x, _y);

		_region.__Add(_sprite, _index, _x, _y, _xScale, _yScale, _ang, _col, _alpha, _z);
		return self;
	}	 

	/// @param {Asset.Sprite} sprite_index The sprite to use.
	/// @param {Real} image_index The image index to use.
	/// @param {Real} x The x coordinate to place the sprite.
	/// @param {Real} y	The y coordinate to place the sprite.
	/// @param {Real, Constant.Colour} colour The colour of the sprite. Default is c_white.
	/// @param {Real} alpha The alpha of the sprite. Default is 1.
	static AddSimple = function(_sprite, _index, _x, _y, _col = c_white, _alpha = 1) {
		if (__destroyed) return;
		var _region = __StickersFindRegion(_x, _y);

		_region.__AddSimple(_sprite, _index, _x, _y, _col, _alpha);
		return self;
	}

	/// @param {Asset.Sprite} sprite_index The sprite to use.
	/// @param {Real} image_index The image index to use.
	/// @param {Real} x The x coordinate to place the sprite.
	/// @param {Real} y	The y coordinate to place the sprite.
	static AddBasic = function(_sprite, _index, _x, _y) {
		if (__destroyed) return;
		var _region = __StickersFindRegion(_x, _y);

		_region.__AddBasic(_sprite, _index, _x, _y);
		return self;
	}

	/// @param {Asset.Sprite} sprite_index The sprite to use.
	/// @param {Real} image_index The image index to use.
	/// @param {Real} x The x coordinate to place the sprite.
	/// @param {Real} y	The y coordinate to place the sprite.
	/// @param {Real} angle The angle of the sprite. Default is 0.
	/// @param {Real, Constant.Colour} colour The colour of the sprite. Default is c_white.
	/// @param {Real} alpha The alpha of the sprite. Default is 1.
	static AddSimpleAngle = function(_sprite, _index, _x, _y, _angle = 0, _col = c_white, _alpha = 1) {
		if (__destroyed) return;
		var _region = __StickersFindRegion(_x, _y);

		_region.__AddSimpleAngle(_sprite, _index, _x, _y, _angle, _col, _alpha);
		return self;
	}

	/// @param {Asset.Sprite} sprite_index The sprite to use.
	/// @param {Real} image_index The image index to use.
	/// @param {Real} x The x coordinate to place the sprite.
	/// @param {Real} y	The y coordinate to place the sprite.
	/// @param {Real} xscale The x scale of the sprite. Default is 1.
	/// @param {Real} yscale The y scale of the sprite. Default is 1.
	/// @param {Real} angle The angle of the sprite. Default is 0.
	/// @param {Real, Constant.Colour} colour The colour of the sprite. Default is c_white.
	/// @param {Real} alpha The alpha of the sprite. Default is 1.
	/// @param {Real} z The depth (or z) of the sprite. Default is 0.
	static AddFull = function(_sprite, _index, _x, _y, _xScale = 1, _yScale = 1, _ang = 0, _col = c_white, _alpha = 1, _z = 0) {
		if (__destroyed) return;
		var _region = __StickersFindRegion(_x, _y);

		_region.__AddFull(_sprite, _index, _x, _y, _xScale, _yScale, _ang, _col, _alpha, _z);
		return self;
	}

	/// @param {Real} x The x coordinate to start the fetch from.
	/// @param {Real} y	The y coordinate to start the fetch from. 
	/// @param {Real} leftPad The left to pad from the x coordinate. Default is -128.
	/// @param {Real} topPad The top to pad from the y coordinate. Default is -128.
	/// @param {Real} rightPad The right to pad from the x coordinate. Default is 128.
	/// @param {Real} bottomPad The bottom to pad from the y coordinate. Default is 128.
	/// @param {Bool} sortByDepth Whether the returned array should be sorted or not. Default is false.
	/// @param {Array} Array The array to add the data onto. Default is a new array.
	/// @return {Array<Struct.__StickersImageDataClass>}
	static GetImageData = function(_x, _y, _leftPad = -128, _topPad = -128, _rightPad = 128, _bottomPad = 128, _sortByDepth = false, _array = []) {
		if (__destroyed) return;
		if (!__STICKERS_STORE_IMAGE_DATA) {
			__StickersError($"Cannot fetch image data as \"{nameof(__STICKERS_STORE_IMAGE_DATA)}\" is disabled!\nPlease enable it from \"{nameof(__StickersConfig)}\"!");
			return;
		}

		var _signX = sign(_x);
		var _signY = sign(_y);
		var _xCell = ((_x div __regionWidth) * __regionWidth) - (_signX != -1 ? 0 : __regionWidth);
		var _yCell = ((_y div __regionHeight) * __regionHeight) - (_signY != -1 ? 0 : __regionHeight);
		var _region = undefined;
		var _results = _array;
		
		var _i = 0;
		repeat(array_length(__regions)) {
			if (__regions[_i].__x == _xCell) && (__regions[_i].__y == _yCell) {
				_region = __regions[_i];	
				var _j = 0;
				repeat(array_length(_region.__entries)) {
					var _k = 0;
					var _vb = _region.__entries[_j];
					repeat(array_length(_vb.__imageData)) {
						if (!is_undefined(_vb.__imageData[_k])) {
							var _imageData = _vb.__imageData[_k];
							if (point_in_rectangle(_x, _y, _imageData.__x+_leftPad, _imageData.__y+_topPad, _imageData.__x+_rightPad, _imageData.__y+_bottomPad)) {
								array_push(_results, _imageData);	
							} 
						}
						++_k;
					}	
					++_j;
				}
			}
			
			++_i;
		}
		
		if (_sortByDepth) {
			array_sort(_results, function(_elmA, _elmB) {
				return _elmA.__depth - _elmB.__depth;
			});
		}
		
		return _results;
	}

	/// @description Clears all regions.
	static Clear = function() {
		if (__destroyed) return;
		array_foreach(__regions, function(_elm, _index) {
			_elm.__Destroy();
		});
		array_resize(__regions, 0);
		delete __cacheRegion;
	}

	/// @param {Real} x The x coordinate to sort from.
	/// @param {Real} y The y coordinate to sort from.
	/// @description Sorts regions from the provided x and y coordinate. Moving regions closer to the x and y coordinate to the top. Improving overall nearby searching for insertion.
	static SortRegions = function(_x, _y) {
		if (__destroyed) return;
		__Sort(_x, _y, __regions);
		return self;
	}

	/// @ignore
	static __Sort = function(_x, _y, _array) {
		static _ctx = {
			x: 0,
			y: 0,
		};

		static _sort = method(_ctx, function(_a, _b) {
			var _dist1 = abs(_a.__x - x) + abs(_a.__y - y);
			var _dist2 = abs(_b.__x - x) + abs(_b.__y - y);
           
			return sign(_dist1 - _dist2);
		});
		_ctx.x = _x;
		_ctx.y = _y;

		array_sort(_array, _sort);
	}

	/// @param {Real} x The x coordinate to check from.
	/// @param {Real} y The y coordinate to check from.
	/// @param {Real} distance How far the distance from the x and y coordinate before regions are cleared. Default is width + padding width.
	/// @description Clears all regions from a select x and y coordinate that are too far away.
	static ClearFromDistance = function(_x, _y, _distance = __regionWidth + __paddingWidth) {
		if (__destroyed) return;
		var _i = array_length(__regions)-1;
		var _xCell = ((_x div __regionWidth) * __regionWidth);
		var _yCell = ((_y div __regionHeight) * __regionHeight);
		var _wCell = _xCell + __regionWCell;
		var _hCell = _yCell + __regionHCell;
		_xCell -= __regionWidth;
		_yCell -= __regionHeight;

		repeat(_i+1) {
			var _entry = __regions[_i];
			if (point_distance(_entry.__x, _entry.__y, _xCell, _yCell) > _distance) {
				__regions[_i].__Destroy();
				array_delete(__regions, _i, 1);
			}
			--_i;
		}
	}

	/// @param {Real} x The x coordinate to start clearing from.
	/// @param {Real} y The y coordinate to start clearing from.
	/// @param {Real} width The width to end clearing from.
	/// @param {Real} height The height to end clearing from.
	/// @description Clears all regions within the selected x and y coordinate, to their respective width and height.
	static ClearRegionExt = function(_x, _y, _width, _height) {
		if (__destroyed) return;
		var _i = array_length(__regions)-1;
		var _xCell = ((_x div __regionWidth) * __regionWidth);
		var _yCell = ((_y div __regionHeight) * __regionHeight);
		var _wCell = ((_width div __regionWidth) * __regionWidth) + __regionWCell;
		var _hCell = ((_height div __regionHeight) * __regionHeight) + __regionHCell;

		repeat(_i+1) {
			var _entry = __regions[_i];
			if (rectangle_in_rectangle(_xCell, _yCell, _wCell, _hCell, _entry.__x, _entry.__y, _entry.__width, _entry.__height) > 0) {
				__regions[_i].__Destroy();
				array_delete(__regions, _i, 1);
			}
			--_i;	
		}
	}

	/// @param {Real} x The x coordinate to clear.
	/// @param {Real} y The y coordinate to clear.
	/// @description Clears a region from the provided x and y coordinate, if any are found.
	static ClearRegion = function(_x, _y) {
		if (__destroyed) return;
		var _signX = sign(_x);
		var _signY = sign(_y);
		var _xCell = ((_x div __regionWidth) * __regionWidth) - (_signX != -1 ? 0 : __regionWidth);
		var _yCell = ((_y div __regionHeight) * __regionHeight) - (_signY != -1 ? 0 : __regionHeight);
		var _i = 0;
		repeat(array_length(__regions)) {
			if (__regions[_i].__x == _xCell) && (__regions[_i].__y == _yCell) {
				__regions[_i].__Destroy();
				array_delete(__regions, _i, 1);
				break;
			}
			++_i;
		}
		return self;
	}

	/// @param {Id.Buffer} buffer the buffer that contains the exported Sticker data.
	/// @param {Real} offset The offset to apply from the buffer.
	/// @param {Real} resetHead When the buffer is done reading, it should reset the head back to the last position.
	/// @self
	static Import = function(_importBuff, _offset = 0, _resetHead = true) {
		if (__destroyed) return;
		if (!__STICKERS_ALLOW_EXPORT) {
			__StickersError($"Cannot import as \"{nameof(__STICKERS_ALLOW_EXPORT)}\" is disabled!\nPlease enable it from \"{nameof(__StickersConfig)}\"!");
			return;
		}
		
		var _oldTell = buffer_tell(_importBuff);
		try {
			buffer_seek(_importBuff, buffer_seek_start, _offset);
			Clear();
			var _header = buffer_read(_importBuff, buffer_text);
			if (_header != __STICKERS_FILE_HEADER) {
				__StickersError($"Invalid Stickers Header! Please ensure that you are only using .Export() from a Stickers instance!");
				return;
			}
			__size = buffer_read(_importBuff, buffer_u32);
			__frozen = 	buffer_read(_importBuff, buffer_bool);
			__regionWidth = buffer_read(_importBuff, buffer_u32);
			__regionHeight = buffer_read(_importBuff, buffer_u32);
			__paddingWidth = buffer_read(_importBuff, buffer_u32);
			__paddingHeight = buffer_read(_importBuff, buffer_u32);
			var _regionsLength = buffer_read(_importBuff, buffer_u32);
			array_resize(__regions, _regionsLength);
			var _i = 0;
			repeat(_regionsLength) {
				var _x = buffer_read(_importBuff, buffer_f64);
				var _y = buffer_read(_importBuff, buffer_f64);
				var _entriesLength = buffer_read(_importBuff, buffer_u32);
		    	  
				var _region = new __StickersRegionClass(_x, _y, self);
				__regions[_i] = _region;
				var _j = 0;
				repeat(_entriesLength) {
					var _textureGroupName = buffer_read(_importBuff, buffer_string);
					var _startPos = buffer_read(_importBuff, buffer_u32);
					var _loopedOnce = buffer_read(_importBuff, buffer_bool);
					var _cSize = buffer_read(_importBuff, buffer_u32);
					var _cBuff = buffer_create(_cSize, buffer_fixed, 1);
					buffer_copy(_importBuff, buffer_tell(_importBuff), _cSize, _cBuff, 0);
					buffer_seek(_importBuff, buffer_seek_relative, _cSize);
					var _dBuff = buffer_decompress(_cBuff);
					buffer_delete(_cBuff);
					var _sprites = buffer_read(_dBuff, buffer_string);
					buffer_delete(_dBuff);
					var _spritesStruct = json_parse(_sprites);
					array_map_ext(_spritesStruct.data, asset_get_index);
					    
					array_map_ext(_spritesStruct.data, function(_elm) {
						if (sprite_exists(_elm)) {
							StickersPrecacheSprite(_elm);
							return {
								sprite: _elm,
								info: sprite_get_info(_elm),
							};
						}  
			     
						return undefined;
					}); 
        
					var _texId = -1;
					var _pos = -1;
					with(_spritesStruct) {
						_pos = array_find_index(index, function(_elm, _index) {
							if (_index >= array_length(data)) return false;
							if (is_undefined(data[_index])) return false;
							return true;
						});
					}   
                	
					if (_pos != -1) {
						_texId = _spritesStruct.data[_pos].info.frames[_spritesStruct.index[_pos]].texture;
					} else {
						var _spritesNames = json_parse(_sprites);
						__StickersError($"No matching sprite data was found while importing!\nPlease ensure that one of these sprites exist! \"{string_join_ext(", ", _spritesNames.data)}\"");
						return;
					}
        
					var _entry = _region.__AddEntry(_texId, sprite_get_texture(_spritesStruct.data[_pos].sprite, _spritesStruct.index[_pos]));
					_entry.__startPos = _startPos*__STICKERS_VERTICE_COUNT;
					_entry.__pos = _startPos;
					_entry.__loopedOnce = _loopedOnce;
					vertex_delete_buffer(_entry.__mainVBuff);
					var _vertexNum = buffer_read(_importBuff, buffer_u64);
					var _vertexSize = buffer_read(_importBuff, buffer_u64);
					_entry.__mainVBuff = vertex_create_buffer_from_buffer_ext(_importBuff, _entry.__format, buffer_tell(_importBuff), _vertexNum);
					buffer_seek(_importBuff, buffer_seek_relative, _vertexSize);
					if (__STICKERS_STORE_IMAGE_DATA) {
						var _k = 0;
						if (is_array(_spritesStruct.imageInfoData)) {
							repeat(array_length(_spritesStruct.imageInfoData)) {
								var _imageEntry = _spritesStruct.imageInfoData[_k];
								if (is_struct(_imageEntry)) {
									_entry.__imageData[_k] = new __StickersImageDataClass(_entry, _k, asset_get_index(_imageEntry.sprite_index), _imageEntry.image_index, _imageEntry.x, _imageEntry.y, _imageEntry.xscale, _imageEntry.yscale,  _imageEntry.angle, _imageEntry.colour, _imageEntry.alpha, _imageEntry.depth);
								}							
								++_k;
							}
						}
					}
					++_j;
				}
		
				++_i;
			}
        
			// Recalculate
			__regionWCell = (__regionWidth div 2)  + __paddingWidth;
			__regionHCell = (__regionHeight div 2)  + __paddingHeight;
		} finally {
			if (_resetHead) buffer_seek(_importBuff, buffer_seek_start, _oldTell);
		}
	}

	/// @description Exports the current state of the sticker instance, including its position, offset, etc.
	/// @return {Id.Buffer}
	static Export = function() {
		if (__destroyed) return;
		static _ctx = {
			texId: -1,
			pos: -1,
		};

		static _search = method(_ctx, function(_elm, _index) {
			var _pos = array_get_index(_elm, texId);
			if (_pos >= 0) {
				pos = _pos;
				return true;
			} 
			return false;
		});

		if (!__STICKERS_ALLOW_EXPORT) {
			__StickersError($"Cannot export as \"{nameof(__STICKERS_ALLOW_EXPORT)}\" is disabled!\nPlease enable it from \"{nameof(__StickersConfig)}\"!");
			return;
		}

		var _names = texturegroup_get_names();
		var _textureIds = array_map(_names, function(_elm) {
			return texturegroup_get_textures(_elm);
		});
		var _exportBuff = buffer_create(1, buffer_grow, 1);
		var _regionsLength = array_length(__regions);
		buffer_write(_exportBuff, buffer_string, __STICKERS_FILE_HEADER);
		buffer_write(_exportBuff, buffer_u32, __size);
		buffer_write(_exportBuff, buffer_bool, __frozen);
		buffer_write(_exportBuff, buffer_u32, __regionWidth);
		buffer_write(_exportBuff, buffer_u32, __regionHeight);
		buffer_write(_exportBuff, buffer_u32, __paddingWidth);
		buffer_write(_exportBuff, buffer_u32, __paddingHeight);
		buffer_write(_exportBuff, buffer_u32, _regionsLength);
	
		var _i = 0;
		repeat(_regionsLength) {
			var _region = __regions[_i];
			var _entriesLength = array_length(_region.__entries);
			buffer_write(_exportBuff, buffer_f64, _region.__x);
			buffer_write(_exportBuff, buffer_f64, _region.__y);
			buffer_write(_exportBuff, buffer_u32, _entriesLength);

			var _j = 0;
			repeat(_entriesLength) {
				var _entry = _region.__entries[_j];
				_entry.__TryUpdate();
				_ctx.texId = _entry.__texId;
				_ctx.pos = -1;
				var _pagePos = array_find_index(_textureIds, _search);
				buffer_write(_exportBuff, buffer_string, _names[_pagePos]);
				buffer_write(_exportBuff, buffer_u32, _entry.__pos);
				buffer_write(_exportBuff, buffer_bool, _entry.__loopedOnce);
				var _data = texturegroup_get_sprites(_names[_pagePos]);
				array_map_ext(_data, sprite_get_name);
				var _imageInfoData = undefined;

				if (__STICKERS_STORE_IMAGE_DATA) {
					_imageInfoData = array_create(__size, undefined);
					var _k = 0;
					repeat(array_length(_entry.__imageData)) {
						if (is_struct(_entry.__imageData[_k])) {
							_imageInfoData[_k] = _entry.__imageData[_k].Export();
						}
 						++_k;
					}
				}

				var _json = json_stringify({
					data: _data,
					index: _entry.__imageIndex,
					imageInfoData: _imageInfoData,
				});
				var _jsonLength = string_byte_length(_json);
				var _buffJson = buffer_create(_jsonLength, buffer_fixed, 1);
				buffer_write(_buffJson, buffer_text, _json);
				var _cBuff = buffer_compress(_buffJson, 0, _jsonLength);
				var _cSize = buffer_get_size(_cBuff);
				buffer_write(_exportBuff, buffer_u32, _cSize);
				buffer_copy(_cBuff, 0, _cSize, _exportBuff, buffer_tell(_exportBuff));
				buffer_delete(_cBuff);
				buffer_delete(_buffJson);
				buffer_seek(_exportBuff, buffer_seek_relative, _cSize);

				var _buffVBuff = buffer_create_from_vertex_buffer(_entry.__mainVBuff, buffer_fixed, 1);
				buffer_write(_exportBuff, buffer_u64, vertex_get_number(_entry.__mainVBuff));
				buffer_write(_exportBuff, buffer_u64, buffer_get_size(_buffVBuff));
				buffer_copy(_buffVBuff, 0, buffer_get_size(_buffVBuff), _exportBuff, buffer_tell(_exportBuff));
				buffer_seek(_exportBuff, buffer_seek_relative, buffer_get_size(_buffVBuff));
				buffer_delete(_buffVBuff);
				++_j;
			}
			++_i;
		}
		
		buffer_resize(_exportBuff, buffer_tell(_exportBuff));
		buffer_seek(_exportBuff, buffer_seek_start, 0);
		return _exportBuff;
	}

	/// @param {Real} x The x coordinate to render from.
	/// @param {Real} y The y coordinate to render from.
	/// @param {Real} width The width coordinate to render to.
	/// @param {Real} height The height coordinate to render to.
	/// @description Renders all regions within the provided x, y, width and height.
	/// @self
	static Draw = function(_x, _y, _width, _height) {
		if (__destroyed) return;
		var _i = 0;
		var _xCell = ((_x div __regionWidth) * __regionWidth);
		var _yCell = ((_y div __regionHeight) * __regionHeight);
		var _wCell = _xCell + _width + __regionWCell;
		var _hCell = _yCell + _height + __regionHCell;
		_xCell -= __regionWidth + __regionWCell;
		_yCell -= __regionHeight + __regionHCell;

		repeat(array_length(__regions)) {
			var _entry = __regions[_i];
			if ((_entry.__x >= _xCell) && (_entry.__x-__paddingWidth <= _wCell)) && ((_entry.__y >= _yCell) && (_entry.__y-__paddingHeight <= _hCell)) {
				_entry.__Draw();
			} else if (__STICKERS_REMOVE_REGIONS_OUT_OF_DRAW_RADIUS) {
				if (point_distance(_entry.__x, _entry.__y, _xCell, _yCell) > __STICKERS_DRAW_RADIUS_REGIONS_LENGTH) {
					__regions[_i].__Destroy();
					array_delete(__regions, _i, 1);
					--_i;
				}
			}
			++_i;
		}
	}
	
	/// @param {Id.Camera} camera The camera to use for rendering. Default is the current view camera.
	/// @description Uses the cameras current x, y, width and height to render regions with.
	/// @self
	static DrawCamera = function(_camera = view_camera[view_current]) {
		if (__destroyed) return;
		var _x = camera_get_view_x(_camera), 
			_y = camera_get_view_y(_camera), 
			_width = camera_get_view_width(_camera), 
			_height = camera_get_view_height(_camera);

		Draw(_x, _y, _width, _height)
	}
}
