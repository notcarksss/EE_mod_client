package sample.ui.components 
{
    import flash.display.*;
    
    public class Component extends flash.display.Sprite
    {
        public function Component()
        {
            super();
            return;
        }

        public override function set width(arg1:Number):void
        {
            if (this._width != arg1) 
            {
                this._width = arg1;
                this.redraw();
            }
            return;
        }

        public override function set height(arg1:Number):void
        {
            if (this._height != arg1) 
            {
                this._height = arg1;
                this.redraw();
            }
            return;
        }

        public function get rwidth():Number
        {
            return Math.max(this._width, this._minWidth);
        }

        public function get rheight():Number
        {
            return Math.max(this._height, this._minHeight);
        }

        public function set minWidth(arg1:Number):void
        {
            if (this._minWidth != arg1) 
            {
                this._minWidth = arg1;
                this.redraw();
            }
            return;
        }

        public function set minHeight(arg1:Number):void
        {
            if (this._minHeight != arg1) 
            {
                this._minHeight = arg1;
                this.redraw();
            }
            return;
        }

        protected function redraw():void
        {
            return;
        }

        protected var _width:Number=0;

        protected var _height:Number=0;

        protected var _minWidth:Number=0;

        protected var _minHeight:Number=0;
    }
}
