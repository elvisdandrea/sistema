<!-- Left side column. contains the logo and sidebar -->
<aside class="left-side sidebar-offcanvas">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
        <!-- sidebar menu -->
        <ul class="sidebar-menu">
            <li>
                <a href="index.html">
                    <i class="fa fa-dashboard"></i> <span>Página inicial</span>
                </a>
            </li>
            <li class="treeview">
                <a href="">
                    <i class="fa fa-bullhorn"></i>
                    <span>Pedidos </span><small class="badge pull-right bg-red" style="right:32px; position:absolute;margin-top:-1px;">18</small>
                    <i class="fa fa-angle-left pull-right"></i>
                </a>
                <ul class="treeview-menu">
                    <li><a href="{$smarty.const.BASEDIR}request"><i class="fa fa-angle-double-right"></i>18 novos pedidos</a></li>
                    <li><a href="{$smarty.const.BASEDIR}request"><i class="fa fa-angle-double-right"></i> Todos os pedidos</a></li>
                    <li><a href="{$smarty.const.BASEDIR}request/newrequest"><i class="fa fa-angle-double-right"></i> Novo pedido</a></li>
                </ul>
            </li>
            <li class="treeview active">
                <a href="">
                    <i class="fa fa-users"></i>
                    <span>Clientes </span>
                    <i class="fa fa-angle-left pull-right"></i>
                </a>
                <ul class="treeview-menu">
                    <li><a href="{$smarty.const.BASEDIR}client"><i class="fa fa-angle-double-right"></i>Todos os clientes</a></li>
                    <li><a href="{$smarty.const.BASEDIR}client/newclient"><i class="fa fa-angle-double-right"></i>Novo cliente</a></li>
                </ul>
            </li>
            <li class="treeview">
                <a href="">
                    <i class="fa fa-cutlery"></i>
                    <span>Produtos </span>
                    <i class="fa fa-angle-left pull-right"></i>
                </a>
                <ul class="treeview-menu">
                    <li><a href="{$smarty.const.BASEDIR}product"><i class="fa fa-angle-double-right"></i>Todos os produtos</a></li>
                    <li><a href="{$smarty.const.BASEDIR}product/newproduct"><i class="fa fa-angle-double-right"></i>Novo produtos</a></li>
                </ul>
            </li>
            <li>
                <a href="settings.html">
                    <i class="fa fa-cog"></i> <span>Configurações</span>
                    <span class="label label-danger">Requer atenção</span>
                </a>
            </li>
            <li>
                <a href="{$smarty.const.BASEDIR}home/logout">
                    <i class="fa fa-sign-out"></i> <span>Sair</span>
                </a>
            </li>
        </ul>
        <!-- search form -->
        <form action="#" method="get" class="sidebar-form">
            <div class="input-group">
                <input type="text" name="q" class="form-control" placeholder="Pesquisar no sistema"/>
                            <span class="input-group-btn">
                                <button type='submit' name='seach' id='search-btn' class="btn btn-flat"><i class="fa fa-search"></i></button>
                            </span>
            </div>
        </form>
        <!-- /.search form -->
    </section>
    <!-- /.sidebar -->
</aside>