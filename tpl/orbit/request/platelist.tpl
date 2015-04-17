{foreach from=$plates key="plate_id" item="plate"}
    <a id="change-{$plate_id}" class="btn btn-primary" href="{$smarty.const.BASEDIR}request/changerequest?request_id={$request_id}&plate_id={$plate_id}">Adicionar itens a este prato</a>
    <!--<a id="save-{$plate_id}" style="display: none;" class="btn btn-success" href="{$smarty.const.BASEDIR}request/savechange?request_id={$request_id}&plate_id={$plate_id}">Salvar Alteração</a>-->
    <div class="input-group col-md-6">

        <div id="search-{$plate_id}"></div>
        <div id="product-results_{$plate_id}"></div>
    </div><!-- /.input group -->
    <table id="plate_{$plate_id}" class="table table-striped">
        <tbody>
        {foreach from=$plate key="item_id" item="item"}
            <tr>
                <td><img  src="{$item['image']}" width="50px" alt="{$item['product_name']}" /></td>
                <td>{$item['product_name']}</td>
                <td>{$item['category_name']}</td>
                <td>{String::convertTextFormat($item['price'], 'currency')}</td>
                <td><button type="button" class="btn label btn-danger">Retirar</button></td>
            </tr>
        {/foreach}
        </tbody>
    </table>
{/foreach}