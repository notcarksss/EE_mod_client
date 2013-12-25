package 
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    
    [Embed(source="Room.swf", symbol = "Room")]
    public class Room extends flash.display.MovieClip
    {
        public function Room(arg1:String, arg2:String, arg3:int, arg4:Boolean, arg5:Function)
        {
            var key:String;
            var title:String;
            var online:int;
            var nokey:Boolean;
            var callback:Function;

            var loc1:*;
            key = arg1;
            title = arg2;
            online = arg3;
            nokey = arg4;
            callback = arg5;
            super();
            this.ltitle.embedFonts = true;
            this.ltitle.defaultTextFormat = new flash.text.TextFormat(new system().fontName, 13);
            this.ltitle.text = title;
            this.lonline.embedFonts = true;
            this.lonline.defaultTextFormat = new flash.text.TextFormat(new system().fontName, 9, 10066329);
            this.lonline.text = online + " Online";
            if (nokey) 
            {
                this.keyicon.visible = false;
                this.ltitle.x = 6;
            }
            this.full.gotoAndStop(online >= 45 ? 2 : 1);
            addEventListener(flash.events.MouseEvent.MOUSE_DOWN, function ():void
            {
                callback(key);
                return;
            })
            return;
        }

        public override function set width(arg1:Number):void
        {
            return;
        }

        public var lonline:flash.text.TextField;

        public var full:flash.display.MovieClip;

        public var ltitle:flash.text.TextField;

        public var keyicon:flash.display.MovieClip;
    }
}
