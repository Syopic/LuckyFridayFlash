package ua.com.syo.luckyfriday
{
	import flash.display.StageQuality;

	import citrus.core.starling.StarlingCitrusEngine;
	import citrus.input.controllers.Keyboard;

	import justpinegames.Logi.Console;
	import justpinegames.Logi.ConsoleSettings;

	import ua.com.syo.luckyfriday.view.GameState;
	import ua.com.syo.luckyfriday.view.HUDView;

	[SWF(frameRate = "60", width = "1280", height = "720", backgroundColor = "0x000410")]
	public class LuckyFriday extends StarlingCitrusEngine
	{
		// entry point
		public function LuckyFriday()
		{
			setUpStarling(true);
			console.openKey = Keyboard.ENTER;
			stage.quality = StageQuality.LOW;
		}

		override public function handleStarlingReady():void {
			state = GameState.instance;

			var settings:ConsoleSettings = new ConsoleSettings();
			var logConsole:Console = new Console(settings);
			this.starling.stage.addChild(logConsole).y = -7;



		}
	}
}

