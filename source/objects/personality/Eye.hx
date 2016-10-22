package objects.personality;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxPointer;
import flixel.input.mouse.FlxMouse;
import flixel.math.FlxAngle;
import flixel.util.FlxColor;
import objects.Ball;

class Eye extends FlxSpriteGroup {
	public var eyeWhite(default, null):FlxSprite;
	public var pupil(default, null):FlxSprite;
	public var pupilColor(get, set):FlxColor;
	
	public var ballTarget(default, set):Ball;
	public var pointerTarget(default, set):FlxPointer;
	
	private var _target:Dynamic;
	private var _targetType:Class<Dynamic>;

	public function new() {
		super();
		createStuff();
		setupStuff();
		addStuff();
	}
	
	override public function update(elapsed:Float):Void {
		look();
		super.update(elapsed);
	}
	
	public function clearTarget() {
		ballTarget = null;
		pointerTarget = null;
	}
	
	private function look() {
		switch (Type.getClass(_target)) {
			case Ball:
				lookAtBall();
			case FlxMouse:
				lookAtPointer();
			default:
				idle();
		}
	}
	
	private function idle() {
		switch (_targetType) {
			case Ball:
				lookAtFacing();
			case _:
				centerPupil();
		}
	}
	
	private inline function centerPupil() {
		pupil.setCenter(eyeWhite.getCenter());
	}
	
	private function lookAtFacing() {
		var angle = FlxAngle.angleFromFacing(facing, true);
		setEyeAngle(angle);
	}
	
	private function lookAtBall() {
		var angle = FlxAngle.angleBetween(this, ballTarget, true);
		setEyeAngle(angle);
	}
	
	private function lookAtPointer() {
		var angle = getPointerAngle();
		setEyeAngle(angle);
	}
	
	private function getPointerAngle():Float {
		return FlxAngle.angleBetweenMouse(this, true);
	}
	
	private function setEyeAngle(angle:Float) {
		var point = FlxAngle.getCartesianCoords(3, angle);
		pupil.setCenter(eyeWhite.getCenter().addPoint(point));
		point.put();
	}
	
	private function createStuff() {
		eyeWhite = new FlxSprite();
		pupil = new FlxSprite();
	}
	
	private function setupStuff() {
		Game.renderer.drawEyeWhite(eyeWhite);
		Game.renderer.drawPupil(pupil);
		pupilColor = Game.color.black;
		
		eyeWhite.solid = pupil.solid = false;
		
		centerPupil();
	}
	
	private function addStuff() {
		add(eyeWhite);
		add(pupil);
	}
	
	function get_pupilColor():FlxColor {
		return pupil.color;
	}
	
	function set_pupilColor(newColor:FlxColor):FlxColor {
		return pupil.color = newColor;
	}
	
	function set_ballTarget(newBall:Ball):Ball {
		_targetType = Ball;
		return _target = ballTarget = newBall;
	}
	
	function set_pointerTarget(newPointer:FlxPointer):FlxPointer {
		_targetType = FlxPointer;
		return _target = pointerTarget = newPointer;
	}
	
}