package states;

import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import ui.AnyInputText;
import ui.GoalText;
import ui.RoundScoreText;
import ui.TimerText;
using flixel.addons.util.position.FlxPosition;

class GoalState extends FlxSubState {
	public var goalText(default, null):GoalText;
	public var roundScoreText(default, null):RoundScoreText;
	public var timerText(default, null):TimerText;
	public var anyInputText(default, null):AnyInputText;
	
	public var multiGoalTimer(default, null):FlxTimer;
	
	override public function create():Void {
		goalText = new GoalText();
		roundScoreText = new RoundScoreText();
		timerText = new TimerText();
		anyInputText = new AnyInputText();
		
		goalText.visible = false;
		anyInputText.visible = false;
		timerText.setMidTop(roundScoreText.getMidBottom());
		
		add(goalText);
		add(roundScoreText);
		add(timerText);
		add(anyInputText);
		
		goal();
	}
	
	override public function update(elapsed:Float):Void {
		closeOnAnyInputIfRoundEnded();
		super.update(elapsed);
	}
	
	private function closeOnAnyInputIfRoundEnded() {
		if (Game.match.roundEnded)
			Game.states.closeOnAnyInput(this, Game.signals.postRoundEnd.dispatch);
	}
	
	public function goal() {
		restartMultiGoalTimer();
		updateRoundScoreText();
	}
	
	private function restartMultiGoalTimer() {
		if (firstGoalInRound())
			multiGoalTimer = new FlxTimer().start(Game.settings.MULTI_GOAL_THRESHOLD, endRound);
		else multiGoalTimer.reset();
		timerText.timer = multiGoalTimer;
	}
	
	private inline function firstGoalInRound() {
		return multiGoalTimer == null;
	}
	
	public inline function updateRoundScoreText() {
		roundScoreText.updateScores();
	}
	
	public function endRound(timer:FlxTimer) {
		Game.signals.roundEnd.dispatch();
		
		hideTimerText();
		destroyMultiGoalTimer();
		showGoalText();
		moveRoundScoreTextUp();
		showAnyInputText();
		pauseGame();
	}
	
	private inline function hideTimerText() {
		timerText.visible = false;
	}
	
	private inline function destroyMultiGoalTimer() {
		multiGoalTimer.destroy();
		multiGoalTimer = null;
	}
	
	public inline function showGoalText() {
		goalText.updateText();
		goalText.visible = true;
	}
	
	private inline function moveRoundScoreTextUp() {
		roundScoreText.setBottom(goalText.y);
	}
	
	private inline function showAnyInputText() {
		anyInputText.visible = true;
	}
	
	private inline function pauseGame() {
		Game.states.pauseState();
	}
	
}