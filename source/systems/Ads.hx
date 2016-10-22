package systems;

import extension.admob.AdMob;
import extension.admob.GravityMode;
import flixel.FlxG;
import flixel.FlxState;
import states.MenuState;
import states.PlayState;

#if mobile
class Ads {
	public static inline var BANNER_AD_ID = "";
	public static inline var INTERSTITIAL_AD_ID = "";
	
	public function new() {
		#if android
		AdMob.initAndroid(BANNER_AD_ID, INTERSTITIAL_AD_ID, GravityMode.BOTTOM);
		#elseif ios
		AdMob.initIOS(BANNER_AD_ID, INTERSTITIAL_AD_ID, GravityMode.BOTTOM);
		#end
	}
	
	public inline function showBanner() {
		AdMob.showBanner();
	}
	
	public inline function hideBanner() {
		AdMob.hideBanner();
	}
	
}
#end