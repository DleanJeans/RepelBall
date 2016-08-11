package;

class Game {
	private static inline var UNIT_LENGTH = 16;
	public static inline function unitLength(times:Float = 1):Int {
		return cast UNIT_LENGTH * times;
	}
}