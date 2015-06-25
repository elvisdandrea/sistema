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
                                                    <thead>
                                                        <tr>
                                                            <td class="drag-block-cell"><b>Bairros:</b> (<i>Deixe aqui os bairros que não se faz entrega por essa loja</i>)</td>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr>
                                                            <td>
                                                                <div class="row">
                                                                    <div class="col-md-12">
                                                                        <div id="" class="redips-drag col-md-2 col-sm-3 col-xs-4"><span><input type="checkbox"/>Cacupé</span></div>
                                                                        <div id="" class="redips-drag col-md-2 col-sm-3 col-xs-4"><span><input type="checkbox"/>Canasvieiras</span></div>
                                                                        <div id="" class="redips-drag col-md-2 col-sm-3 col-xs-4"><span><input type="checkbox"/>Daniela</span></div>
                                                                        <div id="" class="redips-drag col-md-2 col-sm-3 col-xs-4"><span><input type="checkbox"/>Jurerê</span></div>
                                                                        <div id="" class="redips-drag col-md-2 col-sm-3 col-xs-4"><span><input type="checkbox"/>Jurerê Internacional</span></div>
                                                                        <div id="" class="redips-drag col-md-2 col-sm-3 col-xs-4"><span><input type="checkbox"/>Ingleses do Rio Vermelho</span></div>
                                                                        <div id="" class="redips-drag col-md-2 col-sm-3 col-xs-4"><span><input type="checkbox"/>Rio Vermelho</span></div>
                                                                        <div id="" class="redips-drag col-md-2 col-sm-3 col-xs-4"><span><input type="checkbox"/>Moçambique</span></div>
                                                                        <div id="" class="redips-drag col-md-2 col-sm-3 col-xs-4"><span><input type="checkbox"/>Alambique</span></div>
                                                                        <div id="" class="redips-drag col-md-2 col-sm-3 col-xs-4"><span><input type="checkbox"/>Centro</span></div>
                                                                        <div id="" class="redips-drag col-md-2 col-sm-3 col-xs-4"><span><input type="checkbox"/>Pantanal</span></div>
                                                                        <div id="" class="redips-drag col-md-2 col-sm-3 col-xs-4"><span><input type="checkbox"/>Lagoa</span></div>
                                                                        <div id="" class="redips-drag col-md-2 col-sm-3 col-xs-4"><span><input type="checkbox"/>Trindade</span></div>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                    <thead>
                                                        <tr>
                                                            <td class="drag-block-cell"><b>Valores para entrega:</b> (<i>Arraste os bairros para a linha com o valor para entrega</i>)</td>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr>
                                                            <td class="drag-block-cell">
                                                                <table class="table table-bordered drag">
                                                                    <colgroup>
                                                                        <col class="col-lg-2 col-md-3 col-sm-3 col-xs-4"/>
                                                                        <col class="col-lg-10 col-md-9 col-sm-9 col-xs-8"/>
                                                                    </colgroup>
                                                                    <tbody>
                                                                        <!-- Faixa de preço -->
                                                                        <tr><td class="drag-block-cell"><span class="title">Entrega grátis</span></td><td></td></tr>
                                                                        <!-- Faixa de preço -->
                                                                        <tr><td class="drag-block-cell"><span class="title">R$ 1,00</span></td><td></td></tr>
                                                                        <!-- Faixa de preço -->
                                                                        <tr><td class="drag-block-cell"><span class="title">R$ 2,00</span></td><td></td></tr>
                                                                        <!-- Faixa de preço -->
                                                                        <tr>
                                                                            <td class="drag-block-cell">
                                                                                <span class="title">
                                                                                    <div class="input-group input-group-sm">
                                                                                        <input class="form-control" type="text" placeholder="Ex. R$ 1,00">
                                                                                        <span class="input-group-btn">
                                                                                            <button class="btn btn-info btn-flat" type="button">Salvar</button>
                                                                                        </span>
                                                                                    </div>
                                                                                </span>
                                                                            </td>
                                                                            <td>
                                                                            </td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    <tr><td><a class="btn btn-default btn-sm" id="" href="#">Adicione outra faixa de preço</a></td></tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                            
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-12">
                            <a class="btn btn-primary" id="" href="#">Adicione outra cidade</a>
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