<!--
    DB Grid Template

    This template renders a table with the content of
    a Model DBGrid with the selected properties

    Author: Elvis D'Andrea
    E-mail: elvis.vista@gmail.com
-->
<div class="box-body">
    <!-- Listagem -->
    <div id="list-requests" class="list-itens">
        <button class="btn btn-sm btn-warning dropdown-toggle" data-toggle="dropdown"><i class="fa fa-star"></i> Em andamento <span class="caret"></span></button><!-- Itens -->
        <ul class="dropdown-menu" id="item-chooser">
            <li>
                <a href="#" class="text-aqua"><i class="fa fa-magic"></i>Em andamento</a>
            </li>
            <li>
                <a href="#" class="text-blue"><i class="fa fa-check-square-o"></i> Finalizado</a>
            </li>
            <li>
                <a href="#" class="text-green"><i class="fa fa-thumbs-o-up"></i>Entregue</a>
            </li>
            <li>
                <a href="#" class="text-red"><i class="fa fa-times"></i>Cancelado</a>
            </li>
        </ul>
        <!-- /.Itens -->
        <div style="width:100%">
            <a href="">
                <div class="row">
                    <div class="col-md-5 col-sm-12">
                        <i class="fa circle fa-user"></i>
                        <h5>
                            <span>Cliente:</span>&nbsp;
                            <strong>Anndré Luiz Geron Vaz</strong>
                    </h5>
                    </div>
                    <div class="col-md-7 col-sm-12">
                        <i class="fa circle fa-phone"></i>
                        <h5>
                            <span>(XX) 0000 . 0000</span> -- 
                            <span>(XX) 0000 . 0000</span> -- 
                            <span>(XX) 0000 . 0000</span> -- 
                            <span>(XX) 0000 . 0000</span>
                        </h5>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-5 col-sm-5">
                        <i class="fa circle fa-clock-o"></i>
                        <h5>
                            <span>Entrega:&nbsp;&nbsp;<strong>Segunda, 01/06/2015</strong></span>
                        </h5>
                    </div>
                    <div class="col-md-5 col-sm-5">
                        <i class="fa circle fa-usd"></i>
                        <h5>
                            <span>Valor:&nbsp;&nbsp;<strong>R$ 1234,00</strong></span>
                        </h5>
                    </div>
                    <div class="col-md-2 col-sm-12">
                        <i class="fa circle fa-angle-right"></i>
                        <h5>
                            <span>ID #1790</span>
                        </h5>
                    </div>
                </div>
            </a>
        </div>
        <a hef="" class="btn btn-default btn-sm btn-print" title="Imprimir pedido"><i class="fa fa-print"></i></a>
    </div>
    <hr/>
    
    <!-- Lista de clientes -->
    <div id="list-clients" class="list-itens">
        <div class="list-imgs">
            <img src="http://localhost/orbit/tpl/orbit/res/img/avatar.png" alt="ALTERAR O ALT PARA O NOME DO USUÁRIO" />
        </div>
        <!-- /.Itens -->
        <div style="width:100%">
            <a href="">
                <div class="row">
                    <div class="col-md-5 col-sm-12">
                        <i class="fa circle fa-user"></i>
                        <h5>
                            <span>Cliente:</span>&nbsp;
                            <strong>Anndré Luiz Geron Vaz</strong>
                    </h5>
                    </div>
                    <div class="col-md-7 col-sm-12">
                        <i class="fa circle fa-phone"></i>
                        <h5>
                            <span>(XX) 0000 . 0000</span> -- 
                            <span>(XX) 0000 . 0000</span> -- 
                            <span>(XX) 0000 . 0000</span> -- 
                            <span>(XX) 0000 . 0000</span>
                        </h5>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-5 col-sm-5">
                        <i class="fa circle fa-angle-right"></i>
                        <h5>
                            <span>CPF ou CNPJ:&nbsp;&nbsp;<strong>055.632.929-59</strong></span>
                        </h5>
                    </div>
                    <div class="col-md-7 col-sm-7">
                        <i class="fa circle fa-envelope-o"></i>
                        <h5>
                            <span>anndrevaz@gmail.com</span> -- 
                            <span>anndrevaz@outlook.com</span> -- 
                            <span>anndre@gravi.com.br</span>
                        </h5>
                    </div>
                </div>
            </a>
        </div>
    </div>
    <hr/>
    
    <!-- Tabela -->
    <table id="{$id}" class="table {$gridClass} table-responsive">

        <!--    Table Header    -->
        <thead>
        {if (!isset($showTitles) || (isset($showTitles) && $showTitles)) }
            {foreach from=$head key="field" item="data"}
                <th id="{$id}_{$data['field']}">{$data['title']}</th>
            {/foreach}
        {/if}
        </thead>


        <!--    Table Body  -->
        <tbody>

        <!--    Each Row    -->
        {foreach from=$content key="index" item="row"}
            <tr id="{$id}_{$index}"
                    {if ($rowAction != '' && $rowFieldId != '')}
                        style="cursor: pointer;"
                        onclick="Main.quickLink('{$rowAction}?{$rowFieldId}={$row[$rowFieldId]}', true, event, 'a')"
                    {/if}>


                <!--    Row Each Column -->
                {foreach from=$head key="field" item="fieldparams"}
                    <td id="{$id}_{$index}_{str_replace(array('/','.'),'_',$field)}" style="position: relative;">

                        <!--    Text Type Cell  -->
                        {if ($fieldparams['type'] == 'Text')}
                            {$row[$fieldparams['field']]}

                        <!--    DateTime Type Cell  -->
                        {elseif ($fieldparams['type'] == 'DateTime')}
                            {String::FormatDateTimeToLoad($row[$fieldparams['field']])}

                        <!--    Date Type Cell  -->
                        {elseif ($fieldparams['type'] == 'Date')}
                            {String::FormatDateToLoad($row[$fieldparams['field']])}

                        <!--    Currency Type Cell  -->
                        {elseif ($fieldparams['type'] == 'Currency')}
                            {String::convertTextFormat($row[$fieldparams['field']], 'currency')}

                        <!--    Unit Type Cell  -->
                        {elseif ($fieldparams['type'] == 'Unit')}
                            {$row[$fieldparams['field']]} {$unit}

                        <!--    Template content Type Cell  -->
                        {elseif ($fieldparams['type'] == 'Tpl')}
                            {include "{$fieldparams['field']}"}

                            <!--    Date Type Cell  -->
                        {elseif ($fieldparams['type'] == 'Time')}
                            {String::FormatTimeToLoad($row[$fieldparams['field']])}

                        <!--    Image Type Cell  -->
                        {elseif ($fieldparams['type'] == 'Image')}
                            <img width="70px" height="70px" src="{if ($row[$fieldparams['field']] != '')}{$row[$fieldparams['field']]}{else}{$smarty.const.T_IMGURL}/no-image.jpg{/if}" />
                        <!--    Input Type Cell  -->
                        {elseif ($fieldparams['type'] == 'Input')}
                            <input type="text" name="{$id}_{$index}_{$field}" value="{$row[$fieldparams['field']]}">

                        <!--    Checkbox Type Cell  -->
                        {elseif ($fieldparams['type'] == 'Checkbox')}
                            <input id="{$id}_{$index}_{$field}check" name="{$id}_{$index}_{$field}" type="checkbox" {if ($row[$fieldparams['field']] == '1')}checked="checked"{/if} />
                            <label for="{$id}_{$index}_{$field}check" >{$fieldparams['field']}</label>

                        <!--    Combobox Type Cell  -->
                        {elseif ($fieldparams['type'] == 'Select')}
                            <select name="{$id}_{$index}_{$field}">
                                {foreach from=$filedparams['listSource'] key="value" item="caption"}
                                    <option value="{$value}" {if ($value == $row[$fieldparams['field']]) }selected="selected"{/if}>{$caption}</option>
                                {/foreach}
                            </select>
                        {/if}

                        <!--    A Subtitle Content to the Cell  -->
                        {if ($fieldparams['subtitle'])}
                            <br><small style="font-weight: normal; font-size: 11px; line-height: 10px;">
                            {$row[$fieldparams['subtitle']]}
                        </small>
                        {/if}

                    <!--    Close Markups   -->
                    </td>
                {/foreach}
            </tr>
        {/foreach}
        </tbody>
    </table>
</div>