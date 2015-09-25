<?php


class categoryControl extends Control {

    public function __construct() {
        parent::__construct();

    }

    public function getCategory() {

        if ($this->getId() == 0) {
            $categories = $this->model()->getCategories();
            return array(
                'total'     => count($categories),
                'items'     => $categories
            );
        } else {
            return $this->model()->getCategories(array('id' => $this->getId()));
        }
    }
}