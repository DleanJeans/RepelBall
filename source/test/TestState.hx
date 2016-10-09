package test;

import flash.display.BitmapData;
import flash.display.Sprite;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import format.SVG;
import openfl.Assets;

class TestState extends FlxSubState {
	var svg:String = AssetPaths.Icon__svg;
	
	override public function create() {
		var sprite = new FlxSprite();
		sprite.loadGraphic(Game.renderer.getSvg(svg));
		sprite.screenCenter();
		
		add(sprite);
	}
	
	override public function update(elapsed:Float) {
		super.update(elapsed);
	}
	
}