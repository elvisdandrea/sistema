<div class="image left">
    <div class="image avatar-small">
        <img name="image64" class="left" id="client-img" type="upload" src="{$client['image']}"/>
    </div>
</div>
<div class="centered form-right">
    <input type="hidden" value="" name="client_id" />
    <label >Cliente:</label><label >{$client['client_name']}</label>
    <label >Fone:</label><label >{$client['phone_1']}</label>
    <a class="button" href="{$smarty.const.BASEDIR}request/changeclient">Alterar</a>
</div>