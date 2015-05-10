<form id="addproduct" action="{$smarty.const.BASEDIR}product/editproduct?id={$id}" >
    <!-- Buttons (Options) -->
    <div class="box box-solid">
        <div class="box-body pad table-responsive">
            <button type="submit" class="btn btn-success" title="Salvar" style="width:150px;">Salvar alterações</button>
            <a type="button" class="btn btn-danger" title="Cancelar" href="{$smarty.const.BASEDIR}product">Cancelar</i></a>
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
                <img type="upload" id="product-img" name="image64" src="{$product['image']}" class="image-user" alt="user image" style="display:block; margin:0 auto;" />

                <div class="form-group" style="display: block; margin: 20px auto 0px; width: 150px; text-align: center;" />
                <div class="btn btn-success btn-file">
                    <i class="fa fa-upload"></i> Enviar uma imagem
                    <input id="read64" type="file" name="attachment"/>
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
                        <input id="category_id" type="text" name="category_id" data-id="{$product['category_id']}" value="{$product['category_name']}" class="form-control" placeholder="Localizar uma categoria" data-toggle="dropdown" />
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
                        <input type="text" class="form-control" name="nome" value="{$product['product_name']}" />
                    </div>
                    <div class="form-group col-xs-3">
                        <label>Peso:</label>
                        <input type="text" class="form-control" name="weight"  value="{String::convertTextFormat($product['weight'],'float')}" format="currency" data-affixes-stay="true" data-prefix="" data-thousands="." data-decimal=","/>
                    </div>
                    <div class="form-group col-xs-3">
                        <label>Medida:</label>
                        <input id="unit_id" name="unit" type="text" class="form-control" data-toggle="dropdown" data-id="{$product['unit']}" value="{$unit}" data-id="g"/>
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
                        <label>Valor:</label>
                        <input type="text" class="form-control" id="price" name="price"  value="{String::convertTextFormat($product['price'], 'currency')}" format="currency" data-affixes-stay="true" data-prefix="R$ " data-thousands="." data-decimal=","/>
                    </div>
                    <div class="form-group col-xs-3">
                        <label>Valor de custo:</label>
                        <input name="cost" type="text" class="form-control"  value="{String::convertTextFormat($product['cost'], 'currency')}" format="currency" data-affixes-stay="true" data-prefix="R$ " data-thousands="." data-decimal=","/>
                    </div>
                    <div class="form-group col-xs-12">
                        <label>Descrição:</label>
                        <textarea type="text" class="form-control" name="description" >{$product['description']}</textarea>
                    </div>
                </div>
            </div>

        </div><!-- /.box-body -->
    </div><!-- /.box -->
</div><!-- /.col -->

</div> <!-- /.row -->
<!-- /.Conteúdo principal -->


<!-- nuctritional table here -->

</form>
{include "product/editcategory.tpl"}
