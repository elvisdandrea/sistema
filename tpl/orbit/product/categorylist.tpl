<ul class="dropdown-menu list-clients">
    <li class="menu">
        <!-- inner menu: contains the actual data -->
        <ul class="menu">
            {foreach from=$categories item="category"}
                <li>
                    <a href="#" data-type="selitem" data-target="category_id" data-id="{$category['id']}" data-value="{$category['category_name']}" title="select">
                        {$category['category_name']}
                    </a>
                </li>
            {/foreach}
        </ul>
    </li>
    <li class="footer">
        <a href="#" class="btn" data-toggle="modal" data-target="#compose-modal">Edite as categorias</a>
    </li>
</ul>