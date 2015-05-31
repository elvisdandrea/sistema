<form id="addproduct" action="{$smarty.const.BASEDIR}product/addproduct"  changeurl="{$smarty.const.BASEDIR}product" >

<div class="col-md-12">

    <!-- Buttons (Options) -->
    <div class="box box-solid">
        <div class="box-body pad table-responsive">
            <button class="btn btn-success" title="Salvar" type="submit" style="width:150px;">Cadastrar produto</button>
            <button type="button" class="btn btn-danger" title="Cancelar" onclick="Main.quickLink('{$smarty.const.BASEDIR}product')"><i class="fa fa-times"></i></button>
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
                    <img type="upload" id="product-img" name="image64" src="{$smarty.const.T_IMGURL}/no-image.jpg" class="image-user" alt="product image" style="display:block; margin:0 auto;" />

                    <div class="form-group" style="display: block; margin: 20px auto 0px; width: 150px; text-align: center;">
                        <div class="btn btn-success btn-file">
                            <i class="fa fa-upload"></i> Enviar uma imagem
                            <input id="read64" type="file" name="attachment"/>
                        </div>
                    </div>
                    <p class="help-block">Max. 4 MB</p>
                </div>
            </div><!-- /.box-body -->
        </div><!-- /.box -->



        <div class="col-md-9">
            <div class="box">
                <div class="box-header">
                    <h3 class="box-title">Dados do produto</h3>
                </div><!-- /.box-header -->

                <div class="box-body">
                    <div class="row">
                        <div class="form-group col-md-9">
                            <label>Qual a categoria?</label>
                            <div class="input-group">
                                <div class="input-group-addon">
                                    <i class="fa fa-list"></i>
                                </div>
                                <input id="category_id" type="text" name="category_id" data-id="" value="" class="form-control" placeholder="Localizar uma categoria" data-toggle="dropdown" />
                                {include "product/categorylist.tpl"}
                            </div>
                        </div>
                    </div>
                    <!-- Cadastro do produto -->
                    <div class="row">
                        <div class="form-group col-md-9">
                            <hr /><h5>Dados complementares do produto</h5>
                            <div class="form-group col-xs-6">
                                <label>Nome:</label>
                                <input name="nome" type="text" class="form-control" />
                            </div>
                            <div class="form-group col-xs-3">
                                <label>Peso/Volume:</label>
                                <input name="weight" type="text" class="form-control" format="currency" data-affixes-stay="true" data-prefix="" data-thousands="." data-decimal=","/>
                            </div>
                            <div class="form-group col-xs-3">
                                <label>Medida:</label>
                                <input id="unit_id" name="unit" type="text" class="form-control" data-toggle="dropdown" value="Gramas" data-id="g"/>
                                <ul id="unit-list" class="dropdown-menu list-clients">
                                    <li class="menu">
                                        <ul class="menu">
                                            <li data-toggle="collapse" data-target="#unit-list">
                                                <a href="#" data-type="selitem" data-target="unit_id" data-id="g" data-value="Gramas" title="select">
                                                    <img src="{$smarty.const.T_IMGURL}/food-icon.png" alt="unit"/>Gramas
                                                </a>
                                                <a href="#" data-type="selitem" data-target="unit_id" data-id="kg" data-value="Kilos" title="select">
                                                    <img src="{$smarty.const.T_IMGURL}/food-icon.png" alt="unit"/>Kilos
                                                </a>
                                                <a href="#" data-type="selitem" data-target="unit_id" data-id="lt" data-value="Litros" title="select">
                                                    <img src="{$smarty.const.T_IMGURL}/food-icon.png" alt="unit"/>Litros
                                                </a>
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                            </div>
                            <div class="form-group col-xs-3">
                                <label>Valor de venda:</label>
                                <input name="price" type="text" class="form-control" format="currency" data-affixes-stay="true" data-prefix="R$ " data-thousands="." data-decimal="," />
                            </div>
                            <div class="form-group col-xs-3">
                                <label>Valor de custo:</label>
                                <input name="cost" type="text" class="form-control" format="currency" data-affixes-stay="true" data-prefix="R$ " data-thousands="." data-decimal=","/>
                            </div>
                            <div class="form-group col-xs-12">
                                <label>Ingredientes:</label>
                                <select id="ingredients" name="ingredients" style="width: 100%" multiple data-placeholder="Digite os ingredientes">
                                    {foreach from=$ingredientList item="row"}
                                        <option value="{$row['ingredient_name']}">{$row['ingredient_name']}</option>
                                    {/foreach}
                                </select>
                            </div>
                            <div class="form-group col-xs-12">
                                <label>Descrição:</label>
                                <input name="description" type="text" class="form-control" />
                            </div>
                        </div>
                    </div>

                </div><!-- /.box-body -->
            </div><!-- /.box -->
        </div><!-- /.col -->
    </div><!-- /.col -->

</div> <!-- /.row -->
<!-- /.Conteúdo principal -->

{include "product/editcategory.tpl"}

</form>