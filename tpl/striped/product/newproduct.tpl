<form id="addproduct" action="{$smarty.const.BASEDIR}product/addproduct" >
    <div class="top-bar">
        <div class="buttons">
            <input class="button" type="submit" value="Salvar" />
            <a class="button button-red" href="{$smarty.const.BASEDIR}product">Cancelar</a>
        </div>
        <div class="alert alert-error" id="message" style="display: none"></div>
    </div>
    <div class="image left">
        <div class="image avatar">
            <img name="image64" id="product-img" type="upload" class="left" src="{$smarty.const.T_IMGURL}/no_photo.png"/>
        </div>
        <p></p><label>Adicionar foto:</label><input id="read64" type="file"/></p>
    </div>
    <div class="centered form-right">
        <label for="category">Categoria:</label>
        <select id="categorylist" name="category_id" href="{$smarty.const.BASEDIR}product/categorylist"></select>
        <label for="nome">Nome do Produto:</label><input type="text" id="nome" name="nome" />
        <label for="weight">Peso:</label><input type="text" id="weight" name="weight" />
        <label for="price">Valor:</label><input type="text" id="price" name="price" />
        <label for="description">Descrição:</label><textarea id="description" name="description"></textarea>
    </div>
</form>