package ua.com.syo.luckyfriday.view.ui {

	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.PageIndicator;
	import feathers.controls.Panel;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.core.PopUpManager;
	import feathers.data.ListCollection;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;

	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;

	import ua.com.syo.luckyfriday.data.EmbeddedAssets;
	import ua.com.syo.luckyfriday.model.profile.Profile;
	import ua.com.syo.luckyfriday.model.profile.ProfileStorage;
	import ua.com.syo.luckyfriday.view.ui.renderers.TopListItemRenderer;

	/**
	 *
	 * @author Alex
	 *
	 */
	public class ProfileView extends Panel {

		private var panelWidth:int = 600;
		private var panelHeight:int = 600;
		private var backBtn:Button;
		private var nextBtn:Button;
		private var prevBtn:Button;
		private var top:Label;
		private var topuser:List;
		private var currentuser:List;
		public var profimg:Image;
		private var topList:ListCollection = new ListCollection([{label: "1", label2: "Please Wait", label3: "0"}]);
		private var currentUserList:ListCollection = new ListCollection(["Loading Data Please Wait..."]);
		private var pageIndicator:PageIndicator;
		private var pn:int;

		//private static var i:int;

		/**
		 * Add UI Profile View constructor
		 *
		 */
		public function ProfileView() {
			width = panelWidth;
			height = panelHeight;
			title = "Profile & Raiting";

			this.layout = new AnchorLayout();
			//Add top 10 List 
			topuser = new List();
			topuser.dataProvider = topList;
			topuser.width = 310;
			topuser.x = 240;
			topuser.y = 50;
			topuser.itemRendererFactory = function():IListItemRenderer {
				var renderer:TopListItemRenderer = new TopListItemRenderer();
				renderer.padding = 5;
				return renderer;
			};
			this.addChild(topuser);

			//Add current User List
			currentuser = new List()
			currentuser.dataProvider = currentUserList;
			currentuser.width = 200;
			currentuser.paddingRight = 10;
			currentuser.paddingLeft = 10;
			currentuser.x = 15;
			currentuser.y = 230;
			currentuser.touchable = false;
			this.addChild(currentuser);

			//Add Label "TOP"
			top = new Label;
			top.text = "TOP"
			top.x = 375;
			top.y = 10;
			addChild(top);

			//Add back Button
			backBtn = new Button;
			backBtn.label = "Back"
			backBtn.width = 180;
			backBtn.height = 50;
			backBtn.layoutData = new AnchorLayoutData(NaN, NaN, 12, 25);
			backBtn.addEventListener(Event.TRIGGERED, buttonClicked);
			this.addChild(backBtn);

			// add img profile
			profimg = new Image(Texture.fromEmbeddedAsset(EmbeddedAssets.AvatarC));
			profimg.y = 25;
			profimg.x = 20;
			addChild(profimg);

			//add page indicator top 100
			this.pageIndicator = new PageIndicator();
			this.pageIndicator.pageCount = 5;
			this.pageIndicator.addEventListener(Event.CHANGE, pageIndicatorHandler);
			var pageIndicatorLayoutData:AnchorLayoutData = new AnchorLayoutData();
			pageIndicatorLayoutData.bottom = 10
			pageIndicatorLayoutData.right = 80;
			this.pageIndicator.layoutData = pageIndicatorLayoutData;
			this.addChild(this.pageIndicator);

			//add button page next 50-100
			nextBtn = new Button;
			nextBtn.styleNameList.add(Button.ALTERNATE_STYLE_NAME_FORWARD_BUTTON);
			nextBtn.isEnabled = true;
			nextBtn.width = 40;
			nextBtn.height = 40;
			nextBtn.layoutData = new AnchorLayoutData(NaN, 35, 12, NaN);
			nextBtn.addEventListener(Event.TRIGGERED, buttonClicked);
			//nextBtn.label = "+";
			addChild(nextBtn);

			//add button page previous 1-50
			prevBtn = new Button;
			prevBtn.styleNameList.add(Button.ALTERNATE_STYLE_NAME_BACK_BUTTON);
			prevBtn.isEnabled = false;
			prevBtn.width = 40;
			prevBtn.height = 40;
			prevBtn.layoutData = new AnchorLayoutData(NaN, 260, 12, NaN);
			prevBtn.addEventListener(Event.TRIGGERED, buttonClicked);
			//prevBtn.label = "+";
			addChild(prevBtn);
		}



		/**
		* Arrange profile data
		*/
		public function arrange():void {

			this.removeChild(profimg);
			//profimg = null;
			profimg = new Image(ProfileStorage.getProfileTexture());
			profimg.height = 180;
			profimg.width = 180;
			profimg.x = 25;
			profimg.y = 20;
			addChild(profimg);
			topuser.dataProvider = getTopData(pn);
			currentuser.dataProvider = getCurrentUserData();
		}

		/**
		 * Add current user data for User List
		 * @return ListCollection current user data
		 *
		 */
		public static function getCurrentUserData():ListCollection {
			var currentUserList:ListCollection = new ListCollection;
			var p:Profile = ProfileStorage.getPlayerProfile()
			var currentUser:Array = new Array;
			currentUser[0] = p.name;
			currentUser[1] = "SCORE: " + p.score;
			currentUser[2] = "RANK: " + p.rank;
			currentUser[3] = "ACH: " + 10 + "/" + 40;
			currentUserList.data = currentUser;

			return currentUserList;
		}

		/**
		 * Add top 10 user data for Top 100 List
		 * @return ListCollection top List data
		 *
		 */
		public static function getTopData(pind:int):ListCollection {

			var topList:ListCollection = new ListCollection;
			for (var i:int = (1 + pind); i < (11 + pind); i++) {
				var n:int = i - pind - 1;
				var p:Profile = ProfileStorage.getProfileByRank(i);
				topList.data[n] = {label: p.rank, label2: p.name, label3: p.score, player: p.isPlayer};
			}
			return topList;
		}

		/**
		 * Page Indicator Handler
		 * @param event
		 */
		private function pageIndicatorHandler(event:Event):void {
			if (nextBtn.isEnabled == true) {
				pn = pageIndicator.selectedIndex * 10;
			} else {
				pn = (pageIndicator.selectedIndex + 5) * 10;
			}
			arrange();
		}

		/**
		 * Buttons Clicked Handler
		 * @param event button Clicked
		 */
		private function buttonClicked(event:Event):void {
			switch (event.currentTarget as Button) {

				case nextBtn:
					var next:Event = new Event(Event.CHANGE)
					pageIndicator.selectedIndex = 0;
					prevBtn.isEnabled = true;
					nextBtn.isEnabled = false;
					pageIndicatorHandler(next)

					break;
				case prevBtn:
					var prev:Event = new Event(Event.CHANGE)
					pageIndicator.selectedIndex = 0;
					prevBtn.isEnabled = false;
					nextBtn.isEnabled = true;
					pageIndicatorHandler(prev)
					break;
				case backBtn:
					PopUpManager.removePopUp(this);
					break;
			}
		}

	}
}


