package ua.com.syo.luckyfriday.view {
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.filters.BlurFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	import citrus.objects.NapePhysicsObject;

	import nape.phys.Material;

	import starling.display.Image;
	import starling.textures.Texture;

	import ua.com.syo.luckyfriday.data.LevelData;


	public class DrawingPhysicsObject extends NapePhysicsObject {

		private var img:Image;

		public function DrawingPhysicsObject(name:String, params:Object = null) {
			points = params as Array;
			super(name);
		}

		public function drawShape(strokeColor:uint = 0xa78d04, fillColor:uint = 0x18180C):void
		{
			var bBox:Rectangle = LevelData.getBoundingBox(points);
			var w:Number = bBox.width;
			var h:Number = bBox.height;

			var shape:Sprite = new flash.display.Sprite();

			shape.graphics.lineStyle(3, strokeColor);
			shape.graphics.beginFill(fillColor, 1);
			for (var i:int = 0; i < points.length; i++) {
				if (i == 0) {
					shape.graphics.moveTo(points[i].x + w/2, points[i].y + h/2);
				} else {
					shape.graphics.lineTo(points[i].x + w/2, points[i].y + h/2);
				}
			}
			shape.graphics.endFill();

			var bBox2:Rectangle = shape.getBounds(shape);

			var bmd:BitmapData = new BitmapData(bBox2.width + 20, bBox2.height + 20, true, 0x00000000);

			var result:BitmapData = bmd.clone();
			var filter2:BlurFilter = new BlurFilter(1, 1, 2);
			var filter3:GlowFilter = new GlowFilter(0xa78d04, 1, 15, 15, 1);

			bBox.width +=40;
			bBox.height +=40;

			result.draw(shape,  new Matrix(1,0,0,1,-bBox2.x + 10,-bBox2.y + 10), null, null, bBox, true);
			result.applyFilter(result, bBox, new Point(0, 0), filter2);
			result.applyFilter(result, bBox, new Point(0, 0), filter3);
			var tex:Texture = Texture.fromBitmapData(result);
			img = new Image(tex);
			img.pivotX = -w/2;
			img.pivotY = -h/2;
			view = img;
			_material = new Material(0.8,1.0,1.4,1.5,0.01); 
		}
	}
}

