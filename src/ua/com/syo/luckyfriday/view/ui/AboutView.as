package ua.com.syo.luckyfriday.view.ui
{	

	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import citrus.objects.CitrusSprite;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.controls.Panel;
	import feathers.core.PopUpManager;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	import feathers.themes.HyperlinkTextFieldTextRenderer;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	import ua.com.syo.luckyfriday.data.Assets;


	public class AboutView extends Panel
	{
	
		private var backBtn:Button;
		private var panelWidth:int = 500;
		private var panelHeight:int = 470;
		private var img:Image;
		private var url:String;
		private var s:Sprite;
		private var imgover:Image;
		private var imgdown:Image;
		
		public function AboutView()
		{
			width = panelWidth;
			height = panelHeight;
			title = "About";
			
			
			
			this.layout = new AnchorLayout();
			
			var labelsVLayout:VerticalLayout = new VerticalLayout();
			var labelsContainer:LayoutGroup = new LayoutGroup();
			//labelsVLayout.padding = 80;
			labelsVLayout.gap = 5;
			labelsContainer.x = 110;
			labelsContainer.y = 120;
			labelsContainer.width = 240;
			labelsVLayout.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_CENTER;
			labelsContainer.layout = labelsVLayout;
			this.addChild(labelsContainer);
			
			var controlsVLayout:VerticalLayout = new VerticalLayout();
			var controlsContainer:LayoutGroup = new LayoutGroup();
			controlsVLayout.padding = 15;
			controlsVLayout.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_LEFT;
			controlsVLayout.gap = 21;
			controlsContainer.width = 210;
			controlsContainer.x = 230;
			controlsContainer.layout = controlsVLayout;
			this.addChild(controlsContainer);
			
			
			addLabel("Lucky Friday v.0.0.0", labelsContainer);
			
			
			
			//add text
			
			s = new Sprite();
			var legend:TextField = new TextField(180, 200, "Kryvosheya (Syo) Serhii               Myzika Slava               Gonhcar Urii          Kryvosheya Volodymyr    Kysliuk (Riks) Oleksii ", "Segoe Print", 14, 0xFFFFFF, true);
			s.addChild(legend);
			s.x = 140;
			s.y =110;
			addChild(s);
			
			// add Logo
			img = new Image(Texture.fromEmbeddedAsset(Assets.LogobtnC));
			img.y = 5;
			img.x = 180;
			img.touchable = true;
			img.addEventListener(TouchEvent.TOUCH, onTouch);
			addChild(img);
			
			/**
			
			imgover = new Image(Texture.fromEmbeddedAsset(Assets.ButtonOverC));
			//imgover.y = 5;
			//imgover.x = 180;
			//imgover.touchable = true;
			addChild(imgover);
			
			 */
			
			imgdown = new Image(Texture.fromEmbeddedAsset(Assets.ButtonDownC));
			imgdown.y = 5;
			imgdown.x = 180;
			//imgdown.touchable = true;
			imgdown.addEventListener(TouchEvent.TOUCH, onTouch);
			imgdown.visible = false;
			addChild(imgdown);
			 
							
			// add Hyperlink Text
						
			var abtxt:HyperlinkTextFieldTextRenderer = new HyperlinkTextFieldTextRenderer();
			abtxt.text = "<u><a href=\"http://lyuckyfriday.net\">LyuckyFriday.net</a></u>.";
			abtxt.x = 185;
			abtxt.y = 280;
			this.addChild(abtxt);
			
			// back
			backBtn = new Button();
			backBtn.label = "Back";
			backBtn.width = 150;
			backBtn.height = 50;
			backBtn.layoutData = new AnchorLayoutData(NaN,150, 12, 150);
			backBtn.addEventListener(Event.TRIGGERED, buttonClicked);
			this.addChild(backBtn);
			
			
			//addEventListener(Event.ADDED_TO_STAGE, onAdded);	
			
		}
		
		private function add(bgSprite:CitrusSprite):void
		{
			// TODO Auto Generated method stub
			
		}
		
		private function buttonClicked(event:Event):void   
		{   
			switch (event.currentTarget as Button)
			{
				
				case backBtn: 
					PopUpManager.removePopUp(this);
					break;
			}
			
		}
		
	
		
		private function onTouch(e:TouchEvent):void
		{
			
			// get the touch points (can be multiple because of multitouch)
			var touch:Touch = e.getTouch(stage);
			var clicked:DisplayObject = e.currentTarget as DisplayObject;
			
			if (touch.phase == TouchPhase.BEGAN)
			{
				imgdown.visible = true;
				//swapChildren(img, imgdown)
			}
			else
			{
				imgdown.visible = false;
			}
			// detect the click/release phase
			if (touch.phase == TouchPhase.ENDED)
			{
				// get the touch Logobtn open URL
				//var url:String = "http://lyuckyfriday.net";
				var url:String = "https://github.com/";
				navigateToURL(new URLRequest(url));
			
				//PopUpManager.removePopUp(this);	
			}
		}
		

		private function addLabel(text:String, container:LayoutGroup):void
		{
			var label:Label = new Label();
			label.scaleX =0.7;
			label.scaleY =0.7;
			label.text = text;
			container.addChild(label);
		}
		
		//
		
		private function addButton(label:String, container:LayoutGroup):void
		{
			var button:Button = new Button();
			button.label = label;
			button.width = 70;
			button.height = 42;
			container.addChild(button);
		}
		
		
	}
}

