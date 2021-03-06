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
        $this->addField('cdr.state');
        $this->addField('cdr.zip_code');
        $this->addField('cdr.addr_main');

        $this->addFrom('client_addr cdr');
        $this->addWhere('cdr.client_id = "' . $id .'"');
        $this->runQuery();
        return !$this->isEmpty();
    }

    public function getAddress($id) {
        $this->addField('cdr.id');
        $this->addField('cdr.client_id');
        $this->addField('cdr.address_type');
        $this->addField('cdr.street_addr');
        $this->addField('cdr.street_number');
        $this->addField('cdr.street_additional');
        $this->addField('cdr.hood');
        $this->addField('cdr.city');
        $this->addField('cdr.state');
        $this->addField('cdr.zip_code');
        $this->addField('cdr.addr_main');

        $this->addFrom('client_addr cdr');
        $this->addWhere('cdr.id = "' . $id .'"');
        $this->runQuery();
        return !$this->isEmpty();
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

    public function getCartItems($client_id, $request_id = false) {

        $this->addField('i.id');
        $this->addField('i.request_id');
        $this->addField('i.product_id');
        $this->addField('i.price');
        $this->addField('p.product_name');
        $this->addField('p.image');
        $this->addField('p.description');
        $this->addField('p.weight');
        $this->addField('p.height');
        $this->addField('p.width');
        $this->addField('p.length');
        $this->addField('p.diameter');
        $this->addFrom('request_items i');
        $this->addFrom('inner join requests r on r.id = i.request_id');
        $this->addFrom('inner join products p on p.id = i.product_id');

        $this->addWhere('r.client_id = "' . $client_id . '"');
        $this->addWhere('r.deliver_status = "1"');
        if ($request_id)
            $this->addWhere('r.id = "' . $request_id . '"');

        $this->runQuery();
        return !$this->isEmpty();
    }

    public function addFavourite($client_id, $product_id) {

        $this->addInsertSet('client_id', $client_id);
        $this->addInsertSet('product_id', $product_id);

        $this->setInsertTable('client_favs');

        $this->runInsert();

        if ($this->queryOk()) {
            return $this->getLastInsertId();
        }

        return false;

    }

    public function getFavourites($client_id, $product_id = false) {

        $this->addField('*');
        $this->addFrom('client_favs');
        $this->addWhere('client_id = "' . $client_id . '"');

        if ($product_id) {
            $this->addWhere('product_id = "' . $product_id . '"');
        }

        $this->runQuery();

        return !$this->isEmpty();
    }

    public function getFavouriteItems($client_id) {

        $this->addField('f.id');
        $this->addField('f.client_id');
        $this->addField('f.product_id');
        $this->addField('p.product_name');
        $this->addField('p.weight');
        $this->addField('p.price');
        $this->addField('p.description');
        $this->addField('p.image');
        $this->addField('p.cover_image');

        $this->addFrom('client_favs f');
        $this->addFrom('inner join products p on p.id = f.product_id');

        $this->addWhere('f.client_id = "' . $client_id . '"');


        $this->runQuery();
        return !$this->isEmpty();
    }

    public function getOrders($client_id) {

        $this->addField('r.id');
        $this->addField('r.request_date');
        $this->addField('r.payment_date');
        $this->addField('r.deliver_status');
        $this->addField('d.status_name');
        $this->addField('r.client_id');
        $this->addField('r.final_price');
        $this->addField('c.client_name');
        $this->addField('c.email');
        $this->addField('i.id as item_id');
        $this->addField('p.id as product_id');
        $this->addField('p.product_name');
        $this->addField('p.description');
        $this->addField('p.image');
        $this->addField('s.shipping_code');
        $this->addField('s.shipping_value');
        $this->addField('s.delivery_time');
        $this->addField('t.shipping_type');

        $this->addFrom('requests r');
        $this->addFrom('left join clients c on c.id = r.client_id');
        $this->addFrom('left join request_items i on i.request_id = r.id');
        $this->addFrom('left join products p on p.id = i.product_id');
        $this->addFrom('left join delivery_status d on d.id = r.deliver_status');
        $this->addFrom('left join request_shipping s on s.request_id = r.id');
        $this->addFrom('left join shipping_types t on t.shipping_code = s.shipping_code');

        $this->addWhere('r.client_id = "' . $client_id . '"');
        $this->addOrder('r.payment_date desc');

        $this->runQuery();

        return !$this->isEmpty();

    }
}