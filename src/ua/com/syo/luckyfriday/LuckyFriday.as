package ua.com.syo.luckyfriday
{
	import flash.desktop.NativeApplication;
	import flash.display.NativeWindow;
	import flash.display.NativeWindowResize;
	import flash.display.StageDisplayState;
	import flash.display.StageQuality;

	import citrus.core.starling.StarlingCitrusEngine;
	import citrus.input.controllers.Keyboard;

	import ua.com.syo.luckyfriday.view.GameState;
	import ua.com.syo.luckyfriday.view.MenuState;
	import ua.com.syo.luckyfriday.view.UIManager;

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
			console.openKey = Keyboard.ENTER;
		}

		override public function handleStarlingReady():void {
			UIManager.instance.init();
			// TODO add loading state
			//UIManager.instance.changeState(MenuState.newInstance);
			UIManager.instance.changeState(GameState.newInstance);

		}

		/**
		 * Exit to system
		 */
		public static function exitApplication():void    
		{    
			NativeApplication.nativeApplication.exit();
			//NativeWindowResize.BOTTOM.length = 50;
		}
	}
}

