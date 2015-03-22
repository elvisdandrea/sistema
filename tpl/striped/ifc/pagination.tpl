<div class="pagination">
    <a href="{$smarty.const.BASEDIR}{$callUrl}{$page}{$params}" class="button previous"> < </a>
    {if ($currentPage > 5)}
        <a href="#" class="button previous"> 1 </a>
        <span>&hellip;</span>
    {/if}
    <div class="pages">
        {for $i=1 to $nPages}
            <a href="#" {if ($i == $currentPage)} class="active" {/if}>{$i}</a>
        {/for}

        <a href="#">2</a>
        <a href="#">3</a>
        <a href="#">4</a>
        <a href="#">20</a>
    </div>
    <a href="#" class="button next"> > </a>
</div>