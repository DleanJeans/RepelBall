package objects.personality;

import flixel.group.FlxSpriteGroup;
import objects.Paddle;

class Face extends FlxSpriteGroup {
	public var eyes(default, null):EyePair;
	public var mouth(default, null):Mouth;
	public var paddle:Paddle;
	
	public function new(paddle:Paddle) {
		super();
		this.paddle = paddle;
		ignoreDrawDebug = true;
		
		eyes = new EyePair();
		mouth = new Mouth();
		
		eyes.attachToPaddle(paddle);
		mouth.attachToPaddle(paddle);
		
		add(eyes);
		add(mouth);
	}
	
	override public function update(elapsed:Float):Void {
		reattachToPaddle();
		super.update(elapsed);
	}
	
	public inline function reattachToPaddle() {
		setPosition(paddle.x, paddle.y);
	}
	
}