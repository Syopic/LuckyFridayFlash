package ua.com.syo.luckyfriday.model.storage.profile
{
	import flash.utils.Dictionary;
	
	import starling.textures.Texture;


	public class ProfileStorage
	{
		private static var profileDictionary:Dictionary = new Dictionary();
		private static var playerProfile:Profile;
		public static var profTexture:Texture;
		private static var profileJSON:Object;

		public static function addProfileFromJSON(profileData:Object):void {
			var p:Profile = new Profile();
			p.id = profileData.id;
			p.name = profileData.name;
			p.rank = profileData.rank;
			p.score = profileData.score;
			// TODO .... 
			addProfile(p);
		}

		public static function addProfile(profile:Profile):void {
			profileDictionary[profile.id] = profile;
			// cashing player profile
			if (profile.isPlayer)
			{
				playerProfile = profile;
			}
		}

		public static function getProfileById(id:String):Profile {
			return profileDictionary[id] as Profile;
		}

		public static function getProfileByRank(rank:int):Profile {
			var result:Profile = null;
			for each (var p:Profile in profileDictionary) {
				if (p.rank == rank) result = p;
			}
			return null;
		}

		public static function getPlayerProfile():Profile {
			return playerProfile;
		}
		/**
		 * Profile Texture
		 */
		static public function getProfileTexture():Texture {
			return profTexture;
			
		}
		/**
		 * Cashing JSON object
		 */
		public static function setProfile(json:Object):void {
			profileJSON = json;
		}
		/**
		 * Cashing JSON object
		 */
		public static function get profileObjects():Object {
			return profileJSON;
		}

	}
}

