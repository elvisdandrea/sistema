<?php

/**
 * Class stationsModel
 *
 */
class stationsModel extends Model {

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
     * Query that returns stations
     *
     * @param   int     $page       - Current page
     * @param   int     $rp         - Results per page
     * @param   bool    $search     - Search string
     * @return  mixed
     */
    public function getStationsList($page = 1, $rp = 10, $search = false) {

        $total = $this->countStations();

        $fields = array(
            's.id',
            's.phone',
            's.station_name',
            's.street_address',
            's.street_number',
            's.street_additional',
            's.hood',
            's.city',
            's.country'
        );

        foreach ($fields as $field)
            $this->addField($field);

        $this->addField('s.image');

        $this->addFrom('stations s');

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
     * Returns the number of stations
     *
     * @return  mixed
     */
    public function countStations() {

        $this->addField('count(*) as mxm');
        $this->addFrom('stations s');
        $this->runQuery();

        $result = $this->getRow(0);

        return $result['mxm'];

    }

    /**
     * Query to return a station data
     *
     * @param  string     $id
     * @return bool
     */
    public function getStation($id) {

        $this->addField('*');
        $this->addFrom('stations');
        $this->addWhere('id = "' . $id . '"');

        $this->runQuery();

        return !$this->isEmpty();
    }

    /**
     * Query to update a station
     *
     * @param   array       $data       - The station data
     * @param   string      $id         - The station Id
     */
    public function updateStation($data, $id) {
        foreach ($data as $field => $value)
            $this->addUpdateSet($field, $value);

        $this->setUpdateTable('stations');
        $this->addUpdateWhere('id = "' . $id . '"');

        $this->runUpdate();
    }

    /**
     * Insert Query to add a station
     *
     * @param $data
     */
    public function addStation($data) {
        array_walk($data, function($item, $key) {
            $this->addInsertSet($key, $item);
        });

        $this->setInsertTable('stations');
        $this->runInsert();
    }

    /**
     * Gets UF list from Correios
     */
    public function getCorreiosUf() {

        $this->addField('cd_uf');
        $this->addField('ds_uf_sigla');
        $this->addField('ds_uf_nome');

        $this->addFrom('correios_uf');

        $this->runQuery();

    }


}