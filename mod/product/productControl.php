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
        Html::AsyncLoadList('#categorylist');
    }

    public function categoryList() {
        print_r('here');
        exit;
    }

    public function postAddProduct() {

    }

    public function addProduct() {

    }

}