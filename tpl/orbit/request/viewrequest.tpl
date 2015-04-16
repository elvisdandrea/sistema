<div class="top-bar">
    <div class="buttons">
        <a class="button button-red" href="{$smarty.const.BASEDIR}request">Voltar</a>
        <a class="button button-yellow" href="{$smarty.const.BASEDIR}request">Encaminhar para entrega</a>
    </div>
    <div class="alert alert-error" id="message" style="display: none"></div>
</div>
<div class="inner">
    <article class="box post post-excerpt">
        <div class="info">
            <span class="date">
                <span class="month">{String::getMonthAcronym($request['request_month'])}</span>
                <span class="day">{$request['request_day']}</span>
            </span>
            <ul class="stats">
                <li>
                    <a class="icon fa-coffee">{$requestCount}</a>
                </li>
            </ul>
        </div>

        <h2>Cliente</h2>
        <div id="client">
            {include "request/requestclient.tpl"}
        </div>
        <hr/>
        <h2>Pedido</h2>
        <div id="plates">
            {foreach from=$plates key="plate_id" item="plate"}
                <a id="change-{$plate_id}" class="button" href="{$smarty.const.BASEDIR}request/changerequest?request_id={$request_id}&plate_id={$plate_id}">Adicionar itens a este prato</a>
                <a id="save-{$plate_id}" style="display: none;" class="button button-blue" href="{$smarty.const.BASEDIR}request/savechange?request_id={$request_id}&plate_id={$plate_id}">Salvar Alteração</a>
                <hr>
                <div id="search-{$plate_id}"></div>
                <div id="product-results_{$plate_id}"></div>
                <ul id="plate_{$plate_id}" class="plate">
                    {foreach from=$plate key="item_id" item="item"}
                        <li>
                            <div class="plate-img">
                                <img src="{$item['image']}" />
                            </div>
                            <div class="plate-info">
                                <label>{$item['product_name']}</label>
                                <input type="text" name="weight" value="{$item['weight']}"/>
                            </div>
                        </li>
                    {/foreach}
                </ul>
            {/foreach}
        </div>
    </article>
</div>

<div class="col-md-12">

    <!-- Buttons (Options) -->
    <div class="box box-solid">
        <div class="box-body pad table-responsive">
            <blockquote>
                <p>Total do pedido: {$request['final_price']}</p>
                <small>{$count_plates} pratos selecionados</small>
            </blockquote>
            <!-- <button  class="btn btn-success" title="Salvar" onclick="Salvar.html" style="width:150px;">Salvar pedido</button>
            <button type="button" class="btn btn-danger" title="Cancelar o pedido" onclick="pedidos-new.html"><i class="fa fa-times"></i></button> -->
        </div><!-- /.box -->
    </div><!-- /.col -->
    <!-- /.Buttons (Options) -->

    <!-- Conteúdo ENTREGA -->
    <div class="box">
        <div class="box-header">
            <h3 class="box-title">Dados para entrega:</h3>
        </div>

        <div class="box-body">
            <!-- Data de entrega -->
            <div class="form-group">
                <label>Data da entrega:</label>
                <div class="input-group col-md-6">
                    <div class="input-group-addon">
                        <i class="fa fa-calendar"></i>
                    </div>
                    <input value="{$request['delivery_date']}" type="text" class="form-control datemask" data-inputmask="'alias': 'dd/mm/aaaa'" data-mask/>
                </div><!-- /.input group -->
            </div><!-- /.form group -->
            <!-- /.Data de entrega -->

            <!-- Cliente -->
            <div class="form-group">
                <label>Para qual cliente:</label>
                <div class="input-group col-md-6">
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
                            </ul>
                        </li>
                    </ul>
                    <!-- /.Lista de clientes -->

                </div><!-- /.input group -->
            </div><!-- /.form group -->
            <!-- /.Cliente -->

            <!-- Client profile -->
            <div class="box-body client-profile">
                <!-- chat item -->
                <div class="item">
                    <img src="{$client['image']}" alt="user image" />
                    <div class="client-dados">
                        <h5>
                            {$client['client_name']} <small>Telefones: {$client['phones']}</small>
                        </h5>
                        <a id="item-chooser-btn" class="btn btn-default btn-flat dropdown-toggle" data-toggle="dropdown">
                            <i class="fa fa-map-marker"></i> Escolha o endereço de entrega
                        </a><br />
                        <!-- Itens -->
                        <ul class="dropdown-menu list-clients" id="item-chooser">
                        {foreach from=$addressList item="address"}
                            <li>
                                <a href="#">
                                    <i {if ($address['id'] == $request['address_id'])}class="fa fa-check-circle-o"{/if}></i>
                                    {$address['address_type']}: {$address['street_addr']}, {$address['street_number']}, {$address['street_additional']}, {$address['hood']}, {$address['city']}
                                </a>
                            </li>
                        {/foreach}
                            <li class="footer"><a href="#" class="btn" data-toggle="modal" data-target="#compose-modal">Cadastre um novo endereço</a></li>
                        </ul>
                        <!-- /.Itens -->
                    </div>
                </div><!-- /.chat item -->
            </div><!-- /. Client profile -->

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
                <label>Adicione os pratos:</label>
                <div class="input-group col-md-6">
                    <div class="input-group-addon">
                        <i class="fa fa-cutlery"></i>
                    </div>
                    <input type="text" class="form-control" placeholder="Localizar um prato" data-toggle="dropdown" />

                    <!-- Lista de pratos -->
                    <ul class="dropdown-menu list-clients">
                        <li class="header">Encontrados 2 resultados para Ca</li>
                        <li>
                            <!-- inner menu: contains the actual data -->
                            <ul class="menu">
                                <li>
                                    <a href="pedido-view.html" title="Pendente">
                                        <img src="img/pedido.jpg" alt="Camarão"/>Carne | Prato principal | 100g | 22,90
                                    </a>
                                </li>
                                <li>
                                    <a href="pedido-view.html" title="Em andamento">
                                        <img src="img/pedido.jpg" alt="Carne"/>Camarão | Acompanhamento | 100g | R$ 22,00
                                    </a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                    <!-- /.Lista de pratos -->

                </div><!-- /.input group -->
            </div><!-- /.form group -->
            <!-- /.Prato -->

            <table class="table table-striped">
                <tr onclick="pedidos-view.html">
                    <td style="width: 50px"><img src="img/pedido.jpg" width="50px" alt="Frango" />
                    <td>Frango listrado com Javali</td>
                    <td>Carnes simples</td>
                    <td>
                        <select class="form-control">
                            <option>100 gramas</option>
                            <option>200 gramas</option>
                            <option>300 gramas</option>
                            <option>400 gramas</option>
                            <option>500 gramas</option>
                        </select>
                    </td>
                    <td>R$ 121,99</td>
                    <td style="text-align: center;">
                        <button type="button" class="btn label btn-danger">Excluir</button>
                    </td>
                </tr>
                <tr onclick="pedidos-view.html">
                    <td style="width: 50px"><img src="img/pedido.jpg" width="50px" alt="Jovens albaneses" />
                    <td>Jovens Albaneses</td>
                    <td>Acompanhamentos</td>
                    <td>
                        <select class="form-control">
                            <option>100 gramas</option>
                            <option>200 gramas</option>
                            <option>300 gramas</option>
                            <option>400 gramas</option>
                            <option>500 gramas</option>
                        </select>
                    </td>
                    <td>R$ 121,99</td>
                    <td style="text-align: center;">
                        <button type="button" class="btn label btn-danger">Excluir</button>
                    </td>
                </tr>
            </table>

        </div><!-- /.box-body -->

    </div><!-- /.box -->
    <!-- /.Conteúdo PEDIDO -->

    <!-- Buttons (Options) -->
    <div class="box box-solid">
        <div class="box-body pad table-responsive">
            <blockquote>
                <p>Total do pedido: R$ 800,00</p>
                <small>3 pratos selecionados</small>
            </blockquote>
            <button class="btn btn-success" title="Salvar" onclick="Salvar.html" style="width:150px;">Salvar pedido</button>
            <button type="button" class="btn btn-danger" title="Cancelar" onclick="pedidos-new.html"><i class="fa fa-times"></i></button>
        </div><!-- /.box -->
    </div><!-- /.col -->
    <!-- /.Buttons (Options) -->

</div><!-- ./col-md-12 -->