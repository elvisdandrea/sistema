<div>
<form action="{$smarty.const.BASEDIR}client/editClient?id={$client['id']}">
    <div class="top-bar">
        <div class="buttons">
            <input class="button" type="submit" value="Salvar" />
            <a class="button button-red" href="{$smarty.const.BASEDIR}client">Voltar</a>
        </div>
        <div class="alert alert-error" id="message" style="display: none"></div>
    </div>
    <div>
    <div class="image left">
        <div class="image avatar">
            <img name="image64" class="left" id="client-img" type="upload" src="{$client['image64']}"/>
        </div>
        <p></p><label>Adicionar foto:</label><input id="read64" type="file"/></p>
    </div>
    <div class="centered form-right">
        <label>Nome:</label>
        <input type="text" name="client_name" value="{$client['client_name']}">
        <label>Telefone:</label>
        <input type="text" name="phone_1" value="{$client['phone_1']}">
        <label>Telefone (alternativo):</label>
        <input type="text" name="phone_2" value="{$client['phone_2']}">
        <label>Descrição:</label>
        <textarea name="description">{$client['description']}</textarea>
    </div>
    </div>
</form>
</div>
<div id="message">

</div>
<hr>
<div id="add_list">
    <h3>Endereços:</h3>
    <a class="button button-red" href="#">Novo</a>
    <div>
        {$addrlist}
    </div>
</div>
<div id="new_addr">
    <h3>Endereços:</h3>
    <div>
        <form action="{$smarty.const.BASEDIR}client/addClientAddr?id={$client['id']}">
            <div>
                <input class="button" type="submit" value="Salvar" />
                <a class="button button-red" href="#">Cancelar</a>
            </div>
            <div>
                <label>CEP: </label>
                <input type="text" name="zip_code" id="zip_code">
                <label>Rua: </label>
                <input type="hidden" name="street_addr" id="street_addr">
                <input type="text" disabled id="street_addr_label">
                <label>Bairro: </label>
                <input type="hidden" name="hood" id="hood">
                <input type="text" disabled id="hood_label">
                <label>Cidade: </label>
                <input type="hidden" name="city" id="city">
                <input type="text" disabled id="city_label">
                <label>Numero: </label>
                <input type="text" name="street_number">
                <label>Complemento: </label>
                <input type="text" name="street_additional">
                <form>
            </div>
    </div>
</div>