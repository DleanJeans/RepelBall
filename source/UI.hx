package;
import flixel.FlxG;

class UI {
	public static var colorSwatch:ColorSwatch = {};
	public static var loopSelector:LoopSelector = {};
	public static var teamSettings:TeamSettings = {};
	public static var message:Message = {};

	public static function init() {
		defaultUI();
		#if mobile
		mobileUI();
		#else
		nonMobileUI();
		#end
	}
	
	private static function defaultUI() {
		message.fieldWidth = FlxG.width * 0.85;
		teamSettings.paddleBackSize = 150;
		colorSwatch.selectorWidth = 6;
	}
	
	private static function mobileUI() {
		colorSwatch.size = 50;
		colorSwatch.labelSize = 30;
		
		loopSelector.textSize = 35;
		loopSelector.height = 60;
		loopSelector.spaceY = 0;
		
		teamSettings.spaceX = -20;
		teamSettings.teamNameSize = 40;
	}
	
	private static function nonMobileUI() {
		colorSwatch.size = 30;
		colorSwatch.labelSize = 20;
		
		loopSelector.textSize = 25;
		loopSelector.height = 30;
		loopSelector.spaceY = 20;
		
		teamSettings.spaceX = 20;
		teamSettings.teamNameSize = 30;
	}
	
}

typedef ColorSwatch = {
	?size:Int,
	?labelSize:Int,
	?selectorWidth:Int,
	?tweenDuration:Float,
}

typedef LoopSelector = {
	?textSize:Int,
	?height:Int,
	?spaceY:Int,
}

typedef TeamSettings = {
	?spaceX:Int,
	?teamNameSize:Int,
	?paddleBackSize:Int,
}

typedef Message = {
	?fieldWidth:Float,
}