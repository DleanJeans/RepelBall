package;

import systems.Level;
import systems.Renderer;
import systems.Signals;
import systems.collisions.Collision;

class Game {
	private static inline var UNIT_LENGTH = 16;
	public static inline function unitLength(times:Float = 1):Int {
		return cast UNIT_LENGTH * times;
	}
	
	public static var level(default, null):Level;
	
	public static var signals(default, null):Signals;
	public static var renderer(default, null):Renderer;
	public static var collision(default, null):Collision;
	
	public static function init() {
		signals = new Signals();
		renderer = new Renderer();
		collision = new Collision();
	}
	
	public static inline function startNewLevel() {
		level = new Level();
	}
}