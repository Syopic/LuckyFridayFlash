package ua.com.syo.luckyfriday.model.mission {
	import flash.utils.Dictionary;

	import starling.textures.Texture;

	import ua.com.syo.luckyfriday.model.Model;

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
			for (var i:int = 0; i < locations.length; i++) 
			{
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
			for (var i:int = 0; i < missions.length; i++) 
			{
				var mission:Mission = new Mission();
				mission.id = missions[i].id;
				mission.locationId = locationId;
				mission.linkId = missions[i].missionId;
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
		 * Parse Location and Misiion point from Json
		 * @param js - json object
		 *
		 */
		public static function ParseLocationMisiionFromJSON(js:Object):void {
			var misiionPoint:Object = new Object();
			var quantity:int;
			//var q:int = js.location.point.length;
			for (var i:int = 0; i < js.location.length; i++) {

				misiionPoint = js[i];
				quantity = misiionPoint.length;
				for (var n:int = 0; n < misiionPoint.length; n++) {
					//addMissionPointFromJSON(misiionPoint[n]);
				}
					//addLocationFromJSON(js.location[i], quantity);
			}
		}

		/**
		 * Add Location variables From JSON
		 * @param locationData - object JSON
		 */
		private static function parceLocation(locationData:Object, quantity:int):void {
			var loc:Location = new Location();
			loc.id = locationData.id;
			loc.name = locationData.name;
			loc.description = locationData.description;
			loc.bgImageUrl = locationData.bg;
			loc.fgImageUrl = locationData.fg;
			addLocation(loc);
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
					if (mission.linkId != "") {
						result.push(mission.id);
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

