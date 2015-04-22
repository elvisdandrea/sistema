<button id="item-chooser-btn{$row['id']}" data-chooser="item-chooser-btn" class="btn
    {if ($request['status_name']) == 'Novo pedido'}
        btn-warning
    {elseif ($request['status_name']) == 'Em andamento'}
        btn-primary
    {elseif ($request['status_name']) == 'Entregue'}
        btn-success
    {elseif ($request['status_name']) == 'Cancelado'}
        btn-danger
    {/if}
    dropdown-toggle" data-toggle="dropdown">

    {if ($request['status_name']) == 'Novo pedido'}
        <i class="fa fa-star"></i>
    {elseif ($request['status_name']) == 'Em andamento'}
        <i class="fa fa-magic"></i>
    {elseif ($request['status_name']) == 'Entregue'}
        <i class="fa fa-thumbs-o-up"></i>
    {elseif ($request['status_name']) == 'Cancelado'}
        <i class="fa-times"></i>
    {/if} {$request['status_name']} <span class="caret"></span>
</button><br />
<!-- Itens -->
<ul class="dropdown-menu" id="item-chooser" style="margin-top: -15px; text-align: left;">
    <li>
        <a href="{$smarty.const.BASEDIR}request/setstatus?id={$request['id']}&status=2" class="text-aqua"><i class="fa fa-magic"></i>Em andamento</a>
    </li>
    <!--
    <li>
        <a href="#" class="text-blue"><i class="fa fa-check-square-o"></i> Finalizado</a>
    </li>
    -->
    <li>
        <a href="{$smarty.const.BASEDIR}request/setstatus?id={$request['id']}&status=3" class="text-green"><i class="fa fa-thumbs-o-up"></i>Entregue</a>
    </li>
    <li>
        <a href="{$smarty.const.BASEDIR}request/setstatus?id={$request['id']}&status=4" class="text-red"><i class="fa fa-times"></i>Cancelado</a>
    </li>
</ul>