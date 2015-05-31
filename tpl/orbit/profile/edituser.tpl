<div>
<form action="{$smarty.const.BASEDIR}profile/editUser?id={$profile['id']}" changeurl="{$smarty.const.BASEDIR}profile">

    <div class="box box-solid">
        <div class="box-body pad table-responsive">
            <blockquote>
                {if (intval($profile['uid']) == 0)}
                    <p data-id="totalprice">Este usuário ainda não acessa o sistema: </p>
                    <button type="submit" class="btn btn-success" title="Salvar" style="width:150px;" data-toggle="modal" data-target="#compose-modal">Ativar este usuário</button>
                {else}
                    <p data-id="totalprice">Este usuário está ativo no sistema: </p>
                    <button type="submit" class="btn btn-success" title="Salvar" style="width:150px;" data-toggle="modal" data-target="#compose-modal">Alterar senha</button>
                    <a href="{$smarty.const.BASEDIR}profile/deactivate?uid={$profile['uid']}" class="btn btn-danger" title="Eliminar o login" style="width:150px;">Desativar este usuário</a>
                {/if}
            </blockquote>
        </div><!-- /.box -->
    </div>

    <!-- Buttons (Options) -->
    <div class="box box-solid">
        <div class="box-body pad table-responsive">
            <button type="submit" class="btn btn-success" title="Salvar" style="width:150px;">Salvar alterações</button>
            <a type="button" class="btn btn-danger" title="Excluir o usuário" href="{$smarty.const.BASEDIR}profile/removeuser"><i class="fa fa-times"></i></a>
        </div><!-- /.box -->
    </div><!-- /.col -->
    <!-- /.Buttons (Options) -->

    <div class="row">

        <div class="col-md-3">
            <div class="box">
                <div class="box-header">
                    <h3 class="box-title">Imagem de exibição</h3>
                </div><!-- /.box-header -->

                <div class="box-body">
                    <img src="{if ($profile['image']) != ''}{$profile['image']}{else}{$smarty.const.T_IMGURL}/no-profile.jpg{/if}" name="image64" id="profile-img" type="upload" class="image-user" alt="user image" style="display:block; margin:0 auto;" />

                    <div class="form-group" style="display: block; margin: 20px auto 0px; width: 150px; text-align: center;" >
                        <div class="btn btn-success btn-file">
                            <i class="fa fa-upload"></i> Enviar uma imagem
                            <input id="read64" type="file" />
                        </div>
                    </div>
                    <p class="help-block">Max. 1 MB</p>
                </div>
            </div><!-- /.box-body -->
        </div><!-- /.box -->

        <div class="col-md-9">
            <div class="box">
                <div class="box-header">
                    <h3 class="box-title">Dados do usuário</h3>
                </div><!-- /.box-header -->

                <div class="box-body">
                    <div class="row">
                        <div class="form-group col-md-9">
                            <div class="form-group col-xs-6">
                                <label>Nome:</label>
                                <input type="text" class="form-control" name="name" value="{$profile['name']}"/>
                            </div>
                            <div class="form-group col-xs-6">
                                <label>E-mail:</label>
                                <input type="text" class="form-control"  name="email" value="{$profile['email']}" />
                            </div>
                            <div class="form-group col-xs-6">
                                <label>CPF:</label>
                                <input type="text" class="form-control"  name="cpf" value="{$profile['cpf']}" />
                            </div>
                            <div class="form-group col-xs-6">
                                <label>Celular:</label>
                                <input type="text" class="form-control"  name="phone_1" value="{$profile['phone_1']}" />
                            </div>
                            <div class="form-group col-xs-6">
                                <label>Telefone Residencial:</label>
                                <input type="text" class="form-control"  name="phone_2" value="{$profile['phone_2']}" />
                            </div>
                            <div class="form-group col-xs-6">
                                <label id="street_address">Endereço:</label>
                                <input type="text" class="form-control" name="street_address" value="{$profile['street_address']}" />
                            </div>
                            <div class="form-group col-xs-6">
                                <label id="street_address">Numero:</label>
                                <input type="text" class="form-control" name="street_number" value="{$profile['street_number']}" />
                            </div>
                            <div class="form-group col-xs-6">
                                <label id="street_address">Complemento:</label>
                                <input type="text" class="form-control" name="street_additional" value="{$profile['street_additional']}" />
                            </div>
                            <div class="form-group col-xs-6">
                                <label id="street_address">Bairro:</label>
                                <input type="text" class="form-control" name="hood" value="{$profile['hood']}" />
                            </div>
                            <div class="form-group col-xs-6">
                                <label id="street_address">Cidade:</label>
                                <input type="text" class="form-control" name="city" value="{$profile['city']}" />
                            </div>
                        </div>
                    </div>

                </div><!-- /.box-body -->
            </div><!-- /.box -->
        </div><!-- /.col -->
</form>
</div>

{include "profile/usercredentials.tpl"}