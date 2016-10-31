package states.group;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.util.FlxAxes;
import flixel.util.FlxSignal;

class MinimalTitleScreen extends FlxSpriteGroup {
	public var titleText(default, null):FlxText;
	public var creditText(default, null):FlxText;
	public var icon(default, null):FlxSprite;
	
	public var start:FlxSignal;
	
	public function new() {
		super();
		
		createStuff();
		setupStuff();
		addStuff();
	}
	
	private function createStuff() {
		start = new FlxSignal();
		
		titleText = new FlxText(0, 50, 0, "RepelBall", 75);
		creditText = new FlxText(0, 0, FlxG.width * 0.9, "Developer: Dlean Jeans\nGame Engine: HaxeFlixel\nInspiration: Juice it or Lose it", 25);
		icon = new FlxSprite(0, 0, AssetPaths.big_icon__png);
	}
	
	private function setupStuff() {
		titleText.screenCenter(FlxAxes.X);
		creditText.setMidBottom(Positioner.screenMidBottom);
		creditText.y -= 10;
		creditText.alignment = FlxTextAlign.CENTER;
		icon.screenCenter();
		
		Game.notifier.notify(Game.messages.askForAnyInput, Game.notifier.fadeInOut.bind(1));
	}
	
	private function addStuff() {
		add(titleText);
		add(creditText);
		add(icon);
		add(Game.notifier.text);
	}
	
	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		if (Game.anyInput.receivedAny())
			start.dispatch();
	}
	
}