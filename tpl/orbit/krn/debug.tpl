<!--
    Debugger Template

    This template renders when debugger
    function is called

    Author: Elvis D'Andrea
    E-mail: elvis.vista@gmail.com
-->
<div class="box box-solid">
    <div class="box-body pad table-responsive">
        <h1>Debugger</h1>
    </div><!-- /.box -->
</div><!-- /.col -->
<div class="row">

    <div class="col-md-12">
        <div class="box center-block">
            <div class="box-header">
                <h3 class="box-title">Função: {$trace[2]['class']}::{$trace[2]['function']}, Arquivo: {$trace[1]['file']}, Linha: {$trace[1]['line']}</h3>
            </div><!-- /.box-header -->
            <div class="box-body">
                <pre>{print_r($mixed, true)}
                </pre>
                {foreach from=$trace item="action"}
                    <hr>
                    <ul>
                        <li>File: {$action['file']}</li>
                        <li>Line: {$action['line']}</li>
                        <li>Class: {$action['class']}</li>
                        <li>Function: {$action['function']}</li>
                    </ul>
                {/foreach}
            </div>
        </div>
    </div>