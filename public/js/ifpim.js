var IFPim = IFPim || (function() {
    var ws;
    var btn = document.getElementById("send_button");
    var message = document.getElementById("message");
    var display = document.getElementById("response_display");
    
    function sendMessage() {
        ws.send(message.value);
    }
    
    btn.addEventListener("click", function() {
        sendMessage();
    });

    message.addEventListener("keyup", function(event) {
        event.preventDefault();
        if (event.keyCode === 13) {
            sendMessage();
            message.select();
        }
    });

    ws = new WebSocket("ws://localhost:8013/ws");
    ws.onopen = function(event) {
        console.log("websocket connected");
    };

    ws.onmessage = function(event) {
        display.innerHTML = display.innerHTML + event.data + "<br /><br />";
        display.scrollTop = display.scrollHeight;
    }

    message.focus();
})();