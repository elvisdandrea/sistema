<div class="col-md-12">

    <!-- Buttons (Options) -->
    <div class="box box-solid">
        <div class="box-body pad table-responsive">
            <blockquote>
                <p>Total do pedido: {$finalPrice}</p>
                <small>{$count_plates} pratos selecionados</small>
            </blockquote>
            <!-- <button  class="btn btn-success" title="Salvar" onclick="Salvar.html" style="width:150px;">Salvar pedido</button>
            <button type="button" class="btn btn-danger" title="Cancelar o pedido" onclick="pedidos-new.html"><i class="fa fa-times"></i></button> -->
        </div><!-- /.box -->
    </div><!-- /.col -->
    <!-- /.Buttons (Options) -->

    <!-- Conteúdo ENTREGA -->
    <div class="box">
        <div class="box-header">
            <h3 class="box-title">Dados para entrega:</h3>
        </div>

        <div class="box-body">
            <!-- Data de entrega -->
            <div class="form-group">
                <label>Data da entrega:</label>
                <div class="input-group col-md-6">
                    <div class="input-group-addon">
                        <i class="fa fa-calendar"></i>
                    </div>
                    <input value="{$request['delivery_date']}" type="text" class="form-control datemask" data-inputmask="'alias': 'dd/mm/aaaa'" data-mask/>
                </div><!-- /.input group -->
            </div><!-- /.form group -->
            <!-- /.Data de entrega -->

            <!-- Cliente -->
            <div class="form-group">
                <label>Para qual cliente:</label>
            </div><!-- /.form group -->
            <!-- /.Cliente -->

            <!-- Client profile -->
            <div class="box-body client-profile">
                <!-- chat item -->
                <div class="item">
                    <img src="{$client['image']}" alt="user image" />
                    <div class="client-dados">
                        <h5>
                            {$client['client_name']} <small>Telefones: {$client['phones']}</small>
                        </h5>
                        <a id="item-chooser-btn" class="btn btn-default btn-flat dropdown-toggle" data-toggle="dropdown">
                            <i class="fa fa-map-marker"></i> Escolha o endereço de entrega
                        </a><br />
                        <!-- Itens -->
                        <ul class="dropdown-menu list-clients" id="item-chooser">
                        {foreach from=$addressList item="address"}
                            <li>
                                <a href="#">
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
            </div><!-- /. Client profile -->

        </div><!-- /.box-body -->
    </div><!-- /.box -->
    <!-- /.Conteúdo ENTREGA -->

    <!-- Conteúdo PEDIDO -->
    <div class="box">
        <div class="box-header">
            <h3 class="box-title">Monte o pedido:</h3>
        </div>

        <div class="box-body">
            <!-- Prato -->
            <div class="form-group">
                <label>Adicione os pratos:</label>

            </div><!-- /.form group -->
            <!-- /.Prato -->

            {include "request/platelist.tpl"}

        </div><!-- /.box-body -->

    </div><!-- /.box -->
    <!-- /.Conteúdo PEDIDO -->

    <!-- Buttons (Options) -->
    <div class="box box-solid">
        <div class="box-body pad table-responsive">
            <blockquote>
                <p>Total do pedido: {$finalPrice}</p>
                <small>{$count_plates} pratos selecionados</small>
            </blockquote>
        </div><!-- /.box -->
    </div><!-- /.col -->
    <!-- /.Buttons (Options) -->

</div><!-- ./col-md-12 -->