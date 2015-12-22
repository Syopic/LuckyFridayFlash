package ua.com.syo.luckyfriday.view.ui.renderers {
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.core.FeathersControl;
	import feathers.layout.AnchorLayout;

	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;

	public class TopListItemRenderer extends FeathersControl implements IListItemRenderer {
		protected var _label:Label;
		protected var _label2:Label;
		protected var _label3:Label;
		protected var _player:Boolean;
		protected var _index:int = -1;
		protected var _owner:List;
		protected var _data:Object;
		protected var _factoryID:String;
		protected var _isSelected:Boolean;
		protected var _padding:Number = 0;
		protected var _q:Quad;
		protected var _s:Sprite;


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
			if (!this._label && !this._label2 && !this._label3 && !this._q && !this._s) {

				_q = new Quad(310, 100);
				_s = new Sprite();
				this._label = new Label();
				this._label2 = new Label();
				this._label3 = new Label();
				this._q.color = 0x00CC33;
				this._s.addChild(_q);
				this._s.addChild(this._label);
				this._s.addChild(this._label2);
				this._s.addChild(this._label3);
				this.addChild(_s);

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
				this._player = this._data.player;
			} else {
				this._label.text = null;
				this._label2.text = null;
				this._label3.text = null;
				this._player = false;
			}
		}

		protected function layoutChildren():void {

			if (this._player == true) {
				this._q.alpha = 1;
			} else {
				this._q.alpha = 0;
			}
			this._s.x = 0;
			this._s.y = 0;
			this._s.width = this.actualWidth;
			this._s.height = this.actualHeight;
			this._q.width = this.actualWidth;
			this._q.height = this.actualHeight;
			this._label.x = this._padding + 5;
			this._label.y = this._padding;
			this._label2.x = this._padding + 45;
			this._label2.y = this._padding;
			this._label3.x = this._padding + 200;
			this._label3.y = this._padding;
			this._label2.width = 150;
			this._label2.focusPadding = 150;
			this._label.width = this.actualWidth - 2 * this._padding;
			this._label.height = this.actualHeight - 2 * this._padding;
			this._label2.height = this.actualHeight - 2 * this._padding;
			this._label3.height = this.actualHeight - 2 * this._padding;
		}
	}
}
