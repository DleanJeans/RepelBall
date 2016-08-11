package;
import systems.Renderer;

class Game {
	private static inline var UNIT_LENGTH = 16;
	public static inline function unitLength(times:Float = 1):Int {
		return cast UNIT_LENGTH * times;
	}
	
	public static var renderer(default, null):Renderer;
	
	public static function init() {
		renderer = new Renderer();
	}
}