<option value="">Selectione a categoria...</option>
{foreach from=$categories item="category"}
    <option value="{$category['id']}" {if (isset($selected) && $selected == {$category['id']})}selected{/if}>{$category['category_name']}</option>
{/foreach}
