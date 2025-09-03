// Feather ignore all
/// @ignore
function __StickersVFormat(){
	static _format = (function() {
		vertex_format_begin();
		vertex_format_add_position_3d();
		vertex_format_add_color();
		vertex_format_add_texcoord();
		return vertex_format_end();
	})();

	return _format;
}