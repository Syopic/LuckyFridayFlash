package ua.com.syo.luckyfriday.model.storage.profile {
	import feathers.data.ListCollection;

	import starling.textures.Texture;

	public class Profile {

		public static var profTexture:Texture;
		private static var profileJSON:Object;
		public static const NAME_USER:String = "name";
		public static const SCORE_USER:String = "score";
		public static const RANK_USER:String = "rank";
		public static const TOP_USER:String = "top"

		/**
		 *
		 */
		public var id:String;	
		public var name:String;	
		public var rank:int;	
		public var score:int;	
		public var isPlayer:Boolean = false;	
		//...

		public function Profile()
		{

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

		public static function getCurrentUserData():ListCollection {
			var currentUserList:ListCollection = new ListCollection;
			var currentUser:Array = new Array;
			currentUser[0] = profileObjects.name;
			currentUser[1] = "SCORE: " + profileObjects.score;
			currentUser[2] = "RANK: " + profileObjects.rank;
			currentUser[3] = "ACH: " + profileObjects.achives + "/" + profileObjects.achivesMax;
			currentUserList.data = currentUser;

			return currentUserList;
		}

		public static function getTopData():ListCollection {

			var topList:ListCollection = new ListCollection;
			var topData:Array = new Array;
			for (var i:int = 0; i < profileObjects.top.length; i++) {
				topData[i] = profileObjects.top[i].rank + "   " + profileObjects.top[i].name + "  " + profileObjects.top[i].score;
			}
			topList.data = topData;

			return topList;
		}

	}
}

