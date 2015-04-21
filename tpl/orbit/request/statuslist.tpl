<a id="item-chooser-btn{$row['id']}" data-chooser="item-chooser-btn" class="label btn
    {if ($row['status_name']) == 'Novo pedido'}
        label-warning
    {elseif ($row['status_name']) == 'Em andamento'}
        label-primary
    {elseif ($row['status_name']) == 'Entregue'}
        label-success
    {elseif ($row['status_name']) == 'Cancelado'}
        label-danger
    {/if}
    dropdown-toggle" data-toggle="dropdown">

    {if ($row['status_name']) == 'Novo pedido'}
        <i class="fa fa-star"></i>
    {elseif ($row['status_name']) == 'Em andamento'}
        <i class="fa fa-magic"></i>
    {elseif ($row['status_name']) == 'Entregue'}
        <i class="fa fa-thumbs-o-up"></i>
    {elseif ($row['status_name']) == 'Cancelado'}
        <i class="fa-times"></i>
    {/if} {$row['status_name']} <span class="caret"></span>
</a><br />
<!-- Itens -->
<ul class="dropdown-menu" id="item-chooser" style="margin-top: -15px; text-align: left;">
    <li>
        <a href="{$smarty.const.BASEDIR}request/setstatus?id={$row['id']}&status=2&table={$id}&index={$index}&field={str_replace(array('/','.'),'_',$field)}" class="text-aqua"><i class="fa fa-magic"></i>Em andamento</a>
    </li>
    <!--
    <li>
        <a href="#" class="text-blue"><i class="fa fa-check-square-o"></i> Finalizado</a>
    </li>
    -->
    <li>
        <a href="{$smarty.const.BASEDIR}request/setstatus?id={$row['id']}&status=3&table={$id}&index={$index}&field={str_replace(array('/','.'),'_',$field)}" class="text-green"><i class="fa fa-thumbs-o-up"></i>Entregue</a>
    </li>
    <li>
        <a href="{$smarty.const.BASEDIR}request/setstatus?id={$row['id']}&status=4&table={$id}&index={$index}&field={str_replace(array('/','.'),'_',$field)}" class="text-red"><i class="fa fa-times"></i>Cancelado</a>
    </li>
</ul>