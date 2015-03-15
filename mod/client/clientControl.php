<?php

/**
 * Class clientControl
 *
 *
 */
class clientControl extends Control {

    public function __construct() {
        parent::__construct();
    }


    public function clientPage() {
        $this->view()->loadTemplate('clientpage');
        $this->commitReplace($this->view()->render(), '#content');
    }

    public function newClient() {

        $this->view()->loadTemplate('newclient');
        $this->commitReplace($this->view()->render(), '#content');
    }
}