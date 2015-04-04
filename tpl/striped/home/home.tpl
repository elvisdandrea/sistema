<!DOCTYPE HTML>
<html>
	<head>
		<title>Gravi Systems</title>
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
						{if (isset($page_content))}{$page_content}{/if}
					</div>

				<!-- Sidebar -->
				{include "home/sidebar.tpl"}

			</div>
		<script src="{$smarty.const.JSURL}/md5.js"></script>
		<script src="{$smarty.const.JSURL}/html.js"></script>
		<script src="{$smarty.const.JSURL}/main.js"></script>
	</body>
	<div id="loading" style="display: none;">
		<img id="loading-image" src="{$smarty.const.IMGURL}/loading.gif" alt="Loading..." />
	</div>
</html>