package 
{
    import blitter.*;
    
    public class SynchronizedObject extends blitter.BlObject
    {
        public function SynchronizedObject()
        {
            super();
            return;
        }

        public override function update():void
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            if (this._speedX || this._modifierX) 
            {
                this._speedX = this._speedX + this._modifierX;
                this._speedX = this._speedX * this._dragX;
                if (this.mx == 0 && !(this.moy == 0) || this._speedX < 0 && this.mx > 0 || this._speedX > 0 && this.mx < 0) 
                {
                    this._speedX = this._speedX * this._sdragX;
                }
                if (hitmap == null) 
                {
                    _x = _x + this._speedX;
                }
                else 
                {
                    loc1 = _x;
                    _x = _x + this._speedX;
                    if (hitmap.overlaps(this)) 
                    {
                        _x = Math.round(loc1);
                        this._speedX = 0;
                    }
                }
            }
            if (this._speedY || this._modifierY) 
            {
                this._speedY = this._speedY + this._modifierY;
                this._speedY = this._speedY * this._dragY;
                if (this.my == 0 && !(this.mox == 0) || this._speedY < 0 && this.my > 0 || this._speedY > 0 && this.my < 0) 
                {
                    this._speedY = this._speedY * this._sdragY;
                }
                if (hitmap == null) 
                {
                    _y = _y + this._speedY;
                }
                else 
                {
                    loc2 = _y;
                    _y = _y + this._speedY;
                    if (hitmap.overlaps(this)) 
                    {
                        _y = Math.round(loc2);
                        this._speedY = 0;
                    }
                }
            }
            moving = !(this._speedX * 512 >> 0 == 0) || !(this._speedY * 512 >> 0 == 0);
            return;
        }

        public function get speedX():Number
        {
            return this._speedX * 800;
        }

        public function set speedX(arg1:Number):void
        {
            this._speedX = arg1 / 800;
            return;
        }

        public function get speedY():Number
        {
            return this._speedY * 800;
        }

        public function set speedY(arg1:Number):void
        {
            this._speedY = arg1 / 800;
            return;
        }

        public function get modifierX():Number
        {
            return this._modifierX * 800;
        }

        public function set modifierX(arg1:Number):void
        {
            this._modifierX = arg1 / 800;
            return;
        }

        public function get modifierY():Number
        {
            return this._modifierY * 800;
        }

        public function set modifierY(arg1:Number):void
        {
            this._modifierY = arg1 / 800;
            return;
        }

        public function get dragX():Number
        {
            return this._dragX;
        }

        public function set dragX(arg1:Number):void
        {
            this._dragX = arg1;
            return;
        }

        public function get dragY():Number
        {
            return this._dragY;
        }

        public function set dragY(arg1:Number):void
        {
            this._dragY = arg1;
            return;
        }

        protected var _speedX:Number=0;

        protected var _speedY:Number=0;

        protected var _modifierX:Number=0;

        protected var _modifierY:Number=0;

        protected var _dragX:Number=0;

        protected var _dragY:Number=0;

        protected var _sdragX:Number=0.995;

        protected var _sdragY:Number=0.995;

        public var mox:Number=0;

        public var moy:Number=0;

        public var mx:Number=0;

        public var my:Number=0;
    }
}
