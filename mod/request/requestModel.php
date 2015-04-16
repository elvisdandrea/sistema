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
     * Lists requests
     *
     * @param   string|bool     $date       - Delivery Date ( false for current date )
     */
    public function listRequests($dateFrom, $dateTo){

        $this->addField('r.id');
        $this->addField('r.request_date');
        $this->addField('r.delivery_date');
        $this->addField('month(r.delivery_date) as request_month');
        $this->addField('day(r.delivery_date) as request_day');
        $this->addField('c.client_name');
        $this->addField('c.image');
        $this->addField('group_concat(f.phone_number separator "<br>") as phones');
        $this->addField('s.status_name');
        $this->addField('s.color');

        $this->addFrom('requests r');
        $this->addFrom('left join clients c on c.id = r.client_id');
        $this->addFrom('left join client_phone f on f.client_id = c.id');
        $this->addFrom('left join delivery_status s on s.id = r.deliver_status');

        if (!empty($dateFrom) && !empty($dateTo))
            $this->addWhere('r.delivery_date BETWEEN "' . $dateFrom . '" AND "' . $dateTo . '"');

        $this->addGroup('r.id');

        $this->runQuery();
    }

    /**
     * Returns the number of requests of a date
     *
     * @param   bool    $date       - Which date ( false for curdate )
     */
    public function countRequests($dateFrom, $dateTo) {

        $this->addField('count(*) as mxm');
        $this->addFrom('requests r');

        if (!empty($dateFrom) && !empty($dateTo))
            $this->addWhere('r.delivery_date BETWEEN "' . $dateFrom . '" AND "' . $dateTo . '"');

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

    public function getTotalPendingRequests(){
        $this->addField('count(*) as mxm');
        $this->addFrom('requests r');
        $this->addWhere('r.deliver_status = 1');

        $this->runQuery();

        $result = $this->getRow(0);

        return $result['mxm'];
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

        $this->addWhere('p.phone_number like "%' . str_replace(' ', '%', $search) . '%"');
        $this->addGroup('c.id');

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

        $this->addField('a.street_addr');
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

        $this->addFrom('products p');
        $this->addFrom('left join categories c on c.id = p.category_id');

        foreach ($fields as $field)
            $this->addWhere($field . ' like "%' . str_replace(' ', '%', $search) . '%"', 'OR');

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
        $this->addField('p.weight');
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

        $this->setInsertTable('request_plate_items');

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
        $this->addField('c.client_name');
        $this->addField('c.image');
        $this->addField('group_concat(f.phone_number separator ",") as phones');
        $this->addField('s.status_name');
        $this->addField('s.color');

        $this->addFrom('requests r');
        $this->addFrom('left join clients c ON c.id = r.client_id');
        $this->addFrom('left join client_phone f ON f.client_id = c.id');
        $this->addFrom('left join delivery_status s ON s.id = r.deliver_status');

        $this->addWhere('r.id = "' . $id . '"');
        $this->addGroup('r.id');

        $this->runQuery();

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
        $this->addField('i.plate_id');
        $this->addField('i.weight');
        $this->addField('pr.product_name');
        $this->addField('pr.image');

        $this->addFrom('requests r');
        $this->addFrom('left join request_plates p on p.request_id = r.id');
        $this->addFrom('left join request_plate_items i on i.plate_id = p.id');
        $this->addFrom('left join products pr on pr.id = i.product_id');

        $this->addWhere('r.id = "' . $id . '"');

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



}