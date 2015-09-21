<?php

/**
 * Class homeModel
 *
 * This is where you place your queries
 * No logic should be coded here, query functions only
 */
class orderModel extends Model {

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



}