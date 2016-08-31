package states;

import flixel.FlxG;
import flixel.FlxSubState;
import flixel.util.FlxAxes;
import objects.Paddle;

class PlayState extends FlxSubState {
	var paddle:Paddle;
	var paddle2:Paddle;
	
	override public function create() {
		bgColor = Game.color.gray;
		
		add(Game.level);
		
		paddle = Game.match.team1.paddles[0];
		Game.controllers.addNewPlayerController(paddle);
		
		paddle2 = Game.match.team2.paddles[0];
		Game.controllers.addNewSimpleAI(paddle2, Game.walls.topWall);
		
		Game.match.team1.setGoal(Game.walls.bottomWall);
		Game.match.team2.setGoal(Game.walls.topWall);
		
		Game.signals.matchStart.dispatch();
	}
	
	override public function destroy():Void {
		remove(Game.level);
		super.destroy();
	}
}