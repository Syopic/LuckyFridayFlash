package ua.com.syo.luckyfriday
{
	import citrus.core.starling.StarlingCitrusEngine;
	import ua.com.syo.luckyfriday.view.TestGameState;

	[SWF(frameRate = "60", width = "1024", height = "600", backgroundColor = "0x999999")]
	public class LuckyFriday extends StarlingCitrusEngine
	{
		// entry point
		public function LuckyFriday()
		{
			setUpStarling(true);
		}

		override public function handleStarlingReady():void {
			state = new TestGameState();
		}
	}
}

