package ua.com.syo.luckyfriday.model.storage.mission {
	import flash.utils.Dictionary;
	
	import starling.textures.Texture;
	
	import ua.com.syo.luckyfriday.controller.Controller;
	import ua.com.syo.luckyfriday.model.storage.mission.Location;
	import ua.com.syo.luckyfriday.model.storage.mission.Mission;
	import ua.com.syo.luckyfriday.model.storage.profile.Profile;

	/**
	 * 
	 * @author Alex
	 * 
	 */
	public class MissionStorage {
		private static var missionDictionary:Dictionary = new Dictionary();
		public static var locationTexture:Texture;
		private static var po:Object = new Object();

		/**
		 * Parse Location and Misiion point from Json
		 * @param js - json object 
		 * 
		 */
		public static function ParseLocationMisiionFromJSON(js:Object):void {
			var location:Object = new Object();
			var q:int = js.point.length;
			for (var i:int = 0; i < js.point.length; i++) {

				addMissionPointFromJSON(js.point[i]);
			}
			location = {locationId: js.location.locationId, quantityMission: q, locationName: js.location.locationName, locationInfo: js.location.locationInfo, locationTexture: js.location.locationTexture, locationWidth: js.location.locationWidth, locationHeight: js.location.locationHeight};

			addLocationFromJSON(location)

			trace("---->")
		}

		/**
		 * Add Location variables From JSON
		 * @param locationData - object JSON
		 */
		public static function addLocationFromJSON(locationData:Object):void {
			var l:Location = new Location();
			l.locationId = locationData.locationId;
			l.locationTexture = locationData.locationTexture;
			l.locationWidth = locationData.locationWidth;
			l.locationHeight = locationData.locationHeight;
			l.locationInfo = locationData.locationInfo;
			l.locationName = locationData.locationName;
			l.quantityMission = locationData.quantityMission;
			l.point = po;
			addLocation(l);
		}

		/**
		 *Add Location to mission Dictionary
		 * @param l - Location variables
		 */
		public static function addLocation(l:Location):void {

			missionDictionary[l.locationId] = l;
		}

		/**
		 * Add MissionPoint variables From JSON
		 * @param pointData - object JSON
		 */
		public static function addMissionPointFromJSON(pointData:Object):void {
			var m:Mission = new Mission();
			m.pointID = pointData.pointId;
			m.pointX = pointData.pointX;
			m.pointY = pointData.pointY;
			m.rate = pointData.rate;
			m.missionEnable = pointData.missionEnable;
			addMissionPoint(m);
		}

		/**
		 * Create object includet all Missions Point
		 * @param m - Mission variables
		 */
		public static function addMissionPoint(m:Mission):void {
			po[m.pointID] = m;
		}
		
		/**
		 * Get Mission Poin By Id - not checked
		 * @param pointID
		 * @return 
		 * 
		 */
		public static function getMissionPoinById(pointID:String):Mission {
			var result:Mission = null;
			for each (var m:Mission in missionDictionary) {
				if (m.pointID == pointID) {
					result = m;
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
		public static function getLocationById(locationId:String):Location {
			return missionDictionary[locationId] as Location;
		}
		
		/**
		 * Get current lication texture - not work
		 * @param locationId
		 * @return 
		 * 
		 */
		static public function getLocationTexture(locationId:String):Texture {
			var location:Location = null;
			var t:String = null;
			for each (var l:Location in missionDictionary) {
				if (l.locationId == locationId) {
					location = l;
					t = l.locationTexture;
					trace("locationTexture-->"+ t);
				}
			}
			Controller.instance.locationTexture(t);
			trace("locationTexture->"+ locationTexture);
			trace();
			return locationTexture;
			
		}
	}
}
