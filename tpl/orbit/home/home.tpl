<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Clientes - Orbit | Gravi</title>
	<meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
	<link href="{$smarty.const.T_CSSURL}/bootstrap.css" rel="stylesheet" type="text/css" />
	<link href="{$smarty.const.T_CSSURL}/font-awesome.min.css" rel="stylesheet" type="text/css" />
	<link href="{$smarty.const.T_CSSURL}/ionicons.min.css" rel="stylesheet" type="text/css" />
	<link href="{$smarty.const.T_CSSURL}/daterangepicker/daterangepicker-bs3.css" rel="stylesheet" type="text/css" />
	<link href="{$smarty.const.T_CSSURL}/Main.css" rel="stylesheet" type="text/css" />

	<!--[if lt IE 9]>
	<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
	<script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
	<![endif]-->
</head>
<body class="skin-blue">
<header class="header">
	<a href="index.html" class="logo">
		<img src="{$smarty.const.T_IMGURL}/logo.png" title="Orbit" alt="Orbit" />
	</a>
	<!-- Header Navbar: style can be found in header.less -->
	<nav class="navbar navbar-static-top" role="navigation">
		<!-- Sidebar toggle button-->
		<a href="#" class="navbar-btn sidebar-toggle" data-toggle="offcanvas" role="button">
			<span class="sr-only">Toggle navigation</span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
		</a>
		<div class="navbar-right">
			{include "home/notifications.tpl"}
		</div>
	</nav>
</header>
<div class="wrapper row-offcanvas row-offcanvas-left">
	{include "home/sidebar.tpl"}

	<!-- Right side column. Contains the navbar and content of the page -->
	<aside class="right-side">
		<!-- Content Header (Page header) -->
		<section id="content-header" class="content-header">
			<h1 id="page_title">
				Bem-vindo ao Orbit
			</h1>
			<ol class="breadcrumb">
				<li><a href="#"><i class="fa fa-dashboard"></i>Página inicial</a></li>
				<li class="active">Clientes</li>
			</ol>
		</section>

		<!-- Main content -->
		<section id="content" class="content">



		</section><!-- /.content -->
	</aside><!-- /.right-side -->
</div><!-- ./wrapper -->


<!-- jQuery 2.0.2 -->
<script src="{$smarty.const.JSURL}/jquery.js"></script>
<!-- Bootstrap -->
<script src="{$smarty.const.T_JSURL}/bootstrap.min.js" type="text/javascript"></script>
<!-- date-range-picker -->
<script src="{$smarty.const.T_JSURL}/AdminLTE/app.js" type="text/javascript"></script>
<script src="{$smarty.const.T_JSURL}/plugins/input-mask/jquery.inputmask.js" type="text/javascript"></script>
<script src="{$smarty.const.T_JSURL}/plugins/input-mask/jquery.inputmask.date.extensions.js" type="text/javascript"></script>
<script src="{$smarty.const.T_JSURL}/plugins/daterangepicker/daterangepicker.js" type="text/javascript"></script>
<!-- AdminLTE App -->
<script src="{$smarty.const.JSURL}/md5.js"></script>
<script src="{$smarty.const.JSURL}/html.js"></script>
<script src="{$smarty.const.JSURL}/main.js"></script>

</body>
</html>