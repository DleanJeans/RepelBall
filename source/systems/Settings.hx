package systems;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.system.FlxAssets;

class Settings {
	public function new() {
		setSeparateBias();
		setDefaultFont();
		disableFlixelMouseOnJs();
	}
	
	private inline function setSeparateBias() {
		FlxObject.SEPARATE_BIAS = Game.unitLength();
	}
	
	private inline function setDefaultFont() {
		FlxAssets.FONT_DEFAULT = AssetPaths.SquareFont__ttf;
	}
	
	private inline function disableFlixelMouseOnJs() {
		#if js
		FlxG.mouse.useSystemCursor = true;
		if (FlxG.html5.onMobile)
			FlxG.mouse.visible = false;
		#end
	}
	
}