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

        $this->view()->setVariable('productinfo', $this->productInfo());

        $search = $this->getQueryString('search');
        $page   = $this->getQueryString('page');
        $rp     = $this->getQueryString('rp');

        $page || $page = 1;
        intval($rp) > 0 || $rp = 10;

        $total = $this->model()->getProductList($page, $rp, $search);
        $this->view()->setVariable('total',  $total);
        $this->view()->setVariable('search', $search);

        $pagination = $this->getPagination($page, $total, $rp, 'product/productpage');
        $this->view()->setVariable('pagination', $pagination);

        $this->model()->setGridRowLink('product/viewproduct', 'id');
        $this->model()->addGridColumn('','image','Image');
        $this->model()->addGridColumn('Categoria','category_name');
        $this->model()->addGridColumn('Produto','product_name');
        $this->model()->addGridColumn('Peso','weight');
        $this->model()->addGridColumn('Valor','price', 'Currency');
        $this->model()->addGridColumn('Peso','weight', 'Unit', array('unit' => 'g'));

        $this->view()->setVariable('productList', $this->model()->dbGrid());
        $this->commitReplace($this->view()->render(), '#content');

    }

    /**
     * Returns the box with product info
     *
     * @return string
     */
    private function productInfo() {

        $this->newView('info');
        $this->view('info')->loadTemplate('productinfo');
        return $this->view('info')->render();
    }

    /**
     * View for adding a product
     */
    public function newProduct() {

        $this->view()->loadTemplate('newproduct');
        $this->commitReplace($this->view()->render(), '#content');
        echo Html::AsyncLoadList('addproduct');
        echo Html::addImageUploadAction('read64', 'product-img');
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
        $this->commitPrint($this->view()->render());
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
        $this->commitPrint($this->view()->render());
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

        return RestServer::response(array(
            'status'    => 200,
            'id'        => $this->model()->getLastInsertId(),
            'message'   => 'Cadastro realizado!',
            'image'     => $imageFile
        ), 200);

    }

    /**
     * Handler for adding products
     */
    public function addProduct() {

        $product = $this->postAddProduct();
        if ($product['status'] != 200) {
            $this->commitReplace($product['message'], '#message');
            $this->commitShow('#message');
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
        $this->view()->setVariable('categories', $this->model()->getRows());

        $this->commitReplace($this->view()->render(), '#content');

        echo Html::addImageUploadAction('read64', 'product-img');
        if (intval($product['product_fact']) > 0)
            $this->loadNutrictionFacts($product['product_fact']);
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
            'description'   => $post['description'],
            'product_fact'  => $post['product_fact'],
        );

        $validation = $this->validateData4Product($productData);
        if(!$validation['valid'])
            return RestServer::throwError(implode(', ', $validation['message']));

        $image  = $post['image64'];

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

        return RestServer::response(array(
            'status'    => 200,
            'message'   => 'Cadastro atualizado!',
            'image'     => $imageFile
        ), 200);
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



}