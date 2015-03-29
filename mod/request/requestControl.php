<?php

/**
 * Class requestControl
 *
 *
 */
class requestControl extends Control {

    public function __construct() {
        parent::__construct();
    }


    public function requestPage() {

        $this->view()->loadTemplate('requestpage');
        $this->commitReplace($this->view()->render(), '#content');
    }

    public function newRequest() {

        $this->view()->loadTemplate('newrequest');
        $this->view()->appendJs('events');
        $this->commitReplace($this->view()->render(), '#content');
    }

    public function searchClient() {

        $search = $this->getQueryString('search');
        $this->model()->searchClientForRequest($search);
        $this->view()->loadTemplate('clientresult');
        $clients = $this->model()->getRows();
        $this->view()->setVariable('clients', $clients);
        $this->commitReplace($this->view()->render(),'#client-results');

    }

    public function selClient() {
        $id = $this->getQueryString('id');
        $this->model()->selClientForRequest($id);
        $this->commitReplace('', '#client-results');
        $this->view()->loadTemplate('requestclient');
        $this->view()->setVariable('client', $this->model()->getRow(0));
        $this->commitReplace($this->view()->render(),'#client');
        $this->commitShow('#client');
        $this->commitSetValue('#searchclient', '');
    }

}