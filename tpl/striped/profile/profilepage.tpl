<div class="top-bar">
    <a class="button small" href="{$smarty.const.BASEDIR}profile/newuser">Adicionar Usuário</a>
</div>
<section class="box search">
    <form method="get" action="{$smarty.const.BASEDIR}profile">
        <input type="text" class="text" name="search" placeholder="Pesquisa" />
    </form>
</section>
{$pagination}
<div id="client-list">
    {$profilelist}
</div>