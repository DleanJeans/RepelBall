package systems;

import systems.match.Team;

class WinManager {
	public function new() {}
	
	public function triggerWinState() {
		Game.states.win();
		Game.states.pauseState();
	}
}