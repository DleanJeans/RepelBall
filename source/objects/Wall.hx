package objects;

import flixel.FlxSprite;

class Wall extends FlxSprite {
	public function new() {
		super();
		elasticity = 1;
	}
	
	public function resetWall(x:Float, y:Float, width:Int, height:Int, facing:Int) {
		setPosition(x, y);
		setSize(width, height);
		this.facing = facing;
		drawWall();
	}
	
	public inline function drawWall() {
		Game.renderer.draw(this, width, height);
	}
	
}