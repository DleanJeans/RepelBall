package states;

import flixel.FlxG;
import flixel.FlxSubState;
import flixel.text.FlxText;

class WarningState extends FlxSubState {
	public var text(default, null):FlxText;
	
	override public function create():Void {
		bgColor = Game.color.black;
		bgColor.alphaFloat = 0.75;
		
		text = new FlxText();
		text.size = 40;
		text.text = "Team Colors cannot be the same";
		text.fieldWidth = FlxG.width * 0.75;
		text.alignment = FlxTextAlign.CENTER;
		text.screenCenter();
		add(text);
	}
	
	override public function update(elapsed:Float):Void {
		closeOnAnyInput();
		super.update(elapsed);
	}
	
	private function closeOnAnyInput() {
		if (FlxG.mouse.justPressed || FlxG.keys.justPressed.ANY)
			close();
	}
}