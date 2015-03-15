<!DOCTYPE HTML>
<!--
	Gravi Systems

	Author: Elvis D'Andrea
	E-mail: elvis@gravi.com.br
-->
<html>
<head>
    <title>Gravi - O céu não é o limite</title>
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <meta name="description" content="" />
    <meta name="keywords" content="" />
    <!--[if lte IE 8]><script src="{$smarty.const.T_CSSURL}/ie/html5shiv.js"></script><![endif]-->
    <script src="{$smarty.const.JSURL}/jquery.js"></script>
    <script src="{$smarty.const.T_JSURL}/skel.min.js"></script>
    <script src="{$smarty.const.T_JSURL}/skel-layers.min.js"></script>
    <script src="{$smarty.const.T_JSURL}/init.js"></script>
    <noscript>
        <link rel="stylesheet" href="{$smarty.const.T_CSSURL}/skel.css" />
        <link rel="stylesheet" href="{$smarty.const.T_CSSURL}/style.css" />
        <link rel="stylesheet" href="{$smarty.const.T_CSSURL}/style-desktop.css" />
        <link rel="stylesheet" href="{$smarty.const.T_CSSURL}/style-wide.css" />
    </noscript>
    <!--[if lte IE 8]><link rel="stylesheet" href="{$smarty.const.T_CSSURL}/ie/v8.css" /><![endif]-->
</head>
<body class="left-sidebar">

<!-- Wrapper -->
<div id="wrapper">

    <!-- Content -->
    <div id="content">
        <div class="inner">

            <article class="box post post-excerpt">
                <header>
                    <h2>Login</h2>

                    <form method="post" action="{$smarty.const.BASEDIR}auth/login">
                        <p><label for="user">Login:</label><input type="text" id="user" name="user" /></p>
                        <p><label for="pass">Senha:</label><input type="password" id="pass" name="pass" /></p>
                        <p><input type="submit" id="login" value="Login" /></p>
                    </form>
                    <div id="msgbox"></div>
                </header>
            </article>

        </div>
    </div>


        <!-- Copyright -->
        <ul id="copyright">
            <li>&copy; GRAVI Systems.</li><li><a href="http://gravi.com.br">GRAVI</a></li>
        </ul>



</div>
<script src="{$smarty.const.JSURL}/md5.js"></script>
<script src="{$smarty.const.JSURL}/html.js"></script>
<script src="{$smarty.const.JSURL}/main.js"></script>

</body>
</html>