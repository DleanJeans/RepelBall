package systems;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.input.keyboard.FlxKeyList;


class TestingShortcuts extends FlxBasic {
	public var shortcuts(default, null):Array<Void->Void> = new Array<Void->Void>();
	private var _keyList:Array<Bool> = new Array<Bool>();
	
	public function new() {
		super();
		#if (testing && !FLX_NO_KEYBOARD)
		visible = false;
		Game.stage.addSystem(this);
		
		setShortcut(1, Game.speed.toggleSlowMo);
		setShortcut(2, Game.powerups.spawner.spawnRandom);
		#end
	}
	
	#if (testing && !FLX_NO_KEYBOARD)
	public inline function setShortcut(from0to9:Int, shortcut:Void->Void) {
		shortcuts[from0to9] = shortcut;
	}
	
	public inline function removeShortcut(shortcut:Void->Void) {
		shortcuts.remove(shortcut);
	}
	
	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		
		updateKeyList();
		runShortcuts();
	}
	
	private function updateKeyList() {
		var keyList:FlxKeyList = FlxG.keys.justPressed;
		_keyList[0] = keyList.ZERO;
		_keyList[1] = keyList.ONE;
		_keyList[2] = keyList.TWO;
		_keyList[3] = keyList.THREE;
		_keyList[4] = keyList.FOUR;
		_keyList[5] = keyList.FIVE;
		_keyList[6] = keyList.SIX;
		_keyList[7] = keyList.SEVEN;
		_keyList[8] = keyList.EIGHT;
		_keyList[9] = keyList.NINE;
	}
	
	private function runShortcuts() {
		var shortcut:Void->Void = null;
		var run:Bool;
		
		for (i in 0..._keyList.length) {
			shortcut = shortcuts[i];
			run = _keyList[i];
			
			if (shortcut != null && run)
				shortcut();
		}
	}
	#end
	
}