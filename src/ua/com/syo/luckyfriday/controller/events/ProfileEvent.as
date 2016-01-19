package ua.com.syo.luckyfriday.controller.events
{
	import flash.events.Event;

	public class ProfileEvent extends Event
	{
		public static const PROFILE_LOADED:String = "profileLoaded"; 
		public static const MISSION_LOADED:String = "missionLoaded";

		public function ProfileEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}

