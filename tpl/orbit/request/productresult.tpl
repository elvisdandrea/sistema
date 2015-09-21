<ul id="result" class="dropdown-menu itens-any" style="top:-30px">
    <li class="header">Encontrados {$count} resultados para {$search}</li>
    <li>
        <div style="position: relative; overflow-x: hidden; width: auto; height: auto; max-height: 160px;">
            <!-- inner menu: contains the actual data -->
            <ul class="menu">
                {foreach from=$products key="product_id" item="product"}
                    <li>
                        <a href="{$smarty.const.BASEDIR}request/selproduct?id={$product['id']}&request_id={$request_id}&action={$action}" title="{$product['product_name']}">
                            <img src="{$product['image']}" alt="{$product['product_name']}"/>{$product['product_name']} | {$product['category_name']} | {$product['weight']} | {String::convertTextFormat($product['price'], 'currency')}
                        </a>
                    </li>
                {/foreach}
            </ul>
        </div>
    </li>
</ul>