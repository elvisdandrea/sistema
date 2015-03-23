<div class="pagination">
    <a href="{if ($currentPage > 1)}{$smarty.const.BASEDIR}{$callUrl}?page=1{$params}{else}{/if}" class="button previous"> << </a>
    {if ($currentPage > 3)}
        <span>&hellip;</span>
    {/if}
    <div class="pages">
        {for $i=$start to $countPages max=$nPages}
            <a href="{$smarty.const.BASEDIR}{$callUrl}?page={$i}{$params}" {if ($i == $currentPage)} class="active" {/if}>{$i}</a>
        {/for}
    </div>
    {if ($i - 1 < $totalPages)}
        <span>&hellip;</span>
    {/if}
    <a href="{if ($currentPage < $totalPages)}{$smarty.const.BASEDIR}{$callUrl}?page={$totalPages}{$params}{else}{/if}" class="button next"> >> </a>
</div>