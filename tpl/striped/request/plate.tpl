<input id="searchclient" type="text" value="" placeholder="Pesquise o produto..." onkeyup="searchClient(event, '{$smarty.const.BASEDIR}request/searchproduct?search=' + this.value + '&request_id={$request_id}&plate_id={$plate_id}')"/>
<div id="product-results_{$plate_id}"></div>
<div class="plate">
    <ul id="plate_{$plate_id}" class="plate">

    </ul>
    <hr>
</div>