<div class="col-md-12">
    <div class="box box-solid">
        <div class="box-body pad table-responsive">
            <a href="{$smarty.const.BASEDIR}request/newrequest" class="btn btn-success">Clique aqui e adicione um novo pedido</a>
            <button id="daterange-btn" class="btn btn-default pull-right">
                <i class="fa fa-calendar"></i> Escolha o período: Hoje
                <i class="fa fa-caret-down"></i>
            </button>
        </div>
    </div>

    <div class="box box-solid">

        <div class="box-header">
            <h3 class="box-title">Dados e informações:</h3>
            <div class="box-tools pull-right">
                <button class="btn btn-default btn-sm" data-widget="collapse"><i class="fa fa-minus"></i></button>
            </div>
        </div>

        <div class="box-body">
            <div class="row">
                <div class="col-xs-4">
                    <div class="small-box bg-aqua">
                        <div class="inner">
                            <h3>
                                {$totalRequest}
                            </h3>
                            <p>
                                Pedidos realizados
                            </p>
                        </div>
                        <div class="icon">
                            <i class="fa fa-bullhorn"></i>
                        </div>
                        <a href="#" class="small-box-footer">
                            Veja a lista completa <i class="fa fa-arrow-circle-down"></i>
                        </a>
                    </div>
                </div>
                <!-- ** -->
                <div class="col-xs-4">
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
                        <a href="#" class="small-box-footer">
                            Veja todos <i class="fa fa-arrow-circle-down"></i>
                        </a>
                    </div>
                </div>
                <!-- ** -->
                <div class="col-xs-4">
                    <div class="small-box bg-olive">
                        <div class="inner">
                            <h3>
                                R$ PLACEHOLDER
                            </h3>
                            <p>
                                Em pedidos
                            </p>
                        </div>
                        <div class="icon">
                            <i class="fa fa-usd"></i>
                        </div>
                        <a href="#" class="small-box-footer">
                            Confira as finanças <i class="fa fa-arrow-circle-right"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div><!-- /.box -->

</div>

<div class="col-md-12">
    <div class="box">
        <form action="{$smarty.const.BASEDIR}request" method="get" class="sidebar-form">
            <div class="input-group">
                <input type="text" name="search" class="form-control" placeholder="Localizar dentro da lista"/>
                    <span class="input-group-btn">
                        <button type='submit' name='seach' id='search-btn' class="btn btn-flat">
                            <i class="fa fa-search"></i>
                        </button>
                    </span>
            </div>
        </form>

        {$request_table}

        {$pagination}

    </div>
</div>