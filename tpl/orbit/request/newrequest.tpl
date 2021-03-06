<div class="col-md-12">
    <form action="{$smarty.const.BASEDIR}request/addNewRequest?request_id={$request_id}" changeurl="{$smarty.const.BASEDIR}request">

    <!-- Conteúdo ENTREGA -->
    <div class="box">
        <div class="box-header">
            <h3 class="box-title">Dados para entrega:</h3>
        </div>

        <div class="box-body">
            
            <div class="form-group">
                <label>Para qual cliente:</label>
                <div class="input-group col-md-6 col-sm-6 col-xs-12" id="searchclient" {if (isset($client))}style="display: none;" {/if} >
                    <div class="input-group-addon">
                        <i class="fa fa-user"></i>
                    </div>
                    <input type="text" class="form-control" placeholder="Localizar um cliente" onkeyup="searchClient(event, '{$smarty.const.BASEDIR}request/searchclient?search=' + this.value + '&request_id={$request_id}',this.value)" data-toggle="dropdown" />

                    <a class="input-group-addon btn btn-success" data-toggle="modal" data-target="#compose-modal" data-dismiss="#clientresult">
                        <i class="glyphicon glyphicon-plus-sign text-white"></i>
                    </a>

                    <div id="client-results">

                    </div>

                </div><!-- /.input group -->

                <div id="client" class="form-group">
                    {if (isset($client))}
                        {$client}
                    {/if}
                </div>

            </div><!-- /.form group -->
            <!-- /.Cliente -->

            <!-- Data de entrega -->
            <div class="form-group">
                <label>Data da entrega:</label>
                <div class="input-group col-md-6 col-sm-6 col-xs-12">
                    <!--
                    <span class="input-group-addon">
                        <span class="glyphicon glyphicon-calendar"></span>
                    </span> -->
                    <div class='input-group date' id='datetimepicker'>
                        <input id="datetimepicker" value="" type="text" class="form-control datemask" />
                        <input id="delivery-date" type="hidden" name="delivery_date" />
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
    <div class="row">
        <div class="col-md-12 col-sm12">
            <ul class="request-itens" id="request-items">
                {include "request/itemlist.tpl"}
            </ul>
        </div>
    </div>
    <!-- Buttons (Options) -->
    <div class="box box-solid">
        <div class="box-body pad table-responsive">
            <blockquote>
                <p data-id="totalprice">Total do pedido: </p>
                <small>nenhum prato adicionado</small>
            </blockquote>
            <button type="submit" class="btn btn-success" title="Salvar" style="width:150px;">Salvar pedido</button>
            <button type="button" class="btn btn-danger" title="Cancelar o pedido" onclick="Main.quickLink('{$smarty.const.BASEDIR}request')"><i class="fa fa-times"></i></button>
        </div><!-- /.box -->
    </div><!-- /.col -->
    <!-- /.Buttons (Options) -->
</form>
</div><!-- ./col-md-12 -->

{include "request/newclient.tpl"}
{include "request/newaddress.tpl"}