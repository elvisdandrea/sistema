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
                                <div class="form-group col-xs-6">
                                    <label id="">CEP:</label>
                                    <input type="text" class="form-control" name="zip_code" value="{$station['zip_code']}"/>
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
        {include "stations/places.tpl"}
        
        <!-- Buttons (Options) -->
        <div class="box box-solid">
            <div class="box-body pad table-responsive">
                <button class="btn btn-success" title="Salvar" type="submit" style="width:150px;">Cadastrar loja</button>
                <button type="button" class="btn btn-danger" title="Cancelar" onclick="Main.quickLink('{$smarty.const.BASEDIR}stations')"><i class="fa fa-times"></i></button>
            </div><!-- /.box -->
        </div><!-- /.col -->
        
    </div> <!-- /.row -->
</form>