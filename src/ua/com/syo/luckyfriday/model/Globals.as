package ua.com.syo.luckyfriday.model
{
	import flash.geom.Point;

	import nape.geom.GeomPoly;
	import nape.geom.Vec2;

	public class Globals
	{
		public static var gravity:Number = 0.1;
		public static var rotateImpulse:Number = 50;
		public static var moveUpImpulse:Number = 1;
		public static var moveDownImpulse:Number = 1;
		public static var moveRightImpulse:Number = 1;
		public static var moveLeftImpulse:Number = 1;

		// in miliseconds
		public static var doubleTapDelay:int = 300;

		static public function createShipGeom():Array {
			var vertices:Array = [];

			var dx:int = -103;
			var dy:int = -42;

			vertices.push(new Point(15 + dx, 15 + dy));
			vertices.push(new Point(22 + dx, 16 + dy));
			vertices.push(new Point(22 + dx, 12 + dy));
			vertices.push(new Point(51 + dx, 19 + dy));
			vertices.push(new Point(106 + dx, 18 + dy));
			vertices.push(new Point(117 + dx, 21 + dy));
			vertices.push(new Point(144 + dx, 13 + dy));
			vertices.push(new Point(140 + dx, 7 + dy));
			vertices.push(new Point(184 + dx, 10 + dy));
			vertices.push(new Point(196 + dx, 21 + dy));
			vertices.push(new Point(196 + dx, 27 + dy));
			vertices.push(new Point(164 + dx, 48 + dy));
			vertices.push(new Point(138 + dx, 77 + dy));
			vertices.push(new Point(67 + dx, 77 + dy));
			vertices.push(new Point(61 + dx, 64 + dy));
			vertices.push(new Point(23 + dx, 72 + dy));
			vertices.push(new Point(22 + dx, 68 + dy));
			vertices.push(new Point(15 + dx, 69 + dy));
			vertices.push(new Point(7 + dx, 59 + dy));
			vertices.push(new Point(7 + dx, 26 + dy));

			return vertices;
		}

	}
}

