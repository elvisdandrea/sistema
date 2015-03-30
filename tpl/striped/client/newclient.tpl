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
        <label>Tipo de pessoa</label>
        <select name="client_type" id="client_type">
            <option value="F">Pessoa física</option>
            <option value="J">Pessoa jurídica</option>
        </select>
        <label>Nome:</label>
        <input type="text" name="client_name" value="{$client['client_name']}">
        <div id="legal_entity" class="no-display">
            <label>Razão social:</label>
            <input class="legal_entity_field" type="text" name="corporate_name" disabled>
            <label>Inscrição estadual:</label>
            <input class="legal_entity_field" type="text" name="state_registration" disabled>
            <label>Inscrição municipal:</label>
            <input class="legal_entity_field" type="text" name="municipal_registration" disabled>
            <label>Pessoa para contato:</label>
            <input class="legal_entity_field" type="text" name="contact" disabled>
        </div>
        <label id="cpf_cnpj">CPF:</label>
        <input type="text" name="cpf_cnpj">
        <label>Email:</label>
        <input type="text" name="email">
        <label>Descrição:</label>
        <textarea name="description"></textarea>
    </div>
</form>
<div id="message">

</div>