package ua.com.syo.luckyfriday.model.storage.mission {
	import flash.utils.Dictionary;

	import starling.textures.Texture;

	import ua.com.syo.luckyfriday.model.storage.Model;

	/**
	 *
	 * @author Alex
	 *
	 */
	public class MissionStorage {
		private static var missionDictionary:Dictionary = new Dictionary();
		private static var locationDictionary:Dictionary = new Dictionary();
		public static var locationTexture:Texture;

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
					addMissionPointFromJSON(misiionPoint[n]);
				}
				addLocationFromJSON(js.location[i], quantity);
			}
		}

		/**
		 * Add Location variables From JSON
		 * @param locationData - object JSON
		 */
		private static function addLocationFromJSON(locationData:Object, quantity:int):void {
			var l:Location = new Location();
			l.locationId = locationData.locationId;
			l.locationTexture = locationData.locationTexture;
			l.locationWidth = locationData.locationWidth;
			l.locationHeight = locationData.locationHeight;
			l.locationInfo = locationData.locationInfo;
			l.locationName = locationData.locationName;
			l.quantityMission = quantity;
			addLocation(l);
		}

		/**
		 *Add Location to mission Dictionary
		 * @param l - Location variables
		 */
		private static function addLocation(l:Location):void {

			locationDictionary[l.locationId] = l;
		}

		/**
		 * Add MissionPoint variables From JSON
		 * @param pointData - object JSON
		 */
		private static function addMissionPointFromJSON(pointData:Object):void {
			var m:Mission = new Mission();
			m.location = pointData.location;
			m.missionId = pointData.missionId;
			m.pointX = pointData.pointX;
			m.pointY = pointData.pointY;
			m.rate = pointData.rate;
			m.missionEnable = pointData.missionEnable;
			m.additionalPoint = pointData.additionalPoint;
			m.additQuantity = pointData.additQuantity;
			addMissionPoint(m);
		}

		/**
		 * Create object includet all Missions Point
		 * @param m - Mission variables
		 */
		private static function addMissionPoint(m:Mission ):void {
			missionDictionary[m.missionId] = m;
		}

		/**
		 * Get Mission Poin By Id - not checked
		 * @param pointID
		 * @return Mission
		 *
		 */
		public static function getMissionById(missionId:String):Mission {
			var result:Mission = null;
			for each (var m:Mission in missionDictionary) {
				if (m.missionId == missionId) {
					result = m;
				}
			}
			return result;
		}

		/**
		 *  Get Mission Poin By Type - primary or additional
		 * @param additional - Boolean true or false
		 * @param locationId - locationId
		 * @return Mission
		 *
		 */
		public static function getMissionByType(locationId:String, additional:Boolean ):Array {
			var result:Array = new Array;
			for each (var m:Mission in missionDictionary) {
				if (m.location == locationId) {
					if (m.additionalPoint == additional){
						result.push(m.missionId);
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
		public static function getLocationById(locationId:String):Location {
			return locationDictionary[locationId] as Location;
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
					trace("locationTexture-->" + t);
				}
			}
			locationTexture = Model.instance.assetManager.getTexture(t);
			trace("locationTexture->" + locationTexture);
			return locationTexture;

		}
	}
}

