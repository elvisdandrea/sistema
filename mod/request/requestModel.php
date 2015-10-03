<?php

/**
 * Class requestModel
 *
 */
class requestModel extends Model {

    /**
     * The constructor
     *
     * You may specify the connection name
     * ob the object instantiation
     *
     * @param   string      $connection     - The connection name used by this model
     */
    public function __construct($connection = DEFAULT_CONNECTION) {
        parent::__construct($connection);
    }

    /**
     * Query to get a list of requests
     *
     * @param string        $dateFrom       - Start Date
     * @param string        $dateTo         - End Date
     * @param string|bool   $status         - Request status
     * @param string|bool   $client_id      - A client Id
     * @param string|bool   $search         - Search string
     * @param int           $page           - The current page number
     * @param int           $rp             - The bumber of results per page
     */
    public function listRequests($dateFrom, $dateTo, $status = false, $client_id = false, $search = false, $page = 1, $rp = 10){

        $this->addField('r.id');
        $this->addField('r.request_date');
        $this->addField('r.delivery_date');
        //TODO: fix de double sum
        $this->addField('sum(i.price) / if(count(distinct f.id) > 0, count(distinct f.id) ,1) AS price');
        //----------------
        $this->addField('month(r.delivery_date) as request_month');
        $this->addField('day(r.delivery_date) as request_day');
        $this->addField('c.client_name');
        $this->addField('c.image');
        $this->addField('group_concat(distinct f.phone_number separator " -- ") as phones');
        $this->addField('s.status_name');
        $this->addField('s.color');

        $this->addFrom('requests r');
        $this->addFrom('left join clients c on c.id = r.client_id');
        $this->addFrom('left join client_phone f on f.client_id = c.id');
        $this->addFrom('left join delivery_status s on s.id = r.deliver_status');

        $this->addFrom('left join request_items i ON i.request_id = r.id');

        if (!empty($dateFrom) && !empty($dateTo))
            $this->addWhere('r.delivery_date BETWEEN "' . $dateFrom . '" AND "' . $dateTo . '"');

        if ($status)
            $this->addWhere('r.deliver_status = "' . $status . '"');

        if ($client_id)
            $this->addWhere('r.client_id = "' . $client_id . '"');

        if ($search)
            $this->addWhere($this->mountSearchString($search));

        $offset = intval(($page - 1) * $rp);

        $this->addLimit($offset . ',' . $rp);
        $this->addGroup('r.id');


        $this->runQuery();
    }

    private function mountSearchString($search) {

        $fields = array(
            'r.id',
            'r.request_date',
            'r.delivery_date',
            'c.client_name',
            's.status_name',
        );

        $result = array();
        foreach ($fields as $field) {
            $result[] = $field . ' like "%' . str_replace(' ', '%', $search) . '%"';
        }

        return '(' . implode(' OR ', $result) . ')';

    }

    /**
     * Returns the number of requests of a date
     *
     * @param   bool|string     $dateFrom       - Which date from
     * @param   bool|string     $dateTo         - Which date to
     * @param   bool|string     $status         - Which status
     * @param   bool|string     $client_id      - If it's request of a client
     * @param   bool|string     $search         - String Search based
     */
    public function countRequests($dateFrom, $dateTo, $status = false, $client_id = false, $search = false) {

        $this->addField('count(r.id) as mxm');
        $this->addFrom('requests r');

        if (!empty($dateFrom) && !empty($dateTo))
            $this->addWhere('r.delivery_date BETWEEN "' . $dateFrom . '" AND "' . $dateTo . '"');

        if ($status)
            $this->addWhere('r.deliver_status = "' . $status . '"');

        if ($client_id)
            $this->addWhere('r.client_id = "' . $client_id . '"');

        if ($search) {
            $this->addFrom('left join clients c on c.id = r.client_id');
            $this->addFrom('left join delivery_status s on s.id = r.deliver_status');
            $this->addWhere($this->mountSearchString($search));
        }


        $this->runQuery();

        $result = $this->getRow(0);

        return $result['mxm'];

    }


    public function getTotalRequests(){
        $this->addField('count(*) as mxm');
        $this->addFrom('requests r');
        $this->runQuery();

        $result = $this->getRow(0);

        return $result['mxm'];
    }

