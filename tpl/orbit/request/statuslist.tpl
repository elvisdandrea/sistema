<a id="item-chooser-btn" class="label btn label-warning dropdown-toggle" data-toggle="dropdown">

    <i class="fa
    {if ($row['status_name']) == 'Novo pedido'}
        fa-star
    {elseif ($row['status_name']) == 'Em andamento'}
        fa-magic
    {elseif ($row['status_name']) == 'Entregue'}
        fa-thumbs-o-up
    {elseif ($row['status_name']) == 'Cancelado'}
        fa-times
    {/if}"></i> {$row['status_name']} <span class="caret"></span>
</a><br />
<!-- Itens -->
<ul class="dropdown-menu" id="item-chooser" style="margin-top: -15px; text-align: left;">
    <li>
        <a href="#" class="text-aqua"><i class="fa fa-magic"></i>Em andamento</a>
    </li>
    <li>
        <a href="#" class="text-blue"><i class="fa fa-check-square-o"></i> Finalizado</a>
    </li>
    <li>
        <a href="#" class="text-green"><i class="fa fa-thumbs-o-up"></i>Entregue</a>
    </li>
    <li>
        <a href="#" class="text-red"><i class="fa fa-times"></i>Cancelado</a>
    </li>
</ul>