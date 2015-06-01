<div class="modal fade" id="compose-modal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title"><i class="fa map-marker"></i>Adicionar um cliente</h4>
            </div>
            <form action="{$smarty.const.BASEDIR}request/addclient" method="post">
                <div class="modal-body">
                    <h4>Dados do Cliente</h4>
                    <label>Nome do cliente:</label>
                    <div class="input-group col-md-12">
                        <input type="text" name="client_name" class="form-control" style="height:31px" placeholder="Nome do cliente">
                    </div>
                    <div id="fones">
                        <label>telefone:</label>
                        <div class="input-group col-md-12">
                            <input type="text" name="phone_number" class="form-control" style="height:31px" placeholder="XX XXXX-XXXX">
                            <div class="input-group-btn">
                                <button type="button" class="btn btn-info" ><i class="fa fa-plus-circle"></i></button>
                            </div>
                        </div>
                    </div>
                    <hr/>
                    <h4>Endereço</h4>
                    <div class="row">
                        <div class="form-group">
                            <div class="col-md-4">
                                <label>Cep:</label>
                                <input type="text" name="client_name" class="form-control" style="height:31px" placeholder="XXXXX-XX">
                            </div>
                            <div class="col-md-8">
                                <label>Rua:</label>
                                <input type="text" name="client_name" class="form-control" style="height:31px" placeholder="Endereço do cliente">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group">
                            <div class="col-md-4">
                                <label>Número:</label>
                                <input type="text" name="client_name" class="form-control" style="height:31px" placeholder="Número">
                            </div>
                            <div class="col-md-8">
                                <label>Complemento:</label>
                                <input type="text" name="client_name" class="form-control" style="height:31px" placeholder="Complemento">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group">
                            <div class="col-md-6">
                                <label>Bairro:</label>
                                <input type="text" name="client_name" class="form-control" style="height:31px" placeholder="Bairro">
                            </div>
                            <div class="col-md-6">
                                <label>Cidade:</label>
                                <input type="text" name="client_name" class="form-control" style="height:31px" placeholder="Cidade">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer clearfix">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                    <button type="submit" class="btn btn-success pull-left">Salvar alterações</button>
                </div>
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->