# General

### `StickersClearCache()`

Returns: `N/A`.

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Clears the sprite data cache completely.

### `StickersClearCache()`

Returns: `N/A`.

|Name|Datatype|Purpose|
|---|---|---|
|`sprite`|`GMAsset.Sprite`|The sprite to clear from the cache.|

Clears the sprite from the sprite data cache.

### `StickersGetRecyclingByteSize()`

Returns: `N/A`.

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Returns the size of the recyling bin. If `__STICKERS_RECYCLE_VERTEX_BUFFERS` is set to `false`, it will always return `0`.

### `StickersClearRecycling()`

Returns: `N/A`.

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Clears the recycling bin. 

?> If `__STICKERS_RECYCLE_VERTEX_BUFFERS` is set to `false`, this will do nothing, but throw a message in the output window.

### `StickersPrecacheSprite()`

Returns: `N/A`.

|Name|Datatype|Purpose|
|---|---|---|
|`sprite`|`GMAsset.Sprite`|The sprite to precache ahead of time.|

Precaches the sprite data ahead of time. Normally `__STICKERS_AUTO_PRECACHE` will do this for you whenever you add a new sprite by default.

### `StickersPrecacheSpriteExt(array, [offset], [length])`

Returns: `N/A`.

|Name|Datatype|Purpose|
|---|---|---|
|`array`|`Array<GMAsset.Sprite>`|The array of sprites to precache ahead of time.|
|`offset`|`Real`|The offset of the array to start from. Defaults to `0`.|
|`length`|`Real`|The length of the array to end at. Defaults to the arrays length.|

Precaches the sprites data ahead of time from the array. Normally `__STICKERS_AUTO_PRECACHE` will do this for you whenever you add a new sprite by default.