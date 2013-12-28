package 
{
    import blitter.*;
    
    import chat.*;
    
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.text.*;
    import flash.ui.Keyboard;
    import flash.ui.KeyboardType;
    
    import playerio.*;
    
    import ui2.*;
    
    public class GameInterface extends flash.display.Sprite
    {
        public function GameInterface(arg1:playerio.Connection, arg2:Boolean, arg3:String, arg4:Boolean, arg5:Boolean, sidechat:SideChat, arg6:Function)
        {
            var connection:playerio.Connection;
            var canEdit:Boolean;
            var roomid:String;
            var direct:Boolean;
            var iseecom:Boolean;
            var callback:Function;
            var selectorbg:flash.display.Bitmap;
            var content:flash.display.Sprite;
            var contentMask:flash.display.Sprite;
            var bselectorbg:flash.display.Bitmap;
            var bcontent:flash.display.Sprite;
            var bcontentMask:flash.display.Sprite;
            var coinsoverlay:flash.display.Sprite;
            var coinsbg:flash.display.Bitmap;
            var coincontainer:flash.display.Sprite;
            var coin:flash.display.Bitmap;
            var bonuscoincontainer:flash.display.Sprite;
            var bonuscoin:flash.display.Bitmap;
            var coinmask:flash.display.Sprite;
            var bonuscoinmask:flash.display.Sprite;
            var selector:flash.display.Bitmap;
            var side:int;//var alt:Boolean;
			var sides:int;
            var guybg:flash.display.Bitmap;
            var gcontent:flash.display.Sprite;
            var youselector:flash.display.Bitmap;
            var tf:flash.text.TextFormat;
            var edit:flash.text.TextField;
            var sc:flash.display.Sprite;
            var send:flash.text.TextField;
			
			this.chatinput = new ui2.ui2chatinput();
			this.sidechat = sidechat;

            var loc1:*;
            selectorbg = null;
            content = null;
            bselectorbg = null;
            bcontent = null;
            coinsoverlay = null;
            coincontainer = null;
            selector = null;
            side = 0;//alt = false;
            gcontent = null;
            youselector = null;
            edit = null;
            sc = null;
            connection = arg1;
			this.connection = arg1;
            canEdit = arg2;
            roomid = arg3;
            direct = arg4;
            iseecom = arg5;
            callback = arg6;
            this.Rocks = GameInterface_Rocks;
            this.Guy = GameInterface_Guy;
            this.Selector = GameInterface_Selector;
            this.CoinsOverlay = GameInterface_CoinsOverlay;
            this.Coin = GameInterface_Coin;
            this.BonusCoin = GameInterface_BonusCoin;
            super();
            this.callback = callback;
            blitter.Bl.data.selectedBrick = 0;
            this.bottombar = new BottomBar("http://everybodyedits.com/?/" + roomid.split(" ").join("-"), function ():void
            {
                callback();
                return;
            }, function ():void
            {
                blitter.Bl.data.showMap = !blitter.Bl.data.showMap;
                return;
            })
            addChild(this.bottombar);
            this.y = 470;
            selectorbg = new this.Rocks();
			sides = selectorbg.height/16;
            content = new flash.display.Sprite();
            contentMask = new flash.display.Sprite();
            contentMask.graphics.beginFill(0, 1);
            contentMask.graphics.drawRect(0, 0, 80, 16);
            content.addChild(contentMask);
            content.mask = contentMask;
            content.addChild(selectorbg);
            content.x = 113;
            content.y = 11;
            bselectorbg = new this.Rocks();
            bcontent = new flash.display.Sprite();
            bcontentMask = new flash.display.Sprite();
            bcontentMask.graphics.beginFill(0, 1);
            bcontentMask.graphics.drawRect(0, 0, 240, 16);
            bcontent.addChild(bcontentMask);
            bcontent.mask = bcontentMask;
            bcontent.addChild(bselectorbg);
            bselectorbg.x = -80;
            bcontent.x = 198;
            bcontent.y = 11;
            coinsoverlay = new flash.display.Sprite();
            coinsbg = new this.CoinsOverlay();
            coincontainer = new flash.display.Sprite();
            coin = new this.Coin();
            coincontainer.addChild(coin);
            bonuscoincontainer = new flash.display.Sprite();
            bonuscoin = new this.BonusCoin();
            bonuscoincontainer.addChild(bonuscoin);
            coinmask = new flash.display.Sprite();
            coinmask.graphics.beginFill(0, 1);
            coinmask.graphics.drawRect(0, 0, 10, 10);
            coinsoverlay.addChild(coinmask);
            bonuscoinmask = new flash.display.Sprite();
            bonuscoinmask.graphics.beginFill(0, 1);
            bonuscoinmask.graphics.drawRect(0, 0, 10, 10);
            coinsoverlay.addChild(bonuscoinmask);
            coincontainer.mask = coinmask;
            bonuscoincontainer.mask = bonuscoinmask;
            var loc2:*;
            coincontainer.x = loc2 = 6;
            coinmask.x = loc2;
            coincontainer.y = loc2 = 14;
            coinmask.y = loc2 = loc2;
            bonuscoincontainer.y = loc2 = loc2;
            bonuscoinmask.y = loc2;
            bonuscoincontainer.x = loc2 = 22;
            bonuscoinmask.x = loc2;
            coinsoverlay.addChild(coincontainer);
            if (iseecom) 
            {
                coinsoverlay.addChild(bonuscoincontainer);
            }
            coinsoverlay.x = 440;
            coinsoverlay.addChild(coinsbg);
            if (canEdit && blitter.Bl.data.isLockedRoom) 
            {
                addChild(coinsoverlay);
            }
            selector = new this.Selector();
            selector.y = 11;
            selector.x = 113;
            content.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, function (arg1:flash.events.MouseEvent):void
            {
                blitter.Bl.data.selectedBrick = Math.min(content.mouseX >> 4, 4);
                if (side > 0 && !(blitter.Bl.data.selectedBrick == 0)) 
                {
                    blitter.Bl.data.selectedBrick += 4*side;
                }
                selector.x = (Math.min(content.mouseX >> 4, 4) << 4) + content.x;
                return;
            })
            side = 0;//alt = false;
            bcontent.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, function (arg1:flash.events.MouseEvent):void
            {
                if (bcontent.mouseX >= 224) 
                {
					side = (side+1)%sides;
                    selectorbg.y = side*-16;
                    bselectorbg.y = side*-16;
                    selector.x = content.x;
                    blitter.Bl.data.selectedBrick = 0;
                    
                    return;
                }
                blitter.Bl.data.selectedBrick = Math.min(bcontent.mouseX >> 4, 20) + 9 + 14*side;
                if (blitter.Bl.data.selectedBrick > 32) 
                {
                    blitter.Bl.data.selectedBrick = 0;
                }
                selector.x = (Math.min(bcontent.mouseX >> 4, 20) << 4) + bcontent.x;
                return;
            })
            coincontainer.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, function (arg1:flash.events.MouseEvent):void
            {
                blitter.Bl.data.selectedBrick = 100;
                selector.x = coincontainer.x - 3 + coinsoverlay.x;
                return;
            })
            bonuscoincontainer.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, function (arg1:flash.events.MouseEvent):void
            {
                var e:flash.events.MouseEvent;
                var ap:Appeal;

                var loc1:*;
                e = arg1;
                if (Appeal.visible) 
                {
                    return;
                }
                ap = new Appeal(function ():void
                {
                    var url:*;
                    var request:*;

                    var loc1:*;
                    url = "http://www.pledgie.com/campaigns/10809";
                    request = new flash.net.URLRequest(url);
                    try 
                    {
                        flash.net.navigateToURL(request, "_new");
                    }
                    catch (e:Error)
                    {
                        trace("Error occurred!");
                    }
                    return;
                })
                ap.x = 640 / 2;
                ap.y = 500 / 2;
                blitter.Bl.stage.addChild(ap);
                return;
            })
            guybg = new this.Guy();
            gcontent = new flash.display.Sprite();
            gcontent.x = 486;
            gcontent.y = 11;
            gcontent.addChild(guybg);
            this.addChild(gcontent);
            youselector = new this.Selector();
            gcontent.addChild(youselector);
            gcontent.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, function (arg1:flash.events.MouseEvent):void
            {
                connection.send("face", Math.min(gcontent.mouseX >> 4, 5));
                youselector.x = Math.min(gcontent.mouseX >> 4, 5) << 4;
                return;
            })
            tf = new flash.text.TextFormat();
            tf.color = 16777215;
            tf.bold = true;
            tf.font = "Arial";
            edit = new flash.text.TextField();
            edit.defaultTextFormat = new flash.text.TextFormat("Arial", null, 0);
            edit.background = true;
            edit.border = true;
            edit.type = flash.text.TextFieldType.INPUT;
            edit.text = "";
            edit.x = 113;
            edit.y = 11;
            edit.width = 270;
            edit.backgroundColor = 13948116;
            edit.borderColor = 7039851;
            edit.height = edit.textHeight + 2;
            sc = new flash.display.Sprite();
            send = new flash.text.TextField();
            send.defaultTextFormat = tf;
            send.text = "Send";
            sc.x = 113 + 275;
            sc.y = 11;
            send.width = send.textWidth + 10;
            send.selectable = false;
            sc.addChild(send);
            sc.addEventListener(flash.events.MouseEvent.CLICK, function ():void
            {
                if (edit.text != "") 
                {
                    connection.send("access", edit.text);
                }
                return;
            })
            if (canEdit) 
            {
                this.addChild(content);
                this.addChild(bcontent);
                this.addChild(selector);
            }
            else 
            {
                this.bottombar.toogleLocked(true);
                connection.addMessageHandler("access", function (arg1:playerio.Message):void
                {
                    addChild(content);
                    addChild(bcontent);
                    addChild(selector);
                    removeChild(edit);
                    removeChild(sc);
                    bottombar.toogleLocked(true);
                    addChild(coinsoverlay);
                    blitter.Bl.data.canEdit = true;
                    return;
                })
                addChild(edit);
                addChild(sc);
            }
				
			addChild(this.chatinput);
			this.chatinput.y = -30;
			this.chatinput.x = 65;
			this.chatinput.visible = false;
			this.chatinput.text = new chat.TabTextField();
			this.chatinput.addChild(this.chatinput.text);
			this.chatinput.text.x = 37;
			this.chatinput.text.y = 7;
			this.chatinput.text.width = 445;
			if (sidechat != null) 
			{
				this.chatinput.text.SetWordFunction(sidechat.getUsers);
			}
			Bl.stage.addEventListener(flash.events.KeyboardEvent.KEY_DOWN,
				function(arg1:flash.events.KeyboardEvent) : void
				{
				if (arg1.keyCode == Keyboard.ENTER)
				{
				if (!chatinput.visible)
					toggleChat(true);
				}
				});
			this.chatinput.text.field.addEventListener(flash.events.KeyboardEvent.KEY_DOWN, function (arg1:flash.events.KeyboardEvent):void
			{
				arg1.preventDefault();
				arg1.stopImmediatePropagation();
				arg1.stopPropagation();
				if (arg1.keyCode == 27) 
				{
					hideAll();
				}
				if (arg1.keyCode == 13) 
				{
					sendChat();
				}
				return;
			})
			this.chatinput.say.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, function ():void
			{
				sendChat();
				return;
			})
			this.chatinput.text.field.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, function (arg1:flash.events.MouseEvent):void
			{
				arg1.preventDefault();
				arg1.stopImmediatePropagation();
				arg1.stopPropagation();
				return;
			})
				
            return;
        }
		
		public function toggleChat(arg1:Boolean):void
		{
			if (arg1) 
			{
				this.hideAll();
				blitter.Bl.data.chatisvisible = true;
				//this.chatbtn.gotoAndStop(2);
				this.chatinput.visible = true;
				if (stage) 
				{
					stage.focus = this.chatinput.text.field;
				}
				this.chatinput.text.field.text = "";
			}
			else 
			{
				//this.chatbtn.gotoAndStop(1);
				this.chatinput.visible = false;
				blitter.Bl.data.chatisvisible = false;
			}
			return;
		}
		
		public function hideAll():void
		{
			//this.toggleSmiley(false);
			//this.toggleLevel(false);
			this.toggleChat(false);
			//this.toggleMore(false);
			//this.hideCoinsProperties();
			return;
		}
		
		private function sendChat():void
		{
			var loc6:*=0;
			var loc1:String =this.chatinput.text.field.text;
			var loc2:*=loc1.toLocaleLowerCase();
			
			/*this.textArray.push(loc1);
			this.textArray.shift();
			this.timerArray.push(new Date().getTime() - this.lastMessageTime);
			this.timerArray.shift();*/
			var loc3:*=0;
			var loc4:*=0;
			/*while (loc4 < this.timerArray.length) 
			{
				loc3 = loc3 + this.timerArray[loc4];
				++loc4;
			}*/
			loc1 = loc1.replace(new RegExp("([\\?\\!]{2})[\\?\\!]+", "gi"), "$1");
			loc1 = loc1.replace(new RegExp("\\.{4,}", "gi"), "...");
			var loc5:*=loc1.replace(new RegExp("(:?.+)\\1{4,}", "gi"), "$1$1$1");
			while (loc5 != loc1) 
			{
				loc1 = loc5;
				loc5 = loc1.replace(new RegExp("(:?.+)\\1{4,}", "gi"), "$1$1$1");
			}
			if (loc1.length > 4 && loc1.match(new RegExp("[A-Z]", "g")).length > loc1.length / 2) 
			{
				loc1 = loc1.toLowerCase();
			}
			this.hideAll();
			/*if (loc1.charAt(0) != "/") 
			{
				if (loc1.replace(new RegExp("\\s", "gi"), "").length > 0) 
				{
					//this.lastMessageTime = new Date().getTime();
					if (loc3 < 5000) 
					{
						blitter.Bl.data.base.SystemSay("Easy now, you don\'t want the other players mistaking you for a spammer!");
						return;
					}
					loc6 = 0;
					loc4 = 0;
					while (loc4 < this.textArray.length) 
					{
						if (this.textArray[loc4] == loc1) 
						{
							++loc6;
						}
						++loc4;
					}
					if (loc6 > 3) 
					{
						blitter.Bl.data.base.SystemSay("This is the fourth time out of ten you try to say \"" + loc1 + "\". Time to try something new?");
						return;
					}
					this.connection.send("say", loc1);
				}
			}
			else */
			//{
			if (loc1.length > 0)
				this.connection.send("say", loc1);
			//}
			return;
		}

        protected var Rocks:Class;

        protected var Guy:Class;

        protected var Selector:Class;

        protected var CoinsOverlay:Class;

        protected var Coin:Class;

        protected var BonusCoin:Class;

        protected var callback:Function;

        protected var bottombar:BottomBar;
		
		protected var sidechat:chat.SideChat;
		
		protected var connection:Connection;
		
		protected var me_id:String;
		
		private var chatinput:ui2chatinput;
    }
}
