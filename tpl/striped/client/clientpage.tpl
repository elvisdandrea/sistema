<div class="top-bar">
    <a class="button small" href="{$smarty.const.BASEDIR}client/newclient">Adicionar Cliente</a>
</div>
<section class="box search">
    <form method="get" action="{$smarty.const.BASEDIR}client">
        <input type="text" class="text" name="search" placeholder="Pesquisa" />
    </form>
</section>
{$pagination}
<div id="client-list">
    {$clientlist}
</div>