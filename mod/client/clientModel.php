<?php

/**
 * Class clientModel
 *
 */
class clientModel extends Model {

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

    public function addClient($data){
        array_walk($data, function($item, $key) {
            $this->addInsertSet($key, $item);
        });

        $this->addInsertSet('client_date', 'NOW()', false);

        $this->setInsertTable('clients');
        $this->runInsert();
    }

    public function getClient($id){
        $this->addField('cli.id');
        $this->addField('cli.client_date');
        $this->addField('cli.client_name');
        $this->addField('cli.client_type');
        $this->addField('cli.cpf_cnpj');
        $this->addField('cli.phone_1');
        $this->addField('cli.phone_2');
        $this->addField('cli.corporate_name');
        $this->addField('cli.state_registration');
        $this->addField('cli.municipal_registration');
        $this->addField('cli.contact');
        $this->addField('cli.description');
        $this->addField('cli.image');
        $this->addField('cli.email');

        $this->addFrom('clients cli');
        $this->addWhere('cli.id = "' . $id . '"');
        $this->runQuery();
    }

    public function getCountClients() {
        $this->addField('COUNT(id) AS total');
        $this->addFrom('clients');
        $this->runQuery();
        $result = $this->getRow(0);
        return $result['total'];
    }

    public function getClientList($page = 1, $rp = 10){
        $total = $this->getCountClients();

        $this->addField('cli.id');
        $this->addField('cli.client_date');
        $this->addField('cli.client_name');
        $this->addField('cli.client_type');
        $this->addField('cli.cpf_cnpj');
        $this->addField('cli.phone_1');
        $this->addField('cli.phone_2');
        $this->addField('cli.corporate_name');
        $this->addField('cli.state_registration');
        $this->addField('cli.municipal_registration');
        $this->addField('cli.contact');
        $this->addField('cli.description');
        $this->addField('cli.image');
        $this->addField('cli.email');

        $this->addFrom('clients cli');

        $offset = intval($total / $rp * $page);

        $this->addLimit($offset . ',' . $rp);
        $this->runQuery();

        return $total;
    }

    public function updateClient($data, $id) {
        foreach ($data as $field => $value)
            $this->addUpdateSet($field, $value);

        $this->setUpdateTable('clients');
        $this->addUpdateWhere('id = "' . $id . '"');

        $this->runUpdate();
    }

    public function getClientAddrList($id){
        $this->addField('cdr.id');
        $this->addField('cdr.address_type');
        $this->addField('cdr.street_addr');
        $this->addField('cdr.street_number');
        $this->addField('cdr.street_additional');
        $this->addField('cdr.hood');
        $this->addField('cdr.city');
        $this->addField('cdr.zip_code');

        $this->addFrom('client_addr cdr');
        $this->addWhere('cdr.client_id = "' . $id .'"');
        $this->runQuery();
    }

    public function addClientAddress($data, $id){
        array_walk($data, function($item, $key) {
            $this->addInsertSet($key, $item);
        });

        $this->addInsertSet('client_id', $id);

        $this->setInsertTable('client_addr');
        $this->runInsert();
    }

    public function removeClientAddr($id){
        $this->setDeleteFrom('client_addr');
        $this->addDeleteWhere("id = {$id}");
        $this->runDelete();
    }

}