<?php

/**
 * Class productControl
 *
 *
 */
class productControl extends Control {

    /**
     * The module title
     *
     * This will be automatically
     * rendered on the Template Title bar
     */
    const module_title = 'Produtos';

    /**
     * Constructor
     */
    public function __construct() {
        parent::__construct();
    }

    /**
     * Main view of products
     */
    public function productPage() {

        $this->view()->loadTemplate('productpage');

        $search = $this->getQueryString('search');
        $page   = $this->getQueryString('page');
        $rp     = $this->getQueryString('rp');

        $page || $page = 1;
        intval($rp) > 0 || $rp = 10;

        $total = $this->model()->getProductList($page, $rp, $search);
        $this->view()->setVariable('total',  $total['total']);
        $this->view()->setVariable('totalPrice',  String::convertTextFormat($total['totalprice'], 'currency'));
        $this->view()->setVariable('search', $search);

        $this->view()->setVariable('totalProduct', $total['total']);

        $pagination = $this->getPagination($page, $total['total'], $rp, 'product/productpage');
        $this->view()->setVariable('pagination', $pagination);

        $this->newView('table');
        $this->view('table')->loadTemplate('producttable');
        $this->view('table')->setVariable('list', $this->model()->getRows(0));

        $this->view()->setVariable('productList', $this->view('table')->render());
        $this->commitReplace($this->view()->render(), '#content');

    }

    public function getProduct() {

        if ($this->getId() == 0) {

            $page   = $this->getQueryString('page');
            $rp     = $this->getQueryString('rp');
            $search = $this->getQueryString('search');

            $page   = $page   ? $page   : 1;
            $rp     = $rp     ? $rp     : 50;

            $total = $this->model()->getProductList($page, $rp, $search);

            $response = array(
                'total' => $total,
                'items' => $this->model()->getRows()
            );
        } else {
            $total = 0;
            $result = $this->model()->getProduct($this->getId());
            if ($result) $total = 1;

            $response = array(
                'total' => $total,
                'items' => $this->model()->getRows()
            );

        }

        return RestServer::response($response);
    }

    /**
     * View for adding a product
     */
    public function newProduct() {

        $this->model()->getCategoryList();
        $this->view()->setVariable('categoryList', $this->model()->getRows());

        $total      = $this->model()->getCountCategories();
        $this->model()->getCategoryList(1, 5);
        $categories = $this->model()->getRows();
        $pagination = $this->getPagination(1, $total, 5, 'product/vieweditcategories');

        $this->view()->setVariable('categories', $categories);
        $this->view()->setVariable('pagination', $pagination);
        $this->view()->loadTemplate('newproduct');

        $this->model()->getIngredientList();
        $ingredientList = $this->model()->getRows();
        $this->view()->setVariable('ingredientList', $ingredientList);

        $this->view()->appendJs('category');
        $this->view()->appendJs('product');
        $this->commitReplace($this->view()->render(), '#content');
    }

    /**
     * Handler that returns a list options of nutrition facts
     */
    public function factList() {

        $this->newModel('auth');
        $this->model('auth')->getNutrictionProductList();
        $this->view()->loadTemplate('factlist');
        $selected = $this->getQueryString('selected');
        if ($selected) $this->view()->setVariable('selected', $selected);
        $this->view()->setVariable('facts', $this->model('auth')->getRows());
        #$this->commitPrint($this->view()->render());
    }

    /**
     * Loads the nutrition facts of an item
     *
     * @param   bool    $product_id     - The product Id
     */
    public function loadNutrictionFacts($product_id = false) {

        $product_id || $product_id = $this->getQueryString('id');
        $this->newModel('auth');
        $this->model('auth')->getNutrictionFacts($product_id);
        $this->model('auth')->addGridColumn('','fact_type');
        $this->model('auth')->addGridColumn('Quantidade por porção','fact_unit');
        $this->model('auth')->addGridColumn('VD %','fact_vd');
        $this->commitReplace($this->model('auth')->dbGrid(), '#nutriction-table');

    }

    /**
     * Handler that returns the list options of categories
     */
    public function categoryList() {

        $this->view()->loadTemplate('categorylist');
        $this->model()->getCategoryList();
        $selected = $this->getQueryString('selected');
        if ($selected) $this->view()->setVariable('selected', $selected);
        $this->view()->setVariable('categories', $this->model()->getRows());
        $this->commit($this->view()->render());
    }

    /**
     * Validator dor adding products
     *
     * @param   $productData        - The product data
     * @return  array
     */
    private function validateData4Product($productData) {

        $return = array(
            'valid'     => true,
            'message'   => array()
        );

        !empty($productData['product_name']) ||
                $return['message'][] = 'Você deve informar o nome do produto';

        intval($productData['category_id']) > 0 ||
                $return['message'][] = 'Você deve selecionar uma categoria de produto';

        String::validateTextFormat($productData['price'], 'float') ||
                $return['message'][] = 'O preço do produto não é válido';

        count($return['message']) == 0 ||
            $return['valid'] = !$return['valid'];

        return $return;
    }

