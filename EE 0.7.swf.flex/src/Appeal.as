package 
{
    import flash.display.*;
    
    [Embed(source="Appeal.swf", symbol = "Appeal")]
    public class Appeal extends flash.display.MovieClip
    {
        public function Appeal(arg1:Function)
        {
            var callback:Function;
            var self:Appeal;

            var loc1:*;
            self = null;
            callback = arg1;
            super();
            Appeal.visible = true;
            self = this;
            return;
        }

        
        {
            visible = false;
        }

        public var nothanks:flash.display.SimpleButton;

        public var donate:flash.display.SimpleButton;

        public static var visible:Boolean=false;
    }
}
