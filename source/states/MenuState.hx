package states;

import flixel.FlxG;
import flixel.FlxSubState;
import states.group.MatchSettings;
import states.group.TitleMenu;
	
class MenuState extends FlxSubState {
	public var titleMenu:TitleMenu;
	public var matchSettings:MatchSettings;
	
	override public function create() {
		bgColor = 0xFF212121;
		camera.antialiasing = true;
		
		titleMenu = new TitleMenu();
		matchSettings = new MatchSettings();
		
		titleMenu.newMatch.add(switchToMatchSettings);
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
		
		matchSettings.apply();
		Game.states.play();
	}
}

