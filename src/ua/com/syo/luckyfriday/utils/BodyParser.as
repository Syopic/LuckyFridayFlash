package ua.com.syo.luckyfriday.utils
{
	import flash.geom.Point;

	import citrus.core.starling.StarlingState;

	import nape.geom.GeomPoly;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Polygon;

	import ua.com.syo.luckyfriday.view.DrawingPhysicsObject;

	public class BodyParser
	{
		public static function parseDrawing(json:Object, state:StarlingState):Vector.<DrawingPhysicsObject>
		{
			var drawings:Vector.<DrawingPhysicsObject> = new Vector.<DrawingPhysicsObject>();
			var shapes:Array;
			var i:int;
			// rocks
			shapes = json.rocks;

			for (i = 0; i < shapes.length; i++) 
			{
				var points:Array = json.rocks[i].shape;
				//var vertexes:Vector.<Vec2> = new Vector.<Vec2>();
				var pointsD:Array = new Array();

				for (var j:int = 0; j < points.length; j+=2) 
				{
					//vertexes.push(new Vec2(Math.round(points[j]), Math.round(points[j+1])));
					pointsD.push(new Point(Math.round(points[j]), Math.round(points[j+1])));
						//log("point: x: " + points[j] + ", y: " + points[j+1]);

				}
				var dr:DrawingPhysicsObject = new DrawingPhysicsObject("d" + i, pointsD);

				/*var body:Body=new Body(BodyType.DYNAMIC,new Vec2(0, 0));
				var rock:Polygon=new Polygon(new GeomPoly(vertexes));
				rock.material.elasticity=0.5;
				rock.material.density=1;
				body.shapes.add(rock);
				body.align();*/

				state.add(dr);
				dr.body.position.setxy(200, 100);
					//drawings.push(dr);
			}

			return drawings;
		}

		public static function parse(json:Object):Vector.<Body>
		{
			var bodies:Vector.<Body> = new Vector.<Body>();
			var shapes:Array;
			var i:int;
			// cave
			shapes = json.cave;

			for (i = 0; i < shapes.length; i++) 
			{
				var points:Array = json.cave[i].shape;
				var vertexes:Vector.<Vec2> = new Vector.<Vec2>();

				for (var j:int = 0; j < points.length; j+=2) 
				{
					vertexes.push(new Vec2(Math.round(points[j]), Math.round(points[j+1])));
						//log("point: x: " + points[j] + ", y: " + points[j+1]);

				}

				var body:Body=new Body(BodyType.STATIC,new Vec2(0, 0));
				var rock:Polygon=new Polygon(new GeomPoly(vertexes));
				rock.material.elasticity=0.5;
				rock.material.density=1;
				body.shapes.add(rock);
				body.align();


				bodies.push(body);
			}

			// rocks
			/*shapes = json.rocks;

			for (i = 0; i < shapes.length; i++)
			{
				var points:Array = json.rocks[i].shape;
				var vertexes:Vector.<Vec2> = new Vector.<Vec2>();

				for (var j:int = 0; j < points.length; j+=2)
				{
					vertexes.push(new Vec2(Math.round(points[j]), Math.round(points[j+1])));
						//log("point: x: " + points[j] + ", y: " + points[j+1]);

				}

				var body:Body=new Body(BodyType.DYNAMIC,new Vec2(0, 0));
				var rock:Polygon=new Polygon(new GeomPoly(vertexes));
				rock.material.elasticity=0.5;
				rock.material.density=1;
				body.shapes.add(rock);
				body.align();


				bodies.push(body);
			}*/

			// platforms
			shapes = json.platforms;

			for (i = 0; i < shapes.length; i++) 
			{
				var points:Array = json.platforms[i].shape;
				var vertexes:Vector.<Vec2> = new Vector.<Vec2>();

				for (var j:int = 0; j < points.length; j+=2) 
				{
					vertexes.push(new Vec2(Math.round(points[j]), Math.round(points[j+1])));
						//log("point: x: " + points[j] + ", y: " + points[j+1]);

				}

				var body:Body=new Body(BodyType.STATIC,new Vec2(0, 0));
				var rock:Polygon=new Polygon(new GeomPoly(vertexes));
				rock.material.elasticity=0.5;
				rock.material.density=1;
				body.shapes.add(rock);
				body.align();


				bodies.push(body);
			}


			return bodies;
		}
	}
}

