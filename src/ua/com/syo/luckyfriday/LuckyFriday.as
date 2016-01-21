package ua.com.syo.luckyfriday {
	import flash.display.StageQuality;
	import flash.events.KeyboardEvent;

	import citrus.core.starling.StarlingCitrusEngine;
	import citrus.input.controllers.Keyboard;

	import starling.events.Event;

	import ua.com.syo.luckyfriday.controller.Controller;
	import ua.com.syo.luckyfriday.model.storage.Model;
	import ua.com.syo.luckyfriday.view.UIManager;
	import ua.com.syo.luckyfriday.view.states.MenuState;

	[SWF(frameRate = "60", width = "128", height = "72", backgroundColor = "0x000410")]
	public class LuckyFriday extends StarlingCitrusEngine {
		/**
		 * Entry point
		 */

		public function LuckyFriday() {
			setUpStarling(true);

			stage.quality = StageQuality.LOW;
			console.openKey = Keyboard.ENTER;
			stage.addEventListener(Event.RESIZE, function():void {
				UIManager.instance.resizeListener(stage.stageWidth, stage.stageHeight)
			});
			// disable ESC in fullscreen
			stage.addEventListener(KeyboardEvent.KEY_DOWN, function(e:KeyboardEvent):void {
				if (e.keyCode == Keyboard.ESCAPE) {
					UIManager.instance.escPressed();
					e.preventDefault();
				}
			});
		}
		override public function handleStarlingReady():void {
			Controller.instance.init();
			UIManager.instance.init();
			Model.instance.init();
			// TODO add loading state
			Controller.instance.changeState(MenuState.newInstance);
			//Controller.instance.changeState(GameState.newInstance);
		}
	}
}

