package systems.controllers;

import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import objects.Paddle;
import objects.Wall;
import systems.Signals.Signal;
import systems.ai.ExpressionAI;
import systems.ai.SimpleAI;

typedef ControllerGroup = FlxTypedGroup<Controller>;

class ControllerList extends ControllerGroup {
	public function new() {
		super();
		Game.level.addSystem(this);
		kill();
	}
	
	public inline function addNewExpressionAI(?paddle:Paddle) {
		var ai = new ExpressionAI(paddle);
		add(ai);
	}
	
	public inline function addNewSimpleAI(?paddle:Paddle) {
		var ai = new SimpleAI(paddle);
		add(ai);
	}
	
	public function addNewPlayerController(?paddle:Paddle) {
		if (FlxG.onMobile)
			addNewTouch(paddle);
		else addNewKeyboard(paddle);
	}
	
	
	public inline function addNewKeyboard(?paddle:Paddle) {
		#if !FLX_NO_KEYBOARD
		var keyboard = new Keyboard(paddle);
		add(keyboard);
		#end
	}

	
	public inline function addNewTouch(?paddle:Paddle) {
		var touch = new Touch(paddle);
		add(touch);
	}
}