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
	
	public function new<T>(x:Float, y:Float, width:Int = 300, height:Int = 30, labelText:String, values:Array<T>, labelFieldWidth:Int = 200) {
		super();
		
		setPosition(x, y);
		
		arrayLoop = new ArrayLoop<T>(values);
		
		label = new FlxText();
		background = new FlxSprite();
		prevButton = new FlxButton();
		nextButton = new FlxButton();
		midText = new FlxText();
		
		add(label);
		add(background);
		add(prevButton);
		add(nextButton);
		add(midText);
		
		label.size = 25;
		label.text = labelText;
		label.fieldWidth = labelFieldWidth;
		
		Game.bitmapCacher.drawRoundRect(background, width, height);
		background.x = label.getRight() + 20;
		
		var arrowSize:Int = cast height * 0.65;
		
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
		
		showValue(arrayLoop.current());
		midText.size = 25;
		midText.fieldWidth = width;
		midText.alignment = FlxTextAlign.CENTER;
		midText.setCenter(background.getCenter());
	}
	
	private function prevValue() {
		var value = arrayLoop.prev();
		showValue(value);
	}
	
	private function nextValue() {
		var value = arrayLoop.next();
		showValue(value);
	}
	
	public inline function showValue(value:Dynamic) {
		midText.text = Std.string(value);
	}
	
	public function getCurrentValue() {
		
	}
	
}