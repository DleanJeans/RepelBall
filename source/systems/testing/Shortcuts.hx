package systems.testing;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.input.keyboard.FlxKeyList;
import flixel.util.FlxColor;

typedef Shortcut = {
	shortcutFunction:Void->Void,
	?message:String,
	?getMessage:Void->String,
	?effectFunction:Void->Void,
	?color:FlxColor
}

class Shortcuts extends FlxBasic {
	public var shortcuts(default, null):Array<Shortcut> = new Array<Shortcut>();
	private var _keyList:Array<Bool> = new Array<Bool>();
	
	public function new() {
		super();
		#if testing
		FlxG.console.registerClass(Game);
		visible = false;
		Game.stage.addSystem(this);
		
		addShortcut(Game.framerateCounter.toggleVisible);
		addShortcut(Game.speed.toggleSlowMo, null, Game.messages.getSlowMoActivation);
		addShortcut(Game.clickSpawner.switchPowerup, null, Game.clickSpawner.getMessage);
		addShortcut(Game.timeBoard.toggle);
		addShortcut(Game.watermark.toggle);
		#end
	}
	
	#if testing
	public function addShortcut(shortcutFunction:Void->Void, 
	?message:String, ?getMessage:Void->String, ?effectFunction:Void->Void, color:FlxColor = FlxColor.WHITE) {
		if (shortcuts.length > 9) {
			FlxG.log.warn("Cannot addShortcut()! Shortcut slots full!");
			return;
		}
		
		for (i in 1...10) {
			if (shortcuts[i] == null) {
				shortcuts[i] = {
					shortcutFunction: shortcutFunction,
					message: message,
					getMessage: getMessage,
					effectFunction: effectFunction,
					color: color
				};
				return;
			}
		}
	}
	
	public inline function removeShortcut(shortcut:Shortcut) {
		shortcuts.remove(shortcut);
	}
	
	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		
		if (FlxG.keys.justPressed.SPACE)
			Game.notifier.toggleActivation();
		updateKeyList();
		runShortcuts();
	}
	
	private function updateKeyList() {
		var keyList:FlxKeyList = FlxG.keys.justPressed;
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
		var message:String;
		var run:Bool;
		
		for (i in 1..._keyList.length) {
			shortcut = shortcuts[i];
			run = _keyList[i];
			
			if (run && shortcut != null) {
				shortcut.shortcutFunction();
				if (containsMessage(shortcut)) {
					message = getMessage(shortcut);
					Game.notifier.notify(message, shortcut.effectFunction, shortcut.color);
				}
			}
		}
	}
	
	private inline function containsMessage(shortcut:Shortcut) {
		return shortcut.message != null || shortcut.getMessage != null;
	}
	
	private inline function getMessage(shortcut:Shortcut) {
		return shortcut.message != null ? shortcut.message : shortcut.getMessage();
	}
	#end
	
}