<?php

/**
 * Class productControl
 *
 *
 */
class productControl extends Control {

    public function __construct() {
        parent::__construct();
    }

    public function productPage() {

        $this->view()->loadTemplate('productpage');

        $search = $this->getQueryString('search');
        $page = $this->getQueryString('page');
        $page || $page = 1;
        $rp = $this->getQueryString('rp');
        intval($rp) > 0 || $rp = 10;

        $total = $this->model()->getProductList($page, $rp, $search);
        $this->view()->setVariable('total', $total);

        $pagination = $this->getPagination($page, $total, $rp, 'product/productpage');
        $this->view()->setVariable('pagination', $pagination);

        $this->model()->setGridRowLink('product/viewproduct', 'id');
        $this->model()->addGridColumn('Imagem','image','Image');
        $this->model()->addGridColumn('Categoria','category_name');
        $this->model()->addGridColumn('Produto','product_name');
        $this->model()->addGridColumn('Valor','price');
        $this->model()->addGridColumn('Peso','weight');

        $this->view()->setVariable('productList', $this->model()->dbGrid());
        $this->commitReplace($this->view()->render(), '#content');
    }

    public function newProduct() {

        $this->view()->loadTemplate('newproduct');
        $this->commitReplace($this->view()->render(), '#content');
        echo Html::AsyncLoadList('addproduct');
        echo Html::addImageUploadAction('read64', 'product-img');
    }

    public function factList() {

        $this->newModel('auth');
        $this->model('auth')->getNutrictionProductList();
        $this->view()->loadTemplate('factlist');
        $selected = $this->getQueryString('selected');
        if ($selected) $this->view()->setVariable('selected', $selected);
        $this->view()->setVariable('facts', $this->model('auth')->getRows());
        $this->commitPrint($this->view()->render());
    }

    public function categoryList() {

        $this->view()->loadTemplate('categorylist');
        $this->model()->getCategoryList();
        $selected = $this->getQueryString('selected');
        if ($selected) $this->view()->setVariable('selected', $selected);
        $this->view()->setVariable('categories', $this->model()->getRows());
        $this->commitPrint($this->view()->render());
    }

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

    public function postAddProduct() {

        $post = $this->getPost();

        $productData = array(
            'product_name'  => $post['nome'],
            'category_id'   => $post['category_id'],
            'weight'        => $post['weight'],
            'price'         => $post['price'],
            'description'   => $post['description'],
            #'image64'       => $post['image64'],
        );

        $validation = $this->validateData4Product($productData);
        if(!$validation['valid'])
            return RestServer::throwError(implode(', ', $validation['message']));

        $image  = $post['image64'];
        $base64 = explode(',', $image);
        $imageFile = $this->uploadBase64File($base64[1]);

        if (!$imageFile) {
            $imageFile = 'Nao foi possivel efetuar o upload da imagem. Contate o Suporte.';
        } else {
            $productData['image'] = $imageFile;
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

    public function addProduct() {

        $product = $this->postAddProduct();
        if ($product['status'] != 200) {
            $this->commitReplace($product['message'], '#message');
            $this->commitShow('#message');
            $this->terminate();
        }

        $this->productPage();
    }

    public function viewProduct() {

        $id = $this->getQueryString('id');
        $this->model()->getProduct($id);
        $this->view()->loadTemplate('editproduct');
        $product = $this->model()->getRow(0);
        $this->view()->setVariable('product', $product);
        $this->view()->setVariable('id', $id);
        $this->commitReplace($this->view()->render(), '#content');
        echo Html::AsyncLoadList('categorylist', $product['category_id']);
        echo Html::AsyncLoadList('fact', $product['product_fact']);
        echo Html::addImageUploadAction('read64', 'product-img');
    }

    public function updateProduct() {

        $post = $this->getPost();

        $productData = array(
            'product_name'  => $post['nome'],
            'category_id'   => $post['category_id'],
            'weight'        => $post['weight'],
            'price'         => $post['price'],
            'description'   => $post['description'],
            #'image64'       => $post['image64'],
        );

        $validation = $this->validateData4Product($productData);
        if(!$validation['valid'])
            return RestServer::throwError(implode(', ', $validation['message']));

        $image  = $post['image64'];
        $base64 = explode(',', $image);
        $imageFile = $this->uploadBase64File($base64[1]);

        if (!$imageFile) {
            $imageFile = 'Nao foi possivel efetuar o upload da imagem. Contate o Suporte.';
        } else {
            $productData['image'] = $imageFile;
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