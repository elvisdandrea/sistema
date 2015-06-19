<!-- Lista de itens -->
<ul class="dropdown-menu list-clients">
    <li class="header">Encontrados 2 resultados para Princi</li>
    <li>
        <!-- inner menu: contains the actual data -->
        <ul class="menu">
            {foreach from=$categoryList item="category"}
                <li>
                    <a href="#" data-type="selitem" data-target="category_id" data-id="{$category['id']}" data-value="{$category['category_name']}" title="select">
                        <img src="{$smarty.const.T_IMGURL}/food-icon.png" alt="{$category['category_name']}"/>{$category['category_name']}
                    </a>
                </li>
            {/foreach}
        </ul>
    </li>
    <li class="footer">
        <a href="#" class="btn" data-toggle="modal" data-target="#editar-categorias">Editar as categorias</a>
    </li>
</ul>