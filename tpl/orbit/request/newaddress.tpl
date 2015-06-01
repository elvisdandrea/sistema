<div class="modal fade" id="compose-modal-address" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title"><i class="fa map-marker"></i>Adicionar um cliente</h4>
            </div>
            <form action="{$smarty.const.BASEDIR}request/addclientaddress" method="post">
                <div class="modal-body">
                    <h4>Cliente</h4>
                    <input id="clientnewaddress" name="client_id" type="hidden" value=""/>
                    <label id="clientnamenewaddress"></label>
                    <hr/>
                    <h4>Endereço</h4>
                    <div class="row">
                        <div class="form-group">
                            <div class="col-md-6">
                                <label>Tipo:</label>
                                <select id="address_type" class="form-control" name="address_type">
                                    <option value="Residencial">Residencial</option>
                                    <option value="Comercial">Comercial</option>
                                    <option value="Outro">Outro</option>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label>Cep:</label>
                                <input type="text" name="zip_code" class="form-control" style="height:31px" placeholder="XXXXX-XX">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <label>Rua:</label>
                            <input type="text" name="street_addr" class="form-control" style="height:31px" placeholder="Endereço do cliente">
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group">
                            <div class="col-md-4">
                                <label>Número:</label>
                                <input type="text" name="street_number" class="form-control" style="height:31px" placeholder="Número">
                            </div>
                            <div class="col-md-8">
                                <label>Complemento:</label>
                                <input type="text" name="street_additional" class="form-control" style="height:31px" placeholder="Complemento">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group">
                            <div class="col-md-6">
                                <label>Bairro:</label>
                                <input type="text" name="hood" class="form-control" style="height:31px" placeholder="Bairro">
                            </div>
                            <div class="col-md-6">
                                <label>Cidade:</label>
                                <input type="text" name="city" class="form-control" style="height:31px" placeholder="Cidade">
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