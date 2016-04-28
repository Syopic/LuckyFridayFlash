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
		public var padding:int = 60;

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
			for (var i:int = 0; i < body.shapes.length; i++) {
				var s:Shape = body.shapes.at(i);
				var p:Polygon = polygon = s.castPolygon;
				bounds = p.bounds.toRect();
				px = p.localVerts.at(0)
				shape.graphics.moveTo(px.x, px.y);

				if (yMin > px.y) {
					yMin = px.y;
				}
				if (yMax < px.y) {
					yMax = px.y;
				}
				for (var k:int = 0; k < p.worldVerts.length; k++) {
					px = p.localVerts.at(k);
					vertexes.push(px);
					if (yMin > px.y) {
						yMin = px.y;
					}
					if (yMax < px.y) {
						yMax = px.y;
					}
					shape.graphics.lineTo(px.x, px.y);
				}
				px = p.localVerts.at(0);
				shape.graphics.lineTo(px.x, px.y);
				if (yMin > px.y) {
					yMin = px.y;
				}
				if (yMax < px.y) {
					yMax = px.y;
				}
			}
			shape.graphics.endFill();

			var w:Number = bounds.width;
			var h:Number = bounds.height;

			if (shapeType == ROCK_SHAPES) {
				// draw braces
				defineBraces();
				for (var j:int = 0; j < braces.length; j++) {
					var koef:int = 0;
					var v:Vec2 = braces[j] as Vec2;
					shape.graphics.lineStyle(1, 0xffffff, 0.8);
					shape.graphics.drawCircle(v.x + Math.random() * koef, v.y + Math.random() * koef, 1);
				}

			}
			var bmd:BitmapData = new BitmapData(bounds.width + padding, bounds.height + padding, true, 0x00000000);

			var result:BitmapData = bmd.clone();
			var filter2:BlurFilter = new BlurFilter(1, 1, 2);
			var filter3:GlowFilter = new GlowFilter(strokeColor, 1, 13, 13, 1);

			result.draw(shape, new Matrix(1, 0, 0, 1, (bounds.width + padding) / 2, (bounds.height + padding) / 2), null, null, new Rectangle(0, 0, bounds.width + padding, bounds.height + padding), true);
			result.applyFilter(result, new Rectangle(0, 0, bounds.width + padding, bounds.height + padding), new Point(0, 0), filter2);
			result.applyFilter(result, new Rectangle(0, 0, bounds.width + padding, bounds.height + padding), new Point(0, 0), filter3);
			var tex:Texture = Texture.fromBitmapData(result);
			img = new Image(tex);
			view = img;
			_material = new Material(0.8, 1.0, 1.4, 1.5, 0.01);
		}

		private function defineBraces():void {
			for (var i:int = 0; i < vertexes.length; i++) {
				braces.push(vertexes[i].copy());
			}

			var massCenter:Vec2 = body.localCOM.copy();
			var edges:EdgeList = polygon.edges;
			//braces.push(massCenter);

			for (var j:int = 0; j < edges.length; j++) {
				var edge:Edge = edges.at(j);

				var v1:Vec2 = edge.localVertex1;
				var v2:Vec2 = edge.localVertex2;
				var v3:Vec2 = massCenter;


				//var AB:Number = Vec2.distance(v1, v2);

				//var BC:Number = Vec2.distance(v1, v3);
				//var CA:Number = Vec2.distance(v2, v3);

				//var S:Number = 1 / 4 * Math.sqrt((AB + BC + CA) * (BC + CA - AB) * (AB + CA - BC) * (AB + BC - CA));
				//var h1:Number = 2 * S / AB;

				var k:Number = (v2.y - v1.y) / (v2.x - v1.x);
				var b:Number = v1.y - k * v1.x;

				var k2:Number = -1 / k;
				var b2:Number = 0;
				
				var p1:Point = v1.toPoint();
				var p2:Point = v2.toPoint();
				var txMin:Number = Math.min(p1.x, p2.x);
				var txMax:Number = Math.max(p1.x, p2.x);
				
				var p3:Point = new Point(txMin, k2 * txMin + b2);
				var p4:Point = new Point(txMax, k2 * txMax + b2);
				
				if (p1.y == p2.y) {
					p3 = new Point(0, 0);
					p4 = new Point(0, p1.y);
				}
				if (p1.x == p2.x) {
					p3 = new Point(0, 0);
					p4 = new Point(p1.x, 0);
				}
				var p:Point = intersection(p1, p2, p3, p4);
				
				/*
				shape.graphics.lineStyle(1, 0xFFFFFF);
				shape.graphics.moveTo(p1.x, p1.y);
				shape.graphics.lineTo(p2.x, p2.y);
				shape.graphics.lineStyle(1, 0xff00ff);
				shape.graphics.moveTo(p3.x, p3.y);
				shape.graphics.lineTo(p4.x, p4.y);
				*/
				
				if (p) {
					braces.push(new Vec2(p.x, p.y));
				}else
				{
					trace("point is not found");
				}

			}
		}

		private function intersection(p1:Point, p2:Point, p3:Point, p4:Point):Point {
			var x1:Number = p1.x, x2:Number = p2.x, x3:Number = p3.x, x4:Number = p4.x;
			var y1:Number = p1.y, y2:Number = p2.y, y3:Number = p3.y, y4:Number = p4.y;
			var z1:Number = (x1 - x2), z2:Number = (x3 - x4), z3:Number = (y1 - y2), z4:Number = (y3 - y4);
			var d:Number = z1 * z4 - z3 * z2;

			// If d is zero, there is no intersection
			if (d == 0) {
				return null;
			}

			// Get the x and y
			var pre:Number = (x1 * y2 - y1 * x2), post:Number = (x3 * y4 - y3 * x4);
			var x:Number = (pre * z2 - z1 * post) / d;
			var y:Number = (pre * z4 - z3 * post) / d;

			// Check if the x and y coordinates are within both lines
			/*if (x < Math.min(x1, x2) || x > Math.max(x1, x2) || x < Math.min(x3, x4) || x > Math.max(x3, x4)) {
				return null;
			}
			if (y < Math.min(y1, y2) || y > Math.max(y1, y2) || y < Math.min(y3, y4) || y > Math.max(y3, y4)) {
				return null;
			}*/

			// Return the point of intersection
			return new Point(x, y);
		}
	}
}

