<div class="col-md-12">
    <div class="box box-solid">

        <div class="box-header">
            <div class="box-tools">
                <a onclick="$('#box-info').toggle()" class="btn btn-default btn-sm" data-widget="collapse" data-target="#box-info" style="width:100%"><spam class="pull-left"><i class="fa fa-plus"></i>&nbsp;&nbsp; Visualizar os dados e informações:</spam></a>
            </div>
        </div>

        {include "request/requestinfo.tpl"}
    </div><!-- /.box -->
    <div class="box box-solid">
        <div class="box-body pad table-responsive">
            <a href="{$smarty.const.BASEDIR}request/newrequest{if ($client_id)}?client_id={$client_id}{/if}"  changeurl class="btn btn-success">Clique aqui e adicione um novo pedido</a>
        </div>
    </div>

</div>

<div class="col-md-12">
    <div class="box">
    
        <div class="box-body">
            <form action="{$smarty.const.BASEDIR}request" method="get">
                <div class="row">
                    <div class="col-md-8 col-sm-7">
                        <div class="input-group input-group-sm" style="margin-bottom:5px;">
                            <input type="text" name="search" class="form-control" placeholder="Localizar dentro da lista" value="{$search}"/>
                            <span class="input-group-btn">
                                <button type='submit' name='seach' id='search-btn' class="btn btn-info">Pesquisar</button>
                            </span>
                        </div>
                    </div>
                    <div class="col-md-4 col-sm-5">
                        <button id="daterange-btn" data-url="{$smarty.const.BASEDIR}request" class="btn btn-info pull-right" style="width:100%">
                                Período:&nbsp&nbsp Últimos 30 dias &nbsp&nbsp
                                <i class="fa fa-caret-down"></i>
                        </button>
                    {if isset($dateFrom)}
                        <input type="hidden" name="date_from" value="{$dateFrom}"/>
                    {/if}
                    {if isset($dateTo)}
                        <input type="hidden" name="date_from" value="{$dateTo}"/>
                    {/if}
                    </div>
                </div>
            </form>
        </div>

        {$request_table}

        {$pagination}

    </div>
</div>