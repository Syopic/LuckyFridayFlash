package ua.com.syo.luckyfriday.view.game.draggedobjects {
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.filters.BlurFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	import nape.geom.Vec2;
	import nape.phys.Material;
	import nape.shape.Edge;
	import nape.shape.EdgeList;
	import nape.shape.Polygon;
	import nape.shape.Shape;

	import starling.display.Image;
	import starling.textures.Texture;

	import ua.com.syo.core.utils.Utils;

	/**
	 * Physics object with drawing shape
	 * TODO - optimize draw calls
	 */

	public class DrawingDO extends DraggedObject {

		public static const CAVE_SHAPES:String = "cave";
		public static const ROCK_SHAPES:String = "rocks";
		public static const PLATFORM_SHAPES:String = "platforms";

		public var img:Image;
		public var shapeType:String;
		public var shape:Sprite;
		public var polygon:Polygon;

		public function DrawingDO(shapeType:String, name:String, params:Object = null) {
			points = params as Array;
			this.shapeType = shapeType;
			super(name);
		}

		public function drawShape(anchor:Vec2, strokeColor:uint = 0xa78d04, fillColor:uint = 0x18180C):void {

			var bounds:Rectangle = Utils.getBoundingBox(points);

			shape = new flash.display.Sprite();
			shape.graphics.lineStyle(3, strokeColor);
			shape.graphics.beginFill(Utils.darkenColor(strokeColor, 80));
			var px:Vec2;
			var yMin:Number = 1000;
			var yMax:Number = -1000;
			for (var i:int = 0; i < body.shapes.length; i++) 
			{
				var s:Shape = body.shapes.at(i);
				var p:Polygon = polygon = s.castPolygon;
				bounds = p.bounds.toRect();
				px = p.localVerts.at(0)
				shape.graphics.moveTo(px.x, px.y);

				if (yMin > px.y) yMin = px.y;
				if (yMax < px.y) yMax = px.y;
				for (var k:int = 0; k < p.worldVerts.length; k++) 
				{
					px = p.localVerts.at(k);
					vertexes.push(px);
					if (yMin > px.y) yMin = px.y;
					if (yMax < px.y) yMax = px.y;
					shape.graphics.lineTo(px.x,px.y);
				}
				px  = p.localVerts.at(0);
				shape.graphics.lineTo(px.x,px.y);
				if (yMin > px.y) yMin = px.y;
				if (yMax < px.y) yMax = px.y;
			}
			shape.graphics.endFill();

			var w:Number = bounds.width;
			var h:Number = bounds.height;

			if (shapeType == ROCK_SHAPES)
			{
				// add braces
				shape.graphics.lineStyle(3, 0x999999);
				// draw braces
				defineBraces();
				for (var j:int = 0; j < braces.length; j++)
				{
					shape.graphics.drawCircle(braces[j].x, braces[j].y, 2);
				}

			}
			var bmd:BitmapData = new BitmapData(bounds.width + 30, bounds.height + 30, true, 0x00000000);

			var result:BitmapData = bmd.clone();
			var filter2:BlurFilter = new BlurFilter(1, 1, 2);
			var filter3:GlowFilter = new GlowFilter(strokeColor, 1, 15, 15, 1);

			result.draw(shape, new Matrix(1, 0, 0, 1, bounds.width/2 + 15, bounds.height/2 + 15), null, null, new Rectangle(0, 0, bounds.width + 40, bounds.height + 40), true);
			result.applyFilter(result, new Rectangle(0, 0, bounds.width + 40, bounds.height + 40), new Point(0, 0), filter2);
			result.applyFilter(result, new Rectangle(0, 0, bounds.width + 40, bounds.height + 40), new Point(0, 0), filter3);
			var tex:Texture = Texture.fromBitmapData(result);
			img = new Image(tex);
			view = img;
			_material = new Material(0.8, 1.0, 1.4, 1.5, 0.01);
		}

		private function defineBraces():void
		{
			for (var i:int = 0; i < vertexes.length; i++) 
			{
				braces.push(vertexes[i].copy());
			}

			var massCenter:Vec2 = body.localCOM.copy();
			var edges:EdgeList = polygon.edges;

			for (var j:int = 0; j < edges.length; j++) {
				var edge:Edge = edges.at(j);
				braces.push(edge.localNormal);
			}

			braces.push(massCenter);
		}
	}
}

