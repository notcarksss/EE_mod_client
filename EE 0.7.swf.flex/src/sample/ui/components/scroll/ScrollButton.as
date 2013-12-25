package sample.ui.components.scroll 
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import sample.ui.components.*;
    
    public class ScrollButton extends sample.ui.components.SampleButton
    {
        public function ScrollButton(arg1:int=0, arg2:int=10, arg3:Function=null)
        {
            var direction:int=0;
            var size:int=10;
            var clickHandler:Function=null;

            var loc1:*;
            direction = arg1;
            size = arg2;
            clickHandler = arg3;
            super();
            this.upState = new sample.ui.components.Box().margin(0, 0, 0, 0).fill(0, 1, 3).minSize(size, size).add(new sample.ui.components.Box().add(this.drawArrow(16777215, size / 3, direction)));
            this.downState = new sample.ui.components.Box().margin(0, 0, 0, 0).fill(16777215, 1, 3).minSize(size, size).add(new sample.ui.components.Box().add(this.drawArrow(8947848, size / 3, direction)));
            this.overState = new sample.ui.components.Box().margin(0, 0, 0, 0).fill(16777215, 1, 3).minSize(size, size).add(new sample.ui.components.Box().add(this.drawArrow(0, size / 3, direction)));
            this.hitTestState = new sample.ui.components.Box().margin(0, 0, 0, 0).fill(0, 1, 3).minSize(size, size).add(new sample.ui.components.Box().add(this.drawArrow(16777215, size / 3, direction)));
            if (clickHandler != null) 
            {
                this.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, function (arg1:flash.events.MouseEvent):void
                {
                    var e:flash.events.MouseEvent;
                    var n:int;
                    var i:Number;

                    var loc1:*;
                    i = NaN;
                    e = arg1;
                    clickHandler();
                    n = 0;
                    i = flash.utils.setInterval(function ():void
                    {
                        if (e.target.upState.parent) 
                        {
                            flash.utils.clearInterval(i);
                            return;
                        }
                        if (e.target.downState.parent) 
                        {
                            e.target.downState.parent;
                            var loc1:*;
                        }
                        if (e.target.downState.parent) 
                        {
                            clickHandler();
                        }
                        return;
                    }, 50)
                    e.target.addEventListener(flash.events.MouseEvent.MOUSE_UP, function (arg1:flash.events.MouseEvent):void
                    {
                        flash.utils.clearInterval(i);
                        arg1.target.removeEventListener(flash.events.MouseEvent.MOUSE_UP, arguments.callee);
                        return;
                    })
                    return;
                })
            }
            return;
        }

        private function drawArrow(arg1:int, arg2:int, arg3:int=0):flash.display.Sprite
        {
            var loc1:*=new flash.display.Sprite();
            var loc2:*=loc1.graphics;
            var loc3:*=Math.PI / 2 * arg3;
            loc2.beginFill(arg1, 1);
            loc2.moveTo(Math.cos(2.0943 - loc3) * arg2 + arg2, Math.sin(2.0943 - loc3) * arg2 + arg2);
            loc2.lineTo(Math.cos(4.18879 - loc3) * arg2 + arg2, Math.sin(4.18879 - loc3) * arg2 + arg2);
            loc2.lineTo(Math.cos(-loc3) * arg2 + arg2, Math.sin(-loc3) * arg2 + arg2);
            return loc1;
        }
    }
}
