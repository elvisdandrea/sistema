<!-- Client profile -->
<div class="list-clients list-itens">
    <input type="hidden" name="client_id" value="{$client['id']}"/>
    <div class="list-imgs" style="background:url({if (!empty($client['image']))}{$client['image']}{else}{$smarty.const.T_IMGURL}/no-profile.jpg{/if})" title="{$client['client_name']}"></div>
    <!-- /.Itens -->
    <!-- TODO: me diga em qual arquivo JS devo salvar isso! Fecha o dropdown de selecionar/cadastrar endereço ao optar cadastrar novo-->
    <script>
        $("#add-new-address").on("click",function(){
            $(this).closest(".dropdown-menu").prev().dropdown("toggle");
        });
    </script>
    <div class="client-choose">
        <div class="row">
            <div class="col-md-5 col-sm-12">
                <i class="fa circle fa-user"></i>
                <h5>
                    <strong>{$client['client_name']}</strong>
                    {if (!isset($request))}
                        <small> - <a href="{$smarty.const.BASEDIR}request/changeclient"><i>Alterar</i></a></small>
                    {/if}
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
                <a id="addressbtn" id="place-chooser-btn" class="btn {if (isset($request['street_addr']) && !empty($request['street_addr']))}btn-success{else}btn-primary{/if} dropdown-toggle no-space" data-toggle="dropdown" style="margin-top: 7px; margin-bottom: -7px;">
                    <i class="fa fa-map-marker"></i>&nbsp;&nbsp;
                    <span id="seladdress">{if (isset($request['street_addr']) && !empty($request['street_addr']))}
                    {$request['address_type']}: {$request['street_addr']}, {$request['street_number']}, {$request['street_additional']}, {$request['hood']}, {$request['city']}
                    {else}Escolha o endereço de entrega{/if}</span>
                </a>
                <!-- Itens -->
                <ul class="dropdown-menu list-clients" id="item-chooser">
                    {foreach from=$addressList item="address"}
                        <li>
                            <a class="no-space" href="{$smarty.const.BASEDIR}request/{if (isset($request))}setaddress{else}seladdress{/if}?id={$address['id']}&request_id={$request_id}client_id={$address['client_id']}">
                                <i {if ($address['id'] == $request['address_id'])}class="fa fa-check-circle-o"{/if}></i>&nbsp;&nbsp;
                                {$address['address_type']}: {$address['street_addr']}, {$address['street_number']}, {$address['street_additional']}, {$address['hood']}, {$address['city']}
                            </a>
                        </li>
                    {/foreach}
                    <li class="footer"><a href="#" class="btn" id="add-new-address" data-toggle="modal" data-target="#compose-modal-address"><i class="fa fa-plus"></i>&nbsp;Cadastre um novo endereço</a></li>
                </ul>
                <!-- /.Itens -->
            </div>
        </div>
    </div>
</div>