    public function getTotalPendingRequests($dateFrom = false, $dateTo = false, $client_id = false, $search = false){
        $this->addField('count(*) as mxm');
        $this->addFrom('requests r');
        $this->addWhere('r.deliver_status = 1');

        if (!empty($dateFrom) && !empty($dateTo))
            $this->addWhere('r.delivery_date BETWEEN "' . $dateFrom . '" AND "' . $dateTo . '"');

        if ($client_id)
            $this->addWhere('r.client_id = "' . $client_id . '"');

        if ($search) {
            $this->addFrom('left join clients c on c.id = r.client_id');
            $this->addFrom('left join delivery_status s on s.id = r.deliver_status');
            $this->addWhere($this->mountSearchString($search));
        }

        $this->runQuery();

        $result = $this->getRow(0);

        return $result['mxm'];
    }

    public function getTotalPriceRequests($dateFrom = false, $dateTo = false, $status = false, $client_id = false, $search = false) {

        $this->addField('sum(i.price) as total');
        $this->addFrom('request_items i');
        $this->addFrom('inner join requests r on r.id = i.request_id');

        if (!empty($dateFrom) && !empty($dateTo))
            $this->addWhere('r.delivery_date BETWEEN "' . $dateFrom . '" AND "' . $dateTo . '"');

        if ($status)
            $this->addWhere('r.deliver_status = "' . $status . '"');

        if ($client_id)
            $this->addWhere('r.client_id = "' . $client_id . '"');

        if ($search) {
            $this->addFrom('left join clients c on c.id = r.client_id');
            $this->addFrom('left join delivery_status s on s.id = r.deliver_status');
            $this->addWhere($this->mountSearchString($search));
        }

        $this->runQuery();

        $result = $this->getRow(0);

        return $result['total'];
    }

    /**
     * Query to list clients for a request
     *
     * @param   string      $search     - The search parameter
     */
    public function searchClientForRequest($search) {

        $fields = array(
            'c.client_name',
            'c.cpf_cnpj',
            'c.email',
            'c.corporate_name',
            'c.state_registration',
            'c.municipal_registration',
            'c.contact'
        );

        foreach ($fields as $field)
                $this->addField($field);

        $this->addField('c.id');
        $this->addField('group_concat(p.phone_number separator ",") as phones');
        $this->addField('c.client_type');
        $this->addField('c.image');

        $this->addFrom('clients c');
        $this->addFrom('left join client_phone p on p.client_id = c.id');

        foreach ($fields as $field)
            $this->addWhere($field . ' like "%' . str_replace(' ', '%', $search) . '%"', 'OR');

        $this->addWhere('p.phone_number like "%' . str_replace(' ', '%', $search) . '%"', 'OR');
        $this->addGroup('c.id');
        $this->addLimit('10');

        $this->runQuery();

    }

    /**
     * Query to get all client data
     * to be selected for a request
     *
     * @param   string      $id     - The client Id
     */
    public function selClientForRequest($id) {
        $fields = array(
            'c.id',
            'c.client_name',
            'c.cpf_cnpj',
            'c.email',
            'group_concat(p.phone_number separator ",") as phones',
            'c.corporate_name',
            'c.state_registration',
            'c.municipal_registration',
            'c.contact',
            'c.client_type',
            'c.image'
        );

        foreach ($fields as $field)
            $this->addField($field);


        $this->addFrom('clients c');
        $this->addFrom('left join client_phone p on p.client_id = c.id');
        $this->addWhere('c.id = "' . $id . '"');

        $this->runQuery();

    }

    /**
     * Query to list addresses of a client
     *
     * @param   string      $client_id      - The client Id
     */
    public function clientAddressListForRequest($client_id) {

        $this->addField('address_type');
        $this->addField('id');
        $this->addField('client_id');
        $this->addFrom('client_addr');
        $this->addWhere('client_id = "' . $client_id . '"');

        $this->runQuery();
    }

