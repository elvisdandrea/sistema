<div class="col-md-12">
<form action="{$smarty.const.BASEDIR}client/addNewClient">
    <!-- Buttons (Options) -->
    <div class="box box-solid">
        <div class="box-body pad table-responsive">
            <button type="submit" class="btn btn-success" title="Salvar" style="width:150px;">Cadastrar cliente</button>
            <a type="button" class="btn btn-danger" title="Excluir o cliente" href="{$smarty.const.BASEDIR}client">Cancelar</i></a>
        </div><!-- /.box -->
    </div><!-- /.col -->
    <!-- /.Buttons (Options) -->

    <!-- Conteúdo principal -->
    <div class="row">

        <div class="col-md-3">
            <div class="box">
                <div class="box-header">
                    <h3 class="box-title">Imagem de exibição</h3>
                </div><!-- /.box-header -->

                <div class="box-body">
                    <img src="{$smarty.const.T_IMGURL}/no-image.jpg" name="image64" id="client-img" type="upload" class="image-user" alt="user image" style="display:block; margin:0 auto;" />

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
                <h3 class="box-title">Telefone</h3>
            </div>
            <div class="box-body">
                <div class="row">
                    <div class="half-width col-xs-9">
                        <div class="form-group col-xs-6">
                            <label>Tipo: </label>
                            <input type="text" class="form-control" name="phone_type">
                        </div>
                        <div class="form-group col-xs-6">
                            <label id="label_phone">Numero: </label>
                            <input id="new_client_phone" type="text" class="form-control" name="phone_number">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="col-md-9">
        <div class="box">
            <div class="box-header">
                <h3 class="box-title">Dados do cliente</h3>
            </div><!-- /.box-header -->

            <div class="box-body">
                <div class="row">
                    <!-- radio -->
                    <div class="form-group col-md-9">
                        <div class="radio" style="float:left; margin: 0 40px;">
                            <label>
                                <input type="radio" name="client_type" id="client_type_f" value="F" checked>
                                Cadastro de pessoa física
                            </label>
                        </div>
                        <div class="radio" style="float:left; margin:0 40px;">
                            <label>
                                <input type="radio" name="client_type" id="client_type_j" value="J">
                                Cadastro de pessoa jurídica
                            </label>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-md-9">
                        <hr /><h5 id="tipo_pessoa_label">Cliente pessoa física</h5>
                        <div class="form-group col-xs-6">
                            <label>Nome:</label>
                            <input type="text" class="form-control" name="client_name" />
                        </div>
                        <div class="form-group col-xs-6">
                            <label id="cpf_cnpj">CPF:</label>
                            <input type="text" class="form-control" name="cpf_cnpj" />
                        </div>
                        <div class="form-group col-xs-6">
                            <label>E-mail:</label>
                            <input type="text" class="form-control"  name="email" />
                        </div>
                    </div>
                    <div id="legal_entity" class="no-display form-group col-md-9">
                        <div class="form-group col-xs-6">
                            <label>Razão social:</label>
                            <input class="legal_entity_field form-control" type="text" name="corporate_name" disabled>
                        </div>
                        <div class="form-group col-xs-6">
                            <label>Inscrição estadual:</label>
                            <input class="legal_entity_field form-control" type="text" name="state_registration" disabled>
                         </div>
                        <div class="form-group col-xs-6">
                            <label>Inscrição municipal:</label>
                            <input class="legal_entity_field form-control" type="text" name="municipal_registration" disabled>
                        </div>
                        <div class="form-group col-xs-6">
                            <label>Pessoa para contato:</label>
                            <input class="legal_entity_field form-control" type="text" name="contact" disabled>
                        </div>
                    </div>
                    <div class="form-group col-md-9">
                        <div class="form-group col-xs-6">
                            <label>Descrição:</label>
                            <textarea style="width: 100%;" name="description">{$client['description']}</textarea>
                        </div>
                    </div>
                </div>

            </div><!-- /.box-body -->
        </div><!-- /.box -->
    </div><!-- /.col -->

    <div class="col-md-9 col-md-offset-3">
        <div class="box">
            <div class="box-header">
                <h3 class="box-title">Endereço</h3>
            </div>
            <div class="box-body">
                <div class="row">
                    <div class="form-group col-md-9">
                        <form action="{$smarty.const.BASEDIR}client/addClientAddr?id={$client['id']}">
                            <div class="form-group col-xs-6">
                                <label>Tipo: </label>
                                <input type="text" class="form-control" name="address_type">
                            </div>
                            <div class="form-group col-xs-6">
                                <label>CEP: </label>
                                <input type="text" class="form-control" name="zip_code" id="zip_code">
                            </div>
                            <div class="form-group col-xs-6">
                                <label>Rua: </label>
                                <input type="hidden" name="street_addr" id="street_addr">
                                <input type="text" class="form-control" disabled id="street_addr_label">
                            </div>
                            <div class="form-group col-xs-6">
                                <label>Bairro: </label>
                                <input type="hidden" name="hood" id="hood">
                                <input type="text" class="form-control" disabled id="hood_label">
                            </div>
                            <div class="form-group col-xs-6">
                                <label>Cidade: </label>
                                <input type="hidden" name="city" id="city">
                                <input type="text" class="form-control" disabled id="city_label">
                            </div>
                            <div class="form-group col-xs-6">
                                <label>Numero: </label>
                                <input type="text" class="form-control" name="street_number">
                            </div>
                            <div class="form-group col-xs-6">
                                <label>Complemento: </label>
                                <input type="text" class="form-control" name="street_additional">
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div> <!-- /.row -->
<!-- /.Conteúdo principal -->
</form>
</div><!-- ./col-md-12 -->
