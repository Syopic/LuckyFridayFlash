package ua.com.syo.luckyfriday.view.ui
{
	import citrus.core.starling.StarlingState;
	import feathers.controls.Button;
	import feathers.controls.LayoutGroup;
	import feathers.controls.Panel;
	import feathers.core.PopUpManager;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;

	import starling.events.Event;

	import ua.com.syo.luckyfriday.controller.Controller;
	import ua.com.syo.luckyfriday.view.UIManager;
	import ua.com.syo.luckyfriday.view.states.GameState;
	import ua.com.syo.luckyfriday.view.states.MenuState;
	import ua.com.syo.luckyfriday.view.states.MissionsState;

	public class InGameMenu extends Panel
	{
		private var container:LayoutGroup;
		private var showSettings:UIManager;
		private var resumeBtn:Button;
		private var aBtn:Button;
		private var bBtn:Button;
		private var cBtn:Button;
		private var panelWidth:int = 280;
		private var panelHeight:int;
		private var currentState:StarlingState;
		public var btLabelA:String;
		public var btLabelB:String;
		public var btLabelC:String;
		public var viBtC:Boolean;


		public function InGameMenu()
		{



			width = panelWidth;
			height = panelHeight;
			title = "Game Menu";




			/**
			 * Add butons
			 */

			initButtons();

			resumeBtn = new Button();
			resumeBtn.label = "Resume";
			resumeBtn.width = 210;
			resumeBtn.layoutData = new AnchorLayoutData(12, 12, NaN, 15);
			resumeBtn.addEventListener(Event.TRIGGERED, buttonClicked);
			container.addChild(resumeBtn);

			aBtn = new Button();
			aBtn.width = 210;
			aBtn.layoutData = new AnchorLayoutData(74, 12, NaN, 15);
			aBtn.addEventListener(Event.TRIGGERED, buttonClicked);
			container.addChild(aBtn);


			bBtn = new Button();
			bBtn.width = 210;
			bBtn.layoutData = new AnchorLayoutData(136, 12, NaN, 15);
			bBtn.addEventListener(Event.TRIGGERED, buttonClicked);
			container.addChild(bBtn);


			cBtn = new Button();
			cBtn.width = 210;
			cBtn.layoutData = new AnchorLayoutData(198, 12, NaN, 15);
			cBtn.addEventListener(Event.TRIGGERED, buttonClicked);
			container.addChild(cBtn);


			arrange();
		}
		/**
		 * add layout group
		 */

		private function initButtons():void {
			container = new LayoutGroup();
			container.layout = new AnchorLayout();
			//container.autoSizeMode = LayoutGroup.AUTO_SIZE_MODE_CONTENT;
			this.addChild(container);
		}

		/**
		 * arrange buttons
		 */
		public function	arrange():void
		{
			if (Controller.instance.ce.state == GameState.instance){
				aBtn.label = "Restart Misson";
				bBtn.label = "Exit Misson";
				cBtn.label = "Settings";
				cBtn.visible = true;
				panelHeight = 360;
				panelWidth = 280;
				

			} else {
				aBtn.label = "Settings";
				bBtn.label = "Main Menu";
				cBtn.visible = false;
				panelHeight = 290;
				panelWidth = 280;
				

			}
			height = panelHeight;

		}
		private function buttonClicked(event:Event):void   
		{   
			switch (event.currentTarget as Button)
			{
				case resumeBtn: 
					PopUpManager.removePopUp(this);
					Controller.instance.ce.playing = true;
					break;
				case cBtn: 
						UIManager.instance.showSettings();
						Controller.instance.ce.playing = false;
					break;
					if (Controller.instance.ce.state == GameState.instance){
						UIManager.instance.showSettings();
						Controller.instance.ce.playing = false;
						break;
					}else {
					}
				case bBtn:
					if (Controller.instance.ce.state == GameState.instance){
						Controller.instance.changeState(MissionsState.newInstance);
						PopUpManager.removePopUp(this);
						Controller.instance.ce.playing = true;
						break;
					}else{
						Controller.instance.changeState(MenuState.newInstance);
						PopUpManager.removePopUp(this);
						Controller.instance.ce.playing = true;
						break;
					}
				case aBtn:
					if (Controller.instance.ce.state == GameState.instance){
						Controller.instance.startLevel(Controller.instance.currentLevelId);  
						PopUpManager.removePopUp(this);
						Controller.instance.ce.playing = true;
						break;
					}else{
						UIManager.instance.showSettings();
						break;
					}
			}
		}
	}
}

