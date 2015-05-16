<?php

/**
 * Class requestModel
 *
 */
class profileModel extends Model {

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


    /**
     * Query that returns user profiles
     *
     * @param   int     $page       - Current page
     * @param   int     $rp         - Results per page
     * @param   bool    $search     - Search string
     * @return  mixed
     */
    public function getUserList($page = 1, $rp = 10, $search = false) {

        $total = $this->countProfiles();

        $fields = array(
            'u.id',
            'u.uid',
            'u.name',
            'u.street_address',
            'u.street_number',
            'u.street_additional',
            'u.hood',
            'u.city',
            'u.zip_code',
            'u.country',
            'u.phone_1',
            'u.phone_2',
            'u.email'
        );

        foreach ($fields as $field)
            $this->addField($field);

        $this->addField('u.image');

        $this->addFrom('profile u');

        if ($search) {
            foreach ($fields as $field)
                $this->addWhere($field . ' like "%' . str_replace(' ','%',$search) . '%"', 'OR');
        }

        $offset = intval(($page - 1) * $rp);
        $this->addLimit($offset . ',' . $rp);

        $this->runQuery();

        return $total;

    }

    /**
     * Returns the number of profiles
     *
     * @return  mixed
     */
    public function countProfiles() {

        $this->addField('count(*) as mxm');
        $this->addFrom('profile u');
        $this->runQuery();

        $result = $this->getRow(0);

        return $result['mxm'];

    }

    /**
     * Query to return a profile data
     *
     * @param  string     $id
     * @return bool
     */
    public function getProfile($id) {

        $this->addField('*');
        $this->addFrom('profile');
        $this->addWhere('id = "' . $id . '"');

        $this->runQuery();

        return !$this->isEmpty();
    }

    public function updateUser($data, $id) {
        foreach ($data as $field => $value)
            $this->addUpdateSet($field, $value);

        $this->setUpdateTable('profile');
        $this->addUpdateWhere('id = "' . $id . '"');

        $this->runUpdate();
    }


}