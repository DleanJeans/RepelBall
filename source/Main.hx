package;

import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxState;
import openfl.display.Sprite;
import states.MenuState;

class Main extends Sprite
{
	public function new()
	{
		var drawFramerate =
		#if debug 30
		#else 60
		#end;
		
		super();
		// init Game before first state create()
		FlxG.signals.preStateCreate.addOnce(function(state:FlxState) Game.init());
		addChild(new FlxGame(600, 800, MenuState, 1, 60, drawFramerate, true));
	}
}