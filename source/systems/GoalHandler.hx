package systems;

import flixel.FlxG;
import flixel.util.FlxTimer;
import objects.Ball;
import objects.Wall;

class GoalHandler {
	public var multiGoalTimer:FlxTimer;
	public var pauseTimer:FlxTimer;
	
	public function new() {}
	
	public function startMultiGoalTimer(goal:Wall, ball:Ball) {
		if (multiGoalTimer == null)
			multiGoalTimer = new FlxTimer().start(1, pause);
		else multiGoalTimer.reset();
	}
	
	private function pause(timer:FlxTimer) {
		Game.signals.pauseAfterGoal.dispatch();
		multiGoalTimer = null;
		pauseTimer = new FlxTimer().start(1, reset);
		Game.states.goal();
	}
	
	private function reset(timer:FlxTimer) {
		Game.signals.preRoundStart.dispatch();
		FlxG.state.closeSubState();
	}
	
	public function killBall(goal:Wall, ball:Ball) {
		ball.kill();
		Game.level.removeBall(ball);
	}
	
}