<div class="modal fade" id="compose-modal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <form action="{$smarty.const.BASEDIR}profile/authuser?uid={$profile['uid']}&id={$profile['id']}" method="post">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title"><i class="fa map-marker"></i> Login de acesso ao Orbit</h4>
                </div>
                <div class="modal-body">
                    <div class="input-group">
                        <label>Nome de login:</label>
                        <input type="text" name="username" class="form-control" style="height:31px" placeholder="Nome de login"
                                {if (isset($user['username']))}
                                    value="{$user['username']}" disabled
                                {/if}>
                    </div><!-- /input-group -->
                    <div class="input-group">
                        <label>Email:</label>
                        <input type="text" name="email" class="form-control" style="height:31px" placeholder="E-mail"
                                {if (isset($user['email']))}
                                    value="{$user['email']}" disabled
                                {/if}>
                    </div><!-- /input-group -->
                    <input type="hidden" name="name" value="{$profile['name']}"/>
                    <div class="input-group">
                        <label>Senha:</label>
                        <input type="password" name="passwd" class="form-control" style="height:31px" placeholder="Senha">
                    </div><!-- /input-group -->
                </div>
                <div class="modal-footer clearfix">
                    <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i></button>
                    <button type="submit" class="btn btn-success pull-left">Salvar alterações</button>
                </div>
            </div><!-- /.modal-content -->
        </form>
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->