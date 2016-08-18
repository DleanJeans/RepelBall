package systems;

import flixel.FlxG;
import flixel.addons.util.position.FlxText;
import flixel.util.FlxTimer;
import objects.Ball;
import objects.Wall;
import states.GoalState;

class GoalHandler {
	public var multiGoalTimer:FlxTimer;
	public var pauseTimer:FlxTimer;
	
	public function new() {
		Game.signals.goal.add(startMultiGoalTimer);
		Game.signals.goal.add(killBall);
	}
	
	private function startMultiGoalTimer(goal:Wall, ball:Ball) {
		if (multiGoalTimer == null)
			multiGoalTimer = new FlxTimer().start(1, pause);
		else multiGoalTimer.reset();
	}
	
	private function pause(timer:FlxTimer) {
		Game.signals.afterGoalPause.dispatch();
		multiGoalTimer = null;
		pauseTimer = new FlxTimer().start(1, reset);
		FlxG.state.openSubState(new GoalState());
	}
	
	private function reset(timer:FlxTimer) {
		Game.signals.afterGoalReset.dispatch();
		FlxG.state.closeSubState();
	}
	
	private function killBall(goal:Wall, ball:Ball) {
		ball.kill();
		Game.level.removeBall(ball);
	}
	
}