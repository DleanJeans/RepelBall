package states;

import flixel.FlxG;
import flixel.FlxSubState;
import systems.match.Team;
import ui.WinText;

class WinState extends FlxSubState {
	public var winText(default, null):WinText;
	
	override public function create():Void {
		winText = new WinText();
		add(winText);
		
		Game.notifier.notify(Game.messages.askForAnyInput, Game.notifier.fadeInOut.bind(1));
		closeCallback = function() Game.notifier.stopFadingInOut();
	}
	
	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		Game.anyInput.listen([close, Game.signals.postMatchOver.dispatch]);
	}
	
}