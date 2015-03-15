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

    public function getClient($data){

    }


}