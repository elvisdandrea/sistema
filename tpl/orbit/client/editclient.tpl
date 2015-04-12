{$isPessoaFisica = $client['client_type'] == 'F'}
<div>
<form action="{$smarty.const.BASEDIR}client/editClient?id={$client['id']}">

    <!-- Buttons (Options) -->
    <div class="box box-solid">
        <div class="box-body pad table-responsive">
            <button type="submit" class="btn btn-success" title="Salvar" style="width:150px;">Salvar alterações</button>
            <a type="button" class="btn btn-primary" title="Pedidos deste cliente" href="{$smarty.const.BASEDIR}client/clientrequests">Pedidos deste cliente</a>
            <a type="button" class="btn btn-danger" title="Excluir o cliente" href="{$smarty.const.BASEDIR}client/removeclient"><i class="fa fa-times"></i></a>
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
                    <img src="{$client['image']}" name="image64" id="client-img" type="upload" class="image-user" alt="user image" style="display:block; margin:0 auto;" />

                    <div class="form-group" style="display: block; margin: 20px auto 0px; width: 150px; text-align: center;" />
                    <div class="btn btn-success btn-file">
                        <i class="fa fa-upload"></i> Enviar uma imagem
                        <input id="read64" type="file" />
                    </div>
                    <p class="help-block">Max. 1 MB</p>
                </div>
            </div><!-- /.box-body -->
        </div><!-- /.box -->

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
                                    <input type="radio" name="client_type" id="client_type_f" value="F" {if $isPessoaFisica} checked{/if}>
                                    Cadastro de pessoa física
                                </label>
                            </div>

                            <div class="radio" style="float:left; margin:0 40px;">
                                <label>
                                    <input type="radio" name="client_type" id="client_type_j" value="J" {if !$isPessoaFisica} checked{/if}>
                                    Cadastro de pessoa jurídica
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-md-9">
                            <hr /><h5>Cliente pessoa física</h5>
                            <div class="form-group col-xs-6">
                                <label>Nome:</label>
                                <input type="text" class="form-control" name="client_name" value="{$client['client_name']}"/>
                            </div>
                            <div class="form-group col-xs-6">
                                <label id="cpf_cnpj">{if $isPessoaFisica}CPF:{else}CNPJ:{/if}</label>
                                <input type="text" class="form-control" name="cpf_cnpj" value="{$client['cpf_cnpj']}" />
                            </div>
                            <div class="form-group col-xs-6">
                                <label>E-mail:</label>
                                <input type="text" class="form-control"  name="email" value="{$client['email']}" />
                            </div>
                        </div>
                        <div id="legal_entity" class="no-display form-group col-md-9" {if $isPessoaFisica} class="no-display"{/if}>
                            <div class="form-group col-xs-6">
                                <label>Razão social:</label>
                                <input class="legal_entity_field form-control" type="text" name="corporate_name" {if $isPessoaFisica}disabled{/if} value="{$client['corporate_name']}">
                            </div>
                            <div class="form-group col-xs-6">
                                <label>Inscrição estadual:</label>
                                <input class="legal_entity_field form-control" type="text" name="state_registration" {if $isPessoaFisica}disabled{/if} value="{$client['state_registration']}">
                            </div>
                            <div class="form-group col-xs-6">
                                <label>Inscrição municipal:</label>
                                <input class="legal_entity_field form-control" type="text" name="municipal_registration" {if $isPessoaFisica}disabled{/if} value="{$client['municipal_registration']}">
                            </div>
                            <div class="form-group col-xs-6">
                                <label>Pessoa para contato:</label>
                                <input class="legal_entity_field form-control" type="text" name="contact" {if $isPessoaFisica}disabled{/if} value="{$client['contact']}">
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
</form>
</div>
<div class="col-md-3">
    <div class="box">
        <div class="box-header">
            <h3 class="box-title">Telefones</h3>
        </div><!-- /.box-header -->
        <div class="form-group col-md-9">
            <a class="btn btn-primary" id="new_phone" href="#">Adicionar Telefone</a>
        </div>
        <div class="box-body">
            <table class="table table-striped">

                <thead>
                <th>Tipo</th>
                <th>Numero</th>
                <th></th>
                </thead>
                <tbody>

                {foreach from=$phoneList key="key" item="value"}

                    <tr>
                        <td>{$value['phone_type']}</td>
                        <td>{$value['phone_number']}</td>
                        <td>
                            <a href="{$smarty.const.BASEDIR}client/removePhone?id={$client['id']}&addr_id={$value['id']}" class="btn btn-danger"><i class="fa fa-times"></i></a>
                        </td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
        </div>
        <div id="new_phone_form" class="no-display">
            <div class="row">
                <!-- radio -->
                <div class="form-group col-md-9">
                    <form action="{$smarty.const.BASEDIR}client/addClientPhone?id={$client['id']}">
                        <div class="half-width">
                            <div class="form-group col-xs-12">
                                <label>Tipo: </label>
                                <input type="text" name="phone_type">
                            </div>
                            <div class="form-group col-xs-12">
                                <label>Numero: </label>
                                <input type="text" name="phone_number">
                            </div>
                            <div class="form-group col-xs-6">
                                <input class="btn btn-success" type="submit" value="Salvar" />
                                <a id="cancel_phone" class="btn btn-danger" href="#"><i class="fa fa-times"></i></a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            </div>
        </div>
    </div>
