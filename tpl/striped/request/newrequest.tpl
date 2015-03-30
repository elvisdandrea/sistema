<form action="{$smarty.const.BASEDIR}request/addNewRequest">
    <div class="top-bar">
        <div class="buttons">
            <input class="button" type="submit" value="Salvar" />
            <a class="button button-red" href="{$smarty.const.BASEDIR}request">Cancelar</a>
        </div>
        <div class="alert alert-error" id="message" style="display: none"></div>
    </div>
    <h2>Cliente</h2>
    <input id="searchclient" type="text" value="" placeholder="Pesquise o cliente..." onkeyup="searchClient(event, '{$smarty.const.BASEDIR}request/searchclient?search=' + this.value)"/>
    <div id="client-results">

    </div>
    <div id="client" style="display: none">

    </div>
    <hr/>
    <h2>Pedido</h2>
    <a class="button" href="{$smarty.const.BASEDIR}request/addplate">Adicionar Prato</a>
    <div id="plates">

    </div>
</form>