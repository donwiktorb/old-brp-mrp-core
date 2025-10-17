Config.Chat = {}
Config.Chat.Messages = {
	onLoaded = {
		{
			content = '<div style="padding: 0.3vw;  margin: 0.3vw; background-color: rgba(252, 227, 3, 0.6); color:red; border-radius: 3px;"><i class="fas fa-angle-double-right"style="font-size:13px;color:rgb(38,38,38,0.5)"></i>&ensp;<font color="red">[BoskieRP] Ważna wiadomość <font color="black"> Na naszym serwerze jest "system" przycisków pod bindy, jeżeli coś nie działa lub jest inaczej ustawione niż powinno być, <br /> zalecane jest wejście w Ustawienia -> Przypisane Klawisze -> Fivem </font></font>&ensp;</div>',
			sendAll = false,
		},

		{
			content = '<div style="padding: 0.3vw;  margin: 0.3vw; background-color: rgba(252, 227, 3, 0.6); color:red; border-radius: 3px;"><i class="fas fa-angle-double-right"style="font-size:13px;color:rgb(38,38,38,0.5)"></i>&ensp;<font color="red">[BoskieRP] Ważna wiadomość <font color="black">Jeżeli jesteś nowy to pod F9 są ustawienia.</font></font>&ensp;</div>',
			sendAll = false,
		},
	},
	onLoadedChar = {},
	onUnloadedChar = {},
	onUnloaded = {},
}

Config.Chat.MessageTypes = {
	["alert"] = {
		style = [[<div style="padding: 0.3vw;  margin: 0.3vw; background-color: rgba(252, 227, 3, 0.6); color:red; border-radius: 3px;">
        <i class="fas fa-angle-double-right"style="font-size:13px;color:rgb(38,38,38,0.5)"></i>
        &ensp;<font color="red">[BOSKIERP] <font color="black"> {0}</font></font>&ensp;
        </div>]],
	},
}
