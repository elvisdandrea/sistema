<div class="col-md-12">
    <form action="{$smarty.const.BASEDIR}request/addNewRequest?request_id={$request_id}" changeurl="{$smarty.const.BASEDIR}request">

    <!-- Conteúdo ENTREGA -->
    <div class="box">
        <div class="box-header">
            <h3 class="box-title">Dados para entrega:</h3>
        </div>

        <div class="box-body">
            
            <div class="form-group">
                <label>Para qual cliente:</label>
                <br /><br />

                <!-- Lista de clientes -->
                <div id="list-clients" class="list-itens">
                    <div class="list-imgs">
                        <img src="http://localhost/orbit/tpl/orbit/res/img/avatar.png" alt="ALTERAR O ALT PARA O NOME DO USUÁRIO" />
                    </div>
                    <!-- /.Itens -->
                    <div id="client-choose" style="">
                        <div class="row">
                            <div class="col-md-5 col-sm-12">
                                <i class="fa circle fa-user"></i>
                                <h5>
                                    <strong>Anndré Luiz Geron Vaz</strong><small> - <a href=""><i>Alterar</i></a></small>
                                </h5>
                            </div>
                            <div class="col-md-7 col-sm-12">
                                <i class="fa circle fa-phone"></i>
                                <h5>
                                    <span>(XX) 0000 . 0000</span> -- 
                                    <span>(XX) 0000 . 0000</span> -- 
                                    <span>(XX) 0000 . 0000</span> -- 
                                    <span>(XX) 0000 . 0000</span>
                                </h5>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-8 col-sm-9">
                                <a id="place-chooser-btn" class="btn btn-info dropdown-toggle no-space" data-toggle="dropdown">
                                    <i class="fa fa-map-marker"></i>&nbsp;&nbsp;Escolha o endereço de entrega
                                </a>
                                <!-- Itens -->
                                <ul class="dropdown-menu list-clients" id="item-chooser">
                                    <li>
                                        <a href="#" class="no-space">
                                            <i class="fa fa-check-circle-o"></i>&nbsp;&nbsp;
                                            Rua das Acácias Negras e Lindas, 234, Centro, Florianópolis, SC
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#" class="no-space">
                                            <i class="fa fa-check-circle-o"></i>&nbsp;&nbsp;
                                            Avenida Beira-mar, 2341, Centro, Florianópolis, SC
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#" class="no-space">
                                            <i class="fa fa-check-circle-o"></i>&nbsp;&nbsp;
                                            Rua Goianases, 831, Centro, São José, Santa Catarina
                                        </a>
                                    </li>
                                    <li class="footer"><a href="#" class="btn" data-toggle="modal" data-target="#compose-modal"><i class="fa fa-plus"></i>&nbsp;Cadastre um novo endereço</a></li>
                                </ul>
                                <!-- /.Itens -->
                            </div>
                        </div>
                    </div>
                </div>

                <div class="input-group col-md-6" style="display:none;">
                    <div class="input-group-addon">
                        <i class="fa fa-user"></i>
                    </div>
                    <input type="text" class="form-control" placeholder="Localizar um cliente" data-toggle="dropdown" />

                    <!-- Lista de clientes -->
                    <ul class="dropdown-menu list-clients">
                        <li class="header">Encontrados 2 resultados para Ann</li>
                        <li>
                            <!-- inner menu: contains the actual data -->
                            <ul class="menu">
                                <li>
                                    <a href="pedido-view.html" title="Pendente">
                                        <img src="img/avatar5.png" alt="Anndré"/>Anndré Luiz Geron Vaz | (33) 2222 - 1111 | anndre@gravi.com.br
                                    </a>
                                </li>
                                <li>
                                    <a href="pedido-view.html" title="Em andamento">
                                        <img src="img/avatar04.png" alt="Anndré"/>Anndré Júnior | (33) 2222 - 1111 | jose@gravi.com.br
                                    </a>
                                </li>
                                <li>
                                    <a href="pedido-view.html" title="Em andamento">
                                        <img src="img/avatar2.png" alt="Anndré"/>Anngela Marques | (33) 2222 - 1111 | email@gravi.com.br
                                    </a>
                                </li>
                                <li>
                                    <a href="pedido-view.html" title="Em andamento">
                                        <img src="img/avatar3.png" alt="Anndré"/>Luis Anngelo | (33) 2222 - 1111 | ivo@gravi.com.br
                                    </a>
                                </li>
                                <li>
                                    <a href="pedido-view.html" title="Em andamento">
                                        <img src="img/avatar.png" alt="Anndré"/>Marcondes de Anndrade | (33) 2222 - 1111 | malucodagravi@gravi.com.br
                                    </a>
                                </li>
                                <li>
                                    <a href="pedido-view.html" title="Em andamento">
                                        <img src="img/avatar3.png" alt="Anndré"/>(quem botaria essa droga de nome em alguém?) | (33) 2222 - 1111 | anndre@gravi.com.br
                                    </a>
                                </li>
                                <li class="footer"><a href="#" class="btn" data-toggle="modal" data-target="#compose-modal"><i class="fa fa-plus"></i>&nbsp;&nbsp;Cadastre um novo cliente</a></li>
                            </ul>
                        </li>
                    </ul>
                    <!-- /.Lista de clientes -->

                </div><!-- /.input group -->
            </div><!-- /.form group -->
            <!-- /.Cliente -->

            <!-- Cliente
            <div class="form-group" >
                <label>Para qual cliente:</label>
                <div id="searchclient" {if (isset($client))}style="display: none;" {/if}>
                    <div class="input-group col-md-6">
                        <div class="input-group-addon">
                            <i class="fa fa-user"></i>
                        </div>
                        <input type="text" class="form-control" placeholder="Localizar um cliente" onkeyup="searchClient(event, '{$smarty.const.BASEDIR}request/searchclient?search=' + this.value + '&request_id={$request_id}')" data-toggle="dropdown" />
                        <div id="client-results">

                        </div>
                    </div>
                </div>
            </div>
            <div id="client" class="form-group">
                {if (isset($client))}
                    {$client}
                {/if}
            </div>
            
            <div id="client-results">

            </div> -->

            <!-- Data de entrega -->
            <div class="form-group">
                <label>Data da entrega:</label>
                <div class="input-group col-md-6">
                    <!--
                    <span class="input-group-addon">
                        <span class="glyphicon glyphicon-calendar"></span>
                    </span> -->
                    <div class='input-group date' id='datetimepicker'>
                        <input id="datetimepicker" value="" type="text" class="form-control datemask" />
                        <input id="delivery-date" type="hidden" name="delivery_date" />
                        <span class="input-group-addon">
                            <span class="glyphicon glyphicon-calendar"></span>
                        </span>
                    </div>
                </div><!-- /.input group -->
            </div><!-- /.form group -->
            <!-- /.Data de entrega -->

        </div><!-- /.box-body -->
    </div><!-- /.box -->
    <!-- /.Conteúdo ENTREGA -->

    <!-- Conteúdo PEDIDO -->
    <div class="box">
        <div class="box-header">
            <h3 class="box-title">Monte o pedido:</h3>
        </div>

        <div class="box-body">
            <!-- Prato -->
            <div class="form-group">
                <button type="button" class="btn btn-primary" onclick="Main.quickLink('{$smarty.const.BASEDIR}request/addPlate?request_id={$request_id}&action=addplatenew')" >Adicionar um prato</button>
            </div><!-- /.form group -->
            <!-- /.Prato -->

        </div><!-- /.box-body -->

    </div><!-- /.box -->
    <!-- /.Conteúdo PEDIDO -->
        <div id="plates">

        </div>

    <!-- Buttons (Options) -->
    <div class="box box-solid">
        <div class="box-body pad table-responsive">
            <blockquote>
                <p data-id="totalprice">Total do pedido: </p>
                <small>nenhum prato adicionado</small>
            </blockquote>
            <button type="submit" class="btn btn-success" title="Salvar" style="width:150px;">Salvar pedido</button>
            <button type="button" class="btn btn-danger" title="Cancelar o pedido" onclick="Main.quickLink('{$smarty.const.BASEDIR}request')"><i class="fa fa-times"></i></button>
        </div><!-- /.box -->
    </div><!-- /.col -->
    <!-- /.Buttons (Options) -->
</form>
</div><!-- ./col-md-12 -->