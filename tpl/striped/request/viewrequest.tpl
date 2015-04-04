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
        <a class="button" href="{$smarty.const.BASEDIR}request/changerequest?request_id={$request_id}">Modificar</a>
        <div id="plates">

        </div>
    </article>
</div>