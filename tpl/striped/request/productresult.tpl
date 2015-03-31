<div class="result-list" >
    {foreach from=$products key="product_id" item="product"}
        <div class="result-list-row" onclick="Main.quickLink('{$smarty.const.BASEDIR}request/selproduct?id='+ {$product['id']})" style="cursor: pointer; ">
            <div class="image avatar-small">
                <img src="{$product['image']}" alt="avatar">
            </div>
            <label>{$product['product_name']}</label>
            <label>{$product['category_name']}</label>
            <label>{$product['description']}</label>
        </div>
    {/foreach}

</div>