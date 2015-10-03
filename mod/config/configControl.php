<?php


class configControl extends Control {

    public function __construct() {
        parent::__construct();

    }

    public function configPage() {

    }


    public function getConfig() {

        $result = $this->model()->getConfig($this->getId());

        return RestServer::response(array(
            'status'    => 200,
            'config'    => $this->model()->getRows()
        ));

    }
}