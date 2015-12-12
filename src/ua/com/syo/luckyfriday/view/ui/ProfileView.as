package ua.com.syo.luckyfriday.view.ui {
	import flash.filesystem.File;

	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.controls.List;
	import feathers.controls.Panel;
	import feathers.core.PopUpManager;
	import feathers.data.ListCollection;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;

	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.AssetManager;

	import ua.com.syo.luckyfriday.controller.Controller;
	import ua.com.syo.luckyfriday.data.Assets;
	import ua.com.syo.luckyfriday.model.storage.profile.Profile;
	import ua.com.syo.luckyfriday.model.storage.profile.ProfileStorage;

	public class ProfileView extends Panel {

		private var panelWidth:int = 600;
		private var panelHeight:int = 600;
		private var backBtn:Button;

		private var top:Label;
		private var topuser:List;
		private var currentuser:List;
		private var assetManager:AssetManager;
		public var profimg:Image;
		private var topUser:Array;
		private var topScore:Array;
		private var topList:ListCollection = new ListCollection(["Loading Data Please Wait..."]);
		private var currentUserList:ListCollection = new ListCollection(["Loading Data Please Wait..."]);

		/**
		 *
		 *
		 */
		public function ProfileView() {
			width = panelWidth;
			height = panelHeight;
			title = "Profile & Raiting";

			//Load profile data


			this.layout = new AnchorLayout();


			// Make Label container for user data
			var labels2VLayout:VerticalLayout = new VerticalLayout();
			var labels2Container:LayoutGroup = new LayoutGroup();
			labels2VLayout.padding = 12;
			labels2VLayout.gap = 5;
			labels2Container.x = 20;
			labels2Container.y = 200;
			labels2Container.width = 220;
			labels2VLayout.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_LEFT;
			labels2Container.layout = labels2VLayout;
			this.addChild(labels2Container);

			topuser = new List()
			topuser.dataProvider = topList;
			topuser.width = 310;
			topuser.paddingRight = 20;
			topuser.x = 240;
			topuser.y = 40;
			topuser.touchable = true;
			//topuser.itemRendererProperties.labelField = topList;
			this.addChild(topuser);

			currentuser = new List()
			currentuser.dataProvider = currentUserList;
			currentuser.width = 190;
			topuser.paddingRight = 20;
			currentuser.paddingLeft = 20;
			currentuser.x = 20;
			currentuser.y = 230;
			currentuser.touchable = false;
			this.addChild(currentuser);




			top = new Label;
			top.text = "TOP"
			top.x = 380;
			top.y = 10;
			addChild(top);

			backBtn = new Button;
			backBtn.label = "Back"
			backBtn.width = 180;
			backBtn.height = 50;
			backBtn.layoutData = new AnchorLayoutData(NaN, NaN, 12, 25);
			backBtn.addEventListener(Event.TRIGGERED, buttonClicked);
			this.addChild(backBtn);


			// add img profile

			profimg = new Image(Texture.fromEmbeddedAsset(Assets.AvatarC));
			profimg.y = 25;
			profimg.x = 20;
			addChild(profimg);
		}

		private function buttonClicked(event:Event):void {
			switch (event.currentTarget as Button) {

				case backBtn:
					PopUpManager.removePopUp(this);
					break;
			}
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
			topuser.dataProvider = getTopData();
			currentuser.dataProvider = getCurrentUserData();
		}

		public static function getCurrentUserData():ListCollection {
			var currentUserList:ListCollection = new ListCollection;
			var p:Profile = ProfileStorage.getPlayerProfile()
			var currentUser:Array = new Array;
			currentUser[0] = p.name;
			currentUser[1] = "SCORE: " + p.score;
			currentUser[2] = "RANK: " + p.rank;
			currentUser[3] = "ACH: " + p.achives + "/" + p.achivesMax;
			currentUserList.data = currentUser;

			return currentUserList;
		}

		public static function getTopData():ListCollection {

			var topList:ListCollection = new ListCollection;
			var topData:Array = new Array;
			for (var i:int = 1; i < 10; i++) {
				var n:int = i - 1;
				var p:Profile = ProfileStorage.getProfileByRank(i);
				topData[n] = p.rank + "   " + p.name + "  " + p.score;
			}
			topList.data = topData;

			return topList;
		}

	}
}
