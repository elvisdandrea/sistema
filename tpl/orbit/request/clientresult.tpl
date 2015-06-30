<!-- Lista de clientes -->
<ul id="clientresult" class="dropdown-menu list-clients">
    <li class="header">Encontrados {$countClient} resultados para {$search}</li>
    <li>
        <div style="position: relative; overflow-x: hidden; width: auto; height: auto; max-height: 160px;">
            <!-- inner menu: contains the actual data -->
            <ul class="menu">
                {foreach from=$clients key="client_id" item="client"}
                    <li>
                        <a href="{$smarty.const.BASEDIR}request/selclient?id={$client['id']}&request_id={$request_id}" title="{$client['client_name']}">
                            <img src="{if (!empty($client['image']))}{$client['image']}{else}{$smarty.const.T_IMGURL}/no-profile.jpg{/if}" alt=""/>{$client['client_name']} | {$client['phones']} | {$client['email']}
                        </a>
                    </li>
                {/foreach}
            </ul>
        </div>
    </li>
    <li class="footer">
        <a id="newclientbtn" href="#" class="btn" data-toggle="modal" data-target="#compose-modal" data-dismiss="#clientresult"><i class="fa fa-plus"></i>&nbsp;Cadastre um novo cliente</a>
    </li>
</ul>
<!-- /.Lista de clientes -->