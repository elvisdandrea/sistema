<!-- Client profile -->
<div id="list-clients" class="list-itens">
    <input type="hidden" name="client_id" value="{$client['id']}"/>
    <div class="list-imgs">
        <img src="{if (!empty($client['image']))}{$client['image']}{else}{$smarty.const.BASEDIR}/no-profile.jpg{/if}" alt="{$client['client_name']}" />
    </div>
    <!-- /.Itens -->
    <div id="client-choose" style="">
        <div class="row">
            <div class="col-md-5 col-sm-12">
                <i class="fa circle fa-user"></i>
                <h5>
                    <strong>{$client['client_name']}</strong><small> - <a href="{$smarty.const.BASEDIR}request/changeclient"><i>Alterar</i></a></small>
                </h5>
            </div>
            <div class="col-md-7 col-sm-12">
                <i class="fa circle fa-phone"></i>
                <h5>
                    <span>{$client['phones']}</span>
                </h5>
            </div>
        </div>

        <div class="row">
            <div class="col-md-8 col-sm-9">
                <a id="addressbtn" id="place-chooser-btn" class="btn btn-info dropdown-toggle no-space" data-toggle="dropdown" style="width: 60%; margin-top: 7px; margin-bottom: -7px;">
                    <i class="fa fa-map-marker"></i>&nbsp;&nbsp;
                    <span id="seladdress">Escolha o endereço de entrega</span>
                </a>
                <!-- Itens -->
                <ul class="dropdown-menu list-clients" id="item-chooser">
                    {foreach from=$addressList item="address"}
                        <li>
                            <a class="no-space" href="{$smarty.const.BASEDIR}request/seladdress?id={$address['id']}&&request_id={$request_id}client_id={$address['client_id']}">
                                <i {if ($address['id'] == $request['address_id'])}class="fa fa-check-circle-o"{/if}></i>&nbsp;&nbsp;
                                {$address['address_type']}: {$address['street_addr']}, {$address['street_number']}, {$address['street_additional']}, {$address['hood']}, {$address['city']}
                            </a>
                        </li>
                    {/foreach}
                    <li class="footer"><a href="#" class="btn" data-toggle="modal" data-target="#compose-modal"><i class="fa fa-plus"></i>&nbsp;Cadastre um novo endereço</a></li>
                </ul>
                <!-- /.Itens -->
            </div>
        </div>
    </div>
</div>