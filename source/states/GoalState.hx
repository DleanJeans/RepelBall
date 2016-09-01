package states;

import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import ui.GoalText;
import ui.RoundScoreText;
import ui.TimerText;
using flixel.addons.util.position.FlxPosition;

class GoalState extends FlxSubState {
	public var goalText(default, null):GoalText;
	public var roundScoreText(default, null):RoundScoreText;
	public var timerText(default, null):TimerText;
	
	public var multiGoalTimer(default, null):FlxTimer;
	public var pauseTimer(default, null):FlxTimer;
	
	override public function create():Void {
		goalText = new GoalText();
		roundScoreText = new RoundScoreText();
		timerText = new TimerText();
		
		goalText.visible = false;
		timerText.setMidTop(roundScoreText.getMidBottom());
		
		add(goalText);
		add(roundScoreText);
		add(timerText);
		
		newGoal();
	}
	
	public function newGoal() {
		restartMultiGoalTimer();
		updateRoundScoreText();
	}
	
	public inline function updateRoundScoreText() {
		roundScoreText.updateScores();
	}
	
	private function restartMultiGoalTimer() {
		if (firstGoalInRound())
			multiGoalTimer = new FlxTimer().start(1, endRound);
		else multiGoalTimer.reset();
		timerText.timer = multiGoalTimer;
	}
	
	private inline function firstGoalInRound() {
		return multiGoalTimer == null;
	}
	
	public function endRound(timer:FlxTimer) {
		Game.signals.roundEnd.dispatch();
		
		hideTimerText();
		showGoalText();
		moveRoundScoreTextUp();
		destroyMultiGoalTimer();
		pauseGame();
	}
	
	private inline function hideTimerText() {
		timerText.visible = false;
	}
	
	public inline function showGoalText() {
		goalText.updateText();
		goalText.visible = true;
	}
	
	private function moveRoundScoreTextUp() {
		roundScoreText.setBottom(goalText.y);
	}
	
	private function destroyMultiGoalTimer() {
		multiGoalTimer.destroy();
		multiGoalTimer = null;
	}
	
	private function pauseGame() {
		pauseTimer = new FlxTimer().start(1, preRoundStart);
		Game.states.pauseState();
	}
	
	private function preRoundStart(timer:FlxTimer) {
		Game.signals.preRoundStart.dispatch();
	}
	
}