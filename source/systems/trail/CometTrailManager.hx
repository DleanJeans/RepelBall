package systems.trail;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxSpriteUtil;

typedef TrailMap = Map<FlxSprite, CometTrail>;

class CometTrailManager extends FlxTypedGroup<CometTrail> {
	public var canvas(default, null):FlxSprite;
	public var cooldown:Float = 0.02;
	public var nodeLimit:Int = 25;
	
	private var _map:TrailMap = new TrailMap();
	private var _elapsed:Float = 0;
	
	public function new() {
		super();
		canvas = new FlxSprite();
		canvas.makeGraphic(FlxG.width, FlxG.height, 0x0);
	}
	
	public inline function addSprite(sprite:FlxSprite) {
		var trail = new CometTrail(sprite, canvas);
		trail.nodeLimit = nodeLimit;
		_map.set(sprite, trail);
		add(trail);
	}
	
	public function removeSprite(sprite:FlxSprite) {
		var trail:CometTrail = getTrail(sprite);
		trail.destroy();
		_map.remove(sprite);
	}
	
	public function removeAll() {
		forEach(destroyTrail);
		clear();
	}
	
	private inline function destroyTrail(trail:CometTrail) {
		trail.destroy();
	}
	
	public inline function getTrail(sprite:FlxSprite):CometTrail {
		return _map.get(sprite);
	}
	
	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		_elapsed += elapsed;
		if (_elapsed >= cooldown) {
			_elapsed = 0;
			forEach(addNodeNow);
		}
	}
	
	private inline function addNodeNow(trail:CometTrail) {
		trail.addNodeNow();
	}
	
	override public function draw():Void {
		clearCanvas();
		super.draw();
	}
	
	public function clearCanvas() {
		FlxSpriteUtil.fill(canvas, 0x0);
	}
}