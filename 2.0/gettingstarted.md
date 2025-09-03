# Getting Started

## What is Stickers?

Stickers is a vertex buffer-based chunking decal system, designed to be extremely memory and performance efficient. Traditional methods usually involve having a surface that covers the entire room, but runs into many problems. One of which is that they take enormous amounts of memory. A default surface that is created with `surface_rgba8unorm`, is sized as `width * height * 4`. Which can balloon very quickly. Another being that surfaces are volatile, __and can get cleared by the operating system at any point of time__, and require some extra steps to cache it which can be very slow.

Stickers solves this by instead using regions as chunks, and vertex buffers to store sprites. Each sprite added to a Stickers instance, is only **144 bytes** per sprite. Comparing a surface of a size of 1024x1024, vs a Sticker region of the same size, with 1,000 of the same sprite placed at random, is a difference between **4MB (surface)** to **144KB (Sticker vertex buffer & region)** at minimal. The only trade off is that Stickers has a limited set amount of slots before sprites need to be overriden. Stickers allows you to control however many sprites are stored per vertex buffer, per region, by setting a max size amount of decals overall. While Stickers does not aim to be a universal solution to decals, but it does aim to be the more performant and memory efficient solution, for those who wish to have decals in their game.

## Installing
1. Download Stickers's .yymp from [releases!](https://github.com/tabularelf/Stickers/releases)
2. With your GameMaker Project, drag the .yymp (or at the top goto Tools -> Import Local Package)
3. Press "Add All" and press "Import".

## Updating to a new version

1. Delete Stickers's folder (with all scripts inside.) Make sure to backup `__StickersConfig`!
2. Follow the steps through [Installing](#installing), but with the latest version.

## Using Stickers

To begin using Stickers, you first want to initialize a new Stickers instance. Stickers has one main argument, with 4 optional arguments.<br>
(See [`Stickers()`](stickers.md#stickers?id=stickersmaxdecals-width-height-frozen-name) for more.)<br>

We start off by assigning a new Stickers instance to a variable called `decals`, defining the total number of decals.
```gml
// Create Event
decals = new Stickers(1024);
```
We may take the opportunity to also precache some sprites ahead of time. This isn't strictly necessary as by default Stickers is configured to auto precache any sprites it comes across. We can use asset tags and apply `StickerDecal` directly, or call `StickersPrecacheSprite()` or `StickersPrecacheSpriteExt()`.
```gml
// Create Event
decals = new Stickers(1024);
StickersPrecacheSprite(spr_smile);
```
We then take that new Stickers instance, and add decals to it.
```gml
// Step Event
if (mouse_check_button(mb_left)) {
    decals.Add(spr_smile, 0, mouse_x, mouse_y);
}
```
Whenever we press the left mouse button, this will spawn a new decal in its place. Now to draw it, we can call `.Draw()` manually, but we can also use `.DrawCamera()`, which will fetch the current view camera by default.
```gml
// Draw Event
decals.DrawCamera();
```
To free the Stickers instance.
```gml
// Cleanup Event
surf.Destroy();
```
And that is the bare basics to it! Feel free to read the many other pages!