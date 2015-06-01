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
            'u.email',
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

        $this->addField('p.*');
        $this->addField('group_concat(s.station_name) as stations');

        $this->addFrom('profile p');
        $this->addFrom('LEFT JOIN station_members m ON m.profile_id = p.id');
        $this->addFrom('LEFT JOIN stations s ON s.id = m.station_id');

        $this->addWhere('p.id = "' . $id . '"');
        $this->addGroup('p.id');

        $this->runQuery();

        return !$this->isEmpty();
    }

    /**
     * Query to return a profile
     * by its uid
     *
     * @param   string      $uid        - The user UID
     * @return  bool
     */
    public function getProfileByUid($uid) {

        $this->addField('*');
        $this->addFrom('profile');
        $this->addWhere('uid = "' . $uid . '"');

        $this->runQuery();

        return !$this->isEmpty();
    }

    /**
     * Query to update user profile
     *
     * @param   array       $data       - The profile data
     * @param   string      $id         - The profile Id
     */
    public function updateUser($data, $id) {
        foreach ($data as $field => $value)
            $this->addUpdateSet($field, $value);

        $this->setUpdateTable('profile');
        $this->addUpdateWhere('id = "' . $id . '"');

        $this->runUpdate();
    }

    /**
     * Insert Query to add a user profile
     *
     * @param $data
     */
    public function addUser($data) {
        array_walk($data, function($item, $key) {
            $this->addInsertSet($key, $item);
        });

        $this->setInsertTable('profile');
        $this->runInsert();
    }

    public function getStationsList(){
        $this->addField('*');
        $this->addFrom('stations');

        $this->runQuery();

        return !$this->isEmpty();
    }

    public function getUserStations($uid){
        $this->addField('*');
        $this->addFrom('station_members');
        $this->addWhere("profile_id = {$uid}");

        $this->runQuery();

        return !$this->isEmpty();
    }

    public function updateUserStations($uid, $stations){
        $this->getUserStations($uid);

        $currentStations = $this->getRows(0);

        $formattedCurrentStations = array();
        foreach($currentStations as $value){
            $formattedCurrentStations[] = $value['station_id'];
            if(!in_array($value['station_id'], $stations)){
                $this->deleteUserStation($uid, $value['station_id']);
            }
        }
        foreach($stations as $value){
            if(!in_array($value, $formattedCurrentStations)){
                $this->insertUserStation($uid, $value);
            }
        }
    }

    public function insertUserStation($uid, $stationId){
        $this->addInsertSet('profile_id', $uid);
        $this->addInsertSet('station_id', $stationId);

        $this->setInsertTable('station_members');
        $this->runInsert();
    }

    public function deleteUserStation($uid, $stationId){
        $this->setDeleteFrom('station_members');

        $this->addDeleteWhere('profile_id = "' . $uid . '"');
        $this->addDeleteWhere('station_id = "' . $stationId . '"');

        $this->runDelete();
    }
}