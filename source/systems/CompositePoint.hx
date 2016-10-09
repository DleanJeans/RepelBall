package systems;

import flixel.math.FlxPoint;

class CompositePoint extends FlxPoint {
	public var points(default, null):Map<String, FlxPoint>;
	
	public function new(X:Float = 0, Y:Float = 0) {
		super(X, Y);
		points = new Map<String, FlxPoint>();
	}
	
	override public function destroy() {
		super.destroy();
		for (point in points)
			point.put();
	}
	
	public inline function getPoint(name:String, x:Float = 0, y:Float = 0):FlxPoint {
		if (!points.exists(name))
			points.set(name, FlxPoint.get(x, y));
		return points.get(name);
	}
	
	public inline function removePoint(name:String):Bool {
		return points.remove(name);
	}
	
	public inline function product():FlxPoint {
		set(1, 1);
		for (point in points) {
			x *= point.x;
			y *= point.y;
		}
		return this;
	}
	
	public inline function sum():FlxPoint {
		set();
		for (point in points)
			addPoint(point);
		return this;
	}
}