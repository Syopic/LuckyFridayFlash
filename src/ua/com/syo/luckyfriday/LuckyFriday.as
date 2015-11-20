package ua.com.syo.luckyfriday
{
	import flash.desktop.NativeApplication;
	import flash.display.StageQuality;
	import flash.events.KeyboardEvent;

	import citrus.core.starling.StarlingCitrusEngine;
	import citrus.input.controllers.Keyboard;

	import ua.com.syo.luckyfriday.view.states.MenuState;
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
			// disable ESC in fullscreen
			stage.addEventListener(KeyboardEvent.KEY_DOWN, function(e:KeyboardEvent):void { 
				if(e.keyCode == Keyboard.ESCAPE) 
				{
					UIManager.instance.escPressed();
					e.preventDefault();
				}
			});
		}

		override public function handleStarlingReady():void {
			UIManager.instance.init();

			// TODO add loading state
			UIManager.instance.changeState(MenuState.newInstance);
			//UIManager.instance.changeState(GameState.newInstance);
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

