<form id="addproduct" action="{$smarty.const.BASEDIR}product/addproduct"  changeurl="{$smarty.const.BASEDIR}product" >

<div class="col-md-12">

    <!-- Conteúdo principal -->
    <div class="row">

        <div class="col-md-8 col-sm-8">
            <div class="box">
                <div class="box-header">
                    <h3 class="box-title">Dados do produto</h3>
                </div><!-- /.box-header -->
                
                <hr />
                <div style="padding: 0 25px;">
                    <label>Qual a categoria desse produto?</label>
                    <div class="input-group">
                        <div class="input-group-addon">
                            <i class="fa fa-list"></i>
                        </div>
                        <input id="category_id" type="text" name="category_id" data-id="" value="" class="form-control" placeholder="Localizar uma categoria" data-toggle="dropdown" />
                        {include "product/categorylist.tpl"}
                    </div>
                </div>
                <hr />

                <div class="box-body">
                    <!-- Cadastro do produto -->
                    <div class="row">
                        <div class="form-group col-md-12">
                            <h5>Dados complementares do produto</h5>
                            <div class="form-group col-md-12 col-sm-12 col-xs-12">
                                <label>Nome:</label>
                                <input name="nome" type="text" class="form-control" />
                            </div>
                            <div class="form-group col-md-6 col-sm-6 col-xs-6">
                                <label>Peso/Volume:</label>
                                <input name="weight" type="text" class="form-control" format="currency" data-affixes-stay="true" data-prefix="" data-thousands="." data-decimal=","/>
                            </div>
                            <div class="form-group col-md-6 col-sm-6 col-xs-6">
                                <label>Tipo da medida:</label>
                                <select class="form-control"  id="unit_id" name="unit" >
                                    <option value="Gramas">Gramas</option>
                                    <option value="Kilos">Kilos</option>
                                    <option value="Litros">Litros</option>
                                </select>
                            </div>
                            <div class="form-group col-md-6 col-sm-6 col-xs-6">
                                <label>Valor de venda:</label>
                                <input name="price" type="text" class="form-control" format="currency" data-affixes-stay="true" data-prefix="R$ " data-thousands="." data-decimal="," />
                            </div>
                            <div class="form-group col-md-6 col-sm-6 col-xs-6">
                                <label>Valor de custo:</label>
                                <input name="cost" type="text" class="form-control" format="currency" data-affixes-stay="true" data-prefix="R$ " data-thousands="." data-decimal=","/>
                            </div>
                            <div class="form-group col-md-12 col-sm-12 col-xs-12">
                                <label>Características:</label>
                                <select id="charac" name="charac" class="form-control" multiple data-placeholder="Separe cada característica usando vírgula (,)">
                                    {foreach from=$characList item="row"}
                                        <option value="{$row['charac']}">{$row['charac']}</option>
                                    {/foreach}
                                </select>
                            </div>
                            <div class="form-group col-xs-12">
                                <label>Descrição:</label>
                                <textarea name="description" class="form-control" rows="3"></textarea>
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
                    <img type="upload" id="product-img" name="image64" src="{$smarty.const.T_IMGURL}/no-image.jpg" class="image-user" alt="product image" style="display:block; margin:0 auto;" />

                    <div class="form-group" style="display: block; margin: 20px auto 0px; width: 150px; text-align: center;">
                        <div class="btn btn-success btn-file">
                            <i class="fa fa-upload"></i> Enviar uma imagem
                            <input id="read64" type="file" name="attachment"/>
                        </div>
                    </div>
                </div>
            </div><!-- /.box-body -->
        </div><!-- /.box -->

        <div class="col-md-12">
            <div class="panel panel-default">

                <div class="panel-heading">
                    <h3 class="box-title">Imagens</h3>
                    <button type="button" id="add-img" class="btn btn-default">Adicionar</button>
                </div>

                <div class="panel-body" id="images-holder">
                    <div class="col-md-4 col-sm-4">
                        <div class="box">

                            <div class="box-header">
                                <h3 class="box-title block">Imagem de exibição <small>Máximo: 1 MB</small></h3>
                            </div>

                            <div class="box-body">
                                <img type="upload" id="product-img1" name="product_image[]" src="{$smarty.const.T_IMGURL}/no-image.jpg" class="image-user" alt="product image" style="display:block; margin:0 auto;" />
                                <div class="form-group" style="display: block; margin: 20px auto 0px; width: 150px; text-align: center;">
                                    <div class="btn btn-success btn-file">
                                        <i class="fa fa-upload"></i> Enviar uma imagem
                                        <input class="image-upload" id="img1" type="file" name="attachment"/>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>

                </div>
            </div>
        </div>

    </div><!-- /.col -->

    <!-- Buttons (Options) -->
    <div class="box box-solid">
        <div class="box-body pad table-responsive">
            <button class="btn btn-success" title="Salvar" type="submit" style="width:150px;">Cadastrar produto</button>
            <button type="button" class="btn btn-danger" title="Cancelar" onclick="Main.quickLink('{$smarty.const.BASEDIR}product')"><i class="fa fa-times"></i></button>
        </div>
    </div>

</div> <!-- /.row -->
<!-- /.Conteúdo principal -->

{include "product/editcategory.tpl"}

</form>

<div id="product-image-template" class="hide">
    <div class="col-md-4 col-sm-4">
        <div class="box">

            <div class="box-header">
                <h3 class="box-title block">Imagem de exibição <small>Máximo: 1 MB</small></h3>
            </div>

            <div class="box-body">
                <img type="upload" id="img-tpl" name="product_image[]" src="{$smarty.const.T_IMGURL}/no-image.jpg" class="image-user" alt="product image" style="display:block; margin:0 auto;" />
                <div class="form-group" style="display: block; margin: 20px auto 0px; width: 150px; text-align: center;">
                    <div class="btn btn-success btn-file">
                        <i class="fa fa-upload"></i> Enviar uma imagem
                        <input class="image-upload" id="img-input-tpl" type="file" name="attachment"/>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>
