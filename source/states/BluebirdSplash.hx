package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.util.FlxSignal;
import flixel.util.FlxTimer;

class BluebirdSplash extends FlxSubState {
	public var logo(default, null):FlxSprite;
	public var done(default, null):FlxSignal;
	
	override public function create():Void {
		bgColor = Game.color.white;
		
		logo = new FlxSprite(0, 0, AssetPaths.bluebird_logo__9__png);
		logo.setGraphicSize(cast FlxG.width * 0.8);
		logo.updateHitbox();
		logo.setCenter(Positioner.screenCenter);
		add(logo);
		
		done = new FlxSignal();
		
		new FlxTimer().start(3, switchToMenu);
	}
	
	private function switchToMenu(timer:FlxTimer) {
		camera.fade(Game.color.gray, 0.5, false, function() {
			Game.states.menu();
			camera.stopFX();
		});
	}
	
}