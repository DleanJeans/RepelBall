package objects;

import flixel.FlxSprite;
import flixel.util.FlxColor;
using flixel.util.FlxSpriteUtil;

class Ball extends FlxSprite {
	public function new() {
		super();
		elasticity = 1;
		drawBall();
	}
	
	private inline function drawBall() {
		Game.renderer.drawUnit(this, 1, 1);
	}
}