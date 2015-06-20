<ul id="plate{$plate_id}_{$rowId}" class="item-plate">
    <li>
        <img src="{$item['image']}" alt="{$item['product_name']}">
    </li>
    <li class="col-md-3 col-sm-4 col-xs-4">
        Prato: <strong>{$item['product_name']}</strong>
    </li>
    <li class="col-md-5 col-sm-5 col-xs-5">
        Categoria: <strong>{$item['category_name']}</strong>
    </li>
    <li class="col-md-3 col-sm-3 col-xs-3">
        Total: <strong id="price_{$plate_id}_{$rowId}" class="text-green">{String::convertTextFormat($item['price'], 'currency')}</strong>
    </li>
    <li class="col-md-12 col-sm-12 col-xs-12 qnt">
        <button type="button" class="btn btn-primary btn-sm" onclick="Main.quickLink('{$smarty.const.BASEDIR}request/dropitemportion?id={$item['id']}&amount={$item['product_weight']}&plate_id={$plate_id}&request_id={$request_id}{if ($newrequest)}&action=selproductnew&item_id={$rowId}{/if}')">
            <i class="fa fa-minus-circle"></i>
        </button>
        <label id="amount_{$plate_id}_{$rowId}" style="width: 50%; text-align: center;">{$item['product_weight']}{$item['unit']}</label>
        <button type="button" class="btn btn-primary btn-sm" onclick="Main.quickLink('{$smarty.const.BASEDIR}request/additemportion?id={$item['id']}&amount={$item['product_weight']}&plate_id={$plate_id}&request_id={$request_id}{if ($newrequest)}&action=selproductnew&item_id={$rowId}{/if}')"><i class="fa fa-plus-circle"></i></button>
    </li>
    <li>
        <i class="btn btn-danger btn-sm fa fa-times" data-toggle="tooltip" title="Remover" onclick="Main.quickLink('{$smarty.const.BASEDIR}request/removeitem?id={$item['id']}&plate_id={$plate_id}&request_id={$request_id}&row_id=plate{$plate_id}_{$rowId}&action=remproductnew')"></i>
    </li>
</ul>
<!-- Ingredientes -->
<div class="ingredients form-group check-item" id="ingredients_plate{$plate_id}_{$rowId}">
    <h6 style="display: inline;">Ingredientes <i class="fa fa-angle-double-right"></i>&nbsp;</h6>
    <label class="checkbox-inline">
        <input type="checkbox" name="01" class="select-itens" /> <span>Batata</span>
    </label>
    <label class="checkbox-inline">
        <input type="checkbox" name="02" class="select-itens" /> <span class="item-removed">Polenta</span>
    </label>
    <label class="checkbox-inline">
        <input type="checkbox" name="03" class="select-itens" /> <span>Cebola</span>
    </label>
    <label class="checkbox-inline">
        <input type="checkbox" name="04" class="select-itens" /> <span>Queijo</span>
    </label>
</div>