    /**
     * Query to get all data of a client address
     *
     * @param   string      $address_id     - The address Id
     */
    public function getClistAddressForRequest($address_id) {

        $this->addField('a.id');
        $this->addField('a.street_addr');
        $this->addField('a.address_type');
        $this->addField('a.street_number');
        $this->addField('a.street_additional');
        $this->addField('a.hood');
        $this->addField('a.city');
        $this->addField('a.zip_code');
        $this->addField('a.lat');
        $this->addField('a.lng');

        $this->addFrom('client_addr a');
        $this->addWhere('a.id = "' . $address_id . '"');
        $this->runQuery();

    }

    /**
     * Query to list products for a plate
     *
     * @param   string      $search     - The search parameter
     */
    public function searchProductForRequest($search) {

        $fields = array(
            'p.product_name',
            'p.description',
            'c.category_name'
        );

        foreach ($fields as $field)
            $this->addField($field);

        $this->addField('p.id');
        $this->addField('p.image');
        $this->addField('p.price');
        $this->addField('p.weight');
        $this->addField('p.unit');

        $this->addFrom('products p');
        $this->addFrom('left join categories c on c.id = p.category_id');

        foreach ($fields as $field)
            $this->addWhere($field . ' like "%' . str_replace(' ', '%', $search) . '%"', 'OR');

        $this->addLimit('20');

        $this->runQuery();

    }

    /**
     * Query for listing products
     *
     * @param $id
     */
    public function selectProductForRequest($id) {

        $this->addField('p.id');
        $this->addField('c.category_name');
        $this->addField('p.product_name');
        $this->addField('p.weight as product_weight');
        $this->addField('p.unit');
        $this->addField('p.price');
        $this->addField('p.image');
        $this->addField('p.description');
        $this->addField('p.product_fact');

        $this->addFrom('products p');
        $this->addFrom('left join categories c on c.id = p.category_id');

        $this->addWhere('p.id = "' . $id . '"');

        $this->runQuery();
    }

    /**
     * Creates new request
     *
     * @param   array       $data   - The request data
     * @return  bool|int
     */
    public function insertNewRequest(array $data) {

        $this->addInsertSet('request_date', 'now()', false);
        $this->addInsertSet('deliver_status', '1');

        foreach ($data as $field => $value)
            $this->addInsertSet($field, $value);

        $this->setInsertTable('requests');
        $this->runInsert();

        if ($this->queryOk())
            return $this->getLastInsertId();

        return false;
    }

    /**
     * Creates a new plate
     *
     * @param   array      $data    - The plate data
     * @return  bool|int
     */
    public function insertNewPlate(array $data) {

        $this->addInsertSet('request_id', $data['request_id']);
        $this->setInsertTable('request_plates');
        $this->runInsert();

        if ($this->queryOk())
            return $this->getLastInsertId();

        return false;
    }

    public function insertItem(array $data) {

        $this->addInsertSet('request_id', $data['request_id']);
        $this->addInsertSet('product_id', $data['product_id']);
        $this->addInsertSet('price', $data['price']);

        $this->setInsertTable('request_items');
        $this->runInsert();
        if ($this->queryOk())
            return $this->getLastInsertId();

        return false;
    }

    /**
     * Creates new plate item
     *
     * @param   array       $data       - The item data
     * @return  bool|int
     */
    public function insertPlateItem(array $data) {

        $this->addInsertSet('plate_id',     $data['plate_id']);
        $this->addInsertSet('product_id',   $data['product_id']);
        $this->addInsertSet('weight',       $data['weight']);
        $this->addInsertSet('price',        $data['price']);
        $this->addInsertSet('unit',         $data['unit']);

        $this->setInsertTable('request_plate_items');

        $this->runInsert();

        if ($this->queryOk())
            return $this->getLastInsertId();

        return false;
    }

    /**
     * Creates new plate item ingredient
     *
     * @param   array       $data       - The item data
     * @return  bool|int
     */
    public function insertItemIngredient(array $data){
        $this->addInsertSet('request_item_id', $data['request_item_id']);
        $this->addInsertSet('ingredient_name', $data['ingredient_name']);
        $this->addInsertSet('included', $data['included']);

        $this->setInsertTable('request_plate_item_ingredients');

        $this->runInsert();

        if ($this->queryOk())
            return $this->getLastInsertId();

        return false;
    }

