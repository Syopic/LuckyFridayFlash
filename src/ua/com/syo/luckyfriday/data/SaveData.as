package ua.com.syo.luckyfriday.data
{
	import flash.net.SharedObject;

	public class SaveData
	{
		private var so:SharedObject;

		public function SaveData() {
			if (_instance != null)
				throw(new Error("SaveData.as: illegal reinstantiation!"));
			_instance = this;
			try{
				getSharedObject();
			} catch (e:Object) { }
		}

		private function getSharedObject():void {
			so = SharedObject.getLocal("lf");
		}

		public function writeData(name:String, data:Object):void {
			if (so) so.data[name] = data;
		}

		public function readData(changeSettingFunction:Function):void {
			if (so) {
				for (var prop:Object in so.data) {
					//trace(prop + ": " + so.data[prop]);
					changeSettingFunction(prop, so.data[prop]);
				}
			} else {
				//trace ("PROBLEM READING FROM SHARED OBJECT!!!");
			}
		}

		public function clearSharedObject():void {
			if (so) so.clear();
		}

		/**
		 * Singleton
		 */
		private static var _instance:SaveData;

		public static function get instance():SaveData {
			if (_instance == null) {
				_instance = new SaveData();
			}
			return _instance;
		}

	}
}

