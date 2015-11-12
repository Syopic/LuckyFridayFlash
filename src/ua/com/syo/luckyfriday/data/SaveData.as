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
				so = SharedObject.getLocal(Constants.NAME_SO);
			} catch (e:Object) { }
		}

		public function writeData(propertyName:String, data:Object):void {
			if (so) so.data[propertyName] = data;
		}

		public function readData(propertyName:String):Object {
			if (so) {
				//trace(propertyName + ": " + so.data[propertyName]);
				return so.data[propertyName];
			}

			//trace ("Problem reading from shared object!");
			return null;
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

