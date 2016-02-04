package ua.com.syo.luckyfriday {
	import flash.display.StageQuality;
	import flash.events.KeyboardEvent;

	import citrus.core.starling.StarlingCitrusEngine;
	import citrus.input.controllers.Keyboard;

	import starling.events.ResizeEvent;

	import ua.com.syo.luckyfriday.controller.Controller;
	import ua.com.syo.luckyfriday.model.Model;
	import ua.com.syo.luckyfriday.view.UIManager;
	import ua.com.syo.luckyfriday.view.states.MenuState;

	[SWF(frameRate = "60", width = "1280", height = "720", backgroundColor = "0x000410")]
	public class LuckyFriday extends StarlingCitrusEngine {
		/**
		 * Entry point
		 */

		public function LuckyFriday() {
			setUpStarling(true);

			stage.quality = StageQuality.LOW;
			console.openKey = Keyboard.ENTER;

			// disable ESC in fullscreen
			stage.addEventListener(KeyboardEvent.KEY_DOWN, function(e:KeyboardEvent):void {
				if (e.keyCode == Keyboard.ESCAPE) {
					UIManager.instance.escPressed();
					e.preventDefault();
				}
			});

			stage.addEventListener(ResizeEvent.RESIZE, function():void {
				UIManager.instance.resize(stage.stageWidth, stage.stageHeight);
			});
		}

		override public function handleStarlingReady():void {
			Model.instance.init();
			UIManager.instance.init();
			Controller.instance.init();
			Controller.instance.changeState(MenuState.newInstance);
		}
	}
}

