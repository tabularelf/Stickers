function __StickersSpriteStruct(_spr, _img, _x, _y, _xscale, _yscale, _ang, _col, _alpha, _depth) constructor {
		sprite = _spr;
		image = _img;
		angle = _ang;
		colour = _col;
		xScale = _xscale;
		yScale = _yscale;
		alpha = _alpha;
		x = _x;
		y = _y;
		depth = _depth;	
		
	static Update = function(_spr, _img, _x, _y, _xscale, _yscale, _ang, _col, _alpha, _depth) {
		sprite = _spr;
		image = _img;
		angle = _ang;
		colour = _col;
		xScale = _xscale;
		yScale = _yscale;
		alpha = _alpha;
		x = _x;
		y = _y;
		depth = _depth;	
		return self;
	}
}