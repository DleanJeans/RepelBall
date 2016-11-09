package states;

import flixel.FlxSubState;
import flixel.util.FlxTimer;
import ui.GoalText;
import ui.RoundScoreText;
import ui.TimerText;

class GoalState extends FlxSubState {
	public var goalText(default, null):GoalText;
	public var roundScoreText(default, null):RoundScoreText;
	public var timerText(default, null):TimerText;
	
	public var multiGoalTimer(default, null):FlxTimer;
	
	override public function create():Void {
		goalText = new GoalText();
		roundScoreText = new RoundScoreText();
		timerText = new TimerText();
		
		goalText.visible = false;
		timerText.setMidTop(roundScoreText.getMidBottom());
		
		add(goalText);
		add(roundScoreText);
		add(timerText);
		
		goal();
	}
	
	override public function update(elapsed:Float):Void {
		closeOnAnyInputIfRoundEnded();
		super.update(elapsed);
	}
	
	private function closeOnAnyInputIfRoundEnded() {
		if (Game.match.roundEnded) {
			Game.anyInput.listen([close, Game.signals.postRoundEnd.dispatch]);
		}
	}
	
	public function goal() {
		if (!_created) return;
		restartMultiGoalTimer();
		updateRoundScoreText();
	}
	
	private function restartMultiGoalTimer() {
		if (firstGoalInRound())
			multiGoalTimer = new FlxTimer().start(Settings.duration.multiGoalThresholdTime, endRound);
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
		askForAnyInput();
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
	
	private inline function askForAnyInput() {
		Game.notifier.notify(Game.messages.askForAnyInput, Game.notifier.fadeInOut.bind(1));
		closeCallback = Game.notifier.stopFadingInOut;
	}
	
	private inline function pauseGame() {
		Game.states.pauseState();
	}
	
}