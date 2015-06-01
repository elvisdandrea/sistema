<div class="col-md-12">

    <!-- Buttons (Options) -->
    <div class="box box-solid">
        <div class="box-body pad table-responsive">
            <blockquote>
                <p>Pedido #: {$request['id']}</p>
                <p data-id="totalprice">Total do pedido: {$finalPrice}</p>
                <small>{$count_plates} pratos selecionados</small>
            </blockquote>
            <!--<button  class="btn btn-success" title="Salvar" onclick="Salvar.html" style="width:150px;"></button>-->
            <div id="request-status{$request['id']}">
                {include "request/statuslistrequest.tpl"}
            </div>
            <!--<button type="button" class="btn btn-danger" title="Cancelar o pedido" onclick="{$smarty.const.BASEDIR}request/cancelrequest?id={$request['id']}"><i class="fa fa-times"></i></button>-->
        </div><!-- /.box -->
    </div><!-- /.col -->
    <!-- /.Buttons (Options) -->

    <!-- Conteúdo ENTREGA -->
    <div class="box">
        <div class="box-header">
            <h3 class="box-title">Dados para entrega:</h3>
        </div>

        <div class="box-body">

            <!-- Cliente -->
            <div class="form-group">
                <label>Para qual cliente:</label>
                <br /><br />
                {include "request/clientprofile.tpl"}
            </div>

            <!-- Data de entrega -->
            <div class="form-group">
                <label>Data da entrega:</label>
                <div class="input-group col-md-6">
                    <!--
                    <span class="input-group-addon">
                        <span class="glyphicon glyphicon-calendar"></span>
                    </span> -->
                    <div class='input-group date' id='datetimepicker'>
                        <input id="delivery-date" data-setvalue="{$smarty.const.BASEDIR}request/setdate?id={$request['id']}" value="{$request['delivery_date']}" type="text" class="form-control datemask" />
                        <span class="input-group-addon">
                            <span class="glyphicon glyphicon-calendar"></span>
                        </span>
                    </div>
                </div><!-- /.input group -->
            </div><!-- /.form group -->
            <!-- /.Data de entrega -->

        </div><!-- /.box-body -->
    </div><!-- /.box -->
    <!-- /.Conteúdo ENTREGA -->

    <!-- Conteúdo PEDIDO -->
    <div class="box">
        <div class="box-header">
            <h3 class="box-title">Monte o pedido:</h3>
        </div>
        <div class="box-body">
            <a href="{$smarty.const.BASEDIR}request/addplate?id={$request['id']}" class="btn btn-primary">Adicionar Prato</a>
        </div><!-- /.form group -->
    </div><!-- /.box -->
        {include "request/platelist.tpl"}

    <!-- /.Conteúdo PEDIDO -->

    <!-- Buttons (Options) -->
    <div class="box box-solid">
        <div class="box-body pad table-responsive">
            <blockquote>
                <p data-id="totalprice">Total do pedido: {$finalPrice}</p>
                <small>{$count_plates} pratos selecionados</small>
            </blockquote>
        </div><!-- /.box -->
    </div><!-- /.col -->
    <!-- /.Buttons (Options) -->

</div><!-- ./col-md-12 -->
{include "request/newaddress.tpl"}