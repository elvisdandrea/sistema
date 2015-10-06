{$isPessoaFisica = $client['client_type'] == 'F'}
<div class="col-md-12">
<div class="box box-solid">
    <div class="box-body pad table-responsive">
        <button type="submit" class="btn btn-success" title="Salvar" onclick="$('#client-form').submit()" style="width:150px;">Salvar alterações</button>
        <a type="button" class="btn btn-primary" title="Pedidos deste cliente" href="{$smarty.const.BASEDIR}request?client_id={$client['id']}">Pedidos deste cliente</a>
        <a type="button" class="btn btn-danger" title="Excluir o cliente" href="{$smarty.const.BASEDIR}client/removeclient"><i class="fa fa-times"></i></a>
    </div><!-- /.box -->
</div><!-- /.col -->
    <div class="row">
        <form id="client-form" action="{$smarty.const.BASEDIR}client/editClient?id={$client['id']}" changeurl="{$smarty.const.BASEDIR}client">
            <div class="col-md-4 col-sm-12">
                <div class="box">
                    <div class="box-header">
                        <h3 class="box-title">Imagem de exibição</h3>
                    </div>
                    <div class="box-body">
                        <img src="{if ($client['image'] != '')}{$client['image']}{else}{$smarty.const.T_IMGURL}/no-profile.jpg{/if}" name="image64" id="client-img" type="upload" class="image-user" alt="user image" style="display:block; margin:0 auto;" />

                        <div class="form-group" style="display: block; margin: 20px auto 0px; width: 150px; text-align: center;" >
                            <div class="btn btn-success btn-file">
                                <i class="fa fa-upload"></i> Enviar uma imagem
                                <input id="read64" type="file" />
                            </div>
                        </div>
                        <div class="form-group" style="display: block; margin: 20px auto 0px; width: 150px; text-align: center;">
                            <a class="btn btn-info" onclick="openFBSearch()">Localizar no Facebook</a>
                        </div>
                        <p class="help-block">Max. 1 MB</p>
                    </div>
                </div><!-- /.box-body -->
            </div><!-- /.box -->
            <div class="col-md-8 col-sm-12">

                <div class="box">
                    <div class="box-header">
                        <h3 class="box-title">Dados do cliente</h3>
                    </div><!-- /.box-header -->

                    <hr />
                    <div style="white-space: nowrap">
                        <label class="radio-inline">
                            <input type="radio" class="select-itens" name="client_type" id="client_type_f" value="F"{if $isPessoaFisica} checked{/if}/><span> Pessoa física</span>
                        </label>
                        <label class="radio-inline">
                            <input type="radio" class="select-itens" name="client_type" id="client_type_j" value="J"{if !$isPessoaFisica} checked{/if}/><span> Pessoa jurídica</span>
                        </label>
                    </div>
                    <hr />

                    <div class="box-body">
                        <div class="row">
                            <div class="form-group col-md-12">
                                <h5 id="tipo_pessoa_label">{if $isPessoaFisica}Cliente pessoa física{else}Cliente pessoa jurídica{/if}</h5>
                                <div class="form-group col-md-12">
                                    <label>Nome:</label>
                                    <input type="text" class="form-control" name="client_name" value="{$client['client_name']}"/>
                                </div>
                                <div class="form-group col-md-6 col-sm-6">
                                    <label id="cpf_cnpj">{if $isPessoaFisica}CPF:{else}CNPJ:{/if}</label>
                                    <input type="text" class="form-control" name="cpf_cnpj" value="{$client['cpf_cnpj']}" data-url="{$smarty.const.BASEDIR}client/" />
                                </div>
                                <div class="form-group col-md-6 col-sm-6">
                                    <label>E-mail:</label>
                                    <input type="text" class="form-control"  name="email" value="{$client['email']}" />
                                </div>
                            </div>
                            <div id="legal_entity" class="form-group col-md-12 {if $isPessoaFisica}hide{/if}">
                                <div class="form-group col-xs-6 col-sm-6">
                                    <label>Razão social:</label>
                                    <input class="legal_entity_field form-control" type="text" name="corporate_name" {if $isPessoaFisica}disabled{/if} value="{$client['corporate_name']}">
                                </div>
                                <div class="form-group col-xs-6 col-sm-6">
                                    <label>Inscrição estadual:</label>
                                    <input class="legal_entity_field form-control" type="text" name="state_registration" {if $isPessoaFisica}disabled{/if} value="{$client['state_registration']}">
                                </div>
                                <div class="form-group col-xs-6 col-sm-6">
                                    <label>Inscrição municipal:</label>
                                    <input class="legal_entity_field form-control" type="text" name="municipal_registration" {if $isPessoaFisica}disabled{/if} value="{$client['municipal_registration']}">
                                </div>
                                <div class="form-group col-xs-6 col-sm-6">
                                    <label>Pessoa para contato:</label>
                                    <input class="legal_entity_field form-control" type="text" name="contact" {if $isPessoaFisica}disabled{/if} value="{$client['contact']}">
                                </div>
                            </div>
                            <div class="form-group col-md-12">
                                <div class="form-group col-xs-12">
                                    <label>Descrição:</label>
                                    <textarea name="description" class="form-control" rows="3">{$client['description']}</textarea>
                                </div>
                            </div>
                        </div>

                    </div><!-- /.box-body -->
                </div><!-- /.box -->
            </div>

        </form>

        <div class="col-md-12 col-sm-12">
            <div class="box">
                <div class="box-header">
                    <h3 class="box-title">Endereços</h3>
                </div><!-- /.box-header -->
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
                        <th>Endereço principal</th>
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
                                    <input type="radio" name="main_addr" data-url="{$smarty.const.BASEDIR}client/changeClientMainAddr?id={$client['id']}&addr_id={$value['id']}" {if ($value['addr_main'])}checked{/if}>
                                </td>
                                <td>
                                    <a href="{$smarty.const.BASEDIR}client/removeAddr?id={$client['id']}&addr_id={$value['id']}" class="btn btn-danger"><i class="fa fa-times"></i></a>
                                </td>
                            </tr>
                        {/foreach}
                        </tbody>
                    </table>

                    <br>
                    <div class="row">
                        <div class="col-md-12">
                            <a class="btn btn-primary" id="new_addr" href="#">Adicionar outro endereço</a>
                        </div>
                    </div>

                    <div id="new_addr_form" class="box box-solid hide">
                        <div class="box-body">
                            <form action="{$smarty.const.BASEDIR}client/addClientAddr?id={$client['id']}">
                                <div class="row">
                                    <div class="form-group col-md-6 col-sm-12 col-xs-6">
                                        <label>Tipo: </label>
                                        <select class="form-control input-sm" name="address_type">
                                            <option value="Residencial">Residencial</option>
                                            <option value="Comercial">Comercial</option>
                                            <option value="Outro">Outro</option>
                                        </select>
                                    </div>
                                    <div class="form-group col-md-6 col-sm-12 col-xs-6">
                                        <label>CEP: </label>
                                        <input type="text" class="form-control input-sm" name="zip_code" id="zip_code">
                                    </div>
                                    <div class="form-group col-md-6 col-sm-12 col-xs-6">
                                        <label>Rua: </label>
                                        <input type="text" class="form-control input-sm" name="street_addr" id="street_addr">
                                    </div>
                                    <div class="form-group col-md-6 col-sm-12 col-xs-6">
                                        <label>Bairro: </label>
                                        <input type="text" class="form-control input-sm" name="hood" id="hood">
                                    </div>
                                    <div class="form-group col-md-6 col-sm-12 col-xs-6">
                                        <label>Cidade: </label>
                                        <input type="text" class="form-control input-sm" name="city" id="city">
                                    </div>
                                    <div class="form-group col-md-3 col-sm-6 col-xs-3">
                                        <label>Numero: </label>
                                        <input type="text" class="form-control input-sm" name="street_number">
                                    </div>
                                    <div class="form-group col-md-3 col-sm-6 col-xs-3">
                                        <label>Complemento: </label>
                                        <input type="text" class="form-control input-sm" name="street_additional">
                                    </div>

                                    <div class="form-group col-xs-12">
                                        <input class="btn btn-success" type="submit" value="Salvar" />
                                        <a id="cancel_addr" class="btn btn-danger" href="#"><i class="fa fa-times"></i></a>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-12 col-sm-12">
        </div><!-- /.box -->

        <div class="col-md-12 col-sm-12">
            <div class="box">
                <div class="box-header">
                    <h3 class="box-title">Telefones</h3>
                </div><!-- /.box-header -->
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
                    <br>
                    <div class="row">
                        <div class="col-md-12">
                            <a class="btn btn-primary" id="new_phone" href="#">Adicionar outro telefone</a>
                        </div>
                    </div>

                    <div id="new_phone_form" class="box box-solid hide">
                        <div class="box-body">
                            <form action="{$smarty.const.BASEDIR}client/addClientPhone?id={$client['id']}">
                                <div class="row">
                                    <div class="form-group col-md-6 col-sm-6 col-xs-6">
                                        <label>Tipo: </label>
                                        <select class="form-control" name="phone_type">
                                            <option value="Residencial">Residencial</option>
                                            <option value="Comercial">Comercial</option>
                                            <option value="Celular">Celular</option>
                                            <option value="Recado">Recado</option>
                                            <option value="Whatsapp">Whatsapp</option>
                                            <option value="Outro">Outro</option>
                                        </select>
                                    </div>
                                    <div class="form-group col-md-6 col-sm-6 col-xs-6">
                                        <label>Numero: </label>
                                        <input type="text" class="form-control input-sm" name="phone_number" data-url="{$smarty.const.BASEDIR}client/checkPhoneExists">
                                    </div>
                                </div>
                                <div class="row">
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

</div>
