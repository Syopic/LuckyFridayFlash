package ua.com.syo.luckyfriday.view.ui
{
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.controls.Panel;
	import feathers.core.PopUpManager;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.HorizontalLayout;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	import ua.com.syo.luckyfriday.controller.Controller;
	import ua.com.syo.luckyfriday.data.Assets;
	import ua.com.syo.luckyfriday.view.states.MenuState;

	public class GameOverView extends Panel
	{
		private var playagainBtn:Button;
		private var menuBtn:Button;
		private var panelWidth:int = 600;
		private var panelHeight:int = 500;
		private var containerBtn:LayoutGroup;
		private var img:Image;
		private var sText:Sprite;
		
		public function GameOverView() 
		{
			
			width = panelWidth;
			height = panelHeight;
			
			
			
			// add Logo
			img = new Image(Texture.fromEmbeddedAsset(Assets.GameOver1C));
			img.y = 0;
			img.x = 10;
			this.addChild(img);
			
			
			
			
			var labelsVLayout:HorizontalLayout = new HorizontalLayout();
			var labelsContainer:LayoutGroup = new LayoutGroup();
			labelsVLayout.padding = 20;
			labelsVLayout.gap = 8;
			labelsContainer.y = 0;
			labelsContainer.width = 550;
			labelsVLayout.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_CENTER;
			labelsContainer.layout = labelsVLayout;
			this.addChild(labelsContainer);
			
			
			addLabel("Game Over", labelsContainer);
			
		
			//add text
			
			sText = new Sprite();
			var legend:TextField = new TextField(540, 200, " ", "Segoe Print", 13, 0xFFFFFF, true);
			legend.text = "Ты слишком жесток, вот что я тебе должен сказать. Таких, как ты,\n опасно пускать в космос – там все чересчур хрупко,\n да-да, вот именно, хрупко! ";
			sText.addChild(legend);
			sText.x = 10;
			sText.y =250;
			addChild(sText);
			
			/**
			 * 
			   Add buttons
			 * 
			 */
			initButtons()
			
			
			// menu button
			menuBtn = new Button();
			menuBtn.label = "Menu";
			menuBtn.width = 170;
			//menuBtn.height = 50;
			menuBtn.layoutData = new AnchorLayoutData(NaN, 12, 12, NaN, NaN);
			menuBtn.addEventListener(Event.TRIGGERED, buttonClicked);
			containerBtn.addChild(menuBtn);
			
			
			// playagain button
			playagainBtn = new Button();
			playagainBtn.label = "Play Again";
			playagainBtn.width = 170;
			//playagainBtn.height = 50;
			playagainBtn.layoutData = new AnchorLayoutData(NaN, NaN, 20, NaN, NaN);
			playagainBtn.addEventListener(Event.TRIGGERED, buttonClicked);
			containerBtn.addChild(playagainBtn);
			
			
		}
		
		private function addLabel(text:String, container:LayoutGroup):void
		{
			var label:Label = new Label();
			label.text = text;
			container.addChild(label);
		}	
		
		/**
		 * Add conteiner for buttons
		 */ 
		private function initButtons():void {
			var containerVLayout:HorizontalLayout = new HorizontalLayout();
			containerBtn = new LayoutGroup();
			containerBtn.layout = new AnchorLayout();
			containerBtn.y = 390;
			containerBtn.width = 550;
			containerBtn.height = 78;
			containerVLayout.gap = 20; 
			containerVLayout.padding = 8;
			containerVLayout.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_CENTER;
			containerBtn.layout = containerVLayout;
			this.addChild(containerBtn);
		}
		
		
		/**
		 * Add events for buttons
		 */
		
		private function buttonClicked(event:Event):void   
		{
			switch (event.currentTarget as Button){
				case menuBtn: 
					Controller.instance.changeState(MenuState.newInstance);
					PopUpManager.removePopUp(this);
					Controller.instance.ce.playing = true;
					break;
				case playagainBtn:
					Controller.instance.startLevel(Controller.instance.currentLevelId);  
					PopUpManager.removePopUp(this);
					Controller.instance.ce.playing = true;
					break;
			}
		
		}   
	}
}