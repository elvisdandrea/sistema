function searchClient(event, url,val) {

    event.preventDefault();
    setTimeout(Main.quickLink(url), 200);
    $("#client_name").val(val);
    return false;
}