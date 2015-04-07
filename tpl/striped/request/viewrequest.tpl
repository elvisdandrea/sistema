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
                <a id="change-{$plate_id}" class="button" href="{$smarty.const.BASEDIR}request/changerequest?request_id={$request_id}&plate_id={$plate_id}">Modificar este pedido</a>
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