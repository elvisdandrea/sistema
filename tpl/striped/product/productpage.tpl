<div class="top-bar">
    <a class="button small" href="{$smarty.const.BASEDIR}product/newproduct">Adicionar Produto</a>
</div>
<section class="box search">
    <form method="post" action="#">
        <input type="text" class="text" name="search" placeholder="Pesquisa" />
    </form>
</section>
{$pagination}
<div id="product-list">
    {$productList}
</div>
