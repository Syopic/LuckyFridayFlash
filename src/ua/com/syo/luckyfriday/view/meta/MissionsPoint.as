package ua.com.syo.luckyfriday.view.meta {
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;

	import ua.com.syo.luckyfriday.controller.events.MissionPointEvent;
	import ua.com.syo.luckyfriday.data.Assets;

	public class MissionsPoint extends Sprite {
		private var s:Sprite
		private var rate:Image;
		private var rateHalf:Image;
		private var rateEmpty:Image;
		private var missionBtn:Button;
		private var n:String;
		private var e:MissionPointEvent


		public function MissionsPoint(id:String, enab:Boolean) {

			s = new Sprite();
			s.width = 150;
			s.height = 150;
			n = id;


			rate = new Image(Texture.fromEmbeddedAsset(Assets.RateC));
			rate.width = 30;
			rate.height = 30;
			rate.y = 100;
			rate.x = 5;
			rate.visible = enab;
			addChild(rate);

			rateHalf = new Image(Texture.fromEmbeddedAsset(Assets.RateHalfC));
			rateHalf.width = 30;
			rateHalf.height = 30;
			rateHalf.y = 100;
			rateHalf.x = 35;
			rateHalf.visible = enab;
			addChild(rateHalf);

			rateEmpty = new Image(Texture.fromEmbeddedAsset(Assets.RateEmptyC));
			rateEmpty.width = 30;
			rateEmpty.height = 30;
			rateEmpty.y = 100;
			rateEmpty.x = 65;
			rateEmpty.visible = enab;
			addChild(rateEmpty);


			missionBtn = new ImageButton(Texture.fromEmbeddedAsset(Assets.MissionsC), n, Texture.fromEmbeddedAsset(Assets.MissionsDownC), null, Texture.fromEmbeddedAsset(Assets.MissionsLockC));
			missionBtn.fontName = Assets.fontUbuntu.fontName;
			missionBtn.fontSize = 50;
			missionBtn.fontBold = true;
			missionBtn.x = 1;
			missionBtn.y = 0;
			missionBtn.enabled = enab;
			missionBtn.addEventListener(Event.TRIGGERED, buttonClicked);
			addChild(missionBtn);


		}

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
