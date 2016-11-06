package systems.testing;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.math.FlxPoint;

class ClickSpawner extends FlxBasic {
	public var spawn:Void->FlxObject;
	public var addToStage:FlxObject->Void;
	public var notify:Void->Void;
	
	private var _mousePosition:FlxPoint;
	private var _object:FlxObject;
	private var _message:String;
	
	public function new() {
		super();
		visible = false;
		setToSpawnNothing();
		Game.stage.addSystem(this);
	}
	
	public inline function getMessage() {
		return _message;
	}
	
	public function toggleSpawningPowerup() {
		if (spawn == spawnNothing) {
			enableSpawningPowerup(0);
			_message = "Click To Spawn Powerup";
		}
		else {
			setToSpawnNothing();
			_message = "Click To Spawn Powerup OFF";
		}
		
	}
	
	public function enableSpawningPowerup(type:Int) {
		spawn = Game.powerups.spawner.spawn.bind(type);
		addToStage = cast Game.stage.addPowerup;
		notify = Game.notifier.notify.bind("Powerup Spawned!");
	}
	
	public inline function setToSpawnNothing() {
		spawn = spawnNothing;
	}
	
	private function spawnNothing() { return null; }
	
	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		
		if (spawn == spawnNothing) return;
		spawnOnMouseClick();
	}
	
	private function spawnOnMouseClick() {
		if (FlxG.mouse.justPressed) {
			_mousePosition = FlxG.mouse.getWorldPosition(_mousePosition);
			
			_object = spawn();
			_object.setCenter(_mousePosition);
			addToStage(_object);
			notify();
		}
	}
	
}