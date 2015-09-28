package ua.com.syo.luckyfriday
{
	import flash.display.StageScaleMode;

	import citrus.core.starling.StarlingCitrusEngine;
	import citrus.input.controllers.Keyboard;

	import justpinegames.Logi.Console;
	import justpinegames.Logi.ConsoleSettings;

	import starling.utils.ScaleMode;

	import ua.com.syo.luckyfriday.view.TestGameState;

	[SWF(frameRate = "60", width = "1024", height = "600", backgroundColor = "0x999999")]
	public class LuckyFriday extends StarlingCitrusEngine
	{
		// entry point
		public function LuckyFriday()
		{
			setUpStarling(true);
			console.openKey = Keyboard.ENTER;
			stage.scaleMode = StageScaleMode.NO_SCALE;
		}

		override public function handleStarlingReady():void {
			state = new TestGameState();

			var settings:ConsoleSettings = new ConsoleSettings();
			var logConsole:Console = new Console(settings);
			this.starling.stage.addChild(logConsole).y = -7;

			log("Just like the good old trace... ", 4, 8, 15, 16, 23, 42 );
			log("Just like the good osdsdsds  sdsd  ld trace... ", 4, 8, 15, 16, 23, 42 );
			log("Just like the good sdsd old trace... ", 4, 8, 15, 16, 23, 42 );
		}
	}
}

