<div class="modal fade" id="compose-modal-address" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title"><i class="fa map-marker"></i>Cadastrar um novo endereço</h4>
            </div>
            <form action="{$smarty.const.BASEDIR}request/addclientaddress" method="post">
                <div class="modal-body">
                    <div class="row">
                        <div class="form-group">
                            <input type="hidden" name="client_id" id="client_id" value=""/>
                            <div class="col-md-6">
                                <label for="address_type">Tipo:</label>
                                <select id="address_type" class="form-control" name="address_type">
                                    <option value="Residencial">Residencial</option>
                                    <option value="Comercial">Comercial</option>
                                    <option value="Outro">Outro</option>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label for="zip_code">Cep:</label>
                                <input type="text" name="zip_code" id="zip_code" class="form-control" style="height:31px">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <label for="street_addr">Rua:</label>
                            <input type="text" name="street_addr" id="street_addr" class="form-control" style="height:31px">
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group">
                            <div class="col-md-4">
                                <label for="street_number">Número:</label>
                                <input type="text" name="street_number" id="street_number" class="form-control" style="height:31px">
                            </div>
                            <div class="col-md-8">
                                <label for="street_additional">Complemento:</label>
                                <input type="text" name="street_additional" id="street_additional" class="form-control" style="height:31px">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group">
                            <div class="col-md-6">
                                <label>Bairro:</label>
                                <input type="text" name="hood" id="hood" class="form-control" style="height:31px">
                            </div>
                            <div class="col-md-6">
                                <label>Cidade:</label>
                                <input type="text" name="city" id="city" class="form-control" style="height:31px">
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