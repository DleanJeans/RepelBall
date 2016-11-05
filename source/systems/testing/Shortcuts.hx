package systems.testing;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.input.keyboard.FlxKeyList;

typedef Shortcut = {
	shortcutFunction:Void->Void,
	?notifyingFunction:Void->Void
}

class Shortcuts extends FlxBasic {
	public var shortcuts(default, null):Map<Int, Shortcut> = new Map<Int, Shortcut>();
	private var _keyList:Array<Bool> = new Array<Bool>();
	
	public function new() {
		super();
		#if testing
		FlxG.console.registerClass(Game);
		visible = false;
		Game.stage.addSystem(this);
		
		setShortcut(1, Game.speed.toggleSlowMo, Game.notifier.notify.bind("SlowMo Toggled!"));
		setShortcut(2, Game.powerups.spawner.spawnRandom, Game.notifier.notify.bind("Spawn Powerup!"));
		setShortcut(3, Game.watermark.toggle);
		#end
	}
	
	#if testing
	public inline function setShortcut(from0to9:Int, shortcutFunction:Void->Void, ?notifyingFunction:Void->Void) {
		shortcuts[from0to9] = {
			shortcutFunction: shortcutFunction,
			notifyingFunction: notifyingFunction
		};
	}
	
	public inline function removeShortcut(from0to9:Int) {
		shortcuts.remove(from0to9);
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
		var shortcut:Shortcut = null;
		var run:Bool;
		
		for (i in 0..._keyList.length) {
			shortcut = shortcuts[i];
			run = _keyList[i];
			
			if (shortcut != null && run) {
				shortcut.shortcutFunction();
				if (shortcut.notifyingFunction != null)
					shortcut.notifyingFunction();
			}
		}
	}
	#end
	
}