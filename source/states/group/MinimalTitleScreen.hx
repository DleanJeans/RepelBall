package states.group;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.util.FlxAxes;
import flixel.util.FlxSignal;
import ui.AnyInputText;

class MinimalTitleScreen extends FlxSpriteGroup {
	public var titleText(default, null):FlxText;
	public var anyInputText(default, null):AnyInputText;
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
		anyInputText = new AnyInputText();
		creditText = new FlxText(0, 0, FlxG.width * 0.9, "Developed by Dlean Jeans\nPowered by HaxeFlixel", 25);
		icon = new FlxSprite(0, 0, AssetPaths.logo__png);
	}
	
	private function setupStuff() {
		titleText.screenCenter(FlxAxes.X);
		creditText.setMidBottom(Positioner.screenMidBottom);
		creditText.y -= 10;
		creditText.alignment = FlxTextAlign.CENTER;
		icon.screenCenter();
	}
	
	private function addStuff() {
		add(titleText);
		add(anyInputText);
		add(creditText);
		add(icon);
	}
	
	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		if (Game.anyInput.anyInputReceived())
			start.dispatch();
	}
	
}