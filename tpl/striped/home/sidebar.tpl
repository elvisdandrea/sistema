<div id="sidebar">

    <!-- Logo -->
    <h1 id="logo"></h1>

    <!-- Nav -->
    <nav id="nav">
        <ul>
            <li class="current"><a href="#">Pedidos</a></li>
            <li><a href="#">Clientes</a></li>
            <li><a href="#">Produtos</a></li>
            <li><a href="#">Configurar</a></li>
            <li><a href="{$smarty.const.BASEDIR}home/logout">Sair</a></li>
        </ul>
    </nav>

    <!-- Search -->
    {include "home/sidebar_search.tpl"}


    <!-- Calendar -->
    {include "home/calendar.tpl"}

    <!-- Text -->
    {include "home/sidebar_msg.tpl"}

    <!-- Copyright -->
    <ul id="copyright">
        <li>&copy; GRAVI Systems.</li><li><a href="http://gravi.com.br">Gravi</a></li>
    </ul>

</div>