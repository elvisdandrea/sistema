<div class="image left">
    <div class="image avatar-small">
        <img name="image64" class="left" id="client-img" type="upload" src="{$client['image']}"/>
    </div>
</div>
<div class="centered form-right">
    <input type="hidden" value="{$client['id']}" name="client_id" />
    <label >Cliente:</label><label >{$client['client_name']}</label>
    <label >Fones:</label><label >{$client['phone_1']}</label>
    <a class="button" href="{$smarty.const.BASEDIR}request/changeclient">Alterar</a>
    <select name="address_id" onchange="Main.quickLink('{$smarty.const.BASEDIR}request/seladdress?id=' + this.value + '&request_id={$request_id}')">
        <option value="">Selecione o endereço...</option>
        {foreach from=$address_list item="address"}
            <option value="{$address['id']}">{$address['address_type']}</option>
        {/foreach}
    </select>
    <div id="address-table">
        {if (isset($addressTable))}{$addressTable}{/if}
    </div>
</div>