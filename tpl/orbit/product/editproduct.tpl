<form id="addproduct" action="{$smarty.const.BASEDIR}product/editproduct?id={$id}"  changeurl="{$smarty.const.BASEDIR}product">
    <!-- Buttons (Options) -->
    <div class="box box-solid">
        <div class="box-body pad table-responsive">
            <button type="submit" class="btn btn-success" title="Salvar" style="width:150px;">Salvar alterações</button>
            <a type="button" class="btn btn-danger" title="Cancelar" href="{$smarty.const.BASEDIR}product">Cancelar</a>
        </div><!-- /.box -->
    </div><!-- /.col -->
    <!-- /.Buttons (Options) -->

<div class="row">
    <div class="col-md-3">
        <div class="box">
            <div class="box-header">
                <h3 class="box-title">Imagem de destaque</h3>
            </div><!-- /.box-header -->

            <div class="box-body">
                <img type="upload" id="product-img" name="image64" src="{if ($product['image'] != '')}{$product['image']}{else}{$smarty.const.T_IMGURL}/no-image.jpg{/if}" class="image-user" alt="user image" style="display:block; margin:0 auto;" />

                <div class="form-group" style="display: block; margin: 20px auto 0px; width: 150px; text-align: center;" >
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
                            <input id="category_id" type="text" name="category_id" data-id="{$product['category_id']}" value="{$product['category_name']}" class="form-control" placeholder="Localizar uma categoria" data-toggle="dropdown" />
                            {include "product/categorylist.tpl"}
                        </div>
                    </div>
                </div>
                <!-- Cadastro do produto -->
                <div class="row">
                    <div class="form-group col-md-9">
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
                                    <ul class="menu">
                                        <li data-toggle="collapse" data-target="#unit-list">
                                            <a href="#" data-type="selitem" data-target="unit_id" data-id="g" data-value="Gramas" title="select">
                                                Gramas
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#" data-type="selitem" data-target="unit_id" data-id="kg" data-value="Kilos" title="select">
                                                Kilos
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#" data-type="selitem" data-target="unit_id" data-id="lt" data-value="Litros" title="select">
                                                Litros
                                            </a>
                                        </li>
                                    </ul>
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
                        <div class="form-group col-xs-3">
                            <input name="featured" type="checkbox" {if ($product['featured'] == 1)}checked{/if} /><label>Destaque no Site</label>
                        </div>
                        <div class="form-group col-xs-3">
                            <input name="onsale" type="checkbox" /><label>Em Oferta</label>
                        </div>
                        <div class="form-group col-xs-12">
                            <label>Características:</label>
                            <select id="ingredients" name="ingredients" style="width: 100%" multiple data-placeholder="Digite os ingredientes">
                                {foreach from=$ingredientList item="row"}
                                    <option value="{$row['ingredient_name']}" {if (in_array($row['ingredient_name'], explode(',', $product['ingredients'])))}selected{/if}>{$row['ingredient_name']}</option>
                                {/foreach}
                            </select>
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
    <div class="col-md-12">
        <div class="panel panel-default">

            <div class="panel-heading">
                <h3 class="box-title">Imagens</h3>
                <div class="btn btn-success btn-file">
                    <i class="fa fa-upload">Adicionar</i>
                    <input id="image-upload" type="file" name="attachment" action="{$smarty.const.BASEDIR}product/addProductImage?id={$id}"/>
                </div>
            </div>

            <div class="panel-body" id="images-holder">
                {foreach from=$images key="key" item="value"}
                    <div class="col-md-4 col-sm-4">
                        <div class="box">

                            <div class="box-header">
                                <h3 class="box-title block">Imagem de exibição <small>Máximo: 1 MB</small></h3>
                            </div>

                            <div class="box-body">
                                <img type="upload" id="{$value['id']}" name="product_image[]" src="{$value['image']}" class="image-user" alt="product image" style="display:block; margin:0 auto;" />
                                <a type="button" class="btn btn-danger" title="Cancelar" href="{$smarty.const.BASEDIR}product/removeProductImage?id={$product['id']}&img_id={$value['id']}">Excluir</a>
                                <input type="hidden" name="image_order" value="{$value['image_order']}">
                            </div>

                        </div>
                    </div>
                {/foreach}
            </div>
        </div>
    </div>

</div>
</form>

{include "product/editcategory.tpl"}
