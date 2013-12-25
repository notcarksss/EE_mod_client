package sample.ui.components 
{
    import flash.display.*;
    
    public class Box extends sample.ui.components.Component
    {
        public function Box()
        {
            super();
            this.redraw();
            return;
        }

        public function margin(arg1:Number=NaN, arg2:Number=NaN, arg3:Number=NaN, arg4:Number=NaN):*
        {
            this._top = arg1;
            this._right = arg2;
            this._bottom = arg3;
            this._left = arg4;
            this.redraw();
            return this;
        }

        public function fill(arg1:int=0, arg2:Number=1, arg3:Number=0):*
        {
            _width = width;
            _height = height;
            this._color = arg1;
            this._corner = arg3;
            this._alpha = arg2;
            this.useFill = true;
            this.redraw();
            return this;
        }

        public function border(arg1:Number=0, arg2:Number=0, arg3:Number=1):*
        {
            this._strokeWidth = arg1;
            this._strokeColor = arg2;
            this._strokeAlpha = arg3;
            this.redraw();
            return this;
        }

        public function minSize(arg1:Number, arg2:Number):sample.ui.components.Box
        {
            this.minWidth = arg1;
            this.minHeight = arg2;
            this.redraw();
            return this;
        }

        public function add(... rest):sample.ui.components.Box
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=rest;
            for each (loc1 in loc3) 
            {
                addChild(loc1);
            }
            this.redraw();
            return this;
        }

        protected function get borderHeight():Number
        {
            return (this._top ? this._top : 0) + (this._bottom ? this._bottom : 0);
        }

        protected function get borderWidth():Number
        {
            return (this._left ? this._left : 0) + (this._right ? this._right : 0);
        }

        public function reset(arg1:Boolean=true, arg2:Array=null):void
        {
            var loc2:*=null;
            var loc3:*=null;
            if (arg1) 
            {
                arg2 = [];
            }
            var loc1:*=0;
            while (loc1 < numChildren) 
            {
                loc2 = getChildAt(loc1);
                if (loc2 is sample.ui.components.Box) 
                {
                    (loc2 as sample.ui.components.Box).reset(false, arg2);
                }
                ++loc1;
            }
            arg2.push(this.redraw);
            if (arg1) 
            {
                var loc4:*=0;
                var loc5:*=arg2;
                for each (loc3 in loc5) 
                {
                    loc3();
                    loc3();
                }
            }
            return;
        }

        protected override function redraw():void
        {
            var loc4:*=null;
            var loc1:*=_width;
            var loc2:*=_height;
            var loc3:*=0;
            while (loc3 < numChildren) 
            {
                loc4 = getChildAt(loc3);
                loc1 = Math.max(loc1, loc4.width + this.borderWidth);
                loc2 = Math.max(loc2, loc4.height + this.borderHeight);
                if (!isNaN(this._left)) 
                {
                    loc4.x = this._left;
                    if (!isNaN(this._right)) 
                    {
                        loc4.width = rwidth - this.borderWidth;
                    }
                }
                else if (!isNaN(this._right)) 
                {
                    loc4.x = loc1 - loc4.width - this._right;
                }
                else 
                {
                    loc4.x = (Math.max(rwidth, loc1) - loc4.width) / 2;
                }
                if (!isNaN(this._top)) 
                {
                    loc4.y = this._top;
                    if (!isNaN(this._bottom)) 
                    {
                        loc4.height = rheight - this.borderHeight;
                    }
                }
                else if (!isNaN(this._bottom)) 
                {
                    loc4.y = loc2 - loc4.height - this._bottom;
                }
                else 
                {
                    loc4.y = (Math.max(rheight, loc2) - loc4.height) / 2;
                }
                ++loc3;
            }
            graphics.clear();
            if (this._strokeWidth) 
            {
                graphics.lineStyle(this._strokeWidth, this._strokeColor, this._strokeAlpha, true);
                if (_minWidth || _minHeight) 
                {
                    graphics.drawRoundRect(0, 0, Math.max(rwidth, loc1), Math.max(rheight, loc2), this._corner);
                }
                else 
                {
                    graphics.drawRoundRect(0, 0, Math.max(rwidth, _width), Math.max(rheight, _height), this._corner);
                }
            }
            if (this.useFill) 
            {
                graphics.beginFill(this._color, this._alpha);
                if (_minWidth || _minHeight) 
                {
                    graphics.drawRoundRect(0, 0, Math.max(rwidth, loc1), Math.max(rheight, loc2), this._corner);
                }
                else 
                {
                    graphics.drawRoundRect(0, 0, Math.max(rwidth, _width), Math.max(rheight, _height), this._corner);
                }
                graphics.endFill();
            }
            return;
        }

        protected var _top:Number=NaN;

        protected var _bottom:Number=NaN;

        protected var _left:Number=NaN;

        protected var _right:Number=NaN;

        protected var _color:int;

        protected var _corner:Number=0;

        protected var _alpha:Number;

        protected var _strokeWidth:Number;

        protected var _strokeColor:Number;

        protected var _strokeAlpha:Number;

        protected var useFill:Boolean=false;
    }
}
