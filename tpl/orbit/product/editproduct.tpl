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

<div class="modal fade" id="compose-modal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title"><i class="fa map-marker"></i> Editar categorias</h4>
            </div>
            <form action="#" method="post">
                <div class="modal-body">

                    <label>Nova categoria</label>
                    <div class="input-group">
                        <input type="text" class="form-control" style="height:31px" placeholder="Adicionar uma nova categoria">
                        <div class="input-group-btn">
                            <button type="button" class="btn btn-success">Adicionar</button>
                        </div><!-- /btn-group -->
                    </div><!-- /input-group -->

                    <hr />
                    <h5>Categorias cadastradas</h5>
                    <div class="box-body">
                        <table class="table table-striped">
                            <tr>
                                <th>Nome da categoria</th>
                                <th>Produtos</th>
                                <th>Ação</th>
                            </tr>
                            {foreach from=$categories item="category"}
                                <tr title="Ver os produtos">
                                    <td>
                                        <input type="text" class="form-control" value="{$category['category_name']}">
                                    </td>
                                    <td>
                                        {if ($category['product_count'] > 0)}
                                            {$category['product_count']} produtos dessa categoria
                                        {else}
                                            Nenhum produto
                                        {/if}
                                    </td>
                                    <td>
                                        {if ($category['product_count'] > 0)}
                                            <span class="badge" style="background-color:#FCC">Não permitida</span>
                                        {else}
                                            <button type='submit' class="btn badge bg-red" title="Deletar essa categoria">Deletar</button>
                                        {/if}
                                    </td>
                                </tr>
                            {/foreach}
                        </table>
                    </div>
                    <div class="box-footer clearfix">
                        <ul class="pagination pagination-sm no-margin pull-right">
                            <li><a href="#">&laquo;</a></li>
                            <li><a href="#">1</a></li>
                            <li><a href="#">2</a></li>
                            <li><a href="#">3</a></li>
                            <li><a href="#">&raquo;</a></li>
                        </ul>
                    </div>

                </div>
                <div class="modal-footer clearfix">

                    <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i></button>

                    <button type="submit" class="btn btn-success pull-left">Salvar alterações</button>
                </div>
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->