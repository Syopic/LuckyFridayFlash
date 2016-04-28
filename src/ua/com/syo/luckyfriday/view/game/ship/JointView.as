package ua.com.syo.luckyfriday.view.game.ship
{
	import flash.geom.Point;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;

	import ua.com.syo.luckyfriday.data.EmbeddedAssets;

	public class JointView extends Sprite
	{

		private var img:Image;
		private var _defaultAngle:Number = 0;
		private var _angle:Number = 0;
		private var _isActive:Boolean = false;

		public function JointView()
		{
			img = new Image(Texture.fromEmbeddedAsset(EmbeddedAssets.JointC));
			img.pivotX = 10;
			//img.pivotY = 10;
			addChild(img);
		}

		public function get isActive():Boolean
		{
			return _isActive;
		}

		public function set isActive(value:Boolean):void
		{
			_isActive = value;
		}

		public function get angle():Number
		{
			return img.rotation;
		}

		public function set angle(value:Number):void
		{
			isActive = true;
			_angle = value;
		}

		private var p:Point = new Point(0,0);

		public function update():void
		{
			// TODO
			if (isActive) {
				img.rotation += (_angle - img.rotation) / 20;
			}
			else
			{
				img.rotation += (_defaultAngle - img.rotation) / 20;
			}
		}

	}
}

