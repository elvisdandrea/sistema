<div class="input-group col-md-6">
<div class="input-group-addon">
    <i class="fa fa-cutlery"></i>
</div>
<input class="form-control" id="searchproduct-{$plate_id}" type="text" value="" placeholder="Localizar um prato" onkeyup="searchClient(event, '{$smarty.const.BASEDIR}request/searchproduct?search=' + this.value + '&request_id={$request_id}&plate_id={$plate_id}')" data-toggle="dropdown"/>
    <div id="product-results_{$plate_id}"></div>
    </div>
