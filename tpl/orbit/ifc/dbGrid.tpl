<!--
    DB Grid Template

    This template renders a table with the content of
    a Model DBGrid with the selected properties

    Author: Elvis D'Andrea
    E-mail: elvis.vista@gmail.com
-->
<div class="box-body">
    
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