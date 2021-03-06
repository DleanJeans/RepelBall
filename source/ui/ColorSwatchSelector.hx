package ui;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
using flixel.util.FlxSpriteUtil;

class ColorSwatchSelector extends FlxSpriteGroup {
	public var label(default, null):FlxText;
	public var swatches(default, null):FlxSpriteGroup;
	public var selector(default, null):FlxSprite;
	public var colors(default, null):Array<FlxColor>;
	public var index(default, null):Int = 0;
	
	public var maxColumns:Int;
	public var swatchWidth:Int;
	public var swatchHeight:Int;
	public var spacingX:Int;
	public var spacingY:Int;
	public var colorChangedCallback:ColorSwatchSelector->Void;
	
	private var firstSwatch(get, never):FlxSprite;
	private var selectorTween:FlxTween;
	private var selectedSwatch:FlxSprite;
	private var coolDownTimer:FlxTimer;

	public function new(colors:Array<FlxColor>, x:Float = 0, y:Float = 0, swatchWidth:Int = 50, swatchHeight:Int = 50, maxColumns:Int = 4, spacingX:Int = 2, spacingY:Int = 2) {
		super();
		
		assignArguments(colors, swatchWidth, swatchHeight, maxColumns, spacingX, spacingY);
		createStuff();
		setupStuff();
		addStuff();
		moreSetup();
	}
	
	override public function destroy():Void {
		removeMouseEvents();
		super.destroy();
	}
	
	private function removeMouseEvents() {
		for (swatch in swatches)
			FlxMouseEventManager.remove(swatch);
	}
	
	public function selectRandom(excludeIndex:Int = -1):Int {
		var index = FlxG.random.int(0, Game.color.list.length - 1, [excludeIndex]);
		selectByIndex(index);
		return this.index = index;
	}
	
	public function selectByIndex(index:Int) {
		this.index = boundSwatchIndex(index);
		var swatch = swatches.members[this.index];
		selectSwatch(swatch);
	}
	
	private function boundSwatchIndex(index:Int):Int {
		if (index < 0)
			index = 0;
		else if (index >= swatches.members.length)
			index %= swatches.members.length;
		return index;
	}
	
	public inline function fixSelector() {
		moveSelectorTo(selectedSwatch != null ? selectedSwatch : firstSwatch);
	}
	
	public inline function getColor() {
		return selectedSwatch.color;
	}
	
	public inline function getColorName() {
		return Game.color.getName(getColor());
	}
	
	private function assignArguments(colors:Array<FlxColor>, swatchWidth:Int, swatchHeight:Int, maxColumns:Int, spacingX:Int, spacingY:Int) {
		this.colors = colors;
		this.maxColumns = maxColumns;
		this.swatchWidth = swatchWidth;
		this.swatchHeight = swatchHeight;
		this.spacingX = spacingX;
		this.spacingY = spacingY;
	}
	
	private function createStuff() {
		label = new FlxText(0, 0, (swatchWidth + spacingX) * maxColumns, "Color", UI.colorSwatch.labelSize);
		label.alignment = FlxTextAlign.CENTER;
		swatches = new FlxSpriteGroup();
		selector = new FlxSprite();
		coolDownTimer = new FlxTimer();
	}
	
	private function setupStuff() {
		createSwatches();
		setupSelector();
		coolDownTimer.finished = true;
	}
	
	private function createSwatches() {
		var swatch:FlxSprite;
		for (color in colors) {
			swatch = new FlxSprite();
			swatch.makeGraphic(swatchWidth, swatchHeight);
			swatch.color = color;
			swatches.add(swatch);
			FlxMouseEventManager.add(swatch, selectSwatchIfCooledDown);
		}
	}
	
	private function setupSelector() {
		selector.makeGraphic(swatchWidth + 2, swatchHeight + 2, 0x0);
		selector.drawRect(0, 0, selector.width, selector.height, 0x0, { thickness:UI.colorSwatch.selectorWidth, color:Game.color.white });
		selector.setSize(0, 0);
		selector.centerOffsets();
	}
	
	private function addStuff() {
		add(label);
		add(swatches);
		add(selector);
	}
	
	private function moreSetup() {
		setPosition(x, y);
		updateLayout();
		selectFirstSwatchInstantly();
	}
	
	private inline function selectFirstSwatchInstantly() {
		selectSwatch(firstSwatch, true);
	}
	
	private function selectSwatchIfCooledDown(swatch:FlxSprite) {
		if (coolDownTimer.finished) {
			coolDownTimer.start(Settings.duration.paddleColorTween);
			selectSwatch(swatch);
		}
	}
	
	private inline function selectSwatch(swatch:FlxSprite, instantly:Bool = false) {
		selectedSwatch = swatch;
		moveSelectorTo(swatch, instantly);
		index = swatches.members.indexOf(swatch);
		callback();
	}
	
	private function moveSelectorTo(swatch:FlxSprite, instantly:Bool = false) {
		if (selectorTween != null && !selectorTween.finished)
			selectorTween.cancel();
			
		if (instantly)
			selector.setPosition(swatch.getCenterX(), swatch.getCenterY());
		else selectorTween = Game.tween.colorSwatchSelector(selector, swatch.getCenterX(), swatch.getCenterY());
	}
	
	private function callback() {
		if (colorChangedCallback != null)
			colorChangedCallback(this);
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
	
	inline function get_firstSwatch():FlxSprite {
		return swatches.members[0];
	}
	
}