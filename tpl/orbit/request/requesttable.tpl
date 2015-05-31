<div class="box-body">
    <!-- Listagem -->
    {foreach from=$list key="id" item="request"}
        <div id="list-requests" class="list-itens">
            <div id="request-status{$request['id']}">
                {include "request/statuslistrequest.tpl"}
            </div>
            <!-- /.Itens -->
            <div style="width:100%">
                    <a href="{$smarty.const.BASEDIR}request/viewrequest?id={$request['id']}" changeurl>
                        <div class="row">
                            <div class="col-md-5 col-sm-12">
                                <i class="fa circle fa-user"></i>
                                <h5>
                                    <span>Cliente:</span>&nbsp;
                                    <strong>{$request['client_name']}</strong>
                                </h5>
                            </div>
                            <div class="col-md-7 col-sm-12">
                                <i class="fa circle fa-phone"></i>
                                <h5>
                                    <span>{$request['phones']}</span>
                                </h5>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-5 col-sm-5">
                                <i class="fa circle fa-clock-o"></i>
                                <h5>
                                    <span>Entrega:&nbsp;&nbsp;<strong>{String::formatDateTimeToLoad($request['delivery_date'])}</strong></span>
                                </h5>
                            </div>
                            <div class="col-md-5 col-sm-5">
                                <i class="fa circle fa-usd"></i>
                                <h5>
                                    <span>Valor:&nbsp;&nbsp;<strong>{String::convertTextFormat($request['price'], 'currency')}</strong></span>
                                </h5>
                            </div>
                            <div class="col-md-2 col-sm-12">
                                <i class="fa circle fa-angle-right"></i>
                                <h5>
                                    <span>ID <strong>#{$request['id']}</strong></span>
                                </h5>
                            </div>
                        </div>
                    </a>

            </div>
            <a hef="{$smarty.const.BASEDIR}request/print?id={$request['id']}" class="btn btn-default btn-sm btn-print" title="Imprimir pedido"><i class="fa fa-print"></i></a>
        </div>
        <hr/>
    {/foreach}
</div>