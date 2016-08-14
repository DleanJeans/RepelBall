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
		super();
		// init Game before first state create()
		FlxG.signals.preStateCreate.addOnce(function(state:FlxState) Game.init());
		addChild(new FlxGame(480, 640, MenuState, 1, 60, 30, true));
	}
}