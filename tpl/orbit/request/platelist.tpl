<!--<div id="plates"> -->
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
                            {foreach from=$plate_types item="row"}
                                <option {if ($row['plate_name'] == $plate_names[$plate_id])}selected="selected"{/if} value="{$row['id']}">{$row['plate_name']}({$row['plate_size']}g)</option>
                            {/foreach}
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
                        <input class="form-control" type="text" placeholder="Pesquise um item para adicionar ao prato" onkeyup="searchClient(event, '{$smarty.const.BASEDIR}request/searchproduct?search=' + this.value + '&request_id={$request_id}&plate_id={$plate_id}{if (isset($action))}&action={$action}{/if}')">
                    </div>
                    <hr />
                    <div id="product-results_{$plate_id}" style="position:relative"></div>
                    {foreach from=$plate key="item_id" item="item"}
                        <ul id="{$plate_id}_{$item['id']}" class="item-plate">
                            <li>
                                <img src="{$item['image']}" alt="{$item['product_name']}">
                            </li>
                            <li class="col-md-3 col-sm-4 col-xs-4">
                                Prato: <strong>{$item['product_name']}</strong>
                            </li>
                            <li class="col-md-5 col-sm-5 col-xs-5">
                                Categoria: <strong>{$item['category_name']}</strong>
                            </li>
                            <li class="col-md-3 col-sm-3 col-xs-3">
                                Total: <strong id="price_{$plate_id}_{$item['id']}" class="text-green">{String::convertTextFormat($item['price'], 'currency')}</strong>
                            </li>
                            <li class="col-md-12 col-sm-12 col-xs-12 qnt">
                                <button type="button" class="btn btn-primary btn-sm" onclick="Main.quickLink('{$smarty.const.BASEDIR}request/dropitemportion?id={$item['id']}&amount={$item['product_weight']}&plate_id={$plate_id}&request_id={$request_id}{if ($newrequest)}&action=selproductnew{/if}')">
                                    <i class="fa fa-minus-circle"></i>
                                </button>
                                <label id="amount_{$plate_id}_{$item['id']}" style="width: 50%; text-align: center;">{$item['weight']}{$item['unit']}</label>
                                <button type="button" class="btn btn-primary btn-sm" onclick="Main.quickLink('{$smarty.const.BASEDIR}request/additemportion?id={$item['id']}&amount={$item['product_weight']}&plate_id={$plate_id}&request_id={$request_id}{if ($newrequest)}&action=selproductnew{/if}')"><i class="fa fa-plus-circle"></i></button>
                            </li>
                            <li>
                                <a href="{$smarty.const.BASEDIR}request/removeitem?id={$item['id']}&plate_id={$plate_id}&request_id={$request_id}&row_id={$plate_id}_{$item['id']}"><i class="btn btn-danger btn-sm fa fa-times" data-toggle="tooltip" title="Remover"></i></a>
                            </li>
                        </ul>
                        <!-- Ingredientes -->
                        <div id="ingredients_{$plate_id}_{$item['id']}" class="ingredients form-group check-item">
                            <h6 style="display: inline;">Ingredientes <i class="fa fa-angle-double-right"></i>&nbsp;</h6>
                            {foreach from=$item['ingredients'] key="ingredient_id" item="ingredient"}
                                <label class="checkbox-inline">
                                    <input type="checkbox" name="item_ingredients[{$ingredient_id}]" class="select-itens" data-url="{$smarty.const.BASEDIR}request/setIngredientStatus" data-value="{$ingredient_id}" {if ($ingredient['status'] == 1)}checked{/if}/> <span>{$ingredient['ingredient_name']}</span>
                                </label>
                            {/foreach}
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
<!--</div> -->