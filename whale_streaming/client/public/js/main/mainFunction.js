// [ Resize ]
$(document).ready(() => {resize();});
$(window).resize(() => {resize();});

function resize() {
    var windowWidth = $(window).width();
    var libraryWidth = $(".mainLibrary").width();

    var windowHeight = $(window).height();
    var headerHeight = $(".header").height();
    var footerHeight = $(".footer").height();

    $('.main').css({'height': (windowHeight-headerHeight-footerHeight-1)+'px'});
    $('.mainContentFrame').css({'width': (windowWidth-libraryWidth)+'px'});

    var mainContentHeight = $(".mainContent").height();
    var mainContentHeaderHeight = $(".mainContentHeader").height();

    $('.mainContentCenter').css({'height': (mainContentHeight-mainContentHeaderHeight-1)+'px'});
}


// [ Get the Data from the Parent Window ]
window.addEventListener("message", receiveMessage, false);

async function receiveMessage(event) {
    if (event.data === 'Full') {console.log(event.data);}
    else {await sendDeviceId(event);}
}

async function sendDeviceId(event) {
    sessionStorage.device_id = event.data;

    const body = {
        device_id: sessionStorage.device_id,
    };
    fetch(`/whale/streaming/getDeviceId`, {
        headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
        },
        method: 'POST',
        body: JSON.stringify(body)
    })
    .then((response) => response.json())
    .then((data) => {
        sessionStorage.accessToken = data.accessToken;
        console.log("Success fetching device id to the Node js Wep App");
    })
    .catch((error) => console.error("Failed to fetch the device_id: ", error));
}