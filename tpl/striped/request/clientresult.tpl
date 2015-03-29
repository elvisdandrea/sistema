<div class="result-list" >
    {foreach from=$clients key="client_id" item="client"}
        <div onclick="Main.quickLink('{$smarty.const.BASEDIR}request/selclient?id='+ {$client['id']})" style="cursor: pointer;">
            <div class="avatar-small">
                <img src="{$client['image']}" alt="avatar">
            </div>
            <label>{$client['client_name']}</label>
            <label>{$client['phone_1']}</label>
            <label>{$client['pphone_2']}</label>
            <label>{$client['email']}</label>
        </div>
    {/foreach}

</div>