package systems;

import flixel.util.FlxColor;

class Colors {
	public var list(get, null):Array<FlxColor>;
	
	public var red(get, never):FlxColor;
	public var pink(get, never):FlxColor;
	public var purple(get, never):FlxColor;
	public var blue(get, never):FlxColor;
	public var green(get, never):FlxColor;
	public var lime(get, never):FlxColor;
	public var yellow(get, never):FlxColor;
	public var orange(get, never):FlxColor;
	
	public var black(get, never):FlxColor;
	public var white(get, never):FlxColor;
	public var gray(get, never):FlxColor;
	public var transWhite(get, never):FlxColor;
	
	function get_list():Array<FlxColor> {
		if (list == null)
			list = [red, pink, purple, blue, green, lime, yellow, orange];
		return list;
	}
	
	public inline function get_red():FlxColor return 0xFFF44336;
	public inline function get_pink():FlxColor return 0xFFFF4081;
	public inline function get_purple():FlxColor return 0xFF9C27B0;
	public inline function get_blue():FlxColor return 0xFF2196F3;
	public inline function get_green():FlxColor return 0xFF00E676;
	public inline function get_lime():FlxColor return 0xFFAEEA00;
	public inline function get_yellow():FlxColor return 0xFFFFEB3B;
	public inline function get_orange():FlxColor return 0xFFFF9800;
	
	public inline function get_black():FlxColor return 0xFF000000;
	public inline function get_white():FlxColor return 0xFFFFFFFF;
	public inline function get_gray():FlxColor return 0xFF212121;
	public inline function get_transWhite():FlxColor {
		var white = FlxColor.WHITE;
		white.alphaFloat = 0.25;
		return white;
	}
	
	public function getName(color:FlxColor) {
		return
		switch (color) {
			case red: "Red";
			case pink: "Pink";
			case purple: "Purple";
			case blue: "Blue";
			case green: "Green";
			case lime: "Lime";
			case yellow: "Yellow";
			case orange: "Orange";
			case black: "Black";
			case white: "White";
			default: "Unknown";
		}
	}
	
	public function new() {}
	
}