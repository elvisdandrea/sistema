<div class="modal fade" id="compose-modal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title"><i class="fa map-marker"></i> Login de acesso ao Orbit</h4>
            </div>
            <div class="modal-body">
                <form action="{$smarty.const.BASEDIR}profile/authuser" method="post">
                    <div class="input-group">
                        <label>Nome de login:</label>
                        <input type="text" name="username" class="form-control" style="height:31px" placeholder="Nome de login">
                    </div><!-- /input-group -->
                    <div class="input-group">
                        <label>Senha:</label>
                        <input type="password" name="passwd" class="form-control" style="height:31px" placeholder="Senha">
                    </div><!-- /input-group -->
                </form>
            </div>
            <div class="modal-footer clearfix">
                <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i></button>
                <button type="submit" class="btn btn-success pull-left">Salvar alterações</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->