<div id="box-info" class="box-body" style="display: none">
    <div class="row">
        <div class="col-md-4 col-sm-6 col-xs-6">
            <div class="small-box bg-aqua">
                <div class="inner">
                    <h3>
                        {$onRoadRequests}
                    </h3>
                    <p>
                        Pedidos Em Andamento
                    </p>
                </div>
                <div class="icon">
                    <i class="fa fa-bullhorn"></i>
                </div>
                <a href="{$smarty.const.BASEDIR}request?status=2" class="small-box-footer"  changeurl >
                    Veja todos os pedidos <i class="fa fa-arrow-circle-down"></i>
                </a>
            </div>
        </div>
        <!-- ** -->
        <div class="col-md-4 col-sm-6 col-xs-6">
            <div class="small-box bg-yellow">
                <div class="inner">
                    <h3>
                        {$pendingRequests}
                    </h3>
                    <p>
                        Novos pedidos pendentes
                    </p>
                </div>
                <div class="icon">
                    <i class="fa fa-warning"></i>
                </div>
                <a href="{$smarty.const.BASEDIR}request?status=1{if (isset($dateFrom))}&date_from={$dateFrom}{/if}{if (isset($dateTo))}&date_to={$dateTo}{/if}" class="small-box-footer"  changeurl >
                    Veja todos <i class="fa fa-arrow-circle-down"></i>
                </a>
            </div>
        </div>
        <!-- ** -->
        <div class="col-md-4 col-sm-12 col-xs-12">
            <div class="small-box bg-olive">
                <div class="inner">
                    <h3>
                        {$totalPrice}
                    </h3>
                    <p>
                        Em pedidos
                    </p>
                </div>
                <div class="icon">
                    <i class="fa fa-usd"></i>
                </div>
                <div class="small-box-footer">
                    &nbsp
                </div>
            </div>
        </div>
    </div>
</div>