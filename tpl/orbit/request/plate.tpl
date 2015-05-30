<div class="box">
    <div class="box-header">
    </div>
    <div class="box-body">
        <label>Tamanho/tipo do prato:</label>
        <select name="plate_name" onchange="Main.quickLink('{$smarty.const.BASEDIR}request/setplatesize?id=' + this.value + '&request_id={$request_id}&plate_id={$plate_id}&action=selproductnew')">
            {foreach from=$plate_types item="row"}
                <option value="{$row['id']}">{$row['plate_name']} ({$row['plate_size']}g)</option>
            {/foreach}
        </select>
        <div class="input-group col-md-12">
            <div class="input-group-addon">
                <i class="fa fa-cutlery"></i>
            </div>
            <input id="searchproduct-{$plate_id}" type="text" value="" placeholder="Pesquise um item..." onkeyup="searchClient(event, '{$smarty.const.BASEDIR}request/searchproduct?search=' + this.value + '&request_id={$request_id}&plate_id={$plate_id}{if (isset($action))}&action={$action}{/if}')"/>
            <div id="product-results_{$plate_id}"></div>
        </div><!-- /.input group -->
        <div class="input-group col-md-12">
            <table id="plate_{$plate_id}" class="table table-striped">
                <tbody></tbody>
            </table>
        </div>
    </div>
</div>