package ua.com.syo.luckyfriday.model.storage.profile {
	import feathers.data.ListCollection;

	import ua.com.syo.luckyfriday.controller.Controller;

	public class Profile {


		/**
		 *
		 */
		public var id:String;
		public var name:String;
		public var rank:int;
		public var score:int;
		public var isPlayer:Boolean = false;

		//...

		public function Profile() {

		}


		public static function getCurrentUserData():ListCollection {
			var currentUserList:ListCollection = new ListCollection;
			var currentUser:Array = new Array;
			currentUser[0] = Controller.profileObjects.name;
			currentUser[1] = "SCORE: " + Controller.profileObjects.score;
			currentUser[2] = "RANK: " + Controller.profileObjects.rank;
			currentUser[3] = "ACH: " + Controller.profileObjects.achives + "/" + Controller.profileObjects.achivesMax;
			currentUserList.data = currentUser;

			return currentUserList;
		}

		public static function getTopData():ListCollection {

			var topList:ListCollection = new ListCollection;
			var topData:Array = new Array;
			for (var i:int = 0; i < Controller.profileObjects.top.length; i++) {
				topData[i] = Controller.profileObjects.top[i].rank + "   " + Controller.profileObjects.top[i].name + "  " + Controller.profileObjects.top[i].score;
			}
			topList.data = topData;

			return topList;
		}

	}
}

