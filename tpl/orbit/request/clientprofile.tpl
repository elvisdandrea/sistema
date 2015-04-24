<!-- Client profile -->
<div class="box-body client-profile">
    <!-- chat item -->
    <div class="item">
        <img src="{$client['image']}" alt="user image" />
        <div class="client-dados">
            <h5>
                {$client['client_name']} <small>Telefones: {$client['phones']}</small>
            </h5>
            <div id="addresslist">

            </div>
            <a id="item-chooser-btn" class="btn btn-default btn-flat dropdown-toggle" data-toggle="dropdown">
                <i class="fa fa-map-marker"></i> Escolha o endereço de entrega
            </a><br />
            <!-- Itens -->
            <ul class="dropdown-menu list-clients" id="item-chooser">
                {foreach from=$addressList item="address"}
                    <li>
                        <a href="{$smarty.const.BASEDIR}request/seladdress?id=address_id={$address['id']}&client_id={$address['client_id']}">
                            <i {if ($address['id'] == $request['address_id'])}class="fa fa-check-circle-o"{/if}></i>
                            {$address['address_type']}: {$address['street_addr']}, {$address['street_number']}, {$address['street_additional']}, {$address['hood']}, {$address['city']}
                        </a>
                    </li>
                {/foreach}
                <li class="footer"><a href="#" class="btn" data-toggle="modal" data-target="#compose-modal">Cadastre um novo endereço</a></li>
            </ul>
            <!-- /.Itens -->
        </div>
    </div><!-- /.chat item -->
    <div class="input-group">
        <a href="{$smarty.const.BASEDIR}request/changeclient" class="btn btn-primary">Selecionar outro cliente</a>
    </div>
</div><!-- /. Client profile -->