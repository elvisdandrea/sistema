<!-- DELETAR ISSO AQUI -->

<!-- <input type="text" name="username" class="form-control" style="height:31px" placeholder="Nome de login"
    {if (isset($user['username']))}
        value="{$user['username']}" disabled
    {/if}> -->

<!-- <input type="text" name="email" class="form-control" style="height:31px" placeholder="E-mail"
    {if (isset($user['email']))}
        value="{$user['email']}" disabled
    {/if}> -->

<!-- E FAZER COMO NO MODELO ABAIXO: CHAMAR OS DADOS SEM INPUTS -->

<!-- Alteração d0s dados de acesso -->
<div class="modal fade" id="compose-modal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <form action="{$smarty.const.BASEDIR}profile/authuser?uid={$profile['uid']}&id={$profile['id']}" method="post">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title"><i class="fa fa-key"></i>&nbsp;  Dados de acesso ao Orbit</h4>
                </div>
                
                <div class="modal-body">
                    <blockquote>
                        <p>Nome do Cabloco</p>
                        <small>nomedocaboclo@email.com.br</small>
                    </blockquote>
                    <div class="form-group">
                        <div class="margin">
                            <label>Digite a senha atual:</label>
                            <input type="password" name="passwd" class="form-control" placeholder="Digite a senha atual">
                        </div>
                        <div class="margin">
                            <label>Digite a nova senha:</label>
                            <input type="password" name="passwd" class="form-control">
                        </div>
                        <div class="margin">
                            <label>Repita a nova senha:</label>
                            <input type="password" name="passwd" class="form-control">
                        </div>
                    </div>
                </div>
                
                <div class="modal-footer clearfix">
                    <button type="button" class="btn btn-danger" data-dismiss="modal" ><i class="fa fa-times"></i></button>
                    <button type="submit" class="btn btn-success pull-left" >Salvar alterações</button>
                </div>
                    
            </div>
        </form>
    </div>
</div>