package ua.com.syo.luckyfriday.view.ship
{
	import flash.geom.Point;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;

	import ua.com.syo.luckyfriday.data.Assets;

	public class ThrusterView extends Sprite
	{
		public var index:int = 0;

		private var img:Image;
		private var _defaultAngle:Number = 0;
		private var _angle:Number = 0;
		private var _isActive:Boolean = false;

		public function ThrusterView(index:int, defaultAngle:Number)
		{
			this.index = index;
			_defaultAngle = defaultAngle;
			img = new Image(Texture.fromEmbeddedAsset(Assets.EngineC));
			img.pivotX = 4;
			img.pivotY = 12;
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

