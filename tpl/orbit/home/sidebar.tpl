<!-- Left side column. contains the logo and sidebar -->
<aside class="left-side sidebar-offcanvas">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
        <!-- sidebar menu -->
        <ul class="sidebar-menu">
            <li>
                <a href="{$smarty.const.BASEDIR}home">
                    <i class="fa fa-dashboard"></i> <span>Página inicial</span>
                </a>
            </li>
            <li class="treeview active">
                <a href="#">
                    <i class="fa fa-bullhorn"></i>
                    <span>Pedidos </span><small class="badge pull-right bg-red" style="right:32px; position:absolute;margin-top:-1px;">{$countNewRequests}</small>
                    <i class="fa fa-angle-left pull-right"></i>
                </a>
                <ul class="treeview-menu">
                    <li><a href="{$smarty.const.BASEDIR}request?status=1" changeurl ><i class="fa fa-angle-double-right"></i>{$countNewRequests} novos pedidos</a></li>
                    <li><a href="{$smarty.const.BASEDIR}request" changeurl ><i class="fa fa-angle-double-right"></i> Todos os pedidos</a></li>
                    <li><a href="{$smarty.const.BASEDIR}request/newrequest" changeurl ><i class="fa fa-angle-double-right"></i> Novo pedido</a></li>
                </ul>
            </li>
            <li class="treeview">
                <a href="#">
                    <i class="fa fa-users"></i>
                    <span>Clientes </span>
                    <i class="fa fa-angle-left pull-right"></i>
                </a>
                <ul class="treeview-menu">
                    <li><a href="{$smarty.const.BASEDIR}client" changeurl ><i class="fa fa-angle-double-right"></i>Todos os clientes</a></li>
                    <li><a href="{$smarty.const.BASEDIR}client/newclient" changeurl ><i class="fa fa-angle-double-right"></i>Novo cliente</a></li>
                </ul>
            </li>
            <li class="treeview">
                <a href="#">
                    <i class="fa fa-cutlery"></i>
                    <span>Produtos </span>
                    <i class="fa fa-angle-left pull-right"></i>
                </a>
                <ul class="treeview-menu">
                    <li><a href="{$smarty.const.BASEDIR}product" changeurl ><i class="fa fa-angle-double-right"></i>Todos os produtos</a></li>
                    <li><a href="{$smarty.const.BASEDIR}product/newproduct" changeurl ><i class="fa fa-angle-double-right"></i>Novo produto</a></li>
                </ul>
            </li>
            <li class="treeview">
                <a href="#">
                    <i class="fa fa-cog"></i>
                    <span>Usuários</span>
                    <i class="fa fa-angle-left pull-right"></i>
                    <!--<span class="label label-danger">Requer atenção</span>-->
                </a>
                <ul class="treeview-menu">
                    <li><a href="{$smarty.const.BASEDIR}profile" changeurl ><i class="fa fa-angle-double-right"></i>Todos os Usuarios</a></li>
                    <li><a href="{$smarty.const.BASEDIR}profile/viewuser?id={UID::get('profile','id')}" changeurl ><i class="fa fa-angle-double-right"></i>Meu Perfil</a></li>
                    <li><a href="{$smarty.const.BASEDIR}profile/newuser" changeurl ><i class="fa fa-angle-double-right"></i>Novo Usuário</a></li>
                </ul>
            </li>
            <li class="treeview">
                <a href="#">
                    <i class="fa fa-cog"></i>
                    <span>Configurações</span>
                    <i class="fa fa-angle-left pull-right"></i>
                    <!--<span class="label label-danger">Requer atenção</span>-->
                </a>
                <ul class="treeview-menu">
                    <li><a href="{$smarty.const.BASEDIR}settings" changeurl ><i class="fa fa-angle-double-right"></i>Ajustes</a></li>
                </ul>
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