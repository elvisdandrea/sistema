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

        debug('teste');
        $this->view()->loadTemplate('newproduct');
        $this->commitReplace($this->view()->render(), '#content');
    }

    public function postAddProduct() {

    }

    public function addProduct() {

    }

}