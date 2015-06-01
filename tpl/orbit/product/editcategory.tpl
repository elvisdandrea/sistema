<div class="modal fade" id="compose-modal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title"><i class="fa map-marker"></i> Editar categorias</h4>
            </div>
                <div class="modal-body">
                    <label>Nova categoria</label>
                    <form action="{$smarty.const.BASEDIR}product/addcategory" method="post">
                        <div class="input-group">
                                <input type="text" name="category_name" class="form-control" style="height:31px" placeholder="Adicionar uma nova categoria">
                                <div class="input-group-btn">
                                    <button type="submit" class="btn btn-success">Adicionar</button>
                                </div><!-- /btn-group -->
                        </div><!-- /input-group -->
                    </form>
            <hr />
            <div id="categorytable">
                {include "product/editcategorytable.tpl"}
            </div>
        </div>
        <div class="modal-footer clearfix">
            <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
            <!--<button type="submit" class="btn btn-success pull-left">Salvar alterações</button>-->
        </div>
    </div><!-- /.modal-content -->
</div><!-- /.modal-dialog -->
</div><!-- /.modal -->