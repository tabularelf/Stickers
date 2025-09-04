# Stickers().Get*

### `.GetName()`

Returns: `String`.

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Returns the name of the Stickers instance.

### `.GetDebug()`

Returns: `Boolean`.

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Returns the state of debug mode that is currently set.

### `.GetRegionCount()`

Returns: `Real`.

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Returns the region count.

### `.GetVBufferCount()`

Returns: `Real`.

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Returns the vertex buffer count.

### `.GetRegionWidth()`

Returns: `Real`.

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Returns the region width.

### `.GetRegionHeight()`

Returns: `Real`.

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Returns the region height.

### `.GetByteSize()`

Returns: `Real`.

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Returns the current byte size of every vertex buffer.

### `.GetRegion()`

Returns: `Instance of __StickersRegionClass`.

|Name|Datatype|Purpose|
|---|---|---|
|`x`|`Real`|The x coordinate to fetch from.|
|`y`|`Real`|The y coordinate to fetch from.|

Fetches the nearest region from the provided coordinates. Even if that region doesn't exist, it will generate a new region.

### `.GetRegions([array])`

Returns: `Array<Instances of __StickersRegionClass>`.

|Name|Datatype|Purpose|
|---|---|---|
|`array`|`Array`|The array to use. Default is a new array.|

Fetches all regions and returns it to the supplied array.