    /**
     * Rest Handler for adding products
     *
     * @return array|string
     * @throws ExceptionHandler
     */
    public function postAddProduct() {

        $post = $this->getPost();

        $productData = array(
            'product_name'  => $post['nome'],
            'category_id'   => $post['category_id'],
            'weight'        => $post['weight'],
            'price'         => $post['price'],
            'cost'          => $post['cost'],
            'unit'          => $post['unit'],
            'description'   => $post['description'],
            'product_fact'  => $post['product_fact']
        );

        $validation = $this->validateData4Product($productData);
        if(!$validation['valid'])
            return RestServer::throwError(implode(', ', $validation['message']));

        $image      = $post['image64'];
        $imageFile  = $image;

        if (!Html::isUrl($image)) {
            $base64 = explode(',', $image);
            $imageFile = $this->uploadBase64File($base64[1]);

            if (!$imageFile) {
                $imageFile = 'Nao foi possivel efetuar o upload da imagem. Contate o Suporte.';
            } else {
                $productData['image'] = $imageFile;
            }

        }

        $this->model()->insertProduct($productData);

        if (!$this->model()->queryOk()) {
            if (in_array($this->model('auth')->getErrorCode(), array(23000, 1062)))
                return RestServer::throwError('Produto já cadastrado!');
            else
                return RestServer::throwError(Language::QUERY_ERROR(), 500);
        }

        $product_id = $this->model()->getLastInsertId();

        $result_ingredients = $this->insertIngredients($product_id, $post['ingredients']);

        return RestServer::response(array(
            'status'        => 200,
            'id'            => $product_id,
            'message'       => 'Cadastro realizado!',
            'image'         => $imageFile,
            'ingredients'   => $result_ingredients
        ), 200);

    }

    /**
     * Handler for adding products
     */
    public function addProduct() {

        $product = $this->postAddProduct();
        if ($product['status'] != 200) {
            $this->commitAdd($this->view()->showAlert('danger','', $product['message']), 'body');
            $this->terminate();
        }

        $this->productPage();
    }

    /**
     * View of a product
     */
    public function viewProduct() {

        $id = $this->getQueryString('id');
        $this->model()->getProduct($id);
        $this->view()->loadTemplate('editproduct');
        $product = $this->model()->getRow(0);
        $this->view()->setVariable('product', $product);
        $this->view()->setVariable('id', $id);

        $this->model()->getCategoryList();
        $this->view()->setVariable('categoryList', $this->model()->getRows());

        $total      = $this->model()->getCountCategories();
        $this->model()->getCategoryList(1, 5);
        $categories = $this->model()->getRows();
        $pagination = $this->getPagination(1, $total, 5, 'product/vieweditcategories');

        $this->view()->setVariable('categories', $categories);
        $this->view()->setVariable('pagination', $pagination);

        $units = array(
            'g'     => 'Gramas',
            'kg'    => 'Kilos',
            'lt'    => 'Litros'
        );

        $this->model()->getIngredientList();
        $ingredientList = $this->model()->getRows();
        $this->view()->setVariable('ingredientList', $ingredientList);

        $unit = isset($units[$product['unit']]) ? $units[$product['unit']] : '';

        $this->view()->setVariable('unit', $unit);

        $this->view()->appendJs('category');
        $this->view()->appendJs('product');

        $this->commitReplace($this->view()->render(), '#content');
    }

    /**
     * Rest handler for updating products
     *
     * @return  array|string
     * @throws  ExceptionHandler
     */
    public function updateProduct() {

        $post = $this->getPost();

        $productData = array(
            'product_name'  => $post['nome'],
            'category_id'   => $post['category_id'],
            'weight'        => $post['weight'],
            'price'         => $post['price'],
            'cost'          => $post['cost'],
            'unit'          => $post['unit'],
            'description'   => $post['description'],
            'product_fact'  => $post['product_fact'],
        );

        $validation = $this->validateData4Product($productData);
        if(!$validation['valid'])
            return RestServer::throwError(implode(', ', $validation['message']));

        $image     = $post['image64'];
        $imageFile = $image;

        if (!empty($image) && !Html::isUrl($image)) {
            $base64 = explode(',', $image);
            $imageFile = $this->uploadBase64File($base64[1]);

            if (!$imageFile) {
                $imageFile = 'Nao foi possivel efetuar o upload da imagem. Contate o Suporte.';
            } else {
                $productData['image'] = $imageFile;
            }
        }

        $this->model()->updateProduct($productData, $this->getId());

        if (!$this->model()->queryOk()) {
            return RestServer::throwError(Language::QUERY_ERROR(), 500);
        }

        $result_ingredients = $this->insertIngredients($this->getId(), $post['ingredients']);

        return RestServer::response(array(
            'status'        => 200,
            'message'       => 'Cadastro atualizado!',
            'image'         => $imageFile,
            'ingredients'   => $result_ingredients
        ), 200);
    }

