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
        return !$this->isEmpty();
    }

    public function getCountClients() {
        $this->addField('COUNT(id) AS total');
        $this->addFrom('clients');
        $this->runQuery();
        $result = $this->getRow(0);
        return $result['total'];
    }

    public function getClientList($page = 1, $rp = 10, $search = false){

        $total = $this->getCountClients();

        $fields = array(
            'cli.id',
            'cli.client_date',
            'cli.client_name',
            'cli.cpf_cnpj',
            'cli.corporate_name',
            'cli.state_registration',
            'cli.municipal_registration',
            'cli.contact',
            'cli.email',
            'fon.phone_number'
        );

        $this->addField('cli.id');
        $this->addField('cli.client_date');
        $this->addField('cli.client_name');
        $this->addField('cli.client_type');
        $this->addField('cli.cpf_cnpj');
        $this->addField('cli.corporate_name');
        $this->addField('cli.state_registration');
        $this->addField('cli.municipal_registration');
        $this->addField('cli.contact');
        $this->addField('cli.description');
        $this->addField('cli.image');
        $this->addField('cli.email');
        $this->addField('group_concat(fon.phone_number separator " -- ") as phones');

        $this->addFrom('clients cli');
        $this->addFrom('left join client_phone fon on fon.client_id = cli.id');

        if ($search) {
            foreach ($fields as $field)
                $this->addWhere($field . ' like "%' . str_replace(' ','%',$search) . '%"', 'OR');
        }

        $this->addGroup('cli.id');
        $offset = intval(($page - 1) * $rp);

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
        $this->addField('cdr.addr_main');

        $this->addFrom('client_addr cdr');
        $this->addWhere('cdr.client_id = "' . $id .'"');
        $this->runQuery();
    }

    public function getClientPhoneList($id){
        $this->addField('cph.id');
        $this->addField('cph.phone_type');
        $this->addField('cph.phone_number');

        $this->addFrom('client_phone cph');
        $this->addWhere('cph.client_id = "' . $id .'"');
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

    public function addClientPhone($data, $id){
        array_walk($data, function($item, $key) {
            $this->addInsertSet($key, $item);
        });

        $this->addInsertSet('client_id', $id);

        $this->setInsertTable('client_phone');
        $this->runInsert();
    }

    public function removeClientPhone($id){
        $this->setDeleteFrom('client_phone');
        $this->addDeleteWhere("id = {$id}");
        $this->runDelete();
    }

    public function findPhoneByNumber($phoneNumber){
        $this->addField('cph.id');
        $this->addField('cph.phone_type');
        $this->addField('cph.phone_number');

        $this->addFrom('client_phone cph');
        $this->addWhere('cph.phone_number = "' . $phoneNumber .'"');
        $this->runQuery();
    }

    public function changeClientMainAddr($id, $clientId){
        $this->addUpdateSet('addr_main', '0');

        $this->setUpdateTable('client_addr');
        $this->addUpdateWhere('id != "' . $id . '"');
        $this->addUpdateWhere('client_id = "' . $clientId . '"');

        $this->runUpdate();

        $this->addUpdateSet('addr_main', '1');
        $this->setUpdateTable('client_addr');
        $this->addUpdateWhere('id = "' . $id . '"');

        $this->runUpdate();
    }

    public function checkLogin($email, $passwd) {

        $this->addField('id');
        $this->addField('client_name');
        $this->addField('email');
        $this->addField('description');
        $this->addField('image');

        $this->addFrom('clients');

        $this->addWhere('email = "'  . $email  . '"');
        $this->addWhere('passwd = "' . $passwd . '"');

        $this->addLimit('1');

        $this->runQuery();

        return !$this->isEmpty();

    }

    public function getCountFavourites($client_id) {

        $this->addField('count(id) as fav');
        $this->addFrom('client_favs');

        $this->addWhere('client_id = "' . $client_id . '"');

        $this->runQuery();
        $result = $this->getRow(0);
        return $result['fav'];

    }

    public function getCountCart($client_id) {

        $this->addField('count(i.id) as cart');
        $this->addFrom('request_items i');
        $this->addFrom('inner join requests r on r.id = i.request_id');

        $this->addWhere('r.client_id = "' . $client_id . '"');
        $this->addWhere('r.deliver_status = "1"');

        $this->runQuery();
        $result = $this->getRow(0);
        return $result['cart'];
    }

    public function getCartItems($client_id) {

        $this->addField('i.id');
        $this->addField('i.request_id');
        $this->addField('i.product_id');
        $this->addField('i.price');
        $this->addField('p.product_name');
        $this->addField('p.image');
        $this->addField('p.description');
        $this->addFrom('request_items i');
        $this->addFrom('inner join requests r on r.id = i.request_id');
        $this->addFrom('inner join products p on p.id = i.product_id');

        $this->addWhere('r.client_id = "' . $client_id . '"');
        $this->addWhere('r.deliver_status = "1"');

        $this->runQuery();
        return !$this->isEmpty();
    }

}