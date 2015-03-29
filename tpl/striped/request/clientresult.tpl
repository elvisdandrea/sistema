<div class="result-list" >
    {foreach from=$clients key="client_id" item="client"}
        <div class="result-list-row" onclick="Main.quickLink('{$smarty.const.BASEDIR}request/selclient?id='+ {$client['id']})" style="cursor: pointer;">
            <div class="image avatar-small">
                <img src="{$client['image']}" alt="avatar">
            </div>
            <label>{$client['client_name']}</label>
            <label>{$client['phones']}</label>
            <label>{$client['email']}</label>
        </div>
    {/foreach}

</div>