    /**
     * Recovers a request information
     *
     * @param   string      $id     - The request Id
     */
    public function getRequestData($id) {

        $this->addField('r.id');
        $this->addField('r.request_date');
        $this->addField('r.delivery_date');
        $this->addField('month(r.delivery_date) as request_month');
        $this->addField('day(r.delivery_date) as request_day');
        $this->addField('r.address_id');
        $this->addField('r.client_id');
        $this->addField('a.address_type');
        $this->addField('a.street_addr');
        $this->addField('a.street_number');
        $this->addField('a.street_additional');
        $this->addField('a.hood');
        $this->addField('a.city');
        $this->addField('a.zip_code');
        $this->addField('a.lat');
        $this->addField('a.lng');
        $this->addField('c.client_name');
        $this->addField('c.image');
        $this->addField('group_concat(f.phone_number separator ",") as phones');
        $this->addField('s.status_name');
        $this->addField('s.color');

        $this->addFrom('requests r');
        $this->addFrom('left join clients c ON c.id = r.client_id');
        $this->addFrom('left join client_phone f ON f.client_id = c.id');
        $this->addFrom('left join delivery_status s ON s.id = r.deliver_status');
        $this->addFrom('left join client_addr a ON a.id = r.address_id');

        $this->addWhere('r.id = "' . $id . '"');
        $this->addGroup('r.id');

        $this->runQuery();

    }

    /**
     * Query that returns a request status
     *
     * @param   string          $id     - The request Id
     * @return  bool|string
     */
    public function getReqestStatus($id) {

        $this->addField('r.deliver_status');
        $this->addFrom('requests r');
        $this->addWhere('r.id = "' . $id . '"');

        $this->runQuery();

        if ($this->isEmpty()) return false;
        $result = $this->getRow(0);

        return $result['deliver_status'];

    }

    /**
     * Saves the request status change time
     *
     * @param   string      $id             - The request Id
     * @param   array       $changeData     - An array: from_status, to_status
     */
    public function saveStatusChangeTime($id, $changeData) {

        array_walk($changeData, function($value, $field) {
            $this->addInsertSet($field, $value);
        });

        $this->addInsertSet('request_id', $id);
        $this->addInsertSet('change_time', 'now()', false);

        $this->setInsertTable('request_status_change');

        $this->runInsert();

    }

    /**
     * Query that returns a specific client address
     *
     * @param   $id
     */
    public function getAddress($id) {

        $this->addField('a.id');
        $this->addField('a.client_id');
        $this->addField('a.address_type');
        $this->addField('a.street_addr');
        $this->addField('a.street_number');
        $this->addField('a.street_additional');
        $this->addField('a.hood');
        $this->addField('a.city');
        $this->addField('a.zip_code');
        $this->addField('a.lat');
        $this->addField('a.lng');

        $this->addFrom('client_addr a');
        $this->addWhere('client_id = "' . $id . '"');

        $this->runQuery();
    }

    /**
     * Query that returns all request items and plates
     *
     * @param $id
     */
    public function getRequestItems($id) {

        $this->addField('i.id');
        $this->addField('pr.product_name');
        $this->addField('pr.image');
        $this->addField('i.price');
        $this->addField('pr.price as product_price');
        $this->addField('pr.weight as product_weight');
        $this->addField('c.category_name');

        $this->addFrom('requests r');
        $this->addFrom('left join request_items i on i.request_id = r.id');
        $this->addFrom('left join products pr on pr.id = i.product_id');
        $this->addFrom('left join categories c on c.id = pr.category_id');

        $this->addWhere('r.id = "' . $id . '"');

        $this->runQuery();
    }

    public function getRequestItem($id) {

        $this->addField('i.id');
        $this->addField('i.plate_id');
        $this->addField('i.weight');
        $this->addField('i.unit');
        $this->addField('i.price');
        $this->addField('pr.price as product_price');

        $this->addFrom('request_items i');
        $this->addFrom('left join products pr on pr.id = i.product_id');
        $this->addWhere('i.id = "' . $id . '"');

        $this->runQuery();

    }

