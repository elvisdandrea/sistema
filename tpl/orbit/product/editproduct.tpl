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
                <img id="product-img" name="image64" src="{$product['image']}" class="image-user" alt="user image" style="display:block; margin:0 auto;" />

                <div class="form-group" style="display: block; margin: 20px auto 0px; width: 150px; text-align: center;" />
                <div class="btn btn-success btn-file">
                    <i class="fa fa-upload"></i> Enviar uma imagem
                    <input type="file" name="attachment"/>
                </div>
                <p class="help-block">Max. XXX MB</p>
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
                        <input type="text" name="category_id" data-id="{$product['category_id']}" value="{$product['category_name']}" class="form-control" placeholder="Localizar uma categoria" data-toggle="dropdown" />
                        <div id="category-dropdown"></div>
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
                        <input type="text" class="form-control" name="weight"  value="{$product['weight']}" />
                    </div>
                    <div class="form-group col-xs-3">
                        <label>Valor:</label>
                        <input type="text" class="form-control" id="price" name="price"  value="{$product['price']}" />
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

<div class="col-md-12">
    <div class="box">
        <div class="box-header">
            <h3 class="box-title">Tabela Nutricional</h3>
        </div><!-- /.box-header -->
        <div class="row">
            <div class="form-group col-md-9">
                <label for="facts">Tipo de produto:</label><select id="fact" name="product_fact" href="{$smarty.const.BASEDIR}product/factlist" onchange="Main.quickLink('{$smarty.const.BASEDIR}product/loadnutrictionfacts?id='+this.value)"></select>
                <div id="nutriction-table"></div>
            </div>
        </div>
    </div>
</div>
</form>