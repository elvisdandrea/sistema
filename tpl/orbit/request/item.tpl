<ul class="item-plate" >
    <li>
        <img src="{if ($item['image'] != '')}{$item['image']}{else}{$smarty.const.T_IMGURL}/no-image.jpg{/if}" alt="{$item['product_name']}">
    </li>
    <li class="col-md-3 col-sm-4 col-xs-4">
        Item: <strong>{$item['product_name']}</strong>
    </li>
    <li class="col-md-5 col-sm-5 col-xs-5">
        Categoria: <strong>{$item['category_name']}</strong>
    </li>
    <li class="col-md-3 col-sm-3 col-xs-3">
        Total: <strong id="price" class="text-green">{String::convertTextFormat($item['price'], 'currency')}</strong>
    </li>
    <li>
        <i class="btn btn-danger btn-sm fa fa-times" data-toggle="tooltip" title="Remover" onclick="Main.quickLink('{$smarty.const.BASEDIR}request/removeitem?id={$item['id']}&request_id={$request_id}&row_id={$rowId}&action=remproductnew')"></i>
    </li>
</ul>