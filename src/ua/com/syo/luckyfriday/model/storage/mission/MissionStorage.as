package ua.com.syo.luckyfriday.model.storage.mission {
	import flash.utils.Dictionary;

	import starling.textures.Texture;

	import ua.com.syo.luckyfriday.model.storage.mission.Location;
	import ua.com.syo.luckyfriday.model.storage.mission.Mission;


	public class MissionStorage {
		private static var missionDictionary:Dictionary = new Dictionary();
		public static var meteorTexture:Texture;
		private static var po:Object = new Object();

		public static function ParseProfileFromJSON(json:Object):void {
			var location:Object = new Object();
			var q:int = json.point.length;
			for (var i:int = 0; i < json.point.length; i++) {

				addMissionPointFromJSON(json.point[i]);
			}
			location = {locationId: json.location.locationId, quantityMission: q, locationName: json.location.locationName, locationInfo: json.location.locationInfo, locationTexture: json.location.locationTexture, locationWidth: json.location.locationWidth, locationHeight: json.location.locationHeight};

			addLocationFromJSON(location)

			trace("----")
		}

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

		public static function addLocation(l:Location):void {

			missionDictionary[l.locationId] = l;
		}

		public static function addMissionPointFromJSON(pointData:Object):void {
			var m:Mission = new Mission();
			m.pointID = pointData.pointId;
			m.pointX = pointData.pointX;
			m.pointY = pointData.pointY;
			m.rate = pointData.rate;
			m.missionEnable = pointData.missionEnable;

			addMissionPoint(m);
		}

		public static function addMissionPoint(m:Mission):void {
			po[m.pointID] = m;


		}

	}
}
