<div >
    <form id="addproduct" action="{$smarty.const.BASEDIR}product/editproduct?id={$id}" >
        <div class="top-bar">
            <div class="buttons">
                <input class="button" type="submit" value="Salvar" />
                <a class="button button-red" href="{$smarty.const.BASEDIR}product">Voltar</a>
            </div>
            <div class="alert alert-error" id="message" style="display: none"></div>
        </div>
        <div class="image left">
            <div class="image avatar">
                <img name="image64" id="product-img" type="upload" class="left" src="{$product['image']}"/>
            </div>
            <p></p><label>Adicionar foto:</label><input id="read64" type="file"/></p>
        </div>
        <div class="centered form-right">
            <label for="category">Categoria:</label>
            <select id="categorylist" name="category_id" href="{$smarty.const.BASEDIR}product/categorylist"></select>
            <label for="nome">Nome do Produto:</label><input type="text" id="nome" name="nome" value="{$product['product_name']}" />
            <label for="weight">Peso:</label><input type="text" id="weight" name="weight"  value="{$product['weight']}" />
            <label for="price">Valor:</label><input type="text" id="price" name="price"  value="{$product['price']}" />
            <label for="description">Descrição:</label><textarea id="description" name="description">{$product['description']}</textarea>
        </div>
    </form>
    </div>