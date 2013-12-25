package sample.ui.components 
{
    import flash.display.*;
    import flash.events.*;
    
    public class SampleButton extends flash.display.SimpleButton
    {
        public function SampleButton(arg1:Function=null)
        {
            var clickHandler:Function=null;

            var loc1:*;
            clickHandler = arg1;
            super();
            this._clickHandler = function ():void
            {
                if (clickHandler != null) 
                {
                    clickHandler();
                }
                return;
            }
            if (this._clickHandler != null) 
            {
                addEventListener(flash.events.Event.ADDED_TO_STAGE, this.handleAttach);
                addEventListener(flash.events.Event.REMOVED_FROM_STAGE, this.handleDetatch);
            }
            this.redraw();
            return;
        }

        public function handleAttach(arg1:flash.events.Event):void
        {
            addEventListener(flash.events.MouseEvent.CLICK, this._clickHandler);
            return;
        }

        public function handleDetatch(arg1:flash.events.Event):void
        {
            removeEventListener(flash.events.MouseEvent.CLICK, this._clickHandler);
            return;
        }

        public override function set width(arg1:Number):void
        {
            this._width = arg1;
            this.redraw();
            return;
        }

        public override function set height(arg1:Number):void
        {
            this._height = arg1;
            this.redraw();
            return;
        }

        protected function redraw():void
        {
            if (this.upState) 
            {
                this.upState.width = this._width;
                this.upState.height = this._height;
            }
            if (this.downState) 
            {
                this.downState.width = this._width;
                this.downState.height = this._height;
            }
            if (this.overState) 
            {
                this.overState.width = this._width;
                this.overState.height = this._height;
            }
            if (this.hitTestState) 
            {
                this.hitTestState.width = this._width;
                this.hitTestState.height = this._height;
            }
            return;
        }

        protected var _width:Number;

        protected var _height:Number;

        protected var _clickHandler:Function;
    }
}
