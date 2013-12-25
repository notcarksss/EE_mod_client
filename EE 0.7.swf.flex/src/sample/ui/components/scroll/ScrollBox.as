package sample.ui.components.scroll 
{
    import flash.display.*;
    import flash.geom.*;
    import sample.ui.components.*;
    
    public class ScrollBox extends sample.ui.components.Box
    {
        public function ScrollBox()
        {
            var loc1:*;
            this._container = new Content();
            this._mask = new flash.display.Sprite();
            this.hscroll = new sample.ui.components.scroll.ScrollBar();
            super();
            super.addChild(this._container);
            super.addChild(this._mask);
            super.addChild(this.hscroll);
            this._mask.graphics.beginFill(0, 1);
            this._mask.graphics.drawRect(0, 0, 100, 100);
            this._mask.graphics.endFill();
            this.hscroll.scroll(function (arg1:Number):void
            {
                scrollY = arg1;
                return;
            })
            this._container.mask = this._mask;
            return;
        }

        public override function add(... rest):sample.ui.components.Box
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=rest;
            for each (loc1 in loc3) 
            {
                this._container.addChild(loc1);
            }
            this.redraw();
            return this;
        }

        public function set scrollX(arg1:Number):void
        {
            this._scrollX = arg1;
            this.redraw();
            return;
        }

        public function set scrollY(arg1:Number):void
        {
            this.hscroll.scrollValue = arg1;
            this._scrollY = arg1;
            this.redraw();
            return;
        }

        public function get scrollWidth():Number
        {
            return this._container.width - this._mask.width;
        }

        public function get scrollHeight():Number
        {
            return this._container.height - this._mask.height;
        }

        public function get scrollX():Number
        {
            return this._scrollX;
        }

        public function get scrollY():Number
        {
            return this._scrollY;
        }

        public override function get width():Number
        {
            return _width;
        }

        public override function get height():Number
        {
            return _height;
        }

        public override function addChild(arg1:flash.display.DisplayObject):flash.display.DisplayObject
        {
            return this._container.addChild(arg1);
        }

        public override function removeChild(arg1:flash.display.DisplayObject):flash.display.DisplayObject
        {
            return this._container.removeChild(arg1);
        }

        public function refresh():void
        {
            this.redraw();
            return;
        }

        protected override function redraw():void
        {
            var loc1:*=_width;
            if (this._container.height > _height) 
            {
                _width = _width - 10;
                this.hscroll.visible = true;
                this.hscroll.scrollViewable = _height;
                this.hscroll.scrollSize = this._container.height + (_top || 0) + (_bottom || 0);
            }
            else 
            {
                this.hscroll.visible = false;
                this.hscroll.scrollValue = 0;
            }
            super.redraw();
            this._scrollX = Math.max(Math.min(this._scrollX, this.scrollWidth), 0);
            this._scrollY = Math.max(Math.min(this._scrollY, this.scrollHeight), 0);
            this._container.x = this._container.x - (this._scrollX + 1);
            this._container.y = this._container.y - (this._scrollY + 1);
            this.hscroll.x = _width;
            this.hscroll.y = 0;
            this.hscroll.height = Math.ceil(_height);
            _width = loc1;
            this.scrollRect = new flash.geom.Rectangle(0, 0, _width + 1, _height + 1);
            return;
        }

        private var _container:flash.display.Sprite;

        private var _mask:flash.display.Sprite;

        private var _scrollX:Number=0;

        private var _scrollY:Number=0;

        private var hscroll:sample.ui.components.scroll.ScrollBar;
    }
}

import flash.display.*;
import sample.ui.components.*;


class Content extends sample.ui.components.Component
{
    public function Content()
    {
        super();
        return;
    }

    protected override function redraw():void
    {
        var loc2:*=null;
        var loc1:*=0;
        while (loc1 < numChildren) 
        {
            loc2 = getChildAt(loc1);
            loc2.width = _width;
            ++loc1;
        }
        return;
    }
}