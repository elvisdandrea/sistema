<ul class="nav navbar-nav">
    <!-- Notifications -->
    <li class="dropdown notifications-menu">
        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
            <small class="badge pull-right bg-red" style="margin-left:10px;">{$countNewRequests}</small>
            <i class="fa fa-bullhorn" style="width:20px;"></i><span>Novos pedidos</span>
        </a>
        <ul class="dropdown-menu">
            <li class="header">Você tem {$countNewRequests} novos pedidos</li>
            <li>
                <!-- inner menu: contains the actual data -->
                <ul class="menu">
                {foreach from=$newRequests item="row"}
                    <li>
                        <a href="{$smarty.const.BASEDIR}request/viewrequest?id={$row['id']}" title="{$row['status_name']}">
                            <i class="fa fa-minus warning"></i>{$row['client_name']}
                        </a>
                    </li>
                {/foreach}
                </ul>
            </li>
            <li class="footer"><a href="{$smarty.const.BASEDIR}request?status=1">Veja todos os novos pedidos</a></li>
        </ul>
    </li>
    <!-- User Account: style can be found in dropdown.less -->
    <li class="dropdown user user-menu">
        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
            <i class="glyphicon glyphicon-user"></i>
            <span>{UID::get('name')}</span> <i class="caret"></i>
        </a>
        <ul class="dropdown-menu">
            <!-- User image -->
            <li class="user-header bg-orange">
                <img src="{UID::get('image')}" class="img-circle" alt="User Image" />
                <p>
                    {UID::get('name')}
                    <small>{UID::get('email')}</small>
                </p>
            </li>
            <!-- Menu Footer-->
            <li class="user-footer">
                <div class="pull-left">
                    <a href="{$smarty.const.BASEDIR}profile/viewuser?id={UID::get('id')}" changeurl class="btn btn-default btn-flat">Editar perfil</a>
                </div>
                <div class="pull-right">
                    <a href="{$smarty.const.BASEDIR}home/logout" class="btn btn-default btn-flat">Sair</a>
                </div>
            </li>
        </ul>
    </li>
</ul>