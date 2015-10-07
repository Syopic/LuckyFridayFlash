package
{
	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
    import flash.utils.Dictionary;

    public class PhysicsData extends Object
	{
		// ptm ratio
        public var ptm_ratio:Number = 2;
		
		// the physcis data 
		var dict:Dictionary;
		
        //
        // bodytype:
        //  b2_staticBody
        //  b2_kinematicBody
        //  b2_dynamicBody

        public function createBody(name:String, world:b2World, bodyType:uint, userData:*):b2Body
        {
            var fixtures:Array = dict[name];

            var body:b2Body;
            var f:Number;

            // prepare body def
            var bodyDef:b2BodyDef = new b2BodyDef();
            bodyDef.type = bodyType;
            bodyDef.userData = userData;

            // create the body
            body = world.CreateBody(bodyDef);

            // prepare fixtures
            for(f=0; f<fixtures.length; f++)
            {
                var fixture:Array = fixtures[f];

                var fixtureDef:b2FixtureDef = new b2FixtureDef();


                fixtureDef.density=fixture[0];
                fixtureDef.friction=fixture[1];
                fixtureDef.restitution=fixture[2];

                fixtureDef.filter.categoryBits = fixture[3];
                fixtureDef.filter.maskBits = fixture[4];
                fixtureDef.filter.groupIndex = fixture[5];
                fixtureDef.isSensor = fixture[6];

                var p:Number;
                var polygons:Array = fixture[8];
                for(p=0; p<polygons.length; p++)
                {
                    var polygonShape:b2PolygonShape = new b2PolygonShape();
                    polygonShape.SetAsArray(polygons[p], polygons[p].length);
                    fixtureDef.shape=polygonShape;

                    body.CreateFixture(fixtureDef);
                }
            }

            return body;
        }

		
        public function PhysicsData(): void
		{
			dict = new Dictionary();
			

			dict["cave"] = [

										[
											// density, friction, restitution
                                            2, 0, 0,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',
											[

                                                [   new b2Vec2(651.5/ptm_ratio, 180/ptm_ratio)  ,  new b2Vec2(703/ptm_ratio, 199.5/ptm_ratio)  ,  new b2Vec2(668/ptm_ratio, 225.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(509.5/ptm_ratio, 141/ptm_ratio)  ,  new b2Vec2(575.5/ptm_ratio, 143/ptm_ratio)  ,  new b2Vec2(524/ptm_ratio, 187.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(158/ptm_ratio, -1.5/ptm_ratio)  ,  new b2Vec2(292/ptm_ratio, 102.5/ptm_ratio)  ,  new b2Vec2(240.5/ptm_ratio, 114/ptm_ratio)  ,  new b2Vec2(144.5/ptm_ratio, 83/ptm_ratio)  ] ,
                                                [   new b2Vec2(798/ptm_ratio, 363.5/ptm_ratio)  ,  new b2Vec2(880/ptm_ratio, 484.5/ptm_ratio)  ,  new b2Vec2(785.5/ptm_ratio, 457/ptm_ratio)  ,  new b2Vec2(747.5/ptm_ratio, 388/ptm_ratio)  ] ,
                                                [   new b2Vec2(880/ptm_ratio, 484.5/ptm_ratio)  ,  new b2Vec2(1022.5/ptm_ratio, 599/ptm_ratio)  ,  new b2Vec2(769/ptm_ratio, 598.5/ptm_ratio)  ,  new b2Vec2(785.5/ptm_ratio, 457/ptm_ratio)  ] ,
                                                [   new b2Vec2(575.5/ptm_ratio, 143/ptm_ratio)  ,  new b2Vec2(1022/ptm_ratio, -1.5/ptm_ratio)  ,  new b2Vec2(651.5/ptm_ratio, 180/ptm_ratio)  ,  new b2Vec2(606/ptm_ratio, 198.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(457.5/ptm_ratio, 120/ptm_ratio)  ,  new b2Vec2(509.5/ptm_ratio, 141/ptm_ratio)  ,  new b2Vec2(483/ptm_ratio, 158.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(240.5/ptm_ratio, 114/ptm_ratio)  ,  new b2Vec2(292/ptm_ratio, 102.5/ptm_ratio)  ,  new b2Vec2(250/ptm_ratio, 143.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(395.5/ptm_ratio, 116/ptm_ratio)  ,  new b2Vec2(457.5/ptm_ratio, 120/ptm_ratio)  ,  new b2Vec2(435/ptm_ratio, 138.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(340.5/ptm_ratio, 162/ptm_ratio)  ,  new b2Vec2(337.5/ptm_ratio, 98/ptm_ratio)  ,  new b2Vec2(395.5/ptm_ratio, 116/ptm_ratio)  ,  new b2Vec2(369/ptm_ratio, 171.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(831/ptm_ratio, 225.5/ptm_ratio)  ,  new b2Vec2(1022/ptm_ratio, -1.5/ptm_ratio)  ,  new b2Vec2(915/ptm_ratio, 270.5/ptm_ratio)  ,  new b2Vec2(869/ptm_ratio, 273.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(736/ptm_ratio, 210/ptm_ratio)  ,  new b2Vec2(1022/ptm_ratio, -1.5/ptm_ratio)  ,  new b2Vec2(831/ptm_ratio, 225.5/ptm_ratio)  ,  new b2Vec2(792.5/ptm_ratio, 243/ptm_ratio)  ] ,
                                                [   new b2Vec2(891.5/ptm_ratio, 374/ptm_ratio)  ,  new b2Vec2(934.5/ptm_ratio, 330/ptm_ratio)  ,  new b2Vec2(1022.5/ptm_ratio, 599/ptm_ratio)  ,  new b2Vec2(880/ptm_ratio, 484.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(934.5/ptm_ratio, 330/ptm_ratio)  ,  new b2Vec2(1022/ptm_ratio, -1.5/ptm_ratio)  ,  new b2Vec2(1022.5/ptm_ratio, 599/ptm_ratio)  ] ,
                                                [   new b2Vec2(457.5/ptm_ratio, 120/ptm_ratio)  ,  new b2Vec2(1022/ptm_ratio, -1.5/ptm_ratio)  ,  new b2Vec2(575.5/ptm_ratio, 143/ptm_ratio)  ,  new b2Vec2(509.5/ptm_ratio, 141/ptm_ratio)  ] ,
                                                [   new b2Vec2(158/ptm_ratio, -1.5/ptm_ratio)  ,  new b2Vec2(1022/ptm_ratio, -1.5/ptm_ratio)  ,  new b2Vec2(337.5/ptm_ratio, 98/ptm_ratio)  ,  new b2Vec2(292/ptm_ratio, 102.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(337.5/ptm_ratio, 98/ptm_ratio)  ,  new b2Vec2(1022/ptm_ratio, -1.5/ptm_ratio)  ,  new b2Vec2(457.5/ptm_ratio, 120/ptm_ratio)  ,  new b2Vec2(395.5/ptm_ratio, 116/ptm_ratio)  ] ,
                                                [   new b2Vec2(915/ptm_ratio, 270.5/ptm_ratio)  ,  new b2Vec2(1022/ptm_ratio, -1.5/ptm_ratio)  ,  new b2Vec2(934.5/ptm_ratio, 330/ptm_ratio)  ] ,
                                                [   new b2Vec2(703/ptm_ratio, 199.5/ptm_ratio)  ,  new b2Vec2(651.5/ptm_ratio, 180/ptm_ratio)  ,  new b2Vec2(1022/ptm_ratio, -1.5/ptm_ratio)  ,  new b2Vec2(736/ptm_ratio, 210/ptm_ratio)  ]
											]
										]
 ,
										[
											// density, friction, restitution
                                            2, 0, 0,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',
											[

                                                [   new b2Vec2(107.5/ptm_ratio, 316/ptm_ratio)  ,  new b2Vec2(86/ptm_ratio, 388.5/ptm_ratio)  ,  new b2Vec2(0/ptm_ratio, 599.5/ptm_ratio)  ,  new b2Vec2(6.5/ptm_ratio, 217/ptm_ratio)  ,  new b2Vec2(93.5/ptm_ratio, 225/ptm_ratio)  ] ,
                                                [   new b2Vec2(602.5/ptm_ratio, 459/ptm_ratio)  ,  new b2Vec2(534/ptm_ratio, 532.5/ptm_ratio)  ,  new b2Vec2(396.5/ptm_ratio, 462/ptm_ratio)  ,  new b2Vec2(356.5/ptm_ratio, 420/ptm_ratio)  ,  new b2Vec2(376/ptm_ratio, 379.5/ptm_ratio)  ,  new b2Vec2(579/ptm_ratio, 384.5/ptm_ratio)  ,  new b2Vec2(612.5/ptm_ratio, 413/ptm_ratio)  ] ,
                                                [   new b2Vec2(154.5/ptm_ratio, 450/ptm_ratio)  ,  new b2Vec2(0/ptm_ratio, 599.5/ptm_ratio)  ,  new b2Vec2(86/ptm_ratio, 388.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(235.5/ptm_ratio, 483/ptm_ratio)  ,  new b2Vec2(0/ptm_ratio, 599.5/ptm_ratio)  ,  new b2Vec2(154.5/ptm_ratio, 450/ptm_ratio)  ,  new b2Vec2(219.5/ptm_ratio, 456/ptm_ratio)  ] ,
                                                [   new b2Vec2(235.5/ptm_ratio, 483/ptm_ratio)  ,  new b2Vec2(385/ptm_ratio, 490.5/ptm_ratio)  ,  new b2Vec2(543.5/ptm_ratio, 595/ptm_ratio)  ,  new b2Vec2(0/ptm_ratio, 599.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(543.5/ptm_ratio, 595/ptm_ratio)  ,  new b2Vec2(385/ptm_ratio, 490.5/ptm_ratio)  ,  new b2Vec2(396.5/ptm_ratio, 462/ptm_ratio)  ,  new b2Vec2(534/ptm_ratio, 532.5/ptm_ratio)  ] ,
                                                [   new b2Vec2(385/ptm_ratio, 490.5/ptm_ratio)  ,  new b2Vec2(235.5/ptm_ratio, 483/ptm_ratio)  ,  new b2Vec2(360/ptm_ratio, 470.5/ptm_ratio)  ]
											]
										]

									];

		}
	}
}
