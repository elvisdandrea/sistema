<form id="addproduct" action="{$smarty.const.BASEDIR}product/addproduct" xmlns="http://www.w3.org/1999/html">
    <label for="category">Categoria:</label>
    <select id="categorylist" name="category_id" href="{$smarty.const.BASEDIR}product/categorylist"></select>
    <label for="nome">Nome do Produto:</label><input type="text" id="nome" name="nome" />
    <label for="weight">Peso:</label><input type="text" id="weight" name="weight" />
    <label for="price">Valor:</label><input type="text" id="price" name="price" />
    <p></p><label>Imagem do produto:</label><input type="file"/></p>
    <label for="description">Descrição:</label><textarea id="description" name="description"></textarea>
    <input class="button" type="submit" value="Salvar" />
</form>