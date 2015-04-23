<a id="item-chooser-btn" class="btn btn-default btn-flat dropdown-toggle" data-toggle="dropdown">
    <i class="fa fa-map-marker"></i> Escolha o endereço de entrega
</a><br />
<!-- Itens -->
<ul class="dropdown-menu list-clients" id="item-chooser">
    {foreach from=$addressList item="address"}
        <li>
            <a href="{$smarty.const.BASEDIR}request/setaddress?id={$request['id']}&address_id={$address['id']}&client_id={$address['client_id']}">
                <i {if ($address['id'] == $request['address_id'])}class="fa fa-check-circle-o"{/if}></i>
                {$address['address_type']}: {$address['street_addr']}, {$address['street_number']}, {$address['street_additional']}, {$address['hood']}, {$address['city']}
            </a>
        </li>
    {/foreach}
    <li class="footer"><a href="#" class="btn" data-toggle="modal" data-target="#compose-modal">Cadastre um novo endereço</a></li>
</ul>
<!-- /.Itens -->
