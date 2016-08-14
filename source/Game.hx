package;

import systems.Level;
import systems.Positioner;
import systems.Renderer;
import systems.Signals;
import systems.collisions.Collision;
import systems.controllers.ControllerList;
import systems.controllers.PaddleMovement;

class Game {
	private static inline var UNIT_LENGTH = 16;
	public static inline function unitLength(times:Float = 1):Int {
		return cast UNIT_LENGTH * times;
	}
	
	public static var level(default, null):Level;
	
	public static var signals(default, null):Signals;
	public static var renderer(default, null):Renderer;
	public static var collision(default, null):Collision;
	public static var paddleMovement(default, null):PaddleMovement;
	public static var controllers(default, null):ControllerList;
	public static var position(default, null):Positioner;
	
	public static function init() {
		signals = new Signals();
		renderer = new Renderer();
		collision = new Collision();
		paddleMovement = new PaddleMovement();
		controllers = new ControllerList();
		position = new Positioner();
	}
	
	public static inline function startNewLevel() {
		level = new Level();
	}
	
	public static function anyNull(objects:Array<Dynamic>) {
		for (o in objects) {
            if (o == null)
                return true;
        }
        return false;
	}
}