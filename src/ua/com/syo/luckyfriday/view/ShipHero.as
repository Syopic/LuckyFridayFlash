package ua.com.syo.luckyfriday.view
{
	import citrus.objects.NapePhysicsObject;
	import citrus.view.starlingview.AnimationSequence;

	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Circle;
	import nape.shape.Polygon;

	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	import ua.com.syo.luckyfriday.model.Globals;


	public class ShipHero extends NapePhysicsObject
	{

		[Embed(source="/../assets/anim/shipAnim.png")]
		private var ShipAnimC:Class;

		[Embed(source="/../assets/anim/shipAnim.xml",mimeType="application/octet-stream")]
		private var ShipAnimXMLC:Class;

		public var oldX:Number = 0;

		public function ShipHero(name:String, params:Object = null)
		{
			var ta:TextureAtlas = new TextureAtlas(Texture.fromBitmap(new ShipAnimC()), XML(new ShipAnimXMLC()));
			var shipSeq:AnimationSequence = new AnimationSequence(ta, ["idleright", "idleleft", "kren", "rotate", "rrotater"], "rotate", 20);
			super(name, {width:190, height:68, view:shipSeq});
			_material = new Material(0.8,1.0,1.4,1.5,0.01);
			//StarlingArt.setLoopAnimations(["kren"]);
		}


		public function moveRight():void
		{
			/*if (body.position.x - oldX > 0.5) {
				animation = "rrotater";
			}
			log("DX: " + (body.position.x - oldX));*/
			var impulse:Vec2 = new Vec2(1, 0);
			impulse.length = Globals.moveRightImpulse;
			impulse.angle = body.rotation;
			body.applyImpulse(impulse, body.position);

		}

		public function moveLeft():void
		{
			/*if (oldX - body.position.x > 0.5) {
				animation = "rotate";
			}
			log("DX: " + (body.position.x - oldX));*/
			var impulse1:Vec2 = new Vec2(-1, 0);
			impulse1.length = Globals.moveLeftImpulse;
			impulse1.angle = body.rotation;
			body.applyImpulse(impulse1.reflect(impulse1), body.position);
		}

		public function moveUp():void
		{
			var impulse2:Vec2 = new Vec2(0, 1);
			impulse2.length = Globals.moveUpImpulse;
			impulse2.angle = body.rotation;
			body.applyImpulse(impulse2.reflect(impulse2).perp(), body.position);
		}

		public function moveDown():void
		{
			var impulse3:Vec2 = new Vec2(0, 1);
			impulse3.length = Globals.moveDownImpulse;
			impulse3.angle = body.rotation;
			body.applyImpulse(impulse3.perp(), body.position);

		}

		public function rotate(direction:int):void
		{
			body.applyAngularImpulse(direction * Globals.rotateImpulse);
		}
	}
}

