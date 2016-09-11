package states;

import flixel.FlxG;
import flixel.FlxSubState;
import objects.PaddleWrapper;
import states.group.MatchSettings;
import states.group.MinimalTitleScreen;
import states.group.TitleMenu;
	
class MenuState extends FlxSubState {
	public var titleMenu:MinimalTitleScreen;
	public var matchSettings:MatchSettings;
	
	override public function create() {
		bgColor = 0xFF212121;
		Game.sfx.fadeInTheme();
		
		titleMenu = new MinimalTitleScreen();
		matchSettings = new MatchSettings();
		
		titleMenu.start.add(switchToMatchSettings);
		matchSettings.back.add(switchToTitleMenu);
		matchSettings.start.add(startMatch);
		
		add(titleMenu);
		add(matchSettings);
		
		switchToTitleMenu();
	}
	
	private function switchToMatchSettings() {
		titleMenu.visible = false;
		matchSettings.visible = true;
	}
	
	private function switchToTitleMenu() {
		titleMenu.visible = true;
		matchSettings.visible = false;
	}
	
	private function startMatch() {
		if (matchSettings.sameTeamColor()) {
			Game.states.warning();
			return;
		}
		
		Game.sfx.fadeOutTheme();
		matchSettings.apply();
		Game.states.play();
	}
}

