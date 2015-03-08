<?php

/**
 * Class authModel
 *
 * The Model of user autnetication
 */

class authModel extends Model {

    public function __construct($connection = DEFAULT_CONNECTION) {
        parent::__construct($connection);
    }

    /**
     * Query that authenticates a user
     * by its secret
     *
     * @param   string      $uid
     * @param   string      $secret
     * @return  bool
     */
    public function authUser($uid, $secret) {

        $this->addField('uid');
        $this->addField('name');
        $this->addField('email');
        $this->addFrom('users');
        $this->addWhere('secret = "' . $secret . '"');
        $this->addWhere('uid = "' . $uid . '"');

        $this->runQuery();
        return !$this->isEmpty();
    }

    /**
     * Insert query to users table
     *
     * @param $fields
     */
    public function insertUser($fields) {

        array_walk($fields, function($item, $key) {
            $this->addInsertSet($key, $item);
        });

        $this->setInsertTable('users');
        $this->runInsert();
    }


}