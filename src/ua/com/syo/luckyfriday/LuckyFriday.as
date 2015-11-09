package ua.com.syo.luckyfriday
{
	import flash.desktop.NativeApplication;
	import flash.display.StageQuality;

	import citrus.core.starling.StarlingCitrusEngine;
	import citrus.core.starling.StarlingState;
	import citrus.sounds.SoundManager;

	import ua.com.syo.luckyfriday.view.MenuState;

	[SWF(frameRate = "60", width = "1280", height = "720", backgroundColor = "0x000410")]
	public class LuckyFriday extends StarlingCitrusEngine
	{
		/**
		 * Entry point
		 */
		public function LuckyFriday()
		{
			setUpStarling(true);
			stage.quality = StageQuality.LOW;
		}


		override public function handleStarlingReady():void {
			// TODO add loading state
			changeState(MenuState.newInstance);
		}

		/**
		 * Change state
		 * @param nextState new instance of new state
		 */
		public function changeState(nextState:StarlingState):void    
		{    
			// stop all sounds TODO: change sounds by state
			SoundManager.getInstance().stopAllPlayingSounds();
			state = nextState;    
		}

		/**
		 * Exit to system
		 */
		public static function exitApplication():void    
		{    
			NativeApplication.nativeApplication.exit();
		}
	}
}

