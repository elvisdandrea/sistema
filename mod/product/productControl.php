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
        $this->commitReplace($this->view()->render(), '#content');
    }

    public function newProduct() {


        $this->view()->loadTemplate('newproduct');
        $this->commitReplace($this->view()->render(), '#content');
        echo Html::AsyncLoadList('addproduct');
    }

    public function categoryList() {
        $this->view()->loadTemplate('categorylist');
        $this->model()->getCategoryList();
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
        );

        $validation = $this->validateData4Product($productData);
        if(!$validation['valid'])
            return RestServer::throwError(implode(', ', $validation['message']));


    }

    public function addProduct() {

        $product = $this->postAddProduct();
        debug($product);
    }

}