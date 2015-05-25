<div id="plates">
    {foreach from=$plates key="plate_id" item="plate"}
    <div class="box">
        <div class="box-header">
        </div>
            <div class="box-body">
                <div class="input-group">
                    <a id="change-{$plate_id}" class="btn btn-primary" href="{$smarty.const.BASEDIR}request/changerequest?request_id={$request_id}&plate_id={$plate_id}">Adicionar itens a este prato</a>
                </div>
                <div class="input-group col-md-12">
                    <div id="search-{$plate_id}"></div>
                    <div id="product-results_{$plate_id}"></div>
                </div><!-- /.input group -->
                <div class="input-group col-md-12">
                    <table id="plate_{$plate_id}" class="table table-striped">
                        <tbody>
                        {foreach from=$plate key="item_id" item="item"}
                            <tr id="{$plate_id}_{$item['id']}">
                                <td><img  src="{$item['image']}" width="50px" alt="{$item['product_name']}" /></td>
                                <td>{$item['product_name']}</td>
                                <td>{$item['category_name']}</td>
                                <td>
                                    <button onclick="Main.quickLink('{$smarty.const.BASEDIR}request/dropitemportion?id={$item['id']}&amount={$item['product_weight']}&plate_id={$plate_id}&request_id={$request_id}')" class="btn btn-primary"><i class="fa fa-minus-circle"></i></button>
                                    <label id="amount_{$plate_id}_{$item['id']}" style="width: 60px; text-align: center;">{$item['weight']}{$item['unit']}</label>
                                    <button onclick="Main.quickLink('{$smarty.const.BASEDIR}request/additemportion?id={$item['id']}&amount={$item['product_weight']}&plate_id={$plate_id}&request_id={$request_id}')" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button>
                                </td>
                                <td id="price_{$plate_id}_{$item['id']}">{String::convertTextFormat($item['price'], 'currency')}</td>
                                <td><button type="button" class="btn label btn-danger" onclick="Main.quickLink('{$smarty.const.BASEDIR}request/removeitem?id={$item['id']}&row_id={$plate_id}_{$item['id']}&request_id={$request_id}')">Retirar</button></td>
                            </tr>
                        {/foreach}
                        </tbody>
                    </table>
                </div>
        </div>
    </div>
    {/foreach}
</div>