package objects;

import flixel.FlxSprite;

class Wall extends FlxSprite {
	public function new() {
		super();
		immovable = true;
	}
	
	public function resetWall(x:Float, y:Float, width:Int, height:Int, facing:Int) {
		setPosition(x, y);
		setSize(width, height);
		this.facing = facing;
		drawWall();
		alpha = 0.75;
	}
	
	public inline function drawWall() {
		Game.renderer.drawWall(this);
	}
	
}