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

        $this->addField('u.uid');
        $this->addField('u.name');
        $this->addField('u.email');
        $this->addField('u.company_id');
        $this->addField('c.db_connection');
        $this->addFrom('users u');
        $this->addFrom('inner join companies c on c.id = u.company_id');
        $this->addWhere('u.secret = "' . $secret . '"');
        $this->addWhere('u.uid = "' . $uid . '"');

        $this->runQuery();
        return !$this->isEmpty();
    }

    /**
     * Validates login by username and password
     *
     * @param   string      $user       - The Username
     * @param   string      $pass       - Must be MD5 hashed
     * @return  bool
     */
    public function checkLogin($user, $pass) {

        $this->addField('u.*');
        $this->addField('c.company_name');
        $this->addField('c.street_address');
        $this->addField('c.street_number');
        $this->addField('c.street_additional');
        $this->addField('c.hood');
        $this->addField('c.city');
        $this->addField('c.phone_1');
        $this->addField('c.phone_2');
        $this->addField('c.cnpj');
        $this->addField('c.logo');
        $this->addField('c.db_connection');

        $this->addFrom('users u');
        $this->addFrom('inner join companies c on c.id = u.company_id');
        $this->addWhere('u.username = "' . $user . '"');
        $this->addWhere('u.passwd = "' . CR::encodeText($pass) . '"');
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

    /**
     * Query to update an user
     *
     * @param   array       $fields     - The field values
     * @param   string      $uid        - The user Id
     */
    public function updateUser($fields, $uid) {

        array_walk($fields, function($item, $key) {
            $this->addUpdateSet($key, $item);
        });

        $this->setUpdateTable('users');
        $this->addUpdateWhere('uid = "' . $uid . '"');
        $this->runUpdate();
    }

    /**
     * Query to get an user data
     *
     * @param   $uid        - The user UID
     */
    public function getUserData($uid) {

        $this->addField('*');
        $this->addFrom('users');
        $this->addWhere('uid = "' . $uid . '"');

        $this->runQuery();
    }



}