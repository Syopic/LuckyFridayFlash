package ua.com.syo.luckyfriday.view.meta {
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;

	import ua.com.syo.luckyfriday.data.EmbeddedAssets;
	import ua.com.syo.luckyfriday.controller.events.MissionPointEvent;

	public class AdditionalMissionPoint extends Sprite {
		private var aditionalMissionBtn:Button;
		private var n:String;

		public function AdditionalMissionPoint(id:String, enab:Boolean) {
			n = id;
			aditionalMissionBtn = new ImageButton(Texture.fromEmbeddedAsset(EmbeddedAssets.RadiationC), "", Texture.fromEmbeddedAsset(EmbeddedAssets.RadiationC), null, Texture.fromEmbeddedAsset(EmbeddedAssets.RadiationLocC));
			aditionalMissionBtn.fontName = EmbeddedAssets.fontUbuntu.fontName;
			aditionalMissionBtn.fontSize = 50;
			aditionalMissionBtn.fontBold = true;
			aditionalMissionBtn.x = 1;
			aditionalMissionBtn.y = 0;
			aditionalMissionBtn.enabled = enab;
			aditionalMissionBtn.addEventListener(Event.TRIGGERED, buttonClicked);
			addChild(aditionalMissionBtn);
		}

		private function buttonClicked(event:Event):void {
			switch (event.currentTarget as ImageButton) {
				case aditionalMissionBtn:
					var e:MissionPointEvent = new MissionPointEvent(MissionPointEvent.MISSION_SELECT);
					e.id = n;
					dispatchEvent(e);
					break;
			}
		}
	}
}
