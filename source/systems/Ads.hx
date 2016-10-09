package systems;

import extension.admob.AdMob;
import extension.admob.GravityMode;
import flixel.FlxG;
import flixel.FlxState;
import states.MenuState;
import states.PlayState;

#if mobile
class Ads {
	public static inline var BANNER_AD_ID = "ca-app-pub-8112894826901791/6410792864";
	public static inline var INTERSTITIAL_AD_ID = "	ca-app-pub-8112894826901791/7887526066";
	
	public function new() {
		#if android
		AdMob.initAndroid(BANNER_AD_ID, INTERSTITIAL_AD_ID, GravityMode.BOTTOM);
		#end
		
		// init banner ad but not show it
		showBanner();
		
		FlxG.signals.preStateCreate.add(showAndHideBanner);
	}
	
	private function showAndHideBanner(state:FlxState) {
		switch (Type.getClass(state)) {
			case MenuState:
				showBanner();
			case PlayState:
				hideBanner();
		}
	}
	
	public inline function showBanner() {
		AdMob.showBanner();
	}
	
	public inline function hideBanner() {
		AdMob.hideBanner();
	}
	
}
#end