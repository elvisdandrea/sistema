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
        $client_id = $this->getQueryString('client_id');
        if ($client_id)
            $this->selClient($client_id);
    }

    public function searchClient() {

        $search = $this->getQueryString('search');
        if (empty($search))
            $this->commitReplace('','#client-results', false);

        $this->model()->searchClientForRequest($search);
        $this->view()->loadTemplate('clientresult');
        $clients = $this->model()->getRows();
        $this->view()->setVariable('clients', $clients);
        $this->commitReplace($this->view()->render(),'#client-results');

    }

    public function selClient($id = false) {
        $id || $id = $this->getQueryString('id');
        $this->model()->selClientForRequest($id);
        $this->commitReplace('', '#client-results');
        $this->view()->loadTemplate('requestclient');
        $this->view()->setVariable('client', $this->model()->getRow(0));
        $this->model()->clientAddressListForRequest($id);
        $this->view()->setVariable('address_list', $this->model()->getRows());
        $this->commitReplace($this->view()->render(),'#client');
        $this->commitShow('#client');
        $this->commitSetValue('#searchclient', '');
        $this->commitHide('#searchclient');
    }

    public function changeClient() {
        $this->commitShow('#searchclient');
        $this->commitReplace('', '#client');
    }

    public function selAddress() {

        $id = $this->getQueryString('id');
        $this->model()->getClistAddressForRequest($id);

        $this->model()->addGridColumn('Endereco', 'street_addr');
        $this->model()->addGridColumn('Numero', 'street_number');
        $this->model()->addGridColumn('Complemento', 'street_additional');
        $this->model()->addGridColumn('Bairro', 'hood');
        $this->model()->addGridColumn('Cidade', 'city');
        $this->model()->addGridColumn('Cep', 'zip');

        $this->commitReplace($this->model()->dbGrid(), '#address-table');

    }

}