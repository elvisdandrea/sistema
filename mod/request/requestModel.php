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
            'client_name',
            'cpf_cnpj',
            'phone_1',
            'phone_2',
            'email',
            'corporate_name',
            'state_registration',
            'municipal_registration',
            'contact'
        );

        foreach ($fields as $field)
                $this->addField($field);

        $this->addField('id');
        $this->addField('client_type');
        $this->addField('image');

        $this->addFrom('clients');


        foreach ($fields as $field)
            $this->addWhere($field . ' like "%' . str_replace(' ', '%', $search) . '%"', 'OR');

        $this->runQuery();

    }

    public function selClientForRequest($id) {
        $fields = array(
            'id',
            'client_name',
            'cpf_cnpj',
            'phone_1',
            'phone_2',
            'email',
            'corporate_name',
            'state_registration',
            'municipal_registration',
            'contact',
            'client_type',
            'image'
        );

        foreach ($fields as $field)
            $this->addField($field);


        $this->addFrom('clients');

        $this->addWhere('id = "' . $id . '"');

        $this->runQuery();

    }



}