<?php

/**
 * Class requestControl
 *
 *
 */
class requestControl extends Control {

    /**
     * The module title
     *
     * This will be automatically
     * rendered on the Template Title bar
     */
    const module_title = 'Pedidos';

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
     * Returns current working Id
     *
     * @return int
     */
    public function getId() {

        return $this->request_id;
    }

    /**
     * Generates a new request Id
     */
    public function createId() {

        $this->request_id = uniqid();
        UID::set('requests', $this->request_id, array());
    }


    /**
     * Renders the main request page
     *
     */
    public function requestPage() {

        $this->view()->loadTemplate('requestpage');

        $dateFrom  = $this->getQueryString('date_from');
        $dateTo    = $this->getQueryString('date_to');
        $status    = $this->getQueryString('status');
        $client_id = $this->getQueryString('client_id');
        $search    = $this->getQueryString('search');

        $page   = $this->getQueryString('page');
        $rp     = $this->getQueryString('rp');

        $page || $page = 1;
        intval($rp) > 0 || $rp = 10;

        $countRequests   = $this->model()->countRequests($dateFrom, $dateTo, $status, $client_id, $search);

        $onRoadRequests  = $this->model()->countRequests($dateFrom, $dateTo, '2', $client_id, null);        // Caso deva considerar a pesquisa, incluir $search
        $pendingRequests = $this->model()->getTotalPendingRequests($dateFrom, $dateTo, $client_id, null);

        $totalPrice      = $this->model()->getTotalPriceRequests($dateFrom, $dateTo, $status, $client_id, $search);

        $this->view()->setVariable('totalRequest',    $countRequests);
        $this->view()->setVariable('onRoadRequests',  $onRoadRequests);
        $this->view()->setVariable('pendingRequests', $pendingRequests);
        $this->view()->setVariable('totalPrice',      String::convertTextFormat($totalPrice, 'currency'));
        $this->view()->setVariable('search',          $search);
        $this->view()->setVariable('client_id',       $client_id);

        $pagination = $this->getPagination($page, $countRequests, $rp, 'request/requestpage');
        $this->view()->setVariable('pagination', $pagination);

        $this->model()->listRequests($dateFrom, $dateTo, $status, $client_id, $search, $page, $rp);

        $this->newView('table');
        $this->view('table')->loadTemplate('requesttable');
        $this->view('table')->setVariable('list', $this->model()->getRows(0));

        if (!empty($dateFrom)) $this->view()->setVariable('dateFrom', $dateFrom);
        if (!empty($dateTo))   $this->view()->setVariable('dateTo', $dateTo);

        $this->view()->setVariable('rows', $this->model()->getRow(0));
        $this->view()->setVariable('request_table', $this->view('table')->render());
        $this->view()->appendJs('requestpage');

        $this->commitReplace($this->view()->render(), '#content');
    }

    /**
     * Returns the number of new requests
     *
     * @return mixed
     */
    public function countNewRequests() {

        $this->model()->countRequests(null, null, '1');
        $result = $this->model()->getRow(0);
        return $result['mxm'];
    }

    /**
     * Returns a list of new requests
     *
     * @return mixed
     */
    public function listNewRequests() {

        $this->model()->listRequests(null, null, '1');
        return $this->model()->getRows();
    }

    /**
     * New Request Page and form
     */
    public function newRequest() {

        $client_id = $this->getQueryString('client_id');
        if ($client_id) {
            $this->newView('client');
            UID::set('requests', $this->request_id, 'client_id', $client_id);
            $this->model()->selClientForRequest($client_id);
            $this->commitReplace('', '#client-results');
            $this->view('client')->loadTemplate('clientprofile');
            $this->view('client')->setVariable('client', $this->model()->getRow(0));
            $this->model()->getAddress($client_id);
            $this->view('client')->setVariable('request_id', $this->request_id);
            $this->view('client')->setVariable('addressList', $this->model()->getRows());
            $this->view()->setVariable('client', $this->view('client')->render());
        }

        $this->createId();
        $this->view()->setVariable('request_id', $this->request_id);
        $this->view()->setVariable('newrequest', true);
        $this->view()->setVariable('action', 'selproductnew');

        $this->view()->loadTemplate('newrequest');
        $this->view()->appendJs('events');
        $this->view()->appendJs('newrequest');
        $this->commitReplace($this->view()->render(), '#content');

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

        $this->view()->setVariable('countClient', count($clients));
        $this->view()->setVariable('clients', $clients);
        $this->view()->setVariable('search', $search);
        $this->view()->setVariable('request_id', $this->request_id);
        $this->commitReplace($this->view()->render(),'#client-results');
        $this->commitShow('#clientresult');
    }

