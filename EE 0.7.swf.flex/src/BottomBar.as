package 
{
    import flash.display.*;
    import flash.events.*;
    
    [Embed(source="BottomBar.swf", symbol = "BottomBar")]
    public class BottomBar extends flash.display.MovieClip
    {
        public function BottomBar(arg1:String, arg2:Function, arg3:Function)
        {
            var roompath:String;
            var lobbyCallback:Function;
            var showmapCallback:Function;

            var loc1:*;
            roompath = arg1;
            lobbyCallback = arg2;
            showmapCallback = arg3;
            super();
            addFrameScript(0, this.frame1);
            this.directurl.visible = false;
            this.directurl.gameurl.text = roompath;
            stop();
            this.sharebtn.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, function ():void
            {
                directurl.visible = !directurl.visible;
                return;
            })
            this.lobbybtn.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, function (arg1:flash.events.MouseEvent):void
            {
                lobbyCallback();
                arg1.preventDefault();
                arg1.stopImmediatePropagation();
                return;
            })
            this.minimapbtn.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, function ():void
            {
                showmapCallback();
                return;
            })
            return;
        }

        public function toogleLocked(arg1:Boolean):*
        {
            gotoAndStop(arg1 ? 2 : 1);
            return;
        }

        internal function frame1():*
        {
            stop();
            return;
        }

        public var directurl:flash.display.MovieClip;

        public var minimapbtn:flash.display.SimpleButton;

        public var lobbybtn:flash.display.SimpleButton;

        public var sharebtn:flash.display.SimpleButton;
    }
}
