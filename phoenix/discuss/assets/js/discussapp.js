function socket_joined(resp){
    document.getElementById("websocket").innerHTML = "link";
    console.log(resp);
}
function socket_error(resp){
    document.getElementById("websocket").innerHTML = "link_off";
    console.log(resp);
}
export {socket_joined, socket_error}