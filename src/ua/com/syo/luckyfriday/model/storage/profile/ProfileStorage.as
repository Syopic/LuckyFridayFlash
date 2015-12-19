package ua.com.syo.luckyfriday.model.storage.profile {
	import flash.utils.Dictionary;

	import starling.textures.Texture;


	public class ProfileStorage {
		private static var profileDictionary:Dictionary = new Dictionary();
		private static var playerProfile:Profile;
		public static var profTexture:Texture;



		/**
		 *
		 * @param json Parse Profile From JSON
		 *
		 */
		public static function ParseProfileFromJSON(json:Object):void {
			var player:Object = new Object();
			//Parse Player Profile 
			player = {id: json.id, name: json.name, rank: json.rank, score: json.score, achives: json.achives, achivesMax: json.achivesMax, isPlayer: true};
			addProfileFromJSON(player);
			//Parse TOP Profile 
			for (var i:int = 0; i < json.top.length; i++) {
				addProfileFromJSON(json.top[i]);
			//TODO Parse separate data
			}
		}

		/**
		 *
		 * @param profileData createing profile object
		 *
		 */
		public static function addProfileFromJSON(profileData:Object):void {
			var p:Profile = new Profile();

			p.id = profileData.id;
			p.name = profileData.name;
			p.rank = profileData.rank;
			p.score = profileData.score;
			p.achives = profileData.achives;
			p.achivesMax = profileData.achivesMax;
			p.isPlayer = profileData.isPlayer;
			addProfile(p);
		}

		/**
		 *
		 * @param profile add profile in profileDictionary
		 *
		 */
		public static function addProfile(profile:Profile):void {
			profileDictionary[profile.id] = profile;
			// cashing player profile
			if (profile.isPlayer) {
				playerProfile = profile;
			}
		}

		/**
		 *
		 * @param id - select profile by ID
		 * @return profile by ID
		 *
		 */
		public static function getProfileById(id:String):Profile {
			return profileDictionary[id] as Profile;
		}

		/**
		 *
		 * @param rank - select profile by rank
		 * @return profile - rank
		 *
		 */
		public static function getProfileByRank(rank:int):Profile {
			var result:Profile = null;
			for each (var p:Profile in profileDictionary) {
				if (p.rank == rank) {
					result = p;
				}

			}
			return result;
		}

		/**
		 * get current Player Profile
		 * @return Player Profile
		 *
		 */
		public static function getPlayerProfile():Profile {
			return playerProfile;
		}

		/**
		 * Profile Texture
		 */
		static public function getProfileTexture():Texture {
			return profTexture;

		}
	}
}


