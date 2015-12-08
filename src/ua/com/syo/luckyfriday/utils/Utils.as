package ua.com.syo.luckyfriday.utils
{
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class Utils
	{
		/**
		 * Bounding box of points array
		 */
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

