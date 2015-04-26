<ul id="result-{$plate_id}" class="dropdown-menu list-clients">
    <li class="header">Encontrados {$count} resultados para {$search}</li>
    <li>
        <!-- inner menu: contains the actual data -->
        <ul class="menu">
            {foreach from=$products key="product_id" item="product"}
                <li>
                    <a href="{$smarty.const.BASEDIR}request/{$action}?id={$product['id']}&request_id={$request_id}&plate_id={$plate_id}" title="{$product['product_name']}">
                        <img src="{$product['image']}" alt="{$product['product_name']}"/>{$product['product_name']} | {$product['category_name']} | {$product['weight']} | {String::convertTextFormat($product['price'], 'currency')}
                    </a>
                </li>
            {/foreach}
        </ul>
    </li>
</ul>