package ua.com.syo.luckyfriday.controller.events
{
	import starling.events.Event;
	
	public class MyEvent extends Event
	{
		public function MyEvent(type:String, bubbles:Boolean=false, data:Object=null)
		{
			super(type, bubbles, data);
		}
	}
}