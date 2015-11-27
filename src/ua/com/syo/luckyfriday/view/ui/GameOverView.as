package ua.com.syo.luckyfriday.view.ui
{
	import citrus.math.MathUtils;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.controls.Panel;
	import feathers.core.PopUpManager;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.HorizontalLayout;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
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
		private var panelHeight:int = 550;
		private var containerBtn:LayoutGroup;
		private var img:Image;
		private var sText:Sprite;
		private var gtlegend:Array;
		private var legend:TextField;
		private var imglegend:Array;
		private var texture:Texture;
		
		
		public function GameOverView() 
		{
			
			width = panelWidth;
			height = panelHeight;
			title = "Game Over";
			
			
			// add Image
			
			imglegend = new Array;
			imglegend[0] = Texture.fromEmbeddedAsset(Assets.GameOver1C);
			imglegend[1] = Texture.fromEmbeddedAsset(Assets.GameOver2C);
			imglegend[2] = Texture.fromEmbeddedAsset(Assets.GameOver3C);
			imglegend[3] = Texture.fromEmbeddedAsset(Assets.GameOver4C);
			
			
			
			gtlegend = new Array();
			gtlegend[0] = "Ты слишком жесток, вот что я тебе должен сказать. Таких, как ты,\n опасно пускать в космос – там все чересчур хрупко,\n да-да, вот именно, хрупко! ";
			gtlegend[1] = "Шатл отлично взлетел. Жаль только, приземлился не на той планете."
			gtlegend[2] = "Космос - это не прогулка, шатл - не самолет.";
			gtlegend[3] = "Иногда мне кажется, что мы — черти, которые штурмуют Космос.";
			gtlegend[4] = "Прежде, чем лезть к звездам, человеку надо научиться жить на Земле.";
			gtlegend[5] = "— Как иголка в космосе!\n— Там было про стог сена!\n— Да, точно, как стог сена в космосе!";
			gtlegend[6] = "Меняются миры, распадаются Галактики,\n но женщины — всегда женщины.";
			
			
			
			sText = new Sprite();
			legend = new TextField(540, 200, " ", "Source Sans Pro", 15, 0xFFFFFF, false);
			arrange();
			//legend.text = textLegend;
			sText.addChild(legend);
			sText.x = 10;
			sText.y =250;
			addChild(sText);
			
			/**
			 * 
			   Add buttons
			 * 
			 */
			initButtons();
			
			
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
		
		/**
		 * Add legends array
		 */
		
	
		public function arrange():void 
		{
			var i:Number;
			var n:Number;
			i =  MathUtils.randomInt(0, 6);
			n =  MathUtils.randomInt(0, 3);
			texture = imglegend[n];
			legend.text = gtlegend[i];
			
			if (contains(img) != true){
			img = new Image(texture);
			img.y = 0;
			img.x = 10;
			this.addChild(img);
			}else{
				this.removeChild(img);
				img = null;
				img = new Image(texture);
				img.y = 0;
				img.x = 10;
				this.addChild(img);
			}	
			
			//addEventListener(Event.ENTER_FRAME, inImgLegend);
			
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
					arrange();
					Controller.instance.ce.playing = true;
					break;
				case playagainBtn:
					arrange();					
					//Controller.instance.startLevel(Controller.instance.currentLevelId);  
					//PopUpManager.removePopUp(this);
					//Controller.instance.ce.playing = true;
					break;
			}
		
		}   
	}
}