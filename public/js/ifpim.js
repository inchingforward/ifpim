var IFPim = IFPim || (function() {
    var ws;
    var btn = document.getElementById("send_button");
    var message = document.getElementById("message");
    var display = document.getElementById("response_display");
    
    btn.addEventListener("click", function() {
        ws.send(message.value);
    });

    ws = new WebSocket("ws://localhost:8013/ws");
    ws.onopen = function(event) {
        console.log("websocket connected");
    };

    ws.onmessage = function(event) {
        console.log("received", event);
        display.innerHTML = event.data;
    }
})();