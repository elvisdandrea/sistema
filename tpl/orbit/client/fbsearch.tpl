<div class="modal fade" id="fb-search-modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">PLACEHOLDER</h4>
            </div>
            <div class="modal-body">
                <form method="post" action="{$smarty.const.BASEDIR}client/fbSearch">
                    <div class="input-group">
                        <label for="fb-search">Busca:</label>
                        <input class="form-control" type="text" name="fb-search" id="fb-search">
                    </div>
                    <button class="btn btn-default" type="submit">Pesquisar</button>
                </form>
                <div id="fb-matches">

                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->