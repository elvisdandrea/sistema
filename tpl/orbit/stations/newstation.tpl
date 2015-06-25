<form action="{$smarty.const.BASEDIR}stations/addnewstation" changeurl="{$smarty.const.BASEDIR}profile" >

    <div class="col-md-12">
        <!-- Conteúdo principal -->
        <div class="row">
            
            <div class="col-md-8 col-sm-8">
                <div class="box">
                    <div class="box-header">
                        <h3 class="box-title">Dados da loja</h3>
                    </div><!-- /.box-header -->

                    <div class="box-body">
                        <div class="row">
                            <div class="form-group col-md-12">
                                <div class="form-group col-md-6 col-sm-6 col-xs-6">
                                    <label>Nome:</label>
                                    <input type="text" class="form-control" name="station_name" />
                                </div>
                                <div class="form-group col-md-6 col-sm-6 col-xs-6">
                                    <label>Telefone:</label>
                                    <input type="text" class="form-control"  name="phone" />
                                </div>
                                <div class="form-group col-md-6 col-sm-6 col-xs-12">
                                    <label id="street_address">Endereço:</label>
                                    <input type="text" class="form-control" name="street_address" />
                                </div>
                                <div class="form-group col-md-3 col-sm-3 col-xs-6">
                                    <label id="street_address">Numero:</label>
                                    <input type="text" class="form-control" name="street_number" />
                                </div>
                                <div class="form-group col-md-3 col-sm-3 col-xs-6">
                                    <label id="street_address">Complemento:</label>
                                    <input type="text" class="form-control" name="street_additional" />
                                </div>
                                <div class="form-group col-md-6 col-sm-6 col-xs-6">
                                    <label id="street_address">Bairro:</label>
                                    <input type="text" class="form-control" name="hood" />
                                </div>
                                <div class="form-group col-md-6 col-sm-6 col-xs-6">
                                    <label id="street_address">Cidade:</label>
                                    <input type="text" class="form-control" name="city" />
                                </div>
                            </div>
                        </div>

                    </div><!-- /.box-body -->
                </div><!-- /.box -->
            </div><!-- /.col -->

            <div class="col-md-4 col-sm-4">
                <div class="box">
                    <div class="box-header">
                    <h3 class="box-title block">Imagem de exibição <small>Máximo: 4 MB</small></h3>
                    </div><!-- /.box-header -->

                    <div class="box-body">
                        <img type="upload" id="profile-img" name="image64" src="{$smarty.const.T_IMGURL}/no-image.jpg" class="image-user" alt="station image" style="display:block; margin:0 auto;" />

                        <div class="form-group" style="display: block; margin: 20px auto 0px; width: 150px; text-align: center;">
                            <div class="btn btn-success btn-file">
                                <i class="fa fa-upload"></i> Enviar uma imagem
                                <input id="read64" type="file" name="attachment"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
        </div>
        
        <!-- Locais de entrega -->
        <div class="row">
            <div class="col-md-12">
                <h4>Essa loja faz entregas em quais lugares?</h4>
                <hr />
            </div>
            <div class="col-md-12">
            <div class="box">
                <div class="box-body">
                    <div class="row">

                        <div class="col-md-12">
                            <div class="box box-solid">
                                <div class="box-header">
                                    <h6 style="font-size:12px; padding:10px 0 0 10px; display:inline-block">Cidade: Escolha abaixo <!-- Aqui vai o nome da cidade depois que ele esoclhe --></h6>
                                    <div class="box-tools pull-right">
                                        <button data-original-title="Mostrar/Ocultar" class="btn btn-default btn-sm" data-widget="collapse" data-toggle="tooltip" title=""><i class="fa fa-minus"></i></button>
                                        <button data-original-title="Deletar" class="btn btn-default btn-sm text-red" data-widget="remove" data-toggle="tooltip" title=""><i class="fa fa-times"></i></button>
                                    </div>
                                </div>
                                <div class="box-body">
                                    <div class="row">
                                        
                                        <div class="form-group input-group-sm col-md-12">
                                            <input type="text" class="form-control input-group-sm" placeholder="Localize uma cidade" data-toggle="dropdown" />

                                            <!-- Lista de cidades -->
                                            <ul class="dropdown-menu itens-any">
                                                <li class="header">Encontrados 3 resultados para São</li>
                                                <li>
                                                    <!-- inner menu: contains the actual data -->
                                                    <ul class="menu">
                                                        <li>
                                                            <a href="" class="pad" title="NOME DA CIDADE">São Francisco</a>
                                                        </li>
                                                        <li>
                                                            <a href="" class="pad" title="NOME DA CIDADE">São José</a>
                                                        </li>
                                                        <li>
                                                            <a href="" class="pad" title="NOME DA CIDADE">São Paulo</a>
                                                        </li>
                                                    </ul>
                                                </li>
                                            </ul>
                                            <!-- /.Lista de cidades -->

                                        </div>
                                        
                                    </div>
                                    
                                    <div class="alert alert-success alert-dismissable">
                                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true" style="font-size:12px;top:3px">Entendi</button>
                                        <b>DICA!</b>&nbsp;&nbsp; Selecione vários bairros, clique em um deles e arraste para o valor da entrega.
                                    </div>
                                    
                                    <div class="row">
                                        <div class="col-md-12">
                                            
                                            <div class="alert alert-danger alert-dismissable alert-resolution">
                                                <b>ATENÇÃO!</b>&nbsp;&nbsp; Use uma resolução superior a 640 pixels de largura para ver a tabela corretamente.
                                            </div>
                                            
                                            <div id="redips-drag">
                                                <table class="table table-bordered drag">
                                                    <colgroup>
                                                        <col class="col-lg-2 col-md-3 col-sm-3 col-xs-4"/>
                                                        <col class="col-lg-10 col-md-9 col-sm-9 col-xs-8"/>
                                                    </colgroup>
                                                    <thead>
                                                        <tr>
                                                            <td class="drag-block-cell">Bairros (Não entrega)</td>
                                                            <td class="drag-block-cell">Arraste para cá os bairros que se faz entrega</td>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr>
                                                            <td style="max-width:160px">
                                                                <div id="" class="redips-drag"><input type="checkbox"/>Cacupé</div>
                                                                <div id="" class="redips-drag"><input type="checkbox"/>Canasvieiras</div>
                                                                <div id="" class="redips-drag"><input type="checkbox"/>Daniela</div>
                                                                <div id="" class="redips-drag"><input type="checkbox"/>Jurerê</div>
                                                                <div id="" class="redips-drag"><input type="checkbox"/>Jurerê Internacional</div>
                                                                <div id="" class="redips-drag"><input type="checkbox"/>Ingleses do Rio Vermelho</div>
                                                                <div id="" class="redips-drag"><input type="checkbox"/>Rio Vermelho</div>
                                                                <div id="" class="redips-drag"><input type="checkbox"/>Moçambique</div>
                                                                <div id="" class="redips-drag"><input type="checkbox"/>Alambique</div>
                                                                <div id="" class="redips-drag"><input type="checkbox"/>Centro</div>
                                                                <div id="" class="redips-drag"><input type="checkbox"/>Pantanal</div>
                                                                <div id="" class="redips-drag"><input type="checkbox"/>Lagoa</div>
                                                                <div id="" class="redips-drag"><input type="checkbox"/>Trindade</div>
                                                            </td>
                                                            <td style="height:100%" class="drag-block-cell">
                                                                <table class="table table-bordered drag">
                                                                    <colgroup>
                                                                        <col style="width:20%"/>
                                                                        <col style="width:20%"/>
                                                                        <col style="width:20%"/>
                                                                        <col style="width:20%"/>
                                                                        <col style="width:20%"/>
                                                                    </colgroup>
                                                                    <tbody>
                                                                        <tr>
                                                                            <td><span>Entrega grátis</span></td>
                                                                            <td><span>R$ 2,00</span></td>
                                                                            <td><span>R$ 4,00</span></td>
                                                                            <td><span>R$ 6,00</span></td>
                                                                            <td><span>R$ 8,00</span></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><span>R$ 10,00</span></td>
                                                                            <td><span>R$ 12,00</span></td>
                                                                            <td><span>R$ 14,00</span></td>
                                                                            <td><span>R$ 16,00</span></td>
                                                                            <td><span>R$ 18,00</span></td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                            
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-12">
                            <a class="btn btn-primary" id="new_phone" href="#">Adicionar outra cidade</a>
                        </div>

                    </div>
                </div>
            </div>
            </div>
        </div>
        
        <!-- Buttons (Options) -->
        <div class="box box-solid">
            <div class="box-body pad table-responsive">
                <button class="btn btn-success" title="Salvar" type="submit" style="width:150px;">Cadastrar loja</button>
                <button type="button" class="btn btn-danger" title="Cancelar" onclick="Main.quickLink('{$smarty.const.BASEDIR}stations')"><i class="fa fa-times"></i></button>
            </div><!-- /.box -->
        </div><!-- /.col -->
        
    </div> <!-- /.row -->
</form>