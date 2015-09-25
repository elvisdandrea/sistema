<?php


class categoryControl extends Control {

    public function __construct() {
        parent::__construct();

    }

    public function getCategory() {

        if ($this->getId() == 0) {

            $filters = array();

            foreach (array(
                         'id',
                         'category_name'
                     ) as $queryFilter) {
                if ($this->getQueryString($queryFilter)) {
                    $filters[$queryFilter] = $this->getQueryString($queryFilter);
                }
            }

            $categories = $this->model()->getCategories($filters);
            return array(
                'total'     => count($categories),
                'items'     => $categories
            );
        } else {
            return $this->model()->getCategories(array('id' => $this->getId()));
        }
    }
}