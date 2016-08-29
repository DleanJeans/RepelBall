package systems.ui;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
using flixel.util.FlxSpriteUtil;
using flixel.addons.util.position.FlxPosition;

class ColorSwatchSelector extends FlxSpriteGroup {
	public var label(default, null):FlxText;
	public var swatches(default, null):FlxSpriteGroup;
	public var selector(default, null):FlxSprite;
	public var maxColumns:Int;
	public var swatchWidth:Int;
	public var swatchHeight:Int;
	public var spacingX:Int;
	public var spacingY:Int;
	public var colorChangedCallback:ColorSwatchSelector->Void;
	
	private var selectorTween:FlxTween;
	private var selectedSwatch:FlxSprite;

	public function new(colors:Array<FlxColor>, x:Float = 0, y:Float = 0, swatchWidth:Int = 30, swatchHeight:Int = 30, maxColumns:Int = 4, spacingX:Int = 2, spacingY:Int = 2) {
		super();
		
		setPosition(x, y);
		
		this.maxColumns = maxColumns;
		this.swatchWidth = swatchWidth;
		this.swatchHeight = swatchHeight;
		this.spacingX = spacingX;
		this.spacingY = spacingY;
		
		label = new FlxText(0, 0, (swatchWidth + spacingX) * maxColumns, "Color", 20);
		label.alignment = FlxTextAlign.CENTER;
		
		swatches = new FlxSpriteGroup();
		
		var swatch:FlxSprite;
		for (color in colors) {
			swatch = new FlxSprite();
			swatch.makeGraphic(swatchWidth, swatchHeight);
			swatch.color = color;
			swatches.add(swatch);
			FlxMouseEventManager.add(swatch, selectSwatch);
		}
		
		selector = new FlxSprite();
		selector.makeGraphic(swatchWidth + 2, swatchHeight + 2, 0x0);
		selector.drawRect(0, 0, selector.width, selector.height, 0x0, { thickness:6, color:Game.colors.white });
		selector.setSize(0, 0);
		selector.centerOffsets();
		
		add(label);
		add(swatches);
		add(selector);
		
		updateLayout();
		
		selectSwatch(getFirstSwatch());
	}
	
	public inline function fixSelector() {
		moveSelectorTo(selectedSwatch != null ? selectedSwatch : getFirstSwatch());
	}
	
	private inline function getFirstSwatch() {
		return swatches.members[0];
	}
	
	private inline function selectSwatch(swatch:FlxSprite) {
		moveSelectorTo(swatch);
		selectedSwatch = swatch;
		if (colorChangedCallback != null)
			colorChangedCallback(this);
	}
	
	private function moveSelectorTo(swatch:FlxSprite, instantly:Bool = false) {
		if (instantly) {
			selector.setPosition(getFirstSwatch().getCenterX(), getFirstSwatch().getCenterY());
		}
		else {
			if (selectorTween != null && !selectorTween.finished)
				selectorTween.cancel();
			selectorTween = FlxTween.tween(selector, { x:swatch.getCenterX(), y:swatch.getCenterY()}, 0.25, { ease:FlxEase.quartOut});
		}
	}
	
	private function updateLayout() {
		var column = 0;
		var row = 0;
		
		for (swatch in swatches) {
			var x = swatches.x + (swatchWidth + spacingX) * column;
			var y = swatches.y + (swatchHeight + spacingY) * row;
			swatch.setPosition(x, y);
			
			column++;
			if (column >= maxColumns) {
				column = 0;
				row++;
			}
		}
		
		swatches.y = label.getBottom();
	}
	
	public inline function getColor() {
		return selectedSwatch.color;
	}
	
	public inline function getColorName() {
		return Game.colors.getName(getColor());
	}
	
	override public function destroy():Void {
		for (swatch in swatches) {
			FlxMouseEventManager.remove(swatch);
		}
		super.destroy();
	}
	
}