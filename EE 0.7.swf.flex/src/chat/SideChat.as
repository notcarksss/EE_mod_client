package chat 
{
	import flash.display.*;
	
	import playerio.*;
	
	import sample.ui.components.*;
	import sample.ui.components.scroll.*;

	public class SideChat extends flash.display.Sprite
	{
		protected var CHATBG:Class;
		private var ucontainer:sample.ui.components.Rows;
		private var userlist:sample.ui.components.scroll.ScrollBox;
		private var ccontainer:sample.ui.components.Rows;
		private var chatbox:sample.ui.components.scroll.ScrollBox;
		private var guestItem:chat.GuestListItem;
		private var myid:String="";
		private var myname:String="";
		private var chats:Array;
		private var users:Object;
		private var names:Object;
		private var guests:Object;
		
		public function SideChat(arg1:playerio.Connection)
		{
			var c:playerio.Connection;
			
			var loc1:*;
			c = arg1;
			this.CHATBG = chat.SideChat_CHATBG;
			this.ucontainer = new sample.ui.components.Rows().spacing(0);
			this.ccontainer = new sample.ui.components.Rows().spacing(0);
			this.guestItem = new chat.GuestListItem();
			this.chats = [];
			this.users = {};
			this.names = {};
			this.guests = {};
			super();
			c.addMessageHandler("add", function (arg1:playerio.Message, arg2:int, arg3:String, arg4:int, arg5:Number, arg6:Number/*, arg7:Boolean=false, arg8:Boolean=false, arg9:Boolean=false*/):void
			{
				if (arg3.charAt(5) == '-' && false) 
				{
					addGuest(arg2.toString());
				}
				else 
				{
					addUser(arg2.toString(), arg3, arg3 == "ostkaka"/*arg9*/);
				}
				return;
			})
			c.addMessageHandler("left", function (arg1:playerio.Message, arg2:int):void
			{
				removeUser(arg2.toString());
				//removeGuest(arg2.toString());
				return;
			})
			c.addMessageHandler("say", function (arg1:playerio.Message, arg2:int, arg3:String):void
			{
				addChat(arg2.toString(), arg3);
				return;
			})
			c.addMessageHandler("write", function (arg1:playerio.Message, arg2:String, arg3:String):void
			{
				addLine(arg2, arg3);
				return;
			})
			addChild(new this.CHATBG());
			this.userlist = new sample.ui.components.scroll.ScrollBox().margin(1, 1, 1, 1).add(this.ucontainer);
			this.userlist.border(1, 1118481, 1);
			this.userlist.width = 205;
			this.userlist.height = 150;
			this.userlist.x = 3;
			addChild(this.userlist);
			this.chatbox = new sample.ui.components.scroll.ScrollBox().margin(1, 1, 1, 1).add(this.ccontainer);
			this.chatbox.border(1, 1118481, 1);
			this.chatbox.width = 205;
			this.chatbox.height = 347;
			this.chatbox.x = 3;
			this.chatbox.y = 152;
			addChild(this.chatbox);
			//this.ucontainer.addChild(this.guestItem);
			//this.guestItem.online = 0;
			return;
		}
		
		public function setMe(arg1:String, arg2:String, arg3:Boolean):void
		{
			this.myid = arg1;
			this.myname = arg2;
			this.addUser(arg1, arg2, arg3);
			this.redrawUserlist();
			return;
		}
		
		public function addChat(arg1:String, arg2:String):void
		{
			if (this.users[arg1]) 
			{
				this.addLine(this.users[arg1].username, arg2);
			}
			else if (arg1 == this.myid)
			{
				this.addLine(this.myname, arg2);
			}
			return;
		}
		
		public function addLine(arg1:String, arg2:String):void
		{
			var loc3:*=NaN;
			//arg2 = Chat.filter(arg2);
			var loc1:*=!((" " + arg2 + " ").replace(new RegExp("[^a-z0-9 ]", "gi"), "").toLowerCase().indexOf(" " + this.myname.toLowerCase() + " ") == -1);
			var loc2:*=this.chatbox.scrollHeight - this.chatbox.scrollY < 50;
			this.ccontainer.addChild(new chat.ChatEntry(arg1, arg2, loc1 ? 2236962 : 0));
			if (this.ccontainer.numChildren > 50) 
			{
				loc3 = this.chatbox.scrollHeight;
				this.ccontainer.removeChild(this.ccontainer.getChildAt(0));
				if (!loc2) 
				{
					this.chatbox.refresh();
					this.chatbox.scrollY = this.chatbox.scrollY + (this.chatbox.scrollHeight - loc3);
				}
			}
			this.chatbox.refresh();
			if (loc2) 
			{
				this.chatbox.scrollY = 100000;
			}
			return;
		}
		
		public function addUser(arg1:String, arg2:String, arg3:Boolean):void
		{
			var loc1:*=null;
			if (this.names[arg2] == null) 
			{
				loc1 = new chat.UserlistItem(arg2, arg3);
				this.names[arg2] = loc1;
				this.ucontainer.addChild(loc1);
			}
			this.users[arg1] = this.names[arg2];
			var loc2:*;
			var loc3:*=((loc2 = this.names[arg2]).count + 1);
			loc2.count = loc3;
			this.redrawUserlist();
			return;
		}
		
		public function getUsers():Object
		{
			var loc2:*=null;
			var loc1:*={};
			var loc3:*=0;
			var loc4:*=this.names;
			for (loc2 in loc4) 
			{
				loc1[loc2.toUpperCase()] = true;
			}
			return loc1;
		}
		
		public function removeUser(arg1:String):void
		{
			if (this.users[arg1]) 
			{
				var loc1:* = this.users[arg1];
				var loc2:int = --loc1.count;
				if (loc2 == 0)//((loc1.count = loc2 = ((loc1 ).count - 1)) == 0) 
				{
					delete this.names[this.users[arg1].username];
					this.ucontainer.removeChild(this.users[arg1]);
				}
				delete this.users[arg1];
				this.redrawUserlist();
			}
			return;
		}
		
		private function redrawUserlist():void
		{
			var tusers:Array;
			var x:String;
			var a:int;
			
			var loc1:*;
			x = null;
			a = 0;
			tusers = [];
			var loc2:*=0;
			var loc3:*=this.users;
			for (x in loc3) 
			{
				tusers.push(this.users[x]);
			}
			tusers.sort(function (arg1:chat.UserlistItem, arg2:chat.UserlistItem):Number
			{
				if (arg1.canchat && !arg2.canchat) 
				{
					return -1;
				}
				if (!arg1.canchat && arg2.canchat) 
				{
					return 1;
				}
				if (arg1.canchat == arg2.canchat) 
				{
					return arg1.time < arg2.time ? 1 : -1;
				}
				return 0;
			})
			a = 0;
			while (a < tusers.length) 
			{
				this.ucontainer.addChild(tusers[a]);
				++a;
			}
			this.ucontainer.addChild(this.guestItem);
			this.userlist.scrollY = this.userlist.scrollY;
			return;
		}
		
		public function addGuest(arg1:String):void
		{
			if (!this.guests[arg1]) 
			{
				this.guests[arg1] = true;
			}
			this.refreshGuest();
			return;
		}
		
		public function removeGuest(arg1:String):void
		{
			if (this.guests[arg1]) 
			{
				delete this.guests[arg1];
			}
			this.refreshGuest();
			return;
		}
		
		private function refreshGuest():void
		{
			var loc2:*=false;
			var loc1:*=0;
			var loc3:*=0;
			var loc4:*=this.guests;
			for each (loc2 in loc4) 
			{
				++loc1;
			}
			//this.guestItem.online = loc1;
			return;
		}
	}
}