    /**
     * Handler for inserting product ingredients
     *
     * @param   string      $product_id     - The product id
     * @param   string      $ingredients    - Comma separated string
     * @return  array
     */
    public function insertIngredients($product_id, $ingredients) {

        $this->model()->getIngredients($product_id);
        $ingredientList = array();
        foreach ($this->model()->getRows() as $row) {
            $ingredientList[$row['id']] = $row['ingredient_name'];
        }


        $result_ingredients = array();
        if (isset($ingredients) && !empty($ingredients)) {
            $ingredients = explode(',', $ingredients);
            foreach ($ingredients as $ingredient) {
                if (!in_array($ingredient, $ingredientList))
                    $result_ingredients[] = $this->model()->insertIngredient($product_id, $ingredient);
            }
            foreach ($ingredientList as $id => $ingredient) {
                if (!in_array($ingredient, $ingredients))
                    $this->model()->deleteIngredient($id);
            }
        }
        return $result_ingredients;
    }

    /**
     * Handler for editing products
     */
    public function editproduct() {

        $id = $this->getQueryString('id');
        $this->setId($id);
        $product = $this->updateProduct();

        if ($product['status'] != 200) {
            $this->commitReplace($product['message'], '#message');
            $this->commitShow('#message');
            $this->terminate();
        }

        $this->productPage();
    }

    /**
     * Rest Handler for inserting a category
     *
     * @param   array             $data     - The category data (field => value)
     * @return  array|string
     */
    public function putCategory(array $data = array()) {

        $id     = $data['id'];
        $value  = $data['category_name'];

        $this->model()->updateCategory($id, $value);

        if (!$this->model()->queryOk()) {
            return RestServer::throwError(Language::QUERY_ERROR(), 500);
        }

        return RestServer::response(array(
            'status'    => 200,
            'message'   => 'Cadastro atualizado!',
        ), 200);

    }

    /**
     * Saves a category
     */
    public function saveCategory() {

        $id     = $this->getPost('id');
        $value  = $this->getPost('value');

        $update = $this->putCategory(array(
            'id'            => $id,
            'category_name' => $value
        ));

        if ($update['status'] != 200) {
            $this->commitReplace($update['message'], '#message');
            $this->commitShow('#message');
            $this->terminate();
        }

        $this->view()->loadTemplate('categoryitem');
        $this->view()->setVariable('category', array(
            'id' => $id,
            'category_name' => $value)
        );

        $this->commitReplace($this->view()->render(), '#edit' . $id);

    }

    /**
     * View for Category Edition Window
     *
     * @param   string|bool     $page       - Current page
     * @param   string|bool     $rp         - Results per page
     */
    public function viewEditCategories($page = false, $rp = false) {

        $page || $page = $this->getQueryString('page');
        $rp   || $rp   = $this->getQueryString('rp');
        $rp   || $rp   = 5;

        $total      = $this->model()->getCountCategories();
        if ($page == 'last') $page = intval((($total - 1) / $rp)) + 1;
        $this->model()->getCategoryList($page, $rp);
        $categories = $this->model()->getRows();
        $pagination = $this->getPagination($page, $total, $rp, 'product/vieweditcategories');

        $this->view()->loadTemplate('editcategorytable');
        $this->view()->setVariable('categories', $categories);
        $this->view()->setVariable('pagination', $pagination);

        $this->commitReplace($this->view()->render(), '#categorytable');

    }

    /**
     * Rest Handler for adding a category
     *
     * @return array|string
     */
    public function postCategory() {

        $name = $this->getPost('category_name');

        $this->model()->addCategory($name);

        if (!$this->model()->queryOk()) {
            if (in_array($this->model('auth')->getErrorCode(), array(23000, 1062)))
                return RestServer::throwError('Categoria já cadastrada!');
            else
                return RestServer::throwError(Language::QUERY_ERROR(), 500);
        }

        return RestServer::response(array(
            'status'    => 200,
            'id'        => $this->model()->getLastInsertId(),
            'message'   => 'Cadastro realizado!',
        ), 200);

    }

    /**
     * Handler for adding a category
     */
    public function addCategory() {

        $result = $this->postCategory();
        if ($result['status'] != 200) {
            $this->commitAdd($this->view()->showAlert('danger','', $result['message']), 'body');
            $this->terminate();
        }

        $this->viewEditCategories('last');

    }

    /**
     * Rest Handler for removing a category
     *
     * @param   string|bool     $id     - The category id
     * @return  array|string
     */
    public function deleteCategory($id = false) {

        $id || $id = $this->getQueryString('id');
        $this->model()->deleteCategory($id);

        if (!$this->model()->queryOk()) {
            return RestServer::throwError(Language::QUERY_ERROR(), 500);
        }

        return RestServer::response(array(
            'status'    => 200,
            'id'        => $id,
            'message'   => 'Cadastro removido!',
        ), 200);

    }

    /**
     * Handler for removing a category
     */
    public function removeCategory() {

        $id     = $this->getQueryString('id');
        $result = $this->deleteCategory($id);

        if ($result['status'] != 200) {
            $this->commitAdd($this->view()->showAlert('danger','', $result['message']), 'body');
            $this->terminate();
        }

        $this->viewEditCategories(1);

    }



}