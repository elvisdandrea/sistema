<!-- Lista de clientes -->
<ul id="clientresult" class="dropdown-menu list-clients">
    <li class="header">Encontrados {$countClient} resultados para {$search}</li>
    <li>
        <!-- inner menu: contains the actual data -->
        <ul class="menu">
            {foreach from=$clients key="client_id" item="client"}
                <li>
                    <a href="{$smarty.const.BASEDIR}request/selclient?id={$client['id']}&request_id={$request_id}" title="{$client['client_name']}">
                        <img src="{$client['image']}" alt=""/>{$client['client_name']} | {$client['phones']} | {$client['email']}
                    </a>
                </li>
            {/foreach}
        </ul>
    </li>
</ul>
<!-- /.Lista de clientes -->