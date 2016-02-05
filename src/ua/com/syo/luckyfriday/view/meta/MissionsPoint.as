package ua.com.syo.luckyfriday.view.meta {
	import feathers.controls.NumericStepper;

	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;

	import ua.com.syo.luckyfriday.controller.events.MissionPointEvent;
	import ua.com.syo.luckyfriday.data.EmbeddedAssets;


	/**
	 * Class constructor mission
	 * @author Alex
	 */
	public class MissionsPoint extends Sprite {
		private var rateFull:Image;
		private var rateHalf:Image;
		private var rateEmpty:Image;
		private var missionBtn:Button;
		private var n:String;
		private var e:MissionPointEvent;


		/**
		 * Constructor Missions Point
		 * @param id - Missions ID
		 * @param enab - Indicate Missions enabled or disable
		 *
		 */
		public function MissionsPoint(id:String, enab:Boolean, rate:int) {


			n = id;

			//Add rate
			if (enab == true) {
				initRate(rate);
			} else {
			}

			//Add image button 
			missionBtn = new ImageButton(Texture.fromEmbeddedAsset(EmbeddedAssets.MissionsC), n, Texture.fromEmbeddedAsset(EmbeddedAssets.MissionsDownC), null, Texture.fromEmbeddedAsset(EmbeddedAssets.MissionsLockC));
			missionBtn.fontName = EmbeddedAssets.fontUbuntu.fontName;
			missionBtn.fontSize = 50;
			missionBtn.fontBold = true;
			missionBtn.x = 1;
			missionBtn.y = 0;
			missionBtn.enabled = enab;
			missionBtn.addEventListener(Event.TRIGGERED, buttonClicked);
			addChild(missionBtn);
		}


		/**
		 * Constructor sum rate comonent
		 * @param rate
		 */
		private function initRate(rate:int):void {
			//Add Rate image - choise  16 32 50 65 82 100

			if (rate <= 16) {
				halfRate(5);
				emptyRate(35);
				emptyRate(65);

			} else if (rate <= 32) {
				fullRate(5);
				emptyRate(35);
				emptyRate(65);
			} else if (rate <= 50) {
				fullRate(5);
				halfRate(35);
				emptyRate(65);
			} else if (rate <= 65) {
				fullRate(5);
				fullRate(35);
				emptyRate(65);
			} else if (rate <= 82) {
				fullRate(5);
				fullRate(35);
				halfRate(65);
			}
		}

		/**
		 * full rate comonent
		 * @param positionX
		 */
		private function fullRate(positionX:Number):void {
			rateFull = new Image(Texture.fromEmbeddedAsset(EmbeddedAssets.RateC));
			rateFull.width = 30;
			rateFull.height = 30;
			rateFull.y = 100;
			rateFull.x = positionX;
			//rateFull.visible = true;
			addChild(rateFull);
		}

		/**
		 * half rate comonent
		 * @param positionX
		 */
		private function halfRate(positionX:Number):void {
			rateHalf = new Image(Texture.fromEmbeddedAsset(EmbeddedAssets.RateHalfC));
			rateHalf.width = 30;
			rateHalf.height = 30;
			rateHalf.y = 100;
			rateHalf.x = positionX;
			//rateHalf.visible = true;
			addChild(rateHalf);
		}

		/**
		 * empty rate comonent
		 * @param positionX
		 */
		private function emptyRate(positionX:Number):void {
			rateEmpty = new Image(Texture.fromEmbeddedAsset(EmbeddedAssets.RateEmptyC));
			rateEmpty.width = 30;
			rateEmpty.height = 30;
			rateEmpty.y = 100;
			rateEmpty.x = positionX;
			//rateEmpty.visible = true;
			addChild(rateEmpty);
		}

		/**
		 * 	Processing  Click Button, create dispatch event MISSION_SELECT include Mission ID
		 * @param event
		 */
		private function buttonClicked(event:Event):void {
			switch (event.currentTarget as ImageButton) {
				case missionBtn:
					var e:MissionPointEvent = new MissionPointEvent(MissionPointEvent.MISSION_SELECT);
					e.id = n;
					dispatchEvent(e);
					break;
			}
		}
	}
}


