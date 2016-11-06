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
		
		Game.stage.addUI(this);
	}
	
	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		
		updateText();
	}
	
	private function updateText() {
		var timer = Game.timers.roundTimer;
		var totalTime = timer.elapsedLoops * timer.time + timer.elapsedTime;
		text.text = FlxStringUtil.formatTime(totalTime, true);
	}
	
	public function toggle() {
		visible = !visible;
		active = !active;
	}
	
}