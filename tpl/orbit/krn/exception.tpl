<!--
    Exception Template

    This template renders on the
    moments you wish it's not happening

    Author: Elvis D'Andrea
    E-mail: elvis.vista@gmail.com
-->
<div class="box box-solid">
    <div class="box-body pad table-responsive">
        <h1>Ops, algo não saiu como deveria =(</h1>
    </div><!-- /.box -->
</div><!-- /.col -->
<div class="row">

    <div class="col-md-12">
        <div class="box center-block">
            <div class="box-header">
                <h3 class="box-title">Uma execução não concluiu corretamente. Por favor, comunique nosso suporte.</h3>
            </div><!-- /.box-header -->
            <div class="box-body">
                {if (ENVDEV == '0')}
                    <img src="{$smarty.const.T_IMGURL}/orbit_big.png" title="Orbit" alt="Orbit"/>
                {else}
                    {$error['message']} <br>
                    <hr>
                    {if (isset($error['file']))}
                        File: {$error['file']} <br>
                        Line: {$error['line']}
                        <hr>
                    {/if}
                    <label>Trace:</label>
                    {foreach from=$trace item="action"}
                        {if (isset($action['file']))}
                            <hr>
                            <ul>
                                <li>File: {$action['file']}</li>
                                <li>Line: {$action['line']}</li>
                                <li>Class: {$action['class']}</li>
                                <li>Function: {$action['function']}</li>
                            </ul>
                        {/if}
                    {/foreach}
                {/if}
            </div>
        </div>
    </div>