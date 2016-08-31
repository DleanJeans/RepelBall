package states;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.system.debug.FlxDebugger.FlxDebuggerLayout;
import flixel.system.debug.watch.Tracker.TrackerProfile;
import flixel.util.FlxAxes;
import objects.Ball;
import objects.Paddle;
import objects.Wall;
import systems.Level;
import systems.match.Team;
import systems.ui.Scoreboard;
using flixel.addons.util.position.FlxPosition;

class PlayState extends FlxState {
	var paddle:Paddle;
	var paddle2:Paddle;
	
	override public function create() {
		bgColor = Game.color.gray;
		
		add(Game.level);
		
		paddle = Game.match.team1.paddles[0];
		Game.level.addPaddle(paddle);
		
		Game.controllers.addNewPlayerController(paddle);
		
		paddle2 = Game.match.team2.paddles[0];
		Game.level.addPaddle(paddle2);
		Game.controllers.addNewSimpleAI(paddle2, Game.walls.topWall);
		
		Game.match.team1.setGoal(Game.walls.bottomWall);
		Game.match.team2.setGoal(Game.walls.topWall);
		
		Game.signals.matchStart.dispatch();
		Game.signals.preRoundStart.dispatch();
	}
	
	override public function destroy():Void {
		remove(Game.level);
		super.destroy();
	}
}