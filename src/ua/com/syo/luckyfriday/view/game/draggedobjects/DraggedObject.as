package ua.com.syo.luckyfriday.view.game.draggedobjects
{
	import citrus.objects.NapePhysicsObject;

	import nape.geom.Vec2;
	import nape.shape.Edge;

	public class DraggedObject extends NapePhysicsObject
	{
		public var vertexes:Vector.<Vec2> = new Vector.<Vec2>();
		public var edges:Vector.<Edge> = new Vector.<Edge>();
		public var braces:Vector.<Vec2> = new Vector.<Vec2>();
		public function DraggedObject(name:String, params:Object = null)
		{
			super(name);
		}
	}
}

