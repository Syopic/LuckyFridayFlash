package ua.com.syo.luckyfriday.model.storage.level
{
	import flash.geom.Point;
	import flash.geom.Rectangle;

	import citrus.core.starling.StarlingState;
	import citrus.math.MathUtils;

	import nape.geom.Vec2;
	import nape.phys.BodyType;

	import starling.textures.Texture;

	import ua.com.syo.luckyfriday.utils.Utils;
	import ua.com.syo.luckyfriday.view.game.DrawingPhysicsObject;

	public class CurrentLevelData
	{
		/**
		 * Object types
		 */
		private static var shipRightPoints:Array;
		private static var shipLeftPoints:Array;

		private static var _width:int;
		private static var _height:int;

		public static var bgTexture:Texture;
		public static var fgTexture:Texture;

		/**
		 * Create objects from level data by type
		 */
		public static function getObjectsByType(state:StarlingState, shapeType:String, bodyType:BodyType):Vector.<DrawingPhysicsObject> 
		{
			var drawingObj:Vector.<DrawingPhysicsObject> = new Vector.<DrawingPhysicsObject>();
			var shapes:Array = levelObjects[shapeType];
			var shapePoints:Array;
			var points:Array;
			var i:int, j:int;

			for (i = 0; i < shapes.length; i++) {
				shapePoints = shapes[i].shape;
				points = new Array();

				var bounds:Rectangle = Utils.getBoundingBox(shapePoints);
				for (j = 0; j < shapePoints.length; j += 2) {
					points.push(new Point(shapePoints[j] - bounds.x, shapePoints[j + 1] - bounds.y));
				}

				var dr:DrawingPhysicsObject = new DrawingPhysicsObject(shapeType, bodyType + i, points);
				state.add(dr);

				var anchor:Vec2 = new Vec2(0,0);
				var oldPosition:Vec2 = dr.body.position;
				var newPosition:Vec2 = dr.body.position;
				if (shapeType == DrawingPhysicsObject.ROCK_SHAPES || shapeType == DrawingPhysicsObject.PLATFORM_SHAPES)
				{
					dr.body.align();
					newPosition = dr.body.position;
					anchor.x = newPosition.x - oldPosition.x;
					anchor.y = newPosition.y - oldPosition.y;
					dr.drawShape(anchor, MathUtils.getRandomColor());
				}
				//if (shapeType == DrawingPhysicsObject.PLATFORM_SHAPES)
				//{
				//	dr.drawShape(anchor);
				//}
				dr.body.position.setxy(bounds.x + newPosition.x, bounds.y + newPosition.y);

				dr.body.type = bodyType;
				drawingObj.push(dr);
			}

			return drawingObj;
		}

		static public function get levelWidth():int
		{
			_width = levelObjects.levelWidth;
			return _width;
		}

		static public function get levelHeight():int
		{
			_height = levelObjects.levelHeight;
			return _height;
		}

		/**
		 * Bg Texture
		 */
		static public function getBackgroungTexture():Texture {
			return bgTexture;
		}

		/**
		 * Fg Texture
		 */
		static public function getForegroundTexture():Texture {
			return fgTexture;
		}

		/**
		 * Cashing JSON object
		 */
		private static var levelJSON:Object;
		public static function setLevelData(json:Object):void {
			levelJSON = json;
		}

		/**
		 * Cashing JSON object
		 */
		public static function get levelObjects():Object {
			return levelJSON;
		}

		/**
		 * Ship geometry
		 */
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


