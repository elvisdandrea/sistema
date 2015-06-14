<li>
    <span class="request-item-number bg-orange">01</span>
    <div class="request-item">
        <div class="box box-solid">
            <!-- -->
            <div class="box-header">
                <h5>
                    Tamanho ou tipo do prato:
                    <select class="form-control" name="plate_name" onchange="Main.quickLink('{$smarty.const.BASEDIR}request/setplatesize?id=' + this.value + '&request_id={$request_id}&plate_id={$plate_id}&action=selproductnew')">
                        {foreach from=$plate_types item="row"}
                            <option value="{$row['id']}">{$row['plate_name']} ({$row['plate_size']}g)</option>
                        {/foreach}
                    </select>
                </h5>
                <div class="controller-tools">
                    <button data-original-title="Esconder o prato" class="btn btn-primary btn-sm" data-widget="collapse" data-toggle="tooltip" title=""><i class="fa fa-minus"></i></button>
                    <button data-original-title="Deletar" class="btn btn-danger btn-sm" data-widget="remove" data-toggle="tooltip" title=""><i class="fa fa-trash-o"></i></button>
                </div>
            </div>
            <!-- -->
            <div class="box-body" id="plate_{$plate_id}">
                <div class="input-group input-group-sm">
                    <span class="input-group-addon">
                        <i class="fa fa-cutlery"></i>
                    </span>
                    <input class="form-control" id="searchproduct-{$plate_id}" type="text" value="" placeholder="Pesquise um item..." onkeyup="searchClient(event, '{$smarty.const.BASEDIR}request/searchproduct?search=' + this.value + '&request_id={$request_id}&plate_id={$plate_id}{if (isset($action))}&action={$action}{/if}')"/>
                    <div id="product-results_{$plate_id}"></div>
                </div>
                <hr>
            </div>
        </div>
    </div>
</li>