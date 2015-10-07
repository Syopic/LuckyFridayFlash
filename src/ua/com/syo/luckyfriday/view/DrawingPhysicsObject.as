package ua.com.syo.luckyfriday.view {
	import flash.display.BitmapData;
	import flash.display.Sprite;

	import citrus.objects.NapePhysicsObject;

	import nape.phys.Material;

	import starling.display.Image;
	import starling.textures.Texture;



	public class DrawingPhysicsObject extends NapePhysicsObject {

		private var img:Image;

		public function DrawingPhysicsObject(name:String, params:Object = null) {

			points = params as Array;

			var shape:Sprite = new flash.display.Sprite();
			var color:uint = Math.random() * 0xFFFFFF;
			var radius:uint = 20;

			shape.graphics.lineStyle(4, 0x555555);
			shape.graphics.beginFill(0, 0);
			for(var i:int = 0; i < points.length; i++){
				if(i == 0){
					shape.graphics.moveTo(points[i].x + 50, points[i].y+ 100);
				} else {
					shape.graphics.lineTo(points[i].x+ 50, points[i].y+ 100);
				}
			}
			shape.graphics.endFill();

			//shape.graphics.beginFill(color);
			//shape.graphics.drawCircle(radius, radius, radius);
			//shape.graphics.endFill();
			var bmd:BitmapData = new BitmapData(100, 200, true, 0x00000000);
			bmd.draw(shape);
			var tex:Texture = Texture.fromBitmapData(bmd);
			img = new Image(tex);
			super(name, {view: img});

			_material = new Material(0.8,1.0,1.4,1.5,0.01); 
		}
	}
}

