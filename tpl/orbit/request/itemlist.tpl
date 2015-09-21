<div class="box box-solid">
    <div class="box-body">
        <div class="input-group input-group-sm">
                            <span class="input-group-addon">
                                <i class="fa fa-cutlery"></i>
                            </span>
            <input class="form-control" type="text" placeholder="Pesquise um produto para adicionar ao pedido" onkeyup="searchClient(event, '{$smarty.const.BASEDIR}request/searchproduct?search=' + this.value + '&request_id={$request_id}{if (isset($action))}&action={$action}{/if}')">
        </div>
        <hr />
        <div id="product-results" style="position:relative"></div>
        <div class="request-item">
            <div >
                <ul class="request-itens">
                    <li id="itemlist">
                        {if (isset($request_items) && count($request_items) > 0)}
                            {foreach from=$request_items key="rowId" item="item"}
                                {include "request/item.tpl"}
                            {/foreach}
                        {/if}
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>