<?php

/**
 * Class requestControl
 *
 *
 */
class requestControl extends Control {

    /**
     * The request handler Id
     *
     * This is to handle a session position
     * of the current working request
     *
     * @var
     */
    private $request_id;

    /**
     * Constructor
     */
    public function __construct() {
        parent::__construct();
    }

    /**
     * Sets the working Id
     *
     * Use the querystring to handle
     * previous initiated requests
     *
     * @param $id
     */
    public function setId($id = false) {

        $id || $id = $this->getQueryString('request_id');
        $this->request_id = $id;
    }

    /**
     * Generates a new request Id
     */
    public function createId() {

        $this->request_id = uniqid();
        Session::set('requests', $this->request_id, array());
    }


    /**
     * Renders the main request page
     */
    public function requestPage($date = false) {

        $this->view()->loadTemplate('requestpage');
        $this->model()->listRequests($date);
        $this->model()->setGridRowLink('request/viewrequest', 'id');
        $this->model()->addGridColumn('Imagem', 'image', 'Image');
        $this->model()->addGridColumn('Cliente', 'client_name');
        $this->model()->addGridColumn('Telefones', 'phones');
        $this->model()->addGridColumn('Entrega', 'delivery_date', 'Date');
        $this->model()->addGridColumn('Andamento', 'status_name');

        $this->view()->setVariable('request_table', $this->model()->dbGrid());

        $this->commitReplace($this->view()->render(), '#content');
    }

    /**
     * New Request Page and form
     */
    public function newRequest() {

        $this->createId();
        $this->view()->setVariable('request_id', $this->request_id);

        $this->view()->loadTemplate('newrequest');
        $this->view()->appendJs('events');
        $this->commitReplace($this->view()->render(), '#content');
        $client_id = $this->getQueryString('client_id');
        if ($client_id)
            $this->selClient($client_id);
    }

    /**
     * Searches a client for the current request
     */
    public function searchClient() {

        $this->setId();
        $search = $this->getQueryString('search');
        if (empty($search))
            $this->commitReplace('','#client-results', false);

        $this->model()->searchClientForRequest($search);
        $this->view()->loadTemplate('clientresult');
        $clients = $this->model()->getRows();
        $this->view()->setVariable('clients', $clients);
        $this->view()->setVariable('request_id', $this->request_id);
        $this->commitReplace($this->view()->render(),'#client-results');

    }

    /**
     * Sets a client to the current request
     *
     * @param   bool    $id     - The client Id ( false to get from querystring )
     */
    public function selClient($id = false) {
        $this->setId();
        $id || $id = $this->getQueryString('id');
        Session::set('requests', $this->request_id, 'client_id', $id);
        $this->model()->selClientForRequest($id);
        $this->commitReplace('', '#client-results');
        $this->view()->loadTemplate('requestclient');
        $this->view()->setVariable('client', $this->model()->getRow(0));
        $this->model()->clientAddressListForRequest($id);
        $this->view()->setVariable('request_id', $this->request_id);
        $this->view()->setVariable('address_list', $this->model()->getRows());
        $this->commitReplace($this->view()->render(),'#client');
        $this->commitShow('#client');
        $this->commitSetValue('#searchclient', '');
        $this->commitHide('#searchclient');
    }

    /**
     * Action to change current request client
     *
     */
    public function changeClient() {
        $this->commitShow('#searchclient');
        $this->commitReplace('', '#client');
    }

    /**
     * Sets a client address to the current request
     */
    public function selAddress() {

        $this->setId();
        $id = $this->getQueryString('id');
        Session::set('requests', $this->request_id, 'address_id', $id);
        $this->model()->getClistAddressForRequest($id);

        $this->model()->addGridColumn('Endereco', 'street_addr');
        $this->model()->addGridColumn('Numero', 'street_number');
        $this->model()->addGridColumn('Complemento', 'street_additional');
        $this->model()->addGridColumn('Bairro', 'hood');
        $this->model()->addGridColumn('Cidade', 'city');
        $this->model()->addGridColumn('Cep', 'zip_code');

        $this->commitReplace($this->model()->dbGrid(), '#address-table');

    }

    /**
     * Action to add a plate to request
     */
    public function addPlate() {

        $this->setId();
        $this->view()->loadTemplate('plate');
        $plate_id = uniqid();
        Session::set('requests', $this->request_id, 'plates', $plate_id, array());
        $this->view()->setVariable('request_id', $this->request_id);
        $this->view()->setVariable('plate_id', $plate_id);
        $this->commitAdd($this->view()->render(), '#plates');

    }

    /**
     * Searches a product for a plate
     */
    public function searchProduct() {

        $this->setId();
        $search   = $this->getQueryString('search');
        $plate_id = $this->getQueryString('plate_id');
        if (empty($search))
            $this->commitReplace('','#product-results_' . $plate_id, false);

        $this->model()->searchProductForRequest($search);
        $this->view()->loadTemplate('productresult');
        $products = $this->model()->getRows();
        $this->view()->setVariable('products', $products);
        $this->view()->setVariable('request_id', $this->request_id);
        $this->view()->setVariable('plate_id', $plate_id);
        $this->commitReplace($this->view()->render(),'#product-results_'. $plate_id);
    }

    /**
     * Selects a product into a plate
     */
    public function selProduct() {

        $this->setId();
        $plate_id   = $this->getQueryString('plate_id');
        $product_id = $this->getQueryString('id');
        $this->commitReplace('', '#product-results_' . $plate_id);
        $this->model()->selectProductForRequest($product_id);
        $item = $this->model()->getRow(0);
        Session::set('requests', $this->request_id, 'plates', $plate_id, $product_id, $item['weight']);
        $this->view()->loadTemplate('plateitem');
        $this->view()->setVariable('item', $item);
        $this->commitAdd($this->view()->render(), '#plate_' . $plate_id);
    }

    /**
     * Saves a request
     */
    public function addNewRequest() {

        $this->setId();
        $post  = $this->getPost();
        $items = Session::get('requests', $this->request_id);

        $requestData = array(
            'client_id'     => $post['client_id'],
            'address_id'    => $post['address_id'],
            'delivery_date' => String::formatDateToSave($post['delivery_date']),
            'plates'        => $items['plates']
        );

        $result = $this->postAddRequest($requestData);

        if ($result['status'] == 200) {
            $this->requestPage();
            $this->terminate();
        }

    }

    /**
     * Request Handler for adding new requests
     *
     * @param   array   $requestData    - The request data
     * @return  array
     */
    public function postAddRequest(array $requestData = array()) {

        count($requestData) > 0 ||
            $requestData = $this->getPost();

        $result = array();
        $plates = array();

        if (isset($requestData['plates'])) {
            $plates = $requestData['plates'];
            unset($requestData['plates']);
        }

        $request_id = $this->model()->insertNewRequest($requestData);
        $result['id']   = $request_id;

        foreach ($plates as $plate) {

            $plate_id = $this->model()->insertNewPlate(
                array('request_id' => $request_id)
            );

            $result['plates'][$plate_id] = array();

            foreach ($plate as $product_id => $weight) {
                $item_id = $this->model()->insertPlateItem(
                    array(
                        'plate_id'      => $plate_id,
                        'product_id'    => $product_id,
                        'weight'        => $weight
                    )
                );
                $result['plates'][$plate_id][] = $item_id;
            }

        }

        return array(
            'status'    => 200,
            'request'   => $result
        );
    }

}