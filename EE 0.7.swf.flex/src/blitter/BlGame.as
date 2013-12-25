package blitter 
{
    import flash.display.*;
    import flash.events.*;
    
    public class BlGame extends flash.display.MovieClip
    {
        public function BlGame(arg1:int, arg2:int, arg3:int)
        {
            super();
            this.screen = new flash.display.BitmapData(arg1, arg2, false, 0);
            this.screenContainer = new flash.display.Bitmap(this.screen);
            this.screenContainer.width = arg1 * arg3;
            this.screenContainer.height = arg2 * arg3;
            addChild(this.screenContainer);
            addEventListener(flash.events.Event.ADDED_TO_STAGE, this.handleAttach);
            return;
        }

        private function handleAttach(arg1:flash.events.Event):void
        {
            blitter.Bl.init(stage, width, height);
            stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
            stage.frameRate = 120;
            addEventListener(flash.events.Event.ENTER_FRAME, this.handleEnterFrame);
            return;
        }

        public function get state():blitter.BlState
        {
            return this._state;
        }

        public function set state(arg1:blitter.BlState):void
        {
            this._state = arg1;
            blitter.Bl.update();
            return;
        }

        protected function handleEnterFrame(arg1:flash.events.Event=null):void
        {
            if (this.state != null) 
            {
                this.screen.lock();
                this.screen.fillRect(this.screen.rect, 0);
                blitter.Bl.update();
                if (this.state != null) 
                {
                    this.state.enterFrame();
                }
                if (this.state != null) 
                {
                    this.state.tick();
                }
                blitter.Bl.exitFrame();
                if (this.state != null) 
                {
                    this.state.exitFrame();
                }
                if (this.state != null) 
                {
                    this.state.draw(this.screen, 0, 0);
                }
                this.screen.unlock();
            }
            return;
        }

        protected var screen:flash.display.BitmapData;

        protected var screenContainer:flash.display.Bitmap;

        protected var _state:blitter.BlState;
    }
}
