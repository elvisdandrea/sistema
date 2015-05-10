<ul id="category-list" class="dropdown-menu list-clients">
    <li class="menu">
        <!-- inner menu: contains the actual data -->
        <ul class="menu">
            {foreach from=$categoryList item="category"}
                <li data-toggle="collapse" data-target="#category-list">
                    <a href="#" data-type="selitem" data-target="category_id" data-id="{$category['id']}" data-value="{$category['category_name']}" title="select">
                        <img src="{$smarty.const.T_IMGURL}/food-icon.png" alt="Prato principal"/>{$category['category_name']}
                    </a>
                </li>
            {/foreach}
        </ul>
    </li>
    <li class="footer">
        <a href="#" class="btn" data-toggle="modal" data-target="#compose-modal">Edite as categorias</a>
    </li>
</ul>