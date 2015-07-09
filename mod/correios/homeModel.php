<?php

/**
 * Class correiosModel
 *
 * This is where you place your queries
 * No logic should be coded here, query functions only
 */
class correiosModel extends Model {

    /**
     * The constructor
     *
     * You may specify the connection name
     * ob the object instantiation
     *
     * @param   string      $connection     - The connection name used by this model
     */
    public function __construct($connection = 'auth') {
        parent::__construct($connection);
    }



}