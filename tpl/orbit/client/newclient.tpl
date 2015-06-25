<div class="col-md-12">
<form id="client-form" action="{$smarty.const.BASEDIR}client/addNewClient" changeurl="{$smarty.const.BASEDIR}client">

    <!-- Conteúdo principal -->
    <div class="row">
        <div class="col-md-8 col-sm-12">
            <div class="box">
                <div class="box-header">
                    <h3 class="box-title">Dados do cliente</h3>
                </div><!-- /.box-header -->
                
                <hr />
                <div style="white-space: nowrap">
                    <label class="radio-inline">
                        <input type="radio" class="select-itens" name="client_type" id="client_type_f" value="F" checked /><span> Pessoa física</span>
                    </label>
                    <label class="radio-inline">
                        <input type="radio" class="select-itens" name="client_type" id="client_type_j" value="J" /><span> Pessoa jurídica</span>
                    </label>
                </div>
                <hr />

                <div class="box-body">
                    <div class="row">
                        <div class="form-group col-md-12">
                            <h5 id="tipo_pessoa_label">Cliente pessoa física:</h5>
                            <div class="form-group col-md-12">
                                <label>Nome:</label>
                                <input type="text" class="form-control" name="client_name" />
                            </div>
                            <div class="form-group col-md-6 col-sm-6">
                                <label id="cpf_cnpj">CPF:</label>
                                <input type="text" class="form-control" name="cpf_cnpj" data-url="{$smarty.const.BASEDIR}client/" />
                            </div>
                            <div class="form-group col-md-6 col-sm-6">
                                <label>E-mail:</label>
                                <input type="text" class="form-control"  name="email" />
                            </div>
                        </div>
                        <div id="legal_entity" class="hide form-group col-md-12">
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
                        <div class="form-group col-md-12">
                            <div class="form-group col-xs-12">
                                <label>Descrição:</label>
                                <textarea name="description" class="form-control" rows="3">{$client['description']}</textarea>
                            </div>
                        </div>
                    </div>

                </div><!-- /.box-body -->
            </div><!-- /.box -->
        </div><!-- /.col -->
        
        <div class="col-md-4 col-sm-4">
            <div class="box">
                <div class="box-header">
                    <h3 class="box-title block">Imagem de exibição <small>Máximo: 1 MB</small></h3>
                </div><!-- /.box-header -->

                <div class="box-body">
                    <img src="{$smarty.const.T_IMGURL}/no-image.jpg" name="image64" id="client-img" type="upload" class="image-user" alt="user image" style="display:block; margin:0 auto;" />

                    <div class="form-group" style="display: block; margin: 20px auto 0px; width: 150px; text-align: center;" >
                        <div class="btn btn-success btn-file">
                            <i class="fa fa-upload"></i> Enviar uma imagem
                            <input id="read64" type="file" />
                        </div>
                    </div>
                    <div class="form-group" style="display: block; margin: 20px auto 0px; width: 150px; text-align: center;">
                        <a class="btn btn-info" onclick="openFBSearch()">Localizar no Facebook</a>
                    </div>
                </div>
            </div><!-- /.box-body -->
        </div><!-- /.box -->

        <div class="col-md-8 col-sm-8">
            <div class="box">
                <div class="box-header">
                    <h3 class="box-title">Endereço</h3>
                </div>
                <div class="box-body">
                    <div class="row">

                        <div class="col-md-12">
                            <div class="box box-solid">
                                <div class="box-header">
                                    <h5 class="box-title" style="font-size:12px; line-height:4; padding:0 0 0 10px;">Endereço residencial - 88107-455</h5>
                                    <div class="box-tools pull-right">
                                        <button data-original-title="Mostrar/Ocultar" class="btn btn-default btn-sm" data-widget="collapse" data-toggle="tooltip" title=""><i class="fa fa-minus"></i></button>
                                        <button data-original-title="Deletar" class="btn btn-default btn-sm text-red" data-widget="remove" data-toggle="tooltip" title=""><i class="fa fa-times"></i></button>
                                    </div>
                                </div>
                                <div class="box-body">
                                    <div class="row">
                                        
                                        <div class="form-group col-md-12">
                                            <form action="{$smarty.const.BASEDIR}client/addClientAddr?id={$client['id']}">
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
                                            </form>
                                        </div>
                                        
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-12">
                            <a class="btn btn-primary" id="new_phone" href="#">Adicionar outro telefone</a>
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-4 col-sm-4">
        </div><!-- /.box -->
        
        <div class="col-md-8 col-sm-8">
            <div class="box">
                <div class="box-header">
                    <h3 class="box-title">Telefone</h3>
                </div>
                <div class="box-body">
                    <div class="row">

                        <div class="col-md-12">
                            <div class="box box-solid">
                                <!--<div class="box-header">
                                    <h5 class="box-title" style="font-size:12px; line-height:4; padding:0 0 0 10px;">Telefone residencial - (48) 9988 - 0099</h5>
                                    <div class="box-tools pull-right">
                                        <button data-original-title="Mostrar/Ocultar" class="btn btn-default btn-sm" data-widget="collapse" data-toggle="tooltip" title=""><i class="fa fa-minus"></i></button>
                                        <button data-original-title="Deletar" class="btn btn-default btn-sm text-red" data-widget="remove" data-toggle="tooltip" title=""><i class="fa fa-times"></i></button>
                                    </div>
                                </div>-->
                                <div class="box-body">
                                    <div class="row">
                                        <div class="form-group col-md-6 col-sm-6 col-xs-6">
                                            <label>Tipo: </label>
                                            <select class="form-control input-sm" name="phone_type">
                                                <option value="Residencial">Residencial</option>
                                                <option value="Comercial">Comercial</option>
                                                <option value="Celular">Celular</option>
                                                <option value="Recado">Recado</option>
                                                <option value="Whatsapp">Whatsapp</option>
                                                <option value="Outro">Outro</option>
                                            </select>
                                        </div>
                                        <div class="form-group col-md-6 col-sm-6 col-xs-6">
                                            <label>Número: </label>
                                            <input id="new_client_phone" type="text" class="form-control input-sm" name="phone_number" data-url="{$smarty.const.BASEDIR}client/checkPhoneExists">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!--<div class="col-md-12">
                            <a class="btn btn-primary" id="new_phone" href="#">Adicionar outro telefone</a>
                        </div>-->

                    </div>
                </div>
            </div>
        </div>

    </div> <!-- /.row -->
    <!-- /.Conteúdo principal -->
    
    <!-- Buttons (Options) -->
    <div class="box box-solid">
        <div class="box-body pad table-responsive">
            <button type="submit" class="btn btn-success" onclick="$('#client-form').submit()" title="Cadastrar o cliente" style="width:150px;">Cadastrar cliente</button>
            <a type="button" class="btn btn-danger" title="Cancelar" href="{$smarty.const.BASEDIR}client"><i class="fa fa-times"></i></a>
        </div>
    </div>
    
</form>
</div><!-- ./col-md-12 -->
