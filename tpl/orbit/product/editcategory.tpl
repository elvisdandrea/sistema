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
            </form>
            <hr />
            <div id="categorytable">
                {include "product/editcategorytable.tpl"}
            </div>
        </div>
        <div class="modal-footer clearfix">

            <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i></button>

            <!--<button type="submit" class="btn btn-success pull-left">Salvar alterações</button>-->
        </div>
    </div><!-- /.modal-content -->
</div><!-- /.modal-dialog -->
</div><!-- /.modal -->