package;

import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxState;
import openfl.Lib;
import openfl.display.Sprite;
import states.MenuState;

class Main extends Sprite {
	public var gameWidth(get, never):Int;
	public var gameHeight(get, never):Int;
	public var drawFramerate(get, never):Int;
	
	public function new() {
		super();
		// init Game before first state create()
		FlxG.signals.preStateCreate.addOnce(function(state:FlxState) Game.init());
		addChild(new FlxGame(gameWidth, gameHeight, MenuState, 1, 60, drawFramerate, true));
	}
	
	inline function get_gameWidth():Int {
		return 600;
	}
	
	inline function get_gameHeight():Int {
		return
		#if mobile
		cast stage.stageHeight / stage.stageWidth * gameWidth
		#else
		800
		#end;
	}
	
	inline function get_drawFramerate():Int {
		return
		#if debug 30
		#else 60
		#end;
	}
	
	
}