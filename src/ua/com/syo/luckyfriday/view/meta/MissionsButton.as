package ua.com.syo.luckyfriday.view.meta {
	import starling.display.Button;
	import starling.textures.Texture;

	public class MissionsButton extends Button {
		public function MissionsButton(upState:Texture, text:String = "", downState:Texture = null, overState:Texture = null, disabledState:Texture = null) {

			super(upState, text, downState, overState, disabledState);
		}
	}
}
