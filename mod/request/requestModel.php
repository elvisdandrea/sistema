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




}