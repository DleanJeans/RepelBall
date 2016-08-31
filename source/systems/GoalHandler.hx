package systems;

import flixel.FlxG;
import flixel.util.FlxTimer;
import objects.Ball;
import objects.Wall;
import states.GoalState;

class GoalHandler {
	public var goalState(default, null):GoalState;
	
	public function new() {}
	
	public function triggerGoalState() {
		if (firstGoalInRound()) {
			Game.states.goal();
			Game.states.resumeState();
			goalState = cast Game.states.subState;
		}
		else {
			goalState.newGoal();
		}
	}
	
	public function closeGoalState() {
		if (goalState != null) {
			goalState.close();
			goalState = null;
		}
	}
	
	private inline function firstGoalInRound() {
		return goalState == null;
	}
	
	public function killBall(ball:Ball) {
		ball.kill();
		Game.level.removeBall(ball);
	}
	
}