    /**
     * Sets a client to the current request
     *
     * @param   string|bool     $id             - The client Id ( false to get from querystring )
     * @param   string|bool     $address_id     - The pre-selected address_id
     */
    public function selClient($id = false, $address_id = false) {
        $this->setId();
        $id || $id = $this->getQueryString('id');
        UID::set('requests', $this->request_id, 'client_id', $id);
        $this->model()->selClientForRequest($id);
        $this->commitReplace('', '#client-results');
        $this->view()->loadTemplate('clientprofile');
        $this->view()->setVariable('client', $this->model()->getRow(0));
        $this->model()->getAddress($id);
        $this->view()->setVariable('request_id', $this->request_id);
        $addressList = $this->model()->getRows();
        $this->view()->setVariable('addressList', $addressList);

        if ($address_id) foreach ($addressList as $row) {
            if ($address_id == $row['id']) {
                $this->view()->setVariable('request', $row);
                break;
            }
        }

        $this->commitSetValue('#client_id', $id);
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
        UID::set('requests', $this->request_id, 'address_id', $id);
        $this->model()->getClistAddressForRequest($id);

        $this->view()->loadTemplate('seladdress');
        $this->view()->setVariable('address', $this->model()->getRow(0));

        $this->commitReplace($this->view()->render(), '#seladdress');
        $this->commitAddClass('btn-success', '#addressbtn');
        $this->commitRemoveClass('btn-info', '#addressbtn');

    }

    /**
     * Searches a product for a plate
     */
    public function searchProduct() {

        $this->setId();
        $search   = $this->getQueryString('search');

        if (empty($search))
            $this->commitReplace('','#product-results', false);

        $action = $this->getQueryString('action');
        $action || $action = 'selproduct';

        $this->model()->searchProductForRequest($search);
        $this->view()->loadTemplate('productresult');
        $products = $this->model()->getRows();
        $this->view()->setVariable('products', $products);
        $this->view()->setVariable('action', $action);
        $this->view()->setVariable('search', $search);
        $this->view()->setVariable('request_id', $this->request_id);

        $this->commitReplace($this->view()->render(),'#product-results');
        $this->commitShow('#result');
    }


    public function selProduct() {

        $this->setId();
        $product_id = $this->getQueryString('id');
        $request_id = $this->getQueryString('request_id');
        $action     = $this->getQueryString('action');
        $rowId      = uniqid();

        $this->commitReplace('', '#product-results');
        $this->model()->selectProductForRequest($product_id);
        $item = $this->model()->getRow(0);

        if ($action == 'selproductnew') {
            $this->view()->setVariable('newrequest', true);

            $curTotalPrice = intval(UID::get( 'requests', $this->request_id, 'price'));
            $newTotalPrice = $curTotalPrice + $item['price'];
            UID::set('requests', $this->request_id, 'price', $newTotalPrice);
            UID::set('requests', $this->request_id, 'items', $rowId, $item);
        } else {

        }

        $this->view()->loadTemplate('item');
        $this->view()->setVariable('item',       $item);
        $this->view()->setVariable('id',         $product_id);
        $this->view()->setVariable('request_id', $this->request_id);
        $this->view()->setVariable('action',     $action);
        $this->view()->setVariable('rowId',      $rowId);

        $this->commitAdd($this->view()->render(), '#itemlist');
        $this->commitReplace('Total do pedido: ' . String::convertTextFormat($newTotalPrice, 'currency'), '[data-id="totalprice"]');

    }

