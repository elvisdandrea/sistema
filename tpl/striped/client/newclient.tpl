<form action="{$smarty.const.BASEDIR}client/addNewClient">
    <div class="top-bar">
        <div class="buttons">
            <input class="button" type="submit" value="Salvar" />
            <a class="button button-red" href="{$smarty.const.BASEDIR}client">Cancelar</a>
        </div>
        <div class="alert alert-error" id="message" style="display: none"></div>
    </div>
    <div class="image left">
        <div class="image avatar">
            <img name="image64" class="left" id="client-img" type="upload" src="{$smarty.const.T_IMGURL}/no_photo.png"/>
        </div>
        <p></p><label>Adicionar foto:</label><input id="read64" type="file"/></p>
    </div>
    <div class="centered form-right">
        <label>Nome:</label>
        <input type="text" name="client_name">
        <label>Telefone:</label>
        <input type="text" name="phone_1">
        <label>Telefone (alternativo):</label>
        <input type="text" name="phone_2">
        <label>Descrição:</label>
        <textarea name="description"></textarea>
    </div>
</form>
<div id="message">

</div>