</div>

<div class="col-md-9">
    <div class="box">
        <div class="box-header">
            <h3 class="box-title">Endereços</h3>
        </div><!-- /.box-header -->
        <div class="form-group col-md-9">
            <a class="btn btn-primary" id="new_addr" href="#">Adicionar Endereço</a>
        </div>
        <div class="box-body">
            <table class="table table-striped">

                <thead>
                <th>Tipo</th>
                <th>Logradouro</th>
                <th>Numero</th>
                <th>Complemento</th>
                <th>Bairro</th>
                <th>Cidade</th>
                <th>Cep</th>
                <th></th>
                </thead>
                <tbody>

                {foreach from=$addrList key="key" item="value"}

                    <tr>
                        <td>{$value['address_type']}</td>
                        <td>{$value['street_addr']}</td>
                        <td>{$value['street_number']}</td>
                        <td>{$value['street_additional']}</td>
                        <td>{$value['hood']}</td>
                        <td>{$value['city']}</td>
                        <td>{$value['zip_code']}</td>
                        <td>
                            <a href="{$smarty.const.BASEDIR}client/removeAddr?id={$client['id']}&addr_id={$value['id']}" class="btn btn-danger"><i class="fa fa-times"></i></a>
                        </td>
                    </tr>
                {/foreach}
                </tbody>
            </table>


            <div id="new_addr_form" class="new_addr no-display">
                <div class="row">
                    <div class="form-group col-md-9">
                        <form action="{$smarty.const.BASEDIR}client/addClientAddr?id={$client['id']}">
                            <div class="form-group col-xs-6">
                                <label>Tipo: </label>
                                <input type="text" name="address_type">
                            </div>
                            <div class="form-group col-xs-6">
                                <label>CEP: </label>
                                <input type="text" name="zip_code" id="zip_code">
                            </div>
                            <div class="form-group col-xs-6">
                                <label>Rua: </label>
                                <input type="hidden" name="street_addr" id="street_addr">
                                <input type="text" disabled id="street_addr_label">
                            </div>
                            <div class="form-group col-xs-6">
                                <label>Bairro: </label>
                                <input type="hidden" name="hood" id="hood">
                                <input type="text" disabled id="hood_label">
                            </div>
                            <div class="form-group col-xs-6">
                                <label>Cidade: </label>
                                <input type="hidden" name="city" id="city">
                                <input type="text" disabled id="city_label">
                            </div>
                            <div class="form-group col-xs-6">
                                <label>Numero: </label>
                                <input type="text" name="street_number">
                            </div>
                            <div class="form-group col-xs-6">
                                <label>Complemento: </label>
                                <input type="text" name="street_additional">
                            </div>

                            <div class="form-group col-xs-12">
                                <input class="btn btn-success" type="submit" value="Salvar" />
                                <a id="cancel_addr" class="btn btn-danger" href="#"><i class="fa fa-times"></i></a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>


        </div>
    </div>

</div>


