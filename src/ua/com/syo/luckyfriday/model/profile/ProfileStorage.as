package ua.com.syo.luckyfriday.model.profile {
	import flash.utils.Dictionary;

	import starling.textures.Texture;


	public class ProfileStorage {
		private static var profileDictionary:Dictionary = new Dictionary();
		private static var achieveDictionary:Dictionary = new Dictionary();
		private static var playerProfile:Profile;
		public static var profTexture:Texture;



		public static function setProfile(obj:Object):void {
			var p:Profile = new Profile();
			p.id = obj.id;
			p.name = obj.name;
			p.img = obj.img;
			p.rank = obj.rank;
			p.score = obj.score;
			p.isPlayer = true;
			addProfile(p);
		}

		public static function setTop(top:Array):void {
			for (var i:int = 0; i < top.length; i++) 
			{
				var p:Profile = new Profile();
				p.id = top[i].id;
				p.name =  top[i].name;
				p.rank =  top[i].rank;
				p.score =  top[i].score;
				addProfile(p);
			}
		}

		public static function setAchieves(achieves:Array):void {
			for (var i:int = 0; i < achieves.length; i++) 
			{
				var a:Achieve = new Achieve();
				a.id = achieves[i].id;
				a.name = achieves[i].name;
				a.description = achieves[i].description;
				a.img = achieves[i].img;
				a.max = achieves[i].max;
				a.progress = achieves[i].progress;
				addAchieve(a);
			}
		}

		/**
		 * @param profile add profile in profileDictionary
		 */
		public static function addProfile(profile:Profile):void {
			profileDictionary[profile.id] = profile;
			// cashing player profile
			if (profile.isPlayer) {
				playerProfile = profile;
			}
		}

		/**
		 * @param achieve add achieve in achieveDictionary
		 */
		public static function addAchieve(achieve:Achieve):void {
			achieveDictionary[achieve.id] = achieve;
		}

		/**
		 * @param id - select profile by ID
		 * @return profile by ID
		 */
		public static function getProfileById(id:String):Profile {
			return profileDictionary[id] as Profile;
		}

		/**
		 * @param rank - select profile by rank
		 * @return profile - rank
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

		/**
		 * @param id - select achieve by ID
		 * @return achieve by ID
		 */
		public static function getAchieveById(id:String):Achieve {
			return achieveDictionary[id] as Achieve;
		}
	}
}


