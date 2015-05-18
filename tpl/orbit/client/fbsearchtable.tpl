<ul>
    {foreach from=$data key="key" item="value"}
        <li id="{$value['uid']}"><a onClick="populateData({$value['uid']})"><img src="{$value['picture']}"></img>{$value['name']}</a></li>
    {/foreach}
</ul>