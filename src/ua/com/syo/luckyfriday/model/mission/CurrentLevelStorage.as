package ua.com.syo.luckyfriday.model.mission
{
	import flash.geom.Point;
	import flash.geom.Rectangle;

	import citrus.core.starling.StarlingState;
	import citrus.math.MathUtils;
	import citrus.objects.NapePhysicsObject;

	import nape.geom.Vec2;
	import nape.phys.BodyType;
	import nape.shape.Shape;

	import starling.textures.Texture;

	import ua.com.syo.core.utils.Utils;
	import ua.com.syo.luckyfriday.view.game.draggedobjects.DrawingDO;
	import ua.com.syo.luckyfriday.view.states.GameState;

	public class CurrentLevelStorage
	{
		/**
		 * Object types
		 */
		public static const TERRAIN_SHAPES:String = "cave";
		public static const ROCK_SHAPES:String = "rocks";
		public static const PLATFORM_SHAPES:String = "platforms";

		private static var _width:int;
		private static var _height:int;

		public static var bgTexture:Texture;
		public static var fgTexture:Texture;

		private static var terrainShapes:Vector.<NapePhysicsObject> = new Vector.<NapePhysicsObject>();
		private static var staticShapes:Vector.<NapePhysicsObject> = new Vector.<NapePhysicsObject>();
		private static var dynamicShapes:Vector.<NapePhysicsObject> = new Vector.<NapePhysicsObject>();
		private static var draggedObjects:Vector.<DrawingDO> = new Vector.<DrawingDO>();

		/**
		 * Create objects from level data by type
		 */
		public static function getObjectsByType(state:StarlingState, shapeType:String, bodyType:BodyType):Vector.<DrawingDO> 
		{
			var drawingObj:Vector.<DrawingDO> = new Vector.<DrawingDO>();
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

				var dr:DrawingDO = new DrawingDO(shapeType, bodyType + i, points);
				GameState.instance.add(dr);

				var anchor:Vec2 = new Vec2(0,0);
				var oldPosition:Vec2 = dr.body.position;
				var newPosition:Vec2 = dr.body.position;
				if (shapeType == DrawingDO.ROCK_SHAPES || shapeType == DrawingDO.PLATFORM_SHAPES)
				{
					dr.body.align();
					newPosition = dr.body.position;
					anchor.x = newPosition.x - oldPosition.x;
					anchor.y = newPosition.y - oldPosition.y;
					dr.drawShape(anchor, MathUtils.getRandomColor());
				}

				dr.body.position.setxy(bounds.x + newPosition.x, bounds.y + newPosition.y);

				dr.body.type = bodyType;
				drawingObj.push(dr);
			}

			return drawingObj;
		}



		private static function generateShapesByType(shapeType:String, storage:Vector.<Shape>):void
		{
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

				var obj:NapePhysicsObject = new NapePhysicsObject(shapeType + i);
				obj.points = points;

				var anchor:Vec2 = new Vec2(0,0);
				var oldPosition:Vec2 = obj.body.position;
				var newPosition:Vec2 = obj.body.position;

				obj.body.position.setxy(bounds.x + newPosition.x, bounds.y + newPosition.y);

				obj.body.type = BodyType.STATIC;
				storage.push(obj);
			}
		}

		public static function getRockShapes():Vector.<DrawingDO>
		{
			var result:Vector.<DrawingDO> = new Vector.<DrawingDO>();
			return result;
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
		public static function setLevelData(fg:Texture, bg:Texture, json:Object):void {
			fgTexture = fg;
			bgTexture = bg;
			levelJSON = json;
		}

		/**
		 * Cashing JSON object
		 */
		public static function get levelObjects():Object {
			return levelJSON;
		}
	}
}

