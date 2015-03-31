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

    public function clientAddressListForRequest($client_id) {

        $this->addField('address_type');
        $this->addField('id');
        $this->addFrom('client_addr');
        $this->addWhere('client_id = "' . $client_id . '"');

        $this->runQuery();
    }

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



}