package sample.ui.components.scroll 
{
    import flash.events.*;
    import sample.ui.components.*;
    
    public class ScrollBar extends sample.ui.components.Component
    {
        public function ScrollBar(arg1:Boolean=false)
        {
            var horizontal:Boolean=false;

            var loc1:*;
            horizontal = arg1;
            super();
            this.decArrow = new sample.ui.components.scroll.ScrollButton(1, this.pixelSize, this.decScroll);
            this.incArrow = new sample.ui.components.scroll.ScrollButton(3, this.pixelSize, this.incScroll);
            this.scrollbg = new sample.ui.components.Box().fill(0, 1, 3);
            this.tracker = new sample.ui.components.scroll.ScrollTracker();
            this.scrollbg.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, function (arg1:flash.events.MouseEvent):void
            {
                if (scrollbg.mouseY > tracker.y) 
                {
                    incScrollJump();
                }
                else 
                {
                    decScrollJump();
                }
                return;
            })
            this.tracker.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, function (arg1:flash.events.MouseEvent):void
            {
                var e:flash.events.MouseEvent;
                var handleMove:Function;

                var loc1:*;
                handleMove = null;
                e = arg1;
                handleMove = function (arg1:flash.events.Event):void
                {
                    changeByPx(tracker.mouseY - _mouseY);
                    if (tracker.upState.parent) 
                    {
                        tracker.removeEventListener(flash.events.Event.ENTER_FRAME, handleMove);
                    }
                    return;
                }
                _mouseY = tracker.mouseY;
                tracker.addEventListener(flash.events.Event.ENTER_FRAME, handleMove);
                tracker.addEventListener(flash.events.MouseEvent.MOUSE_UP, function (arg1:flash.events.MouseEvent):void
                {
                    tracker.removeEventListener(flash.events.Event.ENTER_FRAME, handleMove);
                    tracker.removeEventListener(flash.events.MouseEvent.MOUSE_UP, arguments.callee);
                    return;
                })
                return;
            })
            addChild(this.scrollbg);
            addChild(this.tracker);
            addChild(this.decArrow);
            addChild(this.incArrow);
            this.tracker.width = this.pixelSize;
            this.tracker.x = 0;
            this.redraw();
            return;
        }

        public function changeByPx(arg1:Number):void
        {
            this.scrollValue = this.scrollValue + this._scrollSize / this.innerSize * arg1;
            return;
        }

        public function decScroll():void
        {
            this.scrollValue = this._scrollValue - 15;
            return;
        }

        public function incScroll():void
        {
            this.scrollValue = this._scrollValue + 15;
            return;
        }

        public function decScrollJump():void
        {
            this.scrollValue = this._scrollValue - this._scrollViewable;
            return;
        }

        public function incScrollJump():void
        {
            this.scrollValue = this._scrollValue + this._scrollViewable;
            return;
        }

        public function set scrollSize(arg1:Number):void
        {
            this._scrollSize = arg1;
            this._scrollValue = Math.max(Math.min(this._scrollValue, this._scrollSize - this._scrollViewable), 0);
            return;
        }

        public function set scrollViewable(arg1:Number):void
        {
            this._scrollViewable = arg1;
            this._scrollValue = Math.max(Math.min(this._scrollValue, this._scrollSize - this._scrollViewable), 0);
            return;
        }

        public function set scrollValue(arg1:Number):void
        {
            if (arg1 != this._scrollValue) 
            {
                this._scrollValue = Math.max(Math.min(arg1, this._scrollSize - this._scrollViewable), 0);
                if (this.scrollListener != null) 
                {
                    this.scrollListener(this._scrollValue);
                }
                this.redraw();
            }
            return;
        }

        public function get scrollValue():Number
        {
            return this._scrollValue;
        }

        public function scroll(arg1:Function):void
        {
            this.scrollListener = arg1;
            return;
        }

        private function get innerSize():Number
        {
            return _height - this.pixelSize * 2;
        }

        public override function get width():Number
        {
            return _width;
        }

        public override function get height():Number
        {
            return _height;
        }

        protected override function redraw():void
        {
            this.tracker.height = Math.max(this.innerSize * this._scrollViewable / this._scrollSize, 10);
            this.tracker.y = this.pixelSize + 1 + this._scrollValue / (this._scrollSize - this._scrollViewable) * (this.innerSize - this.tracker.height - 1);
            this.scrollbg.width = this.pixelSize;
            this.scrollbg.height = _height;
            this.incArrow.y = _height - this.pixelSize;
            return;
        }

        private var decArrow:sample.ui.components.scroll.ScrollButton;

        private var incArrow:sample.ui.components.scroll.ScrollButton;

        private var scrollbg:sample.ui.components.Box;

        private var tracker:sample.ui.components.scroll.ScrollTracker;

        private var _scrollSize:Number=1000;

        private var _scrollViewable:Number=200;

        private var _scrollValue:Number=0;

        private var scrollListener:Function;

        private var _mouseY:Number;

        private var _mouseX:Number;

        private var pixelSize:int=10;
    }
}
