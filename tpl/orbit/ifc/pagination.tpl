<div class="box-footer clearfix">
    <ul class="pagination pagination-sm no-margin pull-right">
        <li><a href="{if ($currentPage > 1)}{$smarty.const.BASEDIR}{$callUrl}?page=1{$params}{else}{/if}">&laquo;</a></li>
        {for $i=$start to $countPages max=$nPages}
            <li><a href="{$smarty.const.BASEDIR}{$callUrl}?page={$i}{$params}" {if ($i == $currentPage)}class="curpage"{/if}>{$i}</a></li>
        {/for}
        <li><a href="{if ($currentPage < $totalPages)}{$smarty.const.BASEDIR}{$callUrl}?page={$totalPages}{$params}{else}{/if}" class="button next">&raquo;</a></li>
    </ul>
</div>