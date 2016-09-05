package states.group;

import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.util.FlxAxes;
import flixel.util.FlxSignal;
import ui.AnyInputText;
using flixel.addons.util.position.FlxPosition;

class MinimalTitleScreen extends FlxSpriteGroup {
	public var titleText(default, null):FlxText;
	public var anyInputText(default, null):AnyInputText;
	public var creditText(default, null):FlxText;
	
	public var anyInput:FlxSignal;
	
	public function new() {
		super();
		
		createStuff();
		setupStuff();
		addStuff();
	}
	
	private function createStuff() {
		anyInput = new FlxSignal();
		
		titleText = new FlxText(0, 50, 0, "RepelBall", 75);
		anyInputText = new AnyInputText();
		creditText = new FlxText(0, 0, FlxG.width * 0.9, "Developed by Dlean Jeans\nPowered by HaxeFlixel", 25);
	}
	
	private function setupStuff() {
		titleText.screenCenter(FlxAxes.X);
		creditText.setMidBottom(FlxPosition.screenMidBottom);
		creditText.y -= 10;
		creditText.alignment = FlxTextAlign.CENTER;
	}
	
	private function addStuff() {
		add(titleText);
		add(anyInputText);
		add(creditText);
	}
	
	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		if (FlxG.mouse.justPressed || FlxG.keys.justPressed.ANY)
			anyInput.dispatch();
	}
	
}