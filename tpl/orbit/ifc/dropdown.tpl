<ul class="dropdown-menu list-clients">
    <li class="header">{$dropdownParams['title']}</li>
    <li>
        <!-- inner menu: contains the actual data -->
        <ul class="menu">
            {foreach from=$content item="row"}
                <li>
                    <a href="{$smarty.const.BASEDIR}{$dropdownParams['action']}?id={$row[$dropdownParams['field_id']]}" >
                        {if (isset($dropdownParams['field_img']) && $dropdownParams['field_img'] != '')}
                            <img src="{$row[$dropdownParams['field_img']]}" />
                        {/if}
                        {$row[$dropdownParams['field_conent']]}
                    </a>
                </li>
            {/foreach}
        </ul>
    </li>
    {if (isset({$dropdownParams['footer']}))}
        <li class="footer">
            <a href="{$smarty.const.BASEDIR}{$dropdownParams['footer']['action']}" class="btn" data-toggle="modal" data-target="#compose-modal">{$dropdownParams['footer']['text']}</a>
        </li>
    {/if}
</ul>