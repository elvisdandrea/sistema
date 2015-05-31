<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Orbit | Gravi</title>
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
    <link href="{$smarty.const.T_CSSURL}/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="{$smarty.const.T_CSSURL}/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link href="{$smarty.const.T_CSSURL}/ionicons.min.css" rel="stylesheet" type="text/css" />
    <link href="{$smarty.const.T_CSSURL}/daterangepicker/daterangepicker-bs3.css" rel="stylesheet" type="text/css" />
    <link href="{$smarty.const.T_CSSURL}/Main.login.css" rel="stylesheet" type="text/css" />

    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
</head>
<body class="skin-login">

<div class="form-box" id="login-box">
    <div class="header">
        <img src="{$smarty.const.T_IMGURL}/logo2.png" alt="Orbit | Gravi" />
    </div>
    <form action="{$smarty.const.BASEDIR}auth/login" method="post">
        <div class="body bg-gray">
            <h4 class="text-center">Bem-vindo ao Orbit. Acesse sua conta.</h4>
            <div class="form-group">
                <input id="user" type="text" name="user" class="form-control" placeholder="Usuário"/>
            </div>
            <div class="form-group">
                <input type="password" name="pass" class="form-control" placeholder="Senha"/>
            </div>
            <p><a href="#">Esqueci minha senha</a></p>
        </div>
        <div class="footer">
            <div class="form-group" style="margin-top:0">
                <input type="checkbox" name="remember_me"/> Mantenha-me conectado
            </div>
            <button type="submit" class="btn btn-primary btn-block">Acessar</button>

            <hr />

            Se ainda não é cadastrado, <a href="register.html" class="text-center">clique aqui</a>.
            <br /><br />
        </div>
    </form>
</div>

<!-- jQuery 2.0.2 -->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
<!-- Bootstrap -->
<script src="{$smarty.const.JSURL}/md5.js"></script>
<script src="{$smarty.const.JSURL}/html.js"></script>
<script src="{$smarty.const.JSURL}/main.js"></script>
<script src="{$smarty.const.T_JSURL}/bootstrap.min.js" type="text/javascript"></script>


</body>
</html>