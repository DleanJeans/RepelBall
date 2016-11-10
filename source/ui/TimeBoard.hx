package ui;

import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.util.FlxStringUtil;

class TimeBoard extends FlxSpriteGroup {
	public var text(default, null):FlxText;

	public function new() {
		super();
		
		text = new FlxText();
		text.size = Settings.unitLength();
		add(text);
		
		visible = false;
		active = false;
		
		Game.stage.addUI(this);
	}
	
	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		
		updateText();
	}
	
	private function updateText() {
		text.text = FlxStringUtil.formatTime(Game.timers.roundTimer.elapsedTime, true);
	}
	
	public function toggle() {
		visible = !visible;
		active = !active;
	}
	
}