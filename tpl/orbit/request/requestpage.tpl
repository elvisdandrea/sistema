<div class="top-bar">
    <a class="button small" href="{$smarty.const.BASEDIR}request/newrequest">Novo Pedido</a>
</div>
<div class="inner">
    <article class="box post post-excerpt">
        <div class="info">
            <span class="date">
                <span class="month">{String::getMonthAcronym($rows['request_month'])}</span>
                <span class="day">{$rows['request_day']}</span>
            </span>
            <ul class="stats">
                <li>
                    <a class="icon fa-coffee">{$requestCount}</a>
                </li>
            </ul>
        </div>

        <div id="request_list">
            {$request_table}
        </div>
    </article>
</div>

