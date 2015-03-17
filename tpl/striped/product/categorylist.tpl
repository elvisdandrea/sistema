<option value="">Selectione a categoria...</option>
{foreach from=$categories item="category"}
    <option value="{$category['id']}">{$category['category_name']}</option>
{/foreach}
