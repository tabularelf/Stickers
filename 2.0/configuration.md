|Name|Default Value|Purpose|
|---|---|---|
|`__STICKERS_VERBOSE`|`false`|Whether Stickers should print out extra information based on certain scenarios. i.e. Generating new regions.|
|`__STICKERS_AUTO_PRECACHE`|`false`|Whether Stickers autocache any sprites. Setting this to false will require you to call `StickersPrecacheSprite()` or `StickersPrecacheSpriteExt()`. You can also apply the asset tag `"StickerDecal"` to have sprites cached at the start of the game.|
|`__STICKERS_PRECACHE_VALIDATE_SPRITE`|`true`|Whether Stickers should validate that a proper sprite ref was passed, and error if it wasn't.|
|`__STICKERS_CACHE_CHECK_EXISTENCE`|`true`|Whether Stickers should check if the sprite exists in the cache prior to fetching. And throwing an error if it doesn't exist.|
|`__STICKERS_IMAGE_INDEX_MODULO`|`2`|The mode that Stickers should operate when it comes to fetching the underlying UVs struct from the cache, for the select sprite. Modes: - 0: No modulo! Pure Index! - 1: GML modulo. Doesn't account for negatives! - 2: Custom Modulo. Accounts for negatives!|
|`__STICKERS_AUTO_FETCH_TEXTURE`|`false`|Whether Stickers should fetch the texture page directly. Useful if texturegroup_set_mode() is set to explicit. Otherwise Stickers will not fetch texture pages. However if texturegroup_set_mode() is set to implicit, GM will handle that anyway.|
|`__STICKERS_FLOOR_VERTEX_BUFFER_COORDS`|`false`|Whether coordinates should be floored prior to adding to the vertex buffers.|
|`__STICKERS_STORE_IMAGE_DATA`|`false`|Whether Image data should be included. Allowing you to fetch, modify, remove images from any vertex buffers. |
|`__STICKERS_ALLOW_EXPORT`|`false`|Whether Stickers should allow exporting/importing Sticker instances. This will include EVERYTHING, including image data (if available). And key information about the sprites/texture pages in order to reconstruct upon import. This should ideally be used only if texture groups are managed properly.|
|`__STICKERS_REMOVE_REGIONS_OUT_OF_DRAW_RADIUS`|`false`|Whether Stickers should remove regions that are too far away automatically from the Draw() or DrawCamera() coordinates. You can alternatively call .ClearFromDistance().|
|`__STICKERS_DRAW_RADIUS_REGIONS_LENGTH`|`8192`|The distance that Stickers will remove regions that are too far away from teh Draw() or DrawCamera() coordinates.|
|`__STICKERS_OPTIMIZE_APPEND`|`true`|Whether Stickers should automatically sort the regions closest to the last x and y coordinate passed into one of the .Add* methods. You can alternatively call .SortRegions().|
|`__STICKERS_OPTIMIZE_APPEND_TIME_MS`|`1_000_000`|How much in real time should pass before Stickers attempts to sort regions.|
|`__STICKERS_RECYCLE_VERTEX_BUFFERS`|`true`|Whether Stickers should recycle vertex buffers that were created. This may be more applicable for scenarios where a extremely large decal size is used, or to prevent memory allocation/deallocation from occurring.|
|`__STICKERS_STACK_ON_TOP`|`true`|Whether Stickers should stack images on top. If set to false, Stickers will just apply the usual buffer insertion logic. Which will result in images appearing underneath it. Without some depth workarounds.|
|`__STICKERS_PADDING_DYNAMIC`|`false`|Whether Stickers should automatically increase the padding size of an instance, if the scale of a newly added sprite exceeds the existing padding size. This is useful purely from a debugging standpoint.|
