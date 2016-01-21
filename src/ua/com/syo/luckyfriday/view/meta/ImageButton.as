package ua.com.syo.luckyfriday.view.meta {
	import starling.display.Button;
	import starling.textures.Texture;

	public class ImageButton extends Button {
		public function ImageButton(upState:Texture, text:String = "", downState:Texture = null, overState:Texture = null, disabledState:Texture = null) {

			super(upState, text, downState, overState, disabledState);
		}
	}
}
