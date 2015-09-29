package ua.com.syo.luckyfriday.view
{
	import citrus.input.controllers.Keyboard;

	import nape.geom.Vec2;

	import ua.com.syo.luckyfriday.model.Globals;

	public class ShipHeroBF extends ShipHero
	{
		public function ShipHeroBF(name:String, params:Object=null)
		{
			super(name, params);
		}

		override public function initKeyboardActions():void
		{
			var kb:Keyboard = _ce.input.keyboard;

			kb.addKeyAction("right", Keyboard.D);
			kb.addKeyAction("left", Keyboard.A);
			kb.addKeyAction("up", Keyboard.W);
			kb.addKeyAction("down", Keyboard.S);

			kb.addKeyAction("rotateCW", Keyboard.Q);
			kb.addKeyAction("rotateCCW", Keyboard.E);

			kb.addKeyAction("forward", Keyboard.O);
			kb.addKeyAction("backward", Keyboard.P);
		}

		override public function update(timeDelta:Number):void {

			//user input
			if (_ce.input.isDoing("rotateCW")) {
				body.applyAngularImpulse(-Globals.rotateImpulse);
			}

			if (_ce.input.isDoing("rotateCCW")) {
				body.applyAngularImpulse(Globals.rotateImpulse);
			}

			if (_ce.input.isDoing("right")) {
				impulse = new Vec2(1, 0);
				impulse.length = Globals.moveRightImpulse;
				if (_ce.input.isDoing("forward")) body.applyImpulse(impulse, body.position);
				if (_ce.input.isDoing("backward")) body.applyImpulse(impulse.reflect(impulse), body.position);
			}

			if (_ce.input.isDoing("left")) {
				impulse = new Vec2(-1, 0);
				impulse.length = Globals.moveLeftImpulse;
				if (_ce.input.isDoing("forward")) body.applyImpulse(impulse, body.position);
				if (_ce.input.isDoing("backward")) body.applyImpulse(impulse.reflect(impulse), body.position);
			}

			if (_ce.input.isDoing("up")) {
				impulse = new Vec2(0, -1);
				impulse.length = Globals.moveUpImpulse;
				if (_ce.input.isDoing("forward")) body.applyImpulse(impulse, body.position);
				if (_ce.input.isDoing("backward")) body.applyImpulse(impulse.reflect(impulse), body.position);
			}

			if (_ce.input.isDoing("down")) {
				impulse = new Vec2(0, 1);
				impulse.length = Globals.moveDownImpulse;
				if (_ce.input.isDoing("forward")) body.applyImpulse(impulse, body.position);
				if (_ce.input.isDoing("backward")) body.applyImpulse(impulse.reflect(impulse), body.position);
			}



		}
	}
}

