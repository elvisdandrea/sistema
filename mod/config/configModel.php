<?php


class configModel extends Model {

    public function __construct($connection = DEFAULT_CONNECTION) {
        parent::__construct($connection);
    }


    public function getConfig($station_id = 0) {

        $this->addField('id');
        $this->addField('station_id');
        $this->addField('iso');
        $this->addField('payment_account');
        $this->addField('token');
        $this->addField('sender_name');
        $this->addField('sender_email');
        $this->addField('sender_area_code');
        $this->addField('sender_phone');

        $this->addFrom('config');

        if ($station_id > 0)
            $this->addWhere('station_id = "' . $station_id . '"');

        $this->runQuery();

        return !$this->isEmpty();

    }

}