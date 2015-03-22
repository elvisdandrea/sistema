<div class="top-bar">
    <a class="button small" href="{$smarty.const.BASEDIR}client/newclient">Adicionar Cliente</a>
</div>
<section class="box search">
    <form method="post" action="#">
        <input type="text" class="text" name="search" placeholder="Pesquisa" />
    </form>
</section>
{include "home/pagination.tpl"}
<div id="client-list">
    {$clientlist}
</div>