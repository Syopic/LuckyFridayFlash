package ua.com.syo.luckyfriday.view.ui.renderers {
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.core.FeathersControl;

	import starling.events.Event;
	import feathers.layout.AnchorLayout;

	public class TopListItemRenderer extends FeathersControl implements IListItemRenderer {
		protected var _label:Label;
		protected var _label2:Label;
		protected var _label3:Label;
		protected var _index:int = -1;
		protected var _owner:List;
		protected var _data:Object;
		protected var _factoryID:String;
		protected var _isSelected:Boolean;
		protected var _padding:Number = 0;
		private var _touchable:Boolean;
		private var layout:AnchorLayout;

		public function TopListItemRenderer() {
			super();
		}

		public function get data():Object {
			return this._data;
		}

		public function set data(value:Object):void {
			if (this._data == value) {
				return;
			}
			this._data = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}

		public function get index():int {
			return this._index;
		}

		public function set index(value:int):void {
			if (this._index == value) {
				return;
			}
			this._index = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}

		public function get owner():List {
			return this._owner;
		}

		public function set owner(value:List):void {
			if (this._owner == value) {
				return;
			}
			this._owner = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}


		public function get factoryID():String {
			return this._factoryID
			return null;
		}

		public function set factoryID(value:String):void {
			if (this._factoryID == value) {
				return;
			}
			this._factoryID = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}

		public function get isSelected():Boolean {
			return this._isSelected;
		}

		public function set isSelected(value:Boolean):void {
			if (this._isSelected == value) {
				return;
			}
			this._isSelected = value;
			this.invalidate(INVALIDATION_FLAG_SELECTED);
			this.dispatchEventWith(Event.CHANGE);
		}

		public function get padding():Number {
			return this._padding;
		}

		public function set padding(value:Number):void {
			if (this._padding == value) {
				return;
			}
			this._padding = value;
			this.invalidate(INVALIDATION_FLAG_LAYOUT);
		}

		override protected function initialize():void {
			if (!this._label && !this._label2 && !this._label3) {


				this._label = new Label();
				//this._label.layoutData = labelLayoutData;
				this._label2 = new Label();
				this._label2.touchable = true;
				//this._label2.layoutData = labelLayoutData;
				this._label3 = new Label();
				//this._label3.layoutData = labelLayoutData;
				this.addChild(this._label);
				this.addChild(this._label2);
				this.addChild(this._label3);

			}
		}

		override protected function draw():void {
			var dataInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_DATA);

			if (dataInvalid) {
				this.commitData();
			}

			this.autoSizeIfNeeded();
			this.layoutChildren();
		}

		protected function autoSizeIfNeeded():Boolean {
			var needsWidth:Boolean = isNaN(this.explicitWidth);
			var needsHeight:Boolean = isNaN(this.explicitHeight);
			if (!needsWidth && !needsHeight) {
				return false;
			}

			this._label.width = this.explicitWidth - 2 * this._padding;
			this._label.height = this.explicitHeight - 2 * this._padding;
			this._label.validate();

			var newWidth:Number = this.explicitWidth;
			if (needsWidth) {
				newWidth = this._label.width + 2 * this._padding;
			}
			var newHeight:Number = this.explicitHeight;
			if (needsHeight) {
				newHeight = this._label.height + 2 * this._padding;
			}

			return this.setSizeInternal(newWidth, newHeight, false);
		}

		protected function commitData():void {
			if (this._data) {
				this._label.text = this._data.label;
				this._label2.text = this._data.label2;
				this._label3.text = this._data.label3;
			} else {
				this._label.text = null;
				this._label2.text = null;
				this._label3.text = null;
			}
		}

		protected function layoutChildren():void {

			this._label.x = this._padding + 5;
			this._label.y = this._padding;
			this._label2.x = this._padding + 45;
			this._label2.y = this._padding;
			this._label3.x = this._padding + 215;
			this._label3.y = this._padding;

			this._label2.width = 150;
			this._label2.focusPadding = 155;
			this._label3.width = 150;
			this._label3.focusPadding = 150;
			this._label.width = this.actualWidth - 2 * this._padding;

			this._label.height = this.actualHeight - 2 * this._padding;
			this._label2.height = this.actualHeight - 2 * this._padding;
			this._label3.height = this.actualHeight - 2 * this._padding;
		}
	}
}