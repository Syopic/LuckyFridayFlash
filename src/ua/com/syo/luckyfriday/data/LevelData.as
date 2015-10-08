package ua.com.syo.luckyfriday.data
{
	import flash.geom.Point;
	import flash.geom.Rectangle;

	import citrus.core.starling.StarlingState;

	import nape.phys.BodyType;

	import ua.com.syo.luckyfriday.view.DrawingPhysicsObject;

	public class LevelData
	{
		public static const CAVE_SHAPES:String = "cave";
		public static const ROCK_SHAPES:String = "rocks";
		public static const PLATFORM_SHAPES:String = "platforms";
		public static const SHIP_SHAPES:String = "platform";

		public static function addShapes(state:StarlingState, shapeType:String, bodyType:BodyType):Vector.<DrawingPhysicsObject> 
		{
			var drawingObj:Vector.<DrawingPhysicsObject> = new Vector.<DrawingPhysicsObject>();
			var shapes:Array = Assets.levelData[shapeType];
			var shapePoints:Array;
			var points:Array;
			var i:int, j:int;

			for (i = 0; i < shapes.length; i++) {
				shapePoints = shapes[i].shape;
				points = new Array();

				var bBox:Rectangle = getBoundingBox(shapePoints);
				for (j = 0; j < shapePoints.length; j += 2) {
					points.push(new Point(shapePoints[j] - bBox.x, shapePoints[j + 1] - bBox.y));
				}

				var dr:DrawingPhysicsObject = new DrawingPhysicsObject(bodyType + i, points);
				state.add(dr);

				if (shapeType != CAVE_SHAPES)
				{
					dr.drawShape();
				}
				dr.body.position.setxy(bBox.x, bBox.y);

				dr.body.type = bodyType;
				drawingObj.push(dr);
			}

			return drawingObj;
		}

		public static function getBoundingBox(points:Array):Rectangle
		{
			var xMin:Number = Infinity;
			var yMin:Number = Infinity;
			var xMax:Number = -Infinity;
			var yMax:Number = -Infinity;
			var j:int;
			if (points[0] is Point) {
				for (j = 0; j < points.length; j++) 
				{
					xMin = Math.min(xMin, points[j].x);
					yMin = Math.min(yMin, points[j].y);
					xMax = Math.max(xMax, points[j].x);
					yMax = Math.max(yMax, points[j].y);
				}
			} else {
				for (j = 0; j < points.length; j += 2) {
					xMin = Math.min(xMin, points[j]);
					yMin = Math.min(yMin, points[j + 1]);
					xMax = Math.max(xMin, points[j]);
					yMax = Math.max(yMin, points[j + 1]);
				}
			}
			var w:Number = xMax - xMin;
			var h:Number = yMax - yMin;
			var result:Rectangle = new Rectangle(xMin, yMin, w, h);

			return result;
		}
	}
}

