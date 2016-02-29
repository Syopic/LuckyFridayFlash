package ua.com.syo.luckyfriday.model.mission {
	import flash.utils.Dictionary;

	import starling.textures.Texture;

	/**
	 *
	 * @author Alex
	 *
	 */
	public class MissionStorage {
		private static var missionDictionary:Dictionary = new Dictionary();
		private static var locationDictionary:Dictionary = new Dictionary();
		public static var locationTexture:Texture;

		public static function setLocations(locations:Array):void {
			for (var i:int = 0; i < locations.length; i++) {
				var loc:Location = new Location();
				loc.id = locations[i].id;
				loc.name = locations[i].name;
				loc.description = locations[i].description;
				loc.bgImageUrl = locations[i].bg;
				loc.fgImageUrl = locations[i].fg;
				addLocation(loc);
			}
		}

		public static function setMissions(missions:Array, locationId:String):void {
			for (var i:int = 0; i < missions.length; i++) {
				var mission:Mission = new Mission();
				mission.id = missions[i].id;
				mission.locationId = locationId;
				mission.linkId = missions[i].linkId;
				mission.name = missions[i].name;
				mission.description = missions[i].description;
				mission.bgImageUrl = missions[i].bg;
				mission.fgImageUrl = missions[i].fg;
				mission.rate = missions[i].rate;
				mission.locX = missions[i].locX;
				mission.locY = missions[i].locY;
				mission.isComplete = missions[i].isComplete;
				addMission(mission);
			}
		}


		/**
		 * Add Location to Dictionary
		 * @param l - Location
		 */
		private static function addLocation(loc:Location):void {
			locationDictionary[loc.id] = loc;
		}

		/**
		 * Create object includet all Missions Point
		 * @param m - Mission variables
		 */
		private static function addMission(mission:Mission):void {
			missionDictionary[mission.id] = mission;
			trace();
		}

		/**
		 * Get Mission Poin By Id - not checked
		 * @param pointID
		 * @return Mission
		 *
		 */
		public static function getMissionById(id:String):Mission {
			return missionDictionary[id];
		}

		/**
		 *  Get Mission Id Array By Type - primary or additional
		 * @param additional - Boolean true or false
		 * @param locationId - locationId
		 * @return Mission -  array mission Id
		 *
		 */
		public static function getMissionIdByType(locationId:String, additional:Boolean):Array {
			var result:Array = new Array;
			for each (var mission:Mission in missionDictionary) {
				if (mission.locationId == locationId) {
					if (additional == false) {
						if (mission.linkId == null) {
							result.push(mission.id);
						}
					}
					if (additional == true) {
						if (mission.linkId != null) {
							result.push(mission.id);
						}
					}
				}
			}
			return result;
		}

		/**
		 * Get Location By Id - not checked
		 * @param locationId
		 * @return
		 *
		 */
		public static function getLocationById(id:String):Location {
			return locationDictionary[id] as Location;
		}
	}
}

