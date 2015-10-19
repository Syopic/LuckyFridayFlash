package ua.com.syo.luckyfriday.model
{
	import flash.geom.Point;

	public class Globals
	{
		public static var isDebugMode:Boolean = false;

		public static var gravity:Number = 0.2;
		public static var rotateImpulse:Number = 70;
		public static var moveUpImpulse:Number = 0.75;
		public static var moveDownImpulse:Number = 0.75;
		public static var moveForwardImpulse:Number = 2.0;
		public static var moveBackwardImpulse:Number = 0.7;

		public static var isReverceLock:Boolean = true;

		public static var shipRightPoints:Array;
		public static var shipLeftPoints:Array;

		// in miliseconds
		public static var doubleTapDelay:int = 300;

		static public function getShipGeom(isMirror:Boolean = false):Array {
			var vertices:Array = [];
			if (!isMirror)
			{
				if (!shipRightPoints)
				{

					vertices = getShipPoints();
					shipRightPoints = vertices;
				} else
				{
					vertices = shipRightPoints;
				}
			}
			else
			{
				if (!shipLeftPoints)
				{
					vertices = getShipPoints();
					for (var i:int = 0; i < vertices.length; i++) 
					{
						var p:Point = vertices[i] as Point;
						p.x = - p.x;
					}
					shipLeftPoints = vertices;
				} else {
					vertices = shipLeftPoints;
				}
			}

			return vertices;
		}


		static private function getShipPoints():Array {
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