    /**
     * Returns the request final price
     *
     * @param   string      $id     - The request Id
     * @return  mixed
     */
    public function getRequestFinalPrice($id) {

        $this->addField('sum(price) as total');
        $this->addFrom('request_items i');
        $this->addWhere('i.request_id = "' . $id . '"');
        $this->runQuery();
        $result = $this->getRow(0);
        return $result['total'];
    }

    /**
     * Returns the product ingredient list
     *
     * @param   string      $id     - The product Id
     */
    public function getProductIngredients($id) {

        $this->addField('id');
        $this->addField('product_id');
        $this->addField('ingredient_name');
        $this->addFrom('product_ingredients');
        $this->addWhere('product_id = "' . $id . '"');

        $this->runQuery();
    }

    /**
     * Query that counts the number
     * of plates of a request
     *
     * @param   string      $id
     * @return  mixed
     */
    public function getRequestCountPlates($id) {

        $this->addField('count(id) as mxm');
        $this->addFrom('request_plates');
        $this->addWhere('request_id = "' . $id . '"');

        $this->runQuery();
        $result = $this->getRow(0);
        return $result['mxm'];

    }

    public function getStatusName($id) {
        //TODO: fazer por query
        $status = array(
            '', 'Novo pedido', 'Em andamento', 'Entregue', 'Cancelado', 'Finalizado'
        );

        if (isset($status[$id])) return $status[$id];

        return false;
    }

    /**
     * Query to update a request
     *
     * @param   string  $id             - The request Id
     * @param   array   $requestData    - The request data
     * @return  string
     */
    public function updateRequest($id, array $requestData) {

        foreach ($requestData as $field => $value)
            $this->addUpdateSet($field, $value);

        $this->setUpdateTable('requests');
        $this->addUpdateWhere('id = "' . $id . '"');

        $this->runUpdate();

        if ($this->queryOk()) {
            return $id;
        }

        return false;
    }

    /**
     * Removes an Item from a request
     *
     * @param   string      $id         - The item id
     */
    public function deleteItem($id) {

        $this->setDeleteFrom('request_items');
        $this->addDeleteWhere('id = "' . $id . '"');

        $this->runDelete();
    }

    /**
     * Query to update an item data
     *
     * @param   string      $id             - The item id
     * @param   array       $itemData       - The Item data
     */
    public function updateItem($id, array $itemData) {

        foreach ($itemData as $field => $value)
            $this->addUpdateSet($field, $value);

        $this->setUpdateTable('request_plate_items');
        $this->addUpdateWhere('id = "' . $id . '"');

        $this->runUpdate();

    }

    /**
     * Query to get all plate types
     */
    public function getPlateTypes($id = false) {

        $this->addField('id');
        $this->addField('plate_name');
        $this->addField('plate_size');

        $this->addFrom('plates');

        if ($id)
            $this->addWhere('id = "' . $id . '"');

        $this->runQuery();

    }

    public function seItemIngredientStatus($id, $status){
        $this->addUpdateSet('included', $status);

        $this->setUpdateTable('request_plate_item_ingredients');
        $this->addUpdateWhere('id = "' . $id . '"');

        $this->runUpdate();
    }

    public function getCart($client_id) {

        $this->addField('id');
        $this->addField('request_date');
        $this->addField('client_id');
        $this->addField('address_id');

        $this->addFrom('requests');

        $this->addWhere('client_id = "' . $client_id . '"');
        $this->addWhere('deliver_status = "1"');

        $this->runQuery();

        return !$this->isEmpty();
    }

    public function insertCart($client_id, $address_id = 0) {

        $this->addInsertSet('request_date', 'now()', false);
        $this->addInsertSet('deliver_status', '1');
        $this->addInsertSet('client_id', $client_id);
        $this->addInsertSet('address_id', $address_id);

        $this->setInsertTable('requests');

        $this->runInsert();

        if ($this->queryOk()) {
            return $this->getLastInsertId();
        }

        return false;

    }

    public function insertShippingData($shippingData) {

        foreach ($shippingData as $field => $value)
            $this->addInsertSet($field, $value);

        $this->setInsertTable('request_shipping');

        $this->runInsert();

        if ($this->queryOk())
            return $this->getLastInsertId();

        return false;

    }


}