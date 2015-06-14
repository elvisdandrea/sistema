<div id="plates">
{foreach from=$plates key="plate_id" item="plate" name="plate_loop"}
    <li>
        <span class="request-item-number bg-orange">{$smarty.foreach.plate_loop.iteration}</span>
        <div class="request-item">
            <div class="box box-solid">
                <!-- -->
                <div class="box-header">
                    <h5>
                        Tamanho ou tipo do prato:
                        <select class="form-control">
                            <option>(Grande) 600g</option>
                            <option>(Pequeno) 300g</option>
                        </select>
                    </h5>
                    <div class="controller-tools">
                        <button class="btn btn-primary btn-sm" data-widget="collapse" data-toggle="tooltip" title="Esconder o prato"><i class="fa fa-minus"></i></button>
                        <button class="btn btn-danger btn-sm" data-widget="remove" data-toggle="tooltip" title="Deletar"><i class="fa fa-trash-o"></i></button>
                    </div>
                </div>
                <!-- -->
                <div class="box-body">
                    <div class="input-group input-group-sm">
                                                            <span class="input-group-addon">
                                                                <i class="fa fa-cutlery"></i>
                                                            </span>
                        <input class="form-control" type="text" placeholder="Pesquise um item para adicionar ao prato">
                    </div>
                    <hr />
                    {foreach from=$plate key="item_id" item="item"}
                        <ul id="{$plate_id}_{$item['id']}">
                            <li>
                                <img src="{$item['image']}" alt="{$item['product_name']}">
                            </li>
                            <li class="col-md-3 col-sm-4">
                                Prato: <strong>{$item['product_name']}</strong>
                            </li>
                            <li class="col-md-3 col-sm-4">
                                Categoria: <strong>{$item['category_name']}</strong>
                            </li>
                            <li class="col-md-2 col-sm-4">
                                Total: <strong id="price_{$plate_id}_{$item['id']}" class="text-green">{String::convertTextFormat($item['price'], 'currency')}</strong>
                            </li>
                            <li class="col-md-4 col-sm-12 qnt">
                                <button type="button" class="btn btn-primary btn-sm" onclick="Main.quickLink('{$smarty.const.BASEDIR}request/dropitemportion?id={$item['id']}&amount={$item['product_weight']}&plate_id={$plate_id}&request_id={$request_id}')">
                                    <i class="fa fa-minus-circle"></i>
                                </button>
                                <label id="amount_{$plate_id}_{$item['id']}" style="width: 50%; text-align: center;">{$item['weight']}{$item['unit']}</label>
                                <button type="button" class="btn btn-primary btn-sm" onclick="Main.quickLink('{$smarty.const.BASEDIR}request/additemportion?id={$item['id']}&amount={$item['product_weight']}&plate_id={$plate_id}&request_id={$request_id}')"><i class="fa fa-plus-circle"></i></button>
                            </li>
                            <li>
                                <i class="btn btn-danger btn-sm fa fa-times" data-toggle="tooltip" title="Remover"></i>
                            </li>
                        </ul>
                        <!-- Ingredientes -->
                        <div class="ingredients form-group check-item">
                            <h6 style="display: inline;">Ingredientes <i class="fa fa-angle-double-right"></i>&nbsp;</h6>
                            <label class="checkbox-inline">
                                <input type="checkbox" name="01" class="select-itens" /> <span>Batata</span>
                            </label>
                            <label class="checkbox-inline">
                                <input type="checkbox" name="02" class="select-itens" /> <span class="item-removed">Polenta</span>
                            </label>
                            <label class="checkbox-inline">
                                <input type="checkbox" name="03" class="select-itens" /> <span>Cebola</span>
                            </label>
                            <label class="checkbox-inline">
                                <input type="checkbox" name="04" class="select-itens" /> <span>Queijo</span>
                            </label>
                        </div>
                    {/foreach}
                </div>
                <div class="box-footer text-green">
                    Total desse prato: <strong>R$ 980,00</strong>
                </div>
            </div>
        </div>
    </li>
{/foreach}
</div>