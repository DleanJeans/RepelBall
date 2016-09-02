package states;

import flixel.FlxG;
import flixel.FlxSubState;
import systems.match.Team;
import ui.AnyInputText;
import ui.WinText;

class WinState extends FlxSubState {
	public var winText(default, null):WinText;
	public var anyInputText(default, null):AnyInputText;
	
	override public function create():Void {
		winText = new WinText();
		anyInputText = new AnyInputText();
		
		winText.updateText();
		
		add(winText);
		add(anyInputText);
	}
	
	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		Game.states.closeOnAnyInput(this, Game.signals.postMatchOver.dispatch);
	}
	
}