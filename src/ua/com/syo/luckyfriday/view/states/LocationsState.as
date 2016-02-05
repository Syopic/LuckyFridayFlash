package ua.com.syo.luckyfriday.view.states
{
	import citrus.core.starling.StarlingState;

	import feathers.controls.Button;
	import feathers.controls.LayoutGroup;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;

	import starling.display.Image;
	import starling.events.Event;

	import ua.com.syo.luckyfriday.controller.Controller;
	import ua.com.syo.luckyfriday.data.EmbeddedAssets;
	import ua.com.syo.luckyfriday.model.Model;
	import ua.com.syo.luckyfriday.view.UIManager;

	public class LocationsState extends StarlingState
	{

		private var backBtn:Button;
		private var location1Btn:Button;
		private var container:LayoutGroup;
		private var settingsBtn:Button;

		override public function initialize():void   
		{   
			super.initialize(); 
			initButtons();
		}

		/**
		 * Init buttons
		 */
		private function initButtons():void {
			container = new LayoutGroup();
			container.layout = new AnchorLayout();
			container.autoSizeMode = LayoutGroup.AUTO_SIZE_MODE_STAGE;
			this.addChild(container);


			// location
			location1Btn = new Button();
			location1Btn.label = "LOCATION 1";
			location1Btn.width = 300;
			location1Btn.height = 100;
			location1Btn.layoutData = new AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);
			location1Btn.addEventListener(Event.TRIGGERED, buttonClicked);
			container.addChild(location1Btn);

			// back
			backBtn = new Button();
			backBtn.label = "←";
			backBtn.width = 75;
			backBtn.height = 75;
			backBtn.layoutData = new AnchorLayoutData(20, NaN, NaN, 20);
			backBtn.addEventListener(Event.TRIGGERED, buttonClicked);
			container.addChild(backBtn);

			// settings
			settingsBtn = new Button();
			settingsBtn.width = 75;
			settingsBtn.height = 75;
			settingsBtn.layoutData = new AnchorLayoutData(NaN, 20, 20, NaN);
			settingsBtn.defaultIcon = new Image(Model.instance.assetManager.getTexture("SettingsIconC"));
			settingsBtn.addEventListener(Event.TRIGGERED, buttonClicked);
			container.addChild(settingsBtn);
		}

		private function buttonClicked(event:Event):void   
		{   
			switch (event.currentTarget as Button)
			{
				case backBtn: 
					Controller.instance.changeState(MenuState.newInstance);   
					break;
				case location1Btn: 
					Controller.instance.changeState(MissionsState.newInstance);   
					break;
				case settingsBtn: 
					UIManager.instance.showSettings();
			}
		}   

		/**
		 * Singleton
		 */
		private static var _instance:LocationsState;

		public static function get instance():LocationsState
		{
			if (_instance == null) _instance = new LocationsState();
			return _instance;
		}

		/**
		 * Reinstance for changeState
		 * @return
		 *
		 */
		public static function get newInstance():LocationsState
		{
			_instance = new LocationsState();
			return _instance;
		}
	}
}

