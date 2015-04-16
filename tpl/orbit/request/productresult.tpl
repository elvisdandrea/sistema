<!-- Lista de pratos -->
<ul class="dropdown-menu list-clients">
    <li class="header">Encontrados 2 resultados para Ca</li>
    <li>
        <!-- inner menu: contains the actual data -->
        <ul class="menu">
            {foreach from=$products key="product_id" item="product"}
                <li>
                    <a href="{$smarty.const.BASEDIR}request/selproduct?id='+ {$product['id']}+'&request_id={$request_id}&plate_id={$plate_id}" title="Pendente">
                        <img src="{$product['image']}" alt="{$product['product_name']}"/>{$product['product_name']} | {$product['category_name']} | 100g | 22,90
                    </a>
                </li>
            {/foreach}
        </ul>
    </li>
</ul>
<!-- /.Lista de pratos -->