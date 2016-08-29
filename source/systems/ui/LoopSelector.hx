package systems.ui;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import systems.ArrayLoop;
using flixel.util.FlxSpriteUtil;
using flixel.addons.util.position.FlxPosition;

class LoopSelector extends FlxSpriteGroup {
	public var label(default, null):FlxText;
	public var background(default, null):FlxSprite;
	public var prevButton(default, null):FlxButton;
	public var nextButton(default, null):FlxButton;
	public var midText(default, null):FlxText;
	
	private var arrayLoop:ArrayLoop<Dynamic>;
	
	private var _labelText:String;
	private var _labelFieldWidth:Int;
	private var _width:Int;
	private var _height:Int;
	
	public function new<T>(x:Float, y:Float, width:Int = 300, height:Int = 30, labelText:String, values:Array<T>, labelFieldWidth:Int = 200) {
		super();
		
		assignArguments(width, height, labelText, labelFieldWidth);
		createStuff(values);
		setupStuff();
		addStuff();
		moreSetup(x, y);
	}
	
	public function getCurrentValue() {
		return arrayLoop.current();
	}
	
	private function assignArguments(width:Int, height:Int, labelText:String, labelFieldWidth:Int) {
		_width = width;
		_height = height;
		_labelText = labelText;
		_labelFieldWidth = labelFieldWidth;
	}
	
	private function createStuff<T>(values:Array<T>) {
		arrayLoop = new ArrayLoop<T>(values);
		label = new FlxText();
		background = new FlxSprite();
		prevButton = new FlxButton();
		nextButton = new FlxButton();
		midText = new FlxText();
	}
	
	private function setupStuff() {
		setupLabel();
		setupBackground();
		setupPrevAndNextButton();
		setupMidText();
	}
	
	private function setupLabel() {
		label.size = 25;
		label.text = _labelText;
		label.fieldWidth = _labelFieldWidth;
	}
	
	private function setupBackground() {
		Game.bitmapCacher.drawRoundRect(background, _width, _height);
		background.x = label.getRight() + 20;
	}
	
	private function setupPrevAndNextButton() {
		var arrowSize:Int = cast _height * 0.65;
		
		Game.bitmapCacher.drawArrow(prevButton, arrowSize);
		prevButton.onUp.callback = prevValue;
		prevButton.angle = -90;
		prevButton.setCenterY(background.getCenterY());
		prevButton.x = background.x + prevButton.y;
		
		Game.bitmapCacher.drawArrow(nextButton, arrowSize);
		nextButton.onUp.callback = nextValue;
		nextButton.angle = 90;
		nextButton.setCenterY(background.getCenterY());
		nextButton.setRight(background.getRight() - nextButton.y);
	}
	
	private function prevValue() {
		var value = arrayLoop.prev();
		showValue(value);
	}
	
	private function nextValue() {
		var value = arrayLoop.next();
		showValue(value);
	}
	
	private inline function showValue(value:Dynamic) {
		midText.text = Std.string(value);
	}
	
	private function setupMidText() {
		midText.size = 25;
		midText.fieldWidth = _width;
		midText.alignment = FlxTextAlign.CENTER;
		midText.setCenter(background.getCenter());
	}
	
	private function addStuff() {
		add(label);
		add(background);
		add(prevButton);
		add(nextButton);
		add(midText);
	}
	
	private function moreSetup(x:Float, y:Float) {
		setPosition(x, y);
		showValue(arrayLoop.current());
	}
	
}