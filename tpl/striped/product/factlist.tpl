<option value="">Selectione tipo...</option>
{foreach from=$facts item="fact"}
    <option value="{$fact['id']}" {if (isset($selected) && $selected == {$fact['id']})}selected{/if}>{$fact['product']}</option>
{/foreach}
