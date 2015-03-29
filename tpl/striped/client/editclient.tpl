{$isPessoaFisica = $client['client_type'] == 'F'}
<div>
<form action="{$smarty.const.BASEDIR}client/editClient?id={$client['id']}">
    <div class="top-bar">
        <div class="buttons">
            <input class="button" type="submit" value="Salvar" />
            <a class="button button-red" href="{$smarty.const.BASEDIR}client">Voltar</a>
            <a class="button button-darkblue" href="{$smarty.const.BASEDIR}request/newrequest?client_id={$client['id']}">Novo Pedido</a>
        </div>
        <div class="alert alert-error" id="message" style="display: none"></div>
    </div>
    <div>
    <div class="image left">
        <div class="image avatar">
            <img name="image64" class="left" id="client-img" type="upload" src="{$client['image']}"/>
        </div>
        <p></p><label>Adicionar foto:</label><input id="read64" type="file"/></p>
    </div>
    <div class="centered form-right">
        <label>Tipo de pessoa</label>
        <select name="client_type" id="client_type">
            <option value="F"{if $isPessoaFisica} Selected{/if}>Pessoa física</option>
            <option value="J"{if !$isPessoaFisica} Selected{/if}>Pessoa jurídica</option>
        </select>
        <label>Nome:</label>
        <input type="text" name="client_name" value="{$client['client_name']}">
        <div id="legal_entity" {if $isPessoaFisica} class="no-display"{/if}>
            <label>Razão social:</label>
            <input class="legal_entity_field" type="text" name="corporate_name" {if $isPessoaFisica}disabled{/if} value="{$client['corporate_name']}">
            <label>Inscrição estadual:</label>
            <input class="legal_entity_field" type="text" name="state_registration" {if $isPessoaFisica}disabled{/if} value="{$client['state_registration']}">
            <label>Inscrição municipal:</label>
            <input class="legal_entity_field" type="text" name="municipal_registration" {if $isPessoaFisica}disabled{/if} value="{$client['municipal_registration']}">
            <label>Pessoa para contato:</label>
            <input class="legal_entity_field" type="text" name="contact" {if $isPessoaFisica}disabled{/if} value="{$client['contact']}">
        </div>
        <label id="cpf_cnpj">{if $isPessoaFisica}CPF:{else}CNPJ:{/if}</label>
        <input type="text" name="cpf_cnpj" value="{$client['cpf_cnpj']}">
        <label>Email:</label>
        <input type="text" name="email" value="{$client['email']}">
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
<div id="addr_list">
    <h3>Endereços:</h3>
    <a class="button button-red" id="new_addr" href="#">Novo</a>
    <div class="table-wrapper">
        <table class="default">

            <thead>
                <th>Tipo</th>
                <th>Logradouro</th>
                <th>Numero</th>
                <th>Complemento</th>
                <th>Bairro</th>
                <th>Cidade</th>
                <th>Cep</th>
                <th></th>
            </thead>
            <tbody>

            {foreach from=$addrList key="key" item="value"}

                <tr>
                    <td>{$value['address_type']}</td>
                    <td>{$value['street_addr']}</td>
                    <td>{$value['street_number']}</td>
                    <td>{$value['street_additional']}</td>
                    <td>{$value['hood']}</td>
                    <td>{$value['city']}</td>
                    <td>{$value['zip_code']}</td>
                    <td>
                        <a href="{$smarty.const.BASEDIR}client/removeAddr?id={$client['id']}&addr_id={$value['id']}" class="button button-red">Remover</a>
                    </td>
                </tr>
            {/foreach}
            </tbody>
        </table>
    </div>
</div>
<div id="new_addr_form" class="new_addr">
    <h3>Endereços:</h3>
    <div>
        <form action="{$smarty.const.BASEDIR}client/addClientAddr?id={$client['id']}">
            <div>
                <input class="button" type="submit" value="Salvar" />
                <a id="cancel_addr" class="button button-red" href="#">Cancelar</a>
            </div>
            <div class="half-width">
                <label>Tipo: </label>
                <select name="address_type">
                    <option value="Residencial">Residencial</option>
                    <option value="Comercial">Comercial</option>
                </select>
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