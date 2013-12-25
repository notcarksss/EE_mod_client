package sample.ui.components 
{
    import flash.display.*;
    
    import mx.states.OverrideBase;
    
    public class Rows extends sample.ui.components.Component
    {
        public function Rows(... rest)
        {
            var loc1:*=null;
            super();
            var loc2:*=0;
            var loc3:*=rest;
            for each (loc1 in loc3) 
            {
                this.addChild(loc1);
            }
            return;
        }

        public override function addChild(arg1:flash.display.DisplayObject):flash.display.DisplayObject
        {
            var loc1:*=super.addChild(arg1);
            this.redraw();
            return loc1;
        }

        public override function addChildAt(arg1:flash.display.DisplayObject, arg2:int):flash.display.DisplayObject
        {
            var loc1:*=super.addChildAt(arg1, arg2);
            this.redraw();
            return loc1;
        }

        public override function removeChild(arg1:flash.display.DisplayObject):flash.display.DisplayObject
        {
            var loc1:*=super.removeChild(arg1);
            this.redraw();
            return loc1;
        }

		//public override function removeChildren():void
		
        /*public function removeChildren():void
        {
            while (numChildren) 
            {
                super.removeChild(getChildAt(0));
            }
            this.redraw();
            return;
        }*/

        public function spacing(arg1:Number):*
        {
            this._spacing = arg1;
            this.redraw();
            return this;
        }

        protected override function redraw():void
        {
            var loc3:*=null;
            var loc1:*=0;
            var loc2:*=0;
            while (loc2 < numChildren) 
            {
                loc3 = getChildAt(loc2);
                loc3.y = loc1;
                loc3.width = _width;
                loc1 = loc1 + (loc3.height + this._spacing);
                ++loc2;
            }
            super.redraw();
            _height = loc1;
            return;
        }

        private var _spacing:Number=10;
    }
}
