# Stickers()

### `Stickers(maxDecals, [width], [height], [frozen], [name])`

Returns: An instance of `Stickers`.

|Name|Datatype|Purpose|
|---|---|---|
|`maxDecals`|`Real`|Max number of decals per region.|
|`width`|`Real`|Width of each region. Default is `1024`.|
|`height`|`Real`|Height of each region. Default is `1024`.|
|`frozen`|`Bool`|Whether vertex buffers should be frozened or not. (Recommended for a extremely large sticker count.) Default is `false`.|
|`name`|`String`|The name of the Stickers instance. Used explicitly for debugging purposes. Default is `""`.|

Constructor, creates a new instance of `Stickers` to be used for storing the regions and vertex buffers for all of your decals.

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

Places a decal with the supplied `sprite_index`, `image_index`, `x` and `y` arguments. Optionally `xscale`, `yscale`, `angle`, `colour`, `alpha` and `z` may be specified. Depending on the arguments filled, `.Add()` will attempt to call whichever `.Add*()` function that is necessary, potentially giving an optimized enough path. Should you know exactly what you need, it is highly suggested to use the other `.Add*()` functions down below, as they may be faster overall.

### `.AddBasic(sprite_index, image_index, x, y)`

Returns: `self`.

|Name|Datatype|Purpose|
|---|---|---|
|`sprite_index`|`GMAsset.Sprite`|The sprite to use.|
|`image_index`|`Real`|The image index to use.|
|`x`|`Real`|The x coordinate to place the sprite.|
|`y`|`Real`|The y coordinate to place the sprite.|

Places a decal with the supplied `sprite_index`, `image_index`, `x` and `y` arguments.

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

Places a decal with the supplied `sprite_index`, `image_index`, `x` and `y` arguments. Optionally `colour` and `alpha` may be specified.

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

Places a decal with the supplied `sprite_index`, `image_index`, `x` and `y` arguments. Optionally `angle`, `colour` and `alpha` may be specified.

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
|`z`|`Real`|The z coordinate (or depth) to place the sprite, if depth testing is enabled. Defaults to `0`.|-

Places a decal with the supplied `sprite_index`, `image_index`, `x` and `y` arguments. Optionally `xscale`, `yscale`, `angle`, `colour`, `alpha` and `z` may be specified.

### `.Clear()`

Returns: `self`.

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Clears the entire Stickers instance of all of its regions and underlying vertex buffers.

### `.Destroy()`

Returns: `N/A`.

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Destroys the Stickers instance, clearing all regions and vertex buffers.

### `.ClearFromDistance(x, y, [dinstance])`

Returns: `self`.

|Name|Datatype|Purpose|
|---|---|---|
|`x`|`Real`|The x coordinate to check from.|
|`y`|`Real`|The y coordinate to check from.|
|`distance`|`Real`|How far the distance from the x and y coordinate before regions are cleared. Default is `width` + `padding width`.|

Clears all Sticker regions and underlying vertex buffers, if they exceed the specified distance. This can be applied automatically via `__STICKERS_REMOVE_REGIONS_OUT_OF_DRAW_RADIUS` and `__STICKERS_DRAW_RADIUS_REGIONS_LENGTH` configs respectively.

### `.ClearRegion(x, y)`

Returns: `self`.

|Name|Datatype|Purpose|
|---|---|---|
|`x`|`Real`|The x coordinate to check from.|
|`y`|`Real`|The y coordinate to check from.|

Clears a region from the provided `x` and `y` coordinate, if any are found.

### `.ClearRegionExt(x, y, width, height)`

Returns: `self`.

|Name|Datatype|Purpose|
|---|---|---|
|`x`|`Real`|The x coordinate to start clearing from.|
|`y`|`Real`|The y coordinate to start clearing from.|
|`width`|`Real`|The width to end clearing from.|
|`height`|`Real`|The height to end clearing from.|

Clears all regions within the selected `x` and `y` coordinate, to their respective `width` and `height`.

### `.Sort(x, y)`

Returns: `self`.

|Name|Datatype|Purpose|
|---|---|---|
|`x`|`Real`|The x coordinate to sort from.|
|`y`|`Real`|The y coordinate to sort from.|

Sorts all regions based on manhattan distance. This primiarily is used to speed up with fetching the closest Stickers region when it comes to adding a new decal with `.Add*().` This can be automatically called by the config `__STICKERS_OPTIMIZE_APPEND`.

### `.Draw(x, y, width, height)`

Returns: `self`.

|Name|Datatype|Purpose|
|---|---|---|
|`x`|`Real`|The x coordinate to start from.|
|`y`|`Real`|The y coordinate to start from.|
|`width`|`Real`|The width coordinate to end from.|
|`height`|`Real`|The height coordinate to end from.|

Renders all regions and their vertex buffer contents that are within view.

### `.DrawCamera([camera])`

Returns: `self`.

|Name|Datatype|Purpose|
|---|---|---|
|`camera`|`Id.Camera`|The camera to fetch from. Defaults to `view_camera[view_current]`.|

Fetches the `x`, `y`, `width` and `height` of the camera and passes it along to `.Draw()`.