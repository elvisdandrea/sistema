function searchClient(event, url) {

    event.preventDefault();
    setTimeout(Main.quickLink(url), 200);
    return false;
}