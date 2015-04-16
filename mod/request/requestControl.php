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
     *
     */
    public function requestPage() {

        $this->view()->loadTemplate('requestpage');

        $dateFrom = $this->getQueryString('date_from');
        $dateTo = $this->getQueryString('date_to');

        $page   = $this->getQueryString('page');
        $rp     = $this->getQueryString('rp');

        $page || $page = 1;
        intval($rp) > 0 || $rp = 10;

        $totalRequest = $this->model()->getTotalRequests();
        $this->view()->setVariable('totalRequest', $totalRequest);
        $pendingRequests = $this->model()->getTotalPendingRequests();

        $this->view()->setVariable('pendingRequests', $pendingRequests);

        $countRequests = $this->model()->countRequests($dateFrom, $dateTo);

        $pagination = $this->getPagination($page, $countRequests, $rp, 'client/clientpage');
        $this->view()->setVariable('pagination', $pagination);

        $this->model()->listRequests($dateFrom, $dateTo);
        $this->model()->setGridRowLink('request/viewrequest', 'id');
        $this->model()->addGridColumn('Pedido #', 'id');
        $this->model()->addGridColumn('', 'image', 'Image');
        $this->model()->addGridColumn('Cliente', 'client_name');
        $this->model()->addGridColumn('Telefones', 'phones');
        $this->model()->addGridColumn('Entrega', 'delivery_date', 'DateTime');
        $this->model()->addGridColumn('Status', 'request/statuslist.tpl', 'Tpl');
        $this->model()->setGridClass('table-bordered');

        $this->view()->setVariable('rows', $this->model()->getRow(0));
        $this->view()->setVariable('request_table', $this->model()->dbGrid());
        $this->view()->appendJs('requestpage');

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

        if (Core::isAjax())
            echo Html::AddClass('content-aligned', '#content');
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

        if ($result['status'] != 200) {
            $this->commitReplace($result['message'], '#message');
            $this->commitShow('#message');
            $this->terminate();
        }

        Session::del('requests', $this->request_id);

        if ($result['status'] == 200) {
            $this->requestPage();
            $this->terminate();
        }

    }

    /**
     * Data validation for new requests
     *
     * @param   array       $requestData    - The request data
     * @return  array
     */
    private function validateNewRequest($requestData) {

        $errors = array();

        !empty($requestData['client_id'])     || $errors[] = 'Você deve informar um cliente';
        !empty($requestData['address_id'])    || $errors[] = 'Você deve selecionar um endereço';
        !empty($requestData['delivery_date']) || $errors[] = 'Você deve selecionar uma data de entrega';

        return $errors;
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

        $errors = $this->validateNewRequest($requestData);

        if (count($errors) > 0)
            return RestServer::throwError(implode(', ', $errors));

        $request_id   = $this->model()->insertNewRequest($requestData);
        $result['id'] = $request_id;

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

        return RestServer::response(array(
            'status'    => 200,
            'request'   => $result
        ));
    }

    /**
     * Request Handler for viewing a request
     *
     */
    public function viewRequest() {

        $id           = $this->getQueryString('id');
        $this->model()->getRequestData($id);

        $request = $this->model()->getRow(0);
        $this->view()->loadTemplate('viewrequest');
        $this->view()->setVariable('request', $request);

        $this->model()->getAddress($request['client_id']);
        $addressList = $this->model()->getRows();

        $this->view()->setVariable('addressList', $addressList);
        $clientFields = array(
            'client_name',
            'phones',
            'image'
        );

        $client = array();
        foreach ($clientFields as $clientField)
            $client[$clientField] = $request[$clientField];


        $this->model()->getRequestItems($id);
        $requestItems = $this->model()->getRows();

        $plates = array(); $count_plates = 0;
        foreach($requestItems as $item) {
            in_array($item['plate_id'], array_keys($plates)) || $count_plates++;
            isset($plates[$item['plate_id']][$item['id']])   || $plates[$item['plate_id']][$item['id']] = $item;
        }

        $this->view()->setVariable('count_plates', $count_plates);
        $this->view()->setVariable('noChangeCustomer', false);
        $this->view()->setVariable('client', $client);
        $this->view()->setVariable('plates', $plates);
        $this->view()->setVariable('request_id', $id);
//        $this->view()->setVariable('productTable', $this->model()->dbGrid());

        $this->commitReplace($this->view()->render(), '#content');

    }

    /**
     * Handler for changing request inputs
     */
    public function changeRequest() {

        $plate_id           = $this->getQueryString('plate_id');
        $this->request_id   = $this->getQueryString('request_id');

        $this->view()->loadTemplate('searchproduct');
        $this->view()->setVariable('plate_id',   $plate_id);
        $this->view()->setVariable('request_id', $this->request_id);
        $this->view()->appendJs('events');
        $this->commitReplace($this->view()->render(), '#search-' . $plate_id);
        $this->commitShow('#searchproduct-' . $plate_id);
        $this->commitShow('#save-'   . $plate_id);
        $this->commitHide('#change-' . $plate_id);
    }

    /**
     * Handler for adding a plate item
     *
     * @param   array       $requestData    - The request data
     * @return  string
     */
    public function postAddItem(array $requestData = array()) {

        count($requestData) > 0 ||
            $requestData = $this->getPost();

        $result     = array();
        $plate_id   = $requestData['plate_id'];
        $plates = $requestData['plates'];

        foreach ($plates as $plate) {
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

        return RestServer::response($result);
    }

    /**
     * Handler for changing plate items
     */
    public function saveChange() {

        $plate_id         = $this->getQueryString('plate_id');
        $this->request_id = $this->getQueryString('request_id');

        $items = Session::get('requests', $this->request_id);
        $items['plate_id']  = $plate_id;
        $result = $this->postAddItem($items);

        if ($result['status'] == 200) {
            $this->commitHide('#searchproduct-' . $plate_id);
            $this->commitHide('#save-'   . $plate_id);
            $this->commitShow('#change-' . $plate_id);
            $this->commitReplace('', '#search-' . $plate_id);
            Session::del('requests', $this->request_id);
        }

    }

}