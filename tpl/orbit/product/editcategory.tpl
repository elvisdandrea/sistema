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
                        <form action="{$smarty.const.BASEDIR}" method="post">
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
                        </form>
                    </div>
                    <!--
                    <div class="box-footer clearfix">
                        <ul class="pagination pagination-sm no-margin pull-right">
                            <li><a href="#">&laquo;</a></li>
                            <li><a href="#">1</a></li>
                            <li><a href="#">2</a></li>
                            <li><a href="#">3</a></li>
                            <li><a href="#">&raquo;</a></li>
                        </ul>
                    </div>
                    -->

                </div>
                <div class="modal-footer clearfix">

                    <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i></button>

                    <button type="submit" class="btn btn-success pull-left">Salvar alterações</button>
                </div>
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->