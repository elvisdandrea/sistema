<h5>Categorias cadastradas</h5>
<div class="box-body">
    <table class="table table-striped">
        <tr>
            <th>Nome da categoria</th>
            <th>Produtos</th>
            <th>Ação</th>
        </tr>
        {foreach from=$categories item="category"}
            <tr title="Editar" >
                <td onclick="openEdit({$category['id']}, event)" id="edit{$category['id']}">
                    {include "product/categoryitem.tpl"}
                </td>
                <td>
                    {if ($category['product_count'] > 0)}
                        {$category['product_count']} produtos dessa categoria
                    {else}
                        Nenhum produto
                    {/if}
                </td>
                <td>
                    {if ($category['product_count'] > 0)}
                        <span class="badge" style="background-color:#FCC">Não permitida</span>
                    {else}
                        <button type="button" class="btn badge bg-red" title="Deletar essa categoria">Remover</button>
                    {/if}
                </td>
            </tr>
        {/foreach}
    </table>
</div>
{if (isset($pagination))}{$pagination}{/if}