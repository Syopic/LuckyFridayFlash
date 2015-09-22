package ua.com.syo.luckyfriday.view
{

	import citrus.objects.CitrusSprite;
	import citrus.objects.platformer.simple.Hero;
	import citrus.view.ISpriteView;
	import citrus.view.starlingview.StarlingArt;

	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	import ua.com.syo.luckyfriday.data.Assets;

	public class ShipHero extends Hero
	{
		public function ShipHero(name:String, params:Object = null)
		{
			super(name, params);
			// create atlas
			var texture:Texture = Assets.getTexture("ShipKrenC");
			var xml:XML = XML(new Assets.ShipKrenXMLC());
			var atlas:TextureAtlas = new TextureAtlas(texture, xml);

			// create movie clip
			var movie:MovieClip = new MovieClip(atlas.getTextures(""), 10);
			movie.loop = false; // default: true

			// control playback
			movie.play();
			movie.pause();
			movie.stop();

			// important: add movie to juggler
			Starling.juggler.add(movie);
		}

	}
}

