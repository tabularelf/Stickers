# Region

Regions are Stickers equivalent to chunks in some systems, where all of the vertex buffers per coordinate are stored. With the introduction of `.GetRegion()` and `.GetRegions()`, you can now access these underlying regions.

The following below is all of the methods exposed.

### `.GetX()`

Returns: `Real`.

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Returns the x coordinate of the region.

### `.GetY()`

Returns: `Real`.

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Returns the y coordinate of the region.

### `.GetWidth()`

Returns: `Real`.

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Returns the width of the region.

### `.GetHeight()`

Returns: `Real`.

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Returns the height of the region.

### `.GetOwner()`

Returns: `Instance of Stickers`.

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Returns the Stickers instance that owns the region, if any.

### `.Add(sprite_index, image_index, x, y, [angle], [colour], [alpha], [z])`

Returns: `self`.

|Name|Datatype|Purpose|
|---|---|---|
|`sprite_index`|`GMAsset.Sprite`|The sprite to use.|
|`image_index`|`Real`|The image index to use.|
|`x`|`Real`|The x coordinate to place the sprite.|
|`y`|`Real`|The y coordinate to place the sprite.|
|`xscale`|`Real`|The x scale of the sprite. Default is `1`.|
|`yscale`|`Real`|The y scale of the sprite. Default is `1`.|
|`angle`|`Real`|The angle to rotate the sprite as. Defaults to `0`|
|`colour`|`Real` or `Constant.Colour`|The colour of the sprite. Defaults to `c_white`.|
|`alpha`|`Real`|The alpha to set for the sprite. Defaults to `1`.|
|`z`|`Real`|The z coordinate (or depth) to place the sprite, if depth testing is enabled. Defaults to `0`.|

Places a decal with the suppled `sprite_index`, `image_index`, `x` and `y` arguments. Optionally `xscale`, `yscale`, `angle`, `colour`, `alpha` and `z` may be specified. Depending on the arguments filled, `.Add()` will attempt to call whichever `.Add*()` function that is necessary, potentially giving an optimized enough path. Should you know exactly what you need, it is highly suggested to use the other `.Add*()` functions down below, as they may be faster overall.

?> Clamping is applied to ensure that the sprites fit within the region boundaries.

### `.AddBasic(sprite_index, image_index, x, y)`

Returns: `self`.

|Name|Datatype|Purpose|
|---|---|---|
|`sprite_index`|`GMAsset.Sprite`|The sprite to use.|
|`image_index`|`Real`|The image index to use.|
|`x`|`Real`|The x coordinate to place the sprite.|
|`y`|`Real`|The y coordinate to place the sprite.|

Places a decal with the suppled `sprite_index`, `image_index`, `x` and `y` arguments.

?> Clamping is applied to ensure that the sprites fit within the region boundaries.

### `.AddSimple(sprite_index, image_index, x, y, [colour], [alpha])`

Returns: `self`.

|Name|Datatype|Purpose|
|---|---|---|
|`sprite_index`|`GMAsset.Sprite`|The sprite to use.|
|`image_index`|`Real`|The image index to use.|
|`x`|`Real`|The x coordinate to place the sprite.|
|`y`|`Real`|The y coordinate to place the sprite.|
|`colour`|`Real` or `Constant.Colour`|The colour of the sprite. Defaults to `c_white`.|
|`alpha`|`Real`|The alpha to set for the sprite. Defaults to `1`.|

Places a decal with the suppled `sprite_index`, `image_index`, `x` and `y` arguments. Optionally `colour` and `alpha` may be specified.

?> Clamping is applied to ensure that the sprites fit within the region boundaries.

### `.AddSimpleAngle(sprite_index, image_index, x, y, [angle], [colour], [alpha])`

Returns: `self`.

|Name|Datatype|Purpose|
|---|---|---|
|`sprite_index`|`GMAsset.Sprite`|The sprite to use.|
|`image_index`|`Real`|The image index to use.|
|`x`|`Real`|The x coordinate to place the sprite.|
|`y`|`Real`|The y coordinate to place the sprite.|
|`angle`|`Real`|The angle to rotate the sprite as. Defaults to `0`|
|`colour`|`Real` or `Constant.Colour`|The colour of the sprite. Defaults to `c_white`.|
|`alpha`|`Real`|The alpha to set for the sprite. Defaults to `1`.|

Places a decal with the suppled `sprite_index`, `image_index`, `x` and `y` arguments. Optionally `angle`, `colour` and `alpha` may be specified.

?> Clamping is applied to ensure that the sprites fit within the region boundaries.

### `.AddFull(sprite_index, image_index, x, y, [angle], [colour], [alpha], [z])`

Returns: `self`.

|Name|Datatype|Purpose|
|---|---|---|
|`sprite_index`|`GMAsset.Sprite`|The sprite to use.|
|`image_index`|`Real`|The image index to use.|
|`x`|`Real`|The x coordinate to place the sprite.|
|`y`|`Real`|The y coordinate to place the sprite.|
|`xscale`|`Real`|The x scale of the sprite. Default is `1`.|
|`yscale`|`Real`|The y scale of the sprite. Default is `1`.|
|`angle`|`Real`|The angle to rotate the sprite as. Defaults to `0`|
|`colour`|`Real` or `Constant.Colour`|The colour of the sprite. Defaults to `c_white`.|
|`alpha`|`Real`|The alpha to set for the sprite. Defaults to `1`.|
|`z`|`Real`|The z coordinate (or depth) to place the sprite, if depth testing is enabled. Defaults to `0`.|

Places a decal with the suppled `sprite_index`, `image_index`, `x` and `y` arguments. Optionally `xscale`, `yscale`, `angle`, `colour`, `alpha` and `z` may be specified.

?> Clamping is applied to ensure that the sprites fit within the region boundaries.

### `.Clear()`

Returns: `self`.

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Clears the entire Stickers region and underlying vertex buffers.

### `.Destroy()`

Returns: `N/A`.

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Destroys the Stickers region, clearing all regions and vertex buffers.

### `.Draw()`

Returns: `self`.

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Draws the stickers region.