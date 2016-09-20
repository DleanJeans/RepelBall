package systems;

import flixel.math.FlxPoint;

class MultiPoint extends FlxPoint {
	public var points(default, null):Map<String, FlxPoint>;
	
	public function new(X:Float = 0, Y:Float = 0) {
		super(X, Y);
		points = new Map<String, FlxPoint>();
	}
	
	public inline function getPoint(name:String, x:Float = 0, y:Float = 0):FlxPoint {
		if (!points.exists(name))
			points.set(name, FlxPoint.get(x, y));
		return points.get(name);
	}
	
	public inline function removePoint(name:String):Bool {
		return points.remove(name);
	}
	
	public inline function multiplyPoints() {
		set(1, 1);
		for (point in points) {
			x *= point.x;
			y *= point.y;
		}
	}
	
	public inline function addPoints() {
		set();
		for (point in points)
			addPoint(point);
	}
}