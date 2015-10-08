package ua.com.syo.luckyfriday.utils {
	import flash.geom.Point;

	import citrus.core.starling.StarlingState;

	import nape.geom.GeomPoly;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Polygon;

	import ua.com.syo.luckyfriday.view.DrawingPhysicsObject;

	public class BodyParser {
		public static function parseDrawing(json:Object, state:StarlingState, id:String, type:BodyType):Vector.<DrawingPhysicsObject> {
			var drawings:Vector.<DrawingPhysicsObject> = new Vector.<DrawingPhysicsObject>();
			var shapes:Array;
			var i:int;
			// rocks
			shapes = json as Array;

			for (i = 0; i < shapes.length; i++) {
				var points:Array = shapes[i].shape;
				//var vertexes:Vector.<Vec2> = new Vector.<Vec2>();
				var pointsD:Array = new Array();

				var xMin:Number = Infinity;
				var yMin:Number = Infinity;
				var xMax:Number = -Infinity;
				var yMax:Number = -Infinity;
				for (var j:int = 0; j < points.length; j += 2) {
					xMin = Math.min(xMin, points[j]);
					yMin = Math.min(yMin, points[j + 1]);
					xMax = Math.max(xMin, points[j]);
					yMax = Math.max(yMin, points[j + 1]);
				}
				var w:Number = xMax - xMin;
				var h:Number = yMax - yMin;


				for (var j:int = 0; j < points.length; j += 2) {
					pointsD.push(new Point(points[j] - xMin, points[j + 1] - yMin));

				}
				var dr:DrawingPhysicsObject = new DrawingPhysicsObject(id + i, pointsD);

				state.add(dr);
				//dr.body.align();
				dr.registration = "center";
				if (type == BodyType.STATIC) {
					dr.drawShape(0xff000);
				} else {
					dr.drawShape();
				}
				dr.body.position.setxy(xMin, yMin);
				dr.body.type = type;
			}

			return drawings;
		}

		public static function parse(json:Object):Vector.<Body> {
			var bodies:Vector.<Body> = new Vector.<Body>();
			var shapes:Array;
			var i:int;
			// cave
			shapes = json.cave;

			for (i = 0; i < shapes.length; i++) {
				var points:Array = json.cave[i].shape;
				var vertexes:Vector.<Vec2> = new Vector.<Vec2>();

				for (var j:int = 0; j < points.length; j += 2) {
					vertexes.push(new Vec2(Math.round(points[j]), Math.round(points[j + 1])));
				}

				var body:Body = new Body(BodyType.STATIC, new Vec2(0, 0));
				var rock:Polygon = new Polygon(new GeomPoly(vertexes));
				rock.material.elasticity = 0.5;
				rock.material.density = 1;
				body.shapes.add(rock);
				body.align();


				bodies.push(body);
			}




			return bodies;
		}
	}
}

