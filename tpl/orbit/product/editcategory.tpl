<!-- Alteração das categorias -->
<div class="modal fade" id="editar-categorias" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title"><i class="fa fa-cutlery"></i>&nbsp; Editar categorias</h4>
            </div>
            <form action="#" method="post">
                <div class="modal-body">

                    <!-- Nova categoria -->
                    <div class="box-group" id="">

                        <div class="panel box box-primary">
                            <div class="box-header">
                                <h4 class="box-title" style="width:100%">
                                    <a data-toggle="collapse" data-parent="#accordion" href="#categorias-nova" class="btn btn-success text-white">
                                        Clique aqui e adicione uma nova categoria
                                    </a>
                                </h4>
                            </div>

                            <div id="categorias-nova" class="collapse">
                                <div class="box-body">
                                    <h5>Escolha um ícone:</h5>
                                    <br />
                                    <div class="form-group check-img">
                                        <label class="col-md-2 col-sm-2">
                                            <img src="img/icons-food/01.png" />
                                            <input type="radio" name="ico-food" class="icons-btn"/>
                                        </label>
                                        <label class="col-md-2 col-sm-2">
                                            <img src="img/icons-food/02.png" />
                                            <input type="radio" name="ico-food" class="icons-btn"/>
                                        </label>
                                        <label class="col-md-2 col-sm-2">
                                            <img src="img/icons-food/03.png" />
                                            <input type="radio" name="ico-food" class="icons-btn"/>
                                        </label>
                                        <label class="col-md-2 col-sm-2">
                                            <img src="img/icons-food/04.png" />
                                            <input type="radio" name="ico-food" class="icons-btn"/>
                                        </label>
                                        <label class="col-md-2 col-sm-2">
                                            <img src="img/icons-food/05.png" />
                                            <input type="radio" name="ico-food" class="icons-btn"/>
                                        </label>
                                        <label class="col-md-2 col-sm-2">
                                            <img src="img/icons-food/06.png" />
                                            <input type="radio" name="ico-food" class="icons-btn"/>
                                        </label>
                                        <label class="col-md-2 col-sm-2">
                                            <img src="img/icons-food/07.png" />
                                            <input type="radio" name="ico-food" class="icons-btn"/>
                                        </label>
                                        <label class="col-md-2 col-sm-2">
                                            <img src="img/icons-food/08.png" />
                                            <input type="radio" name="ico-food" class="icons-btn"/>
                                        </label>
                                        <label class="col-md-2 col-sm-2">
                                            <img src="img/icons-food/09.png" />
                                            <input type="radio" name="ico-food" class="icons-btn"/>
                                        </label>
                                        <label class="col-md-2 col-sm-2">
                                            <img src="img/icons-food/10.png" />
                                            <input type="radio" name="ico-food" class="icons-btn"/>
                                        </label>
                                        <label class="col-md-2 col-sm-2">
                                            <img src="img/icons-food/11.png" />
                                            <input type="radio" name="ico-food" class="icons-btn"/>
                                        </label>
                                        <label class="col-md-2 col-sm-2">
                                            <img src="img/icons-food/12.png" />
                                            <input type="radio" name="ico-food" class="icons-btn"/>
                                        </label>
                                    </div>
                                    <br />
                                    <h5>Escolha um nome:</h5>
                                    <div class="input-group">
                                        <input type="text" class="form-control" style="height:31px" placeholder="Digite o nome da categoria">
                                        <div class="input-group-btn">
                                            <button type="button" class="btn btn-success">Adicionar</button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <!-- -->
                        <div class="panel box box-primary">
                            <div class="box-header">
                                <h4 class="box-title" style="width:100%">
                                    <a data-toggle="collapse" data-parent="#accordion" href="#categorias-listagem" class="block">
                                        Listagem das categorias cadastradas
                                    </a>
                                </h4>
                            </div>

                            <div id="categorias-listagem" class="panel-collapse collapse in">
                                <div class="box-body">
                                    <div class="box-body">
                                        <table class="table table-striped">
                                            <tr>
                                                <th>Nome da categoria</th>
                                                <th>Produtos</th>
                                                <th>Ação</th>
                                            </tr>
                                            <tr title="Ver os produtos">
                                                <td>
                                                    <input type="text" class="form-control" value="Prato principal">
                                                </td>
                                                <td>
                                                    12 produtos dessa categoria
                                                </td>
                                                <td><span class="badge" style="background-color:#FCC">Não permitida</span></td>
                                            </tr>
                                            <tr style="cursor: not-allowed" title="Nenhum produto para visualizar">
                                                <td>
                                                    <input type="text" class="form-control" value="Prato do principe">
                                                </td>
                                                <td>
                                                    Nenhum
                                                </td>
                                                <td><button type='submit' class="btn badge bg-red" title="Deletar essa categoria">Deletar</button></td>
                                            </tr>
                                            <tr title="Ver os produtos">
                                                <td>
                                                    <input type="text" class="form-control" value="Prato principal">
                                                </td>
                                                <td>
                                                    2 produtos dessa categoria
                                                </td>
                                                <td><span class="badge" style="background-color:#FCC">Não permitida</span></td>
                                            </tr>
                                            <tr title="Ver os produtos">
                                                <td>
                                                    <input type="text" class="form-control" value="Prato principal">
                                                </td>
                                                <td>
                                                    1 produtos dessa categoria
                                                </td>
                                                <td><span class="badge" style="background-color:#FCC">Não permitida</span></td>
                                            </tr>
                                            <tr title="Ver os produtos">
                                                <td>
                                                    <input type="text" class="form-control" value="Prato principal">
                                                </td>
                                                <td>
                                                    12 produtos dessa categoria
                                                </td>
                                                <td><span class="badge" style="background-color:#FCC">Não permitida</span></td>
                                            </tr>
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
                            </div>

                        </div>

                    </div>

                </div>
                <div class="modal-footer clearfix">

                    <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i></button>

                    <button type="submit" class="btn btn-success pull-left">Salvar alterações</button>
                </div>
            </form>
        </div>
    </div>
</div>