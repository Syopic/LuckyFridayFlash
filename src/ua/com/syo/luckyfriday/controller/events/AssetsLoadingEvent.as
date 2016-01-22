package ua.com.syo.luckyfriday.controller.events
{
	import flash.events.Event;

	public class AssetsLoadingEvent extends Event
	{
		public static const LEVEL_LOADED:String = "levelLoaded";
		public static const MISSION_LOADED:String = "missionLoaded";
		public static const PROFILE_LOADED:String = "profileLoaded";
		public function AssetsLoadingEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}