    /**
     * Saves a request
     */
    public function addNewRequest() {

        $this->setId();
        $post  = $this->getPost();
        $items = UID::get('requests', $this->request_id);

        $requestData = array(
            'client_id'     => $post['client_id'],
            'address_id'    => $post['address_id'],
            'delivery_date' => String::formatDateTimeToSave($post['delivery_date']),
            'items'        =>  $items['items']
        );

        $result = $this->postAddRequest($requestData);

        if ($result['status'] != 200) {
            $this->view()->showAlert('danger','', $result['message']);
            $this->commitAdd($this->view()->render(), 'body');
            $this->terminate();
        }

        UID::del('requests', $this->request_id);

        if ($result['status'] == 200) {
            $this->commitAdd($this->view()->showAlert('success','','Pedido salvo!'),'body');
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
        $items  = array();

        if (isset($requestData['items'])) {
            $items = $requestData['items'];
            unset($requestData['items']);
        }

        $errors = $this->validateNewRequest($requestData);

        if (count($errors) > 0)
            return RestServer::throwError(implode(', ', $errors));

        $request_id   = $this->model()->insertNewRequest($requestData);
        $result['id'] = $request_id;

        foreach ($items as $product) {

            $item_id = $this->model()->insertItem(
                array(
                    'product_id'    => $product['id'],
                    'request_id'    => $request_id,
                    'price'         => $product['price']
                )
            );
            $result['items'][] = $item_id;
        }

        return RestServer::response(array(
            'status'    => 200,
            'request'   => $result
        ));
    }

    public function getCart() {

        $result = $this->model()->getCart($this->getQueryString('client_id'));

        if ($result) {
            return RestServer::response(array(
                'status'    => 200,
                'cart'      => $this->model()->getRow(0)
            ));
        }

        return RestServer::response(array(
            'status'    => 200,
            'cart'      => 0
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

        $this->model()->getPlateTypes();

        $this->model()->getRequestItems($id);
        $requestItems = $this->model()->getRows();
        $plates       = array(); $count_plates = 0;
        $plate_names  = array();

        $this->view()->appendJs('checkbox');

        $this->view()->setVariable('count_plates', $count_plates);
        $this->view()->setVariable('noChangeCustomer', false);
        $this->view()->setVariable('client', $client);
        $this->view()->setVariable('plates', $plates);
        $this->view()->setVariable('plate_names', $plate_names);
        $this->view()->setVariable('request_id', $id);
        $this->view()->setVariable('request_items', $requestItems);
        $this->view()->setVariable('finalPrice', String::convertTextFormat($this->model()->getRequestFinalPrice($id), 'currency'));

        $this->view()->appendJs('events');
        $this->view()->appendJs('viewrequest');

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

        if (!isset($requestData['price']) || intval($requestData['price']) == 0) {
            $product = new productControl();
            $productData = $product->findProduct($requestData['product_id']);
            if (!$productData) {
                RestServer::throwError('Ocorreu um erro ao acessar as informações do produto. Por favor, entre em contato conosco');
            }
            $requestData['price'] = $productData['price'];
        }

        $item_id = $this->model()->insertItem(
            array(
                'request_id'    => $requestData['request_id'],
                'product_id'    => $requestData['product_id'],
                'price'         => $requestData['price']
            )
        );

        return RestServer::response(array('item_id' => $item_id));

    }

    /**
     * Handler for changing plate items
     *
     * @param   string|bool     $plate_id
     * @param   string|bool     $request_id
     */
    public function saveChange($plate_id = false, $request_id = false) {

        $plate_id   || $plate_id   = $this->getQueryString('plate_id');
        $request_id || $request_id = $this->getQueryString('request_id');

        $this->request_id = $request_id;

        $items = UID::get( 'requests', $this->request_id);
        $items['plate_id']  = $plate_id;
        $result = $this->postAddItem($items);

        if ($result['status'] == 200) {
            $this->commitHide('#searchproduct-' . $plate_id);
            $this->commitHide('#save-'   . $plate_id);
            $this->commitShow('#change-' . $plate_id);
            $this->commitReplace('', '#search-' . $plate_id);
            UID::del('requests', $this->request_id);
        }

    }

    /**
     * Rest Handler to Update request status
     *
     * @param   array               $requestData    - The request data
     * @return  array|string
     * @throws  ExceptionHandler
     */
    public function updateSetStatus(array $requestData = array()) {

        count($requestData) > 0 ||
        $requestData = $this->getPost();

        if (!isset($requestData['id']))
            return RestServer::throwError('Você deve informar o Id', 400);

        if (!isset($requestData['deliver_status']))
            return RestServer::throwError('Você deve informar o novo status', 400);

        $id = $requestData['id'];
        unset($requestData['id']);

        $from_status = $this->model()->getReqestStatus($id);
        $to_status   = $requestData['deliver_status'];

        if (!$from_status)
            return RestServer::throwError('O pedido #' . $id . 'não foi encontrado', 400);

        $this->model()->updateRequest($id, $requestData);
        $this->model()->saveStatusChangeTime($id, array(
            'from_status'   => $from_status,
            'to_status'     => $to_status
        ));

        return RestServer::response(array('status' => 200));

    }

    public function putRequest() {

        debug($this->getPut());
        $requestData = $this->getPut();

        if ($this->getId() == 0)
            return RestServer::throwError('Você deve informar um número de pedido');

        $result = $this->model()->updateRequest($this->getId(), $requestData);

        if (!$result) {
            return RestServer::throwError('Pedido não pôde ser atualizado');
        }

        return RestServer::response(array(
            'status'        => 200,
            'request_id'    => $this->getId()
        ));

    }

    /**
     * Handler to Update request status
     *
     * @param   bool    $request_id     - The request Id
     * @param   bool    $status         - The new status Id
     */
    public function setStatus($request_id = false, $status = false) {

        $status     || $status     = $this->getQueryString('status');
        $request_id || $request_id = $this->getQueryString('id');

        $result = $this->updateSetStatus(array(
            'id'             => $request_id,
            'deliver_status' => $status
        ));

        if ($result['status'] != 200) {
            //TODO: gerar mensagem de erro
            $this->terminate();
        }

        $row = array(
            'id'          => $request_id,
            'status_name' => $this->model()->getStatusName(intval($status))
        );

        $table = $this->getQueryString('table');

        if ($table) {
            $index = $this->getQueryString('index');
            $field = $this->getQueryString('field');

            $this->view()->setVariable('table', $table);
            $this->view()->setVariable('index', $index);
            $this->view()->setVariable('field', $field);
            $this->view()->setVariable('row',   $row);
            $this->view()->loadTemplate('statuslist');
            $this->commitReplace($this->view()->render(), '#' . $table . '_' . $index . '_' . $field);
        } else {
            $this->view()->setVariable('request', $row);
            $this->view()->loadTemplate('statuslistrequest');
            $this->commitReplace($this->view()->render(), '#request-status' . $request_id);
        }

    }

    /**
     * Sets new Request Delivery Date
     */
    public function setDate() {

        $id      = $this->getQueryString('id');
        $newdate = String::formatDateTimeToSave($this->getPost('newdate'));

        if (empty($newdate)) {
            //TODO: show a tough error here
            $this->terminate();
        }

        $this->model()->updateRequest($id, array(
            'delivery_date' => $newdate
        ));
    }

    /**
     * Rest Handler to remove a request item
     *
     * @param   array               $requestData    - The data
     * @return  array|string
     * @throws  ExceptionHandler
     */
    public function deleteRemoveItem(array $requestData = array()) {

        $item_id = $requestData['id'];
        $this->model()->deleteItem($item_id);

        if (!$this->model()->queryOk()) {
            return RestServer::throwError(Language::QUERY_ERROR(), 500);
        }

        return RestServer::response(array(
            'status'    => 200,
            'message'   => 'Item removido!',
        ), 200);
    }

    /**
     * Handler to remove a request item
     */
    public function removeItem() {

        $this->setId();
        $action     = $this->getQueryString('action');
        $plate_id   = $this->getQueryString('plate_id');
        $request_id = $this->getQueryString('request_id');

        if ($action == 'remproductnew') {

            $item       = UID::get( 'requests', $this->request_id, 'plates', $plate_id, $this->getQueryString('id'));

            $curTotalprice = UID::get( 'requests', $this->request_id, 'price');
            $newTotalPrice = $curTotalprice - $item['price'];

            UID::set('requests', $this->request_id, 'price', $newTotalPrice);
            UID::del('requests', $this->request_id, 'plates', $plate_id, $this->getQueryString('id'));
            $plate_fill = UID::get('requests', $this->request_id, 'plate_data', $plate_id, 'plate_fill');
            UID::set('requests', $this->request_id, 'plate_data', $plate_id, 'plate_fill', $plate_fill - $item['weight']);
        } else {
            $this->deleteRemoveItem(array(
                'id'    => $this->getQueryString('id')
            ));
            $newTotalPrice = $this->model()->getRequestFinalPrice($request_id);
        }

        $this->commitRemove('#' . $this->getQueryString('row_id'));
        $this->commitRemove('#ingredients_' . $this->getQueryString('row_id'));
        $this->commitReplace('Total do pedido: ' . String::convertTextFormat($newTotalPrice, 'currency'), '[data-id="totalprice"]');
    }

    /**
     * Handler to set a new delivery address
     */
    public function setAddress() {

        $id         = $this->getQueryString('id');
        $request_id = $this->getQueryString('request_id');
        $client_id  = $this->getQueryString('client_id');

        $requestData = array(
            'address_id'    => $id
        );

        $this->model()->updateRequest($request_id, $requestData);
        $this->model()->getClistAddressForRequest($id);

        $this->view()->loadTemplate('seladdress');
        $this->view()->setVariable('address', $this->model()->getRow(0));

        $this->commitReplace($this->view()->render(), '#seladdress');
        $this->commitAddClass('btn-success', '#addressbtn');
        $this->commitRemoveClass('btn-info', '#addressbtn');

    }

    /**
     * Adds a portion to a request item
     */
    public function addItemPortion() {

        $id         = $this->getQueryString('id');
        $request_id = $this->getQueryString('request_id');
        $plate_id   = $this->getQueryString('plate_id');
        $amount     = $this->getQueryString('amount');
        $action     = $this->getQueryString('action');

        if ($action == 'selproductnew') {
            $this->setId();
            $weight   = UID::get( 'requests', $this->request_id, 'plates', $plate_id, $id, 'weight');
            $curprice = UID::get( 'requests', $this->request_id, 'plates', $plate_id, $id, 'price');

            $newValue = $weight + $amount;
            $this->model()->selectProductForRequest($id);
            $item          = $this->model()->getRow(0);

            $plate_size = UID::get('requests', $this->request_id, 'plate_data', $plate_id, 'plate_size');
            $plate_fill = UID::get('requests', $this->request_id, 'plate_data', $plate_id, 'plate_fill');

            if ($item['product_weight'] + $plate_fill > $plate_size) {
                $this->commitAdd($this->view()->showAlert('danger','','Este prato já está cheio'),'body');
                $this->terminate();
            }

            $curTotalprice = UID::get( 'requests', $this->request_id, 'price');
            $newTotalPrice = $curTotalprice + $item['price'];
            $newPrice      = $curprice + $item['price'];
            UID::set('requests', $this->request_id, 'price', $newTotalPrice);
            UID::set('requests', $this->request_id, 'plates', $plate_id, $id, 'weight', $newValue);
            UID::set('requests', $this->request_id, 'plates', $plate_id, $id, 'price',  $newPrice);
            UID::set('requests', $this->request_id, 'plate_data', $plate_id, 'plate_fill', $item['product_weight'] + $plate_fill);
            $id = $this->getQueryString('item_id');
        } else {
            $this->model()->getRequestItem($id);
            $item     = $this->model()->getRow(0);
            $weight   = $item['weight'];
            $newValue = $weight + $amount;
            $newPrice = $item['price'] + $item['product_price'];

            $this->model()->updateItem($id, array(
                'weight'    => $newValue,
                'price'     => $newPrice
            ));

            $newTotalPrice = $this->model()->getRequestFinalPrice($request_id);
        }

        $this->commitReplace($newValue . $item['unit'], '#amount_' . $plate_id . '_' . $id);
        $this->commitReplace(String::convertTextFormat($newPrice, 'currency'), '#price_'  . $plate_id . '_' . $id);
        $this->commitReplace('Total do pedido: ' . String::convertTextFormat($newTotalPrice, 'currency'), '[data-id="totalprice"]');
    }

    /**
     * Drops a portion of a request item
     */
    public function dropItemPortion() {

        $id         = $this->getQueryString('id');
        $request_id = $this->getQueryString('request_id');
        $plate_id   = $this->getQueryString('plate_id');
        $amount     = $this->getQueryString('amount');
        $action     = $this->getQueryString('action');

        if ($action == 'selproductnew') {
            $this->setId();
            $weight   = UID::get( 'requests', $this->request_id, 'plates', $plate_id, $id, 'weight');
            $curprice = UID::get( 'requests', $this->request_id, 'plates', $plate_id, $id, 'price');
            $newValue = $weight - $amount;
            if ($newValue <= 0) return;
            $this->model()->selectProductForRequest($id);
            $item          = $this->model()->getRow(0);
            $curTotalprice = UID::get( 'requests', $this->request_id, 'price');
            $newTotalPrice = $curTotalprice - $item['price'];
            $newPrice      = $curprice - $item['price'];

            $plate_fill = UID::get('requests', $this->request_id, 'plate_data', $plate_id, 'plate_fill');

            UID::set('requests', $this->request_id, 'price', $newTotalPrice);
            UID::set('requests', $this->request_id, 'plates', $plate_id, $id, 'weight', $newValue);
            UID::set('requests', $this->request_id, 'plates', $plate_id, $id, 'price',  $newPrice);
            UID::set('requests', $this->request_id, 'plate_data', $plate_id, 'plate_fill', $plate_fill - $item['product_weight']);
            $id = $this->getQueryString('item_id');
        } else {
            $this->model()->getRequestItem($id);
            $item     = $this->model()->getRow(0);
            $weight   = $item['weight'];
            $newValue = $weight - $amount;

            if ($newValue <= 0) return;

            $newPrice = $item['price'] - $item['product_price'];

            $this->model()->updateItem($id, array(
                'weight'    => $newValue,
                'price'     => $newPrice
            ));

            $newTotalPrice = $this->model()->getRequestFinalPrice($request_id);
        }


        $this->commitReplace($newValue . $item['unit'], '#amount_' . $plate_id . '_' . $id);
        $this->commitReplace(String::convertTextFormat($newPrice, 'currency'), '#price_'  . $plate_id . '_' . $id);
        $this->commitReplace('Total do pedido: ' . String::convertTextFormat($newTotalPrice, 'currency'), '[data-id="totalprice"]');
    }

    /**
     * Handler to set a plate size
     */
    public function setPlateSize() {

        $this->setId();
        $plate_id = $this->getQueryString('plate_id');
        $type_id  = $this->getQueryString('id');

        $this->model()->getPlateTypes($type_id);
        if ($this->model()->isEmpty()) {
            $this->commitAdd($this->view()->showAlert('danger','','Ocorreu um erro ao localizar o tipo de prato selecionado'), 'body');
            $this->terminate();
        }

        $result = $this->model()->getRow(0);

        $plate_fill = UID::get('requests', $this->request_id, 'plate_data', $plate_id, 'plate_fill');

        if ($result['plate_size'] < $plate_fill) {
            $this->commitAdd($this->view()->showAlert('danger','','O tamanho selecionado é menor que sua quantidade. Remova alguns itens para diminuir este prato.'), 'body');
            $this->terminate();
        }

        UID::set('requests', $this->request_id, 'plate_data', $plate_id, 'plate_size', $result['plate_size']);
        UID::set('requests', $this->request_id, 'plate_data', $plate_id, 'plate_name', $result['plate_name']);
    }

    public function addclient() {

        $client = new clientControl();
        $result = $client->postAddClient();
        if ($result['status'] != 200) {
            $this->commitAdd($this->view()->showAlert('danger', '', $result['message']) ,'body');
            $this->terminate();
        }

        $this->commitAdd($this->view()->showAlert('success', '', 'Cliente cadastrado com sucesso') ,'body');
        $this->view()->appendJs('saveclient');
        $this->selClient($result['uid'], $result['address_id']);

    }

    /*
     * TODO: rever isto, o ideal seria centralizar tudo de cliente no controller de clientes
     * */
    public function addclientaddress(){
        $address = new clientControl();
        $address->addClientAddr();

    }

    /*
     * TODO: Está duplicando código, melhor rever isto. É "quase" um Ctrl C + Ctrl V de clientControl->validateDataForClient
     * */
    private function validateDataForClientAddress($postData){
        $return = array(
            'valid'     => true,
            'message'   => '',
        );

        if(empty($postData['street_addr'])){
            $return['valid']     = false;
            $return['message'][] = "Favor informar o endereço do cliente";
        }

        if(empty($postData['hood'])){
            $return['valid']     = false;
            $return['message'][] = "Favor informar o bairro do cliente";
        }

        if(empty($postData['city'])){
            $return['valid']     = false;
            $return['message'][] = "Favor informar a cidade do cliente";
        }

        if(empty($postData['street_number'])){
            $return['valid']     = false;
            $return['message'][] = "Favor verificar o numero do endereço do cliente";
        }

        return $return;
    }

    public function setIngredientStatusNewRequest(){
        $itemId = $this->getQueryString('item_id');
        $ingredient = explode('_', $itemId);

        $requestId = $ingredient[0];
        $plateId = $ingredient[1];
        $itemId = $ingredient[2];
        $ingredientName = $ingredient[3];
        $statusIngredient = $ingredient[4];

        UID::set('requests', $requestId, 'plates', $plateId, $itemId, 'ingredients', $ingredientName, $statusIngredient);
    }

    public function setIngredientStatus(){
        $itemId = $this->getQueryString('item_id');
        $ingredient = explode('_', $itemId);

        $ingredientId = $ingredient[0];
        $statusIngredient = $ingredient[1];

        $this->model()->seItemIngredientStatus($ingredientId, $statusIngredient);
    }

    public function postAddCart() {

        //TODO: validate if client exists

        $cart_id = $this->model()->insertCart($this->getPost('client_id'));

        if (!$cart_id) {
            return RestServer::response(array(
                'status'    => 500,
                'message'   => $this->model()->getError()
            ));
        }

        return RestServer::response(array(
            'status'    => 200,
            'cart'      => array('id' => $cart_id)
        ));
    }

    public function postPurchase() {

        $orderData = array(
            'address_id'        => $this->getPost('address_id'),
            'deliver_status'    => '2',
            'payment_date'      => date('Y-m-d h:i:s'),
            'final_price'       => $this->getPost('price'),
            'pay_hash'          => $this->getPost('pay_hash')
        );

        $this->model()->updateRequest($this->getPost('request_id'), $orderData);

        if (!$this->getPost('address_id')) {
            return RestServer::throwError('O endereço de entrega não foi informado');
        }

        $shipping_data = array(
            'request_id'        => $this->getPost('request_id'),
            'shipping_code'     => $this->getPost('shipping_code'),
            'shipping_value'    => $this->getPost('shipping_value'),
            'delivery_time'     => $this->getPost('delivery_time'),
            'hand_value'        => $this->getPost('hand_value'),
            'notify_value'      => $this->getPost('notify_value'),
            'recover_value'     => $this->getPost('recover_value'),
            'home_delivery'     => $this->getPost('home_delivery'),
            'weekend_delivery'  => $this->getPost('weekend_delivery')
        );

        $shipping_id = $this->model()->insertShippingData($shipping_data);

        if (!$shipping_id) {
            return RestServer::throwError('Não foi possível salvar a informação de entrega');
        }


        return RestServer::response(array(
            'status'        => 200,
            'request_id'    => $this->getPost('request_id'),
            'address_id'    => $this->getPost('address_id'),
            'shipping_id'   => $shipping_id
        ));

    }

    public function deleteItem() {

        $this->model()->deleteItem($this->getId());

        return RestServer::response(array(
            'status'    => 200,
            'item'      => $this->getId()
        ));

    }
}