package blitter 
{
    import flash.display.*;
    
    public class BlContainer extends blitter.BlObject
    {
        public function BlContainer()
        {
            this.content = [];
            super();
            return;
        }

        public function add(arg1:blitter.BlObject):blitter.BlObject
        {
            this.content.push(arg1);
            return arg1;
        }

        public function addAt(arg1:blitter.BlObject, arg2:int):blitter.BlObject
        {
            this.content.splice(arg2, 0, arg1);
            return arg1;
        }

        public function addBefore(arg1:blitter.BlObject, arg2:blitter.BlObject):blitter.BlObject
        {
            var loc1:*=0;
            while (loc1 < this.content.length) 
            {
                if (this.content[loc1] == arg2) 
                {
                    return this.addAt(arg1, loc1);
                }
                ++loc1;
            }
            return this.add(arg1);
        }

        public function remove(arg1:blitter.BlObject):blitter.BlObject
        {
            var loc1:*=0;
            while (loc1 < this.content.length) 
            {
                if (this.content[loc1] === arg1) 
                {
                    this.content.splice(loc1, 1);
                    break;
                }
                ++loc1;
            }
            return arg1;
        }

        public override function update():void
        {
            if (this.target != null) 
            {
                this.x = this.x - (this.x - ((-this.target.x >> 0) + blitter.Bl.width / 2)) / (this.cameraLag + 1);
                this.y = this.y - (this.y - ((-this.target.y >> 0) + blitter.Bl.height / 2)) / (this.cameraLag + 1);
            }
            return;
        }

        public override function tick():void
        {
            var loc1:*=null;
            //var loc2:*=0;
            //var loc3:*=this.content;
			for each (loc1 in this.content)//for each (loc1 in loc3) 
            {
                loc1.tick();
            }
            super.tick();
            return;
        }

        public override function exitFrame():void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=this.content;
            for each (loc1 in loc3) 
            {
                loc1.exitFrame();
            }
            return;
        }

        public override function enterFrame():void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=this.content;
            for each (loc1 in loc3) 
            {
                loc1.enterFrame();
            }
            return;
        }

        public override function draw(arg1:flash.display.BitmapData, arg2:Number, arg3:Number):void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=this.content;
            for each (loc1 in loc3) 
            {
                loc1.draw(arg1, arg2 + _x, arg3 + _y);
            }
            return;
        }

        protected var content:Array;

        public var target:blitter.BlObject;

        public var cameraLag:uint=0;
    }
}
