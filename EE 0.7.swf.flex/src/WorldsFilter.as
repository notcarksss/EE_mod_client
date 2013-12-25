package 
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    
    [Embed(source="WorldsFilter.swf", symbol = "WorldsFilter")]
    public class WorldsFilter extends flash.display.MovieClip
    {
        public function WorldsFilter(arg1:Function)
        {
            var callback:Function;

            var loc1:*;
            callback = arg1;
            super();
            this.filter.addEventListener(flash.events.KeyboardEvent.KEY_UP, function (arg1:flash.events.Event):*
            {
                callback(filter.text);
                return;
            })
            return;
        }

        public var filter:flash.text.TextField;
    }
}
