<div class="col-md-12">
<form action="{$smarty.const.BASEDIR}client/addNewClient">
    <!-- Buttons (Options) -->
    <div class="box box-solid">
        <div class="box-body pad table-responsive">
            <button type="submit" class="btn btn-success" title="Salvar" style="width:150px;">Cadastrar cliente</button>
            <a type="button" class="btn btn-danger" title="Excluir o cliente" href="{$smarty.const.BASEDIR}client"><i class="fa fa-times"></i></a>
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
                        <div class="radio" style="float:left; margin: 0;">
                            <label>
                                <input type="radio" name="optionsRadios" id="optionsRadios1" value="option1" checked>
                                Cadastro de pessoa física
                            </label>
                        </div>
                        <div class="radio" style="float:left; margin:0 40px;">
                            <label>
                                <input type="radio" name="optionsRadios" id="optionsRadios2" value="option2">
                                Cadastro de pessoa jurídica
                            </label>
                        </div>
                    </div>
                </div>
                <!-- Cadastro de pessoa física -->
                <div class="row">
                    <div class="form-group col-md-9">
                        <hr /><h5>Cliente pessoa física</h5>
                        <div class="form-group col-xs-6">
                            <label>Nome:</label>
                            <input type="text" class="form-control" />
                        </div>
                        <div class="form-group col-xs-6">
                            <label>CPF:</label>
                            <input type="text" class="form-control" />
                        </div>
                        <div class="form-group col-xs-6">
                            <label>E-mail:</label>
                            <input type="text" class="form-control" />
                        </div>
                        <div class="form-group col-xs-6">
                            <label>Telefone:</label>
                            <input type="text" class="form-control" />
                        </div>
                        <div class="form-group col-xs-12">
                            <label>Endereço:</label>
                            <input type="text" class="form-control" />
                        </div>
                    </div>
                </div>

            </div><!-- /.box-body -->
        </div><!-- /.box -->
    </div><!-- /.col -->

</div> <!-- /.row -->
<!-- /.Conteúdo principal -->
</form>
</div><!-- ./col-md-12 -->