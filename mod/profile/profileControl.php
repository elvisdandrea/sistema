<?php

/**
 * Class profileControl
 *
 *
 */
class profileControl extends Control {

    /**
     * The constructor
     */
    public function __construct() {
        parent::__construct();
    }

    /**
     * Renders the client main page
     */
    public function profilePage() {

        $this->view()->loadTemplate('profilepage');

        $search = $this->getQueryString('search');
        $page   = $this->getQueryString('page');
        $rp     = $this->getQueryString('rp');

        $page || $page = 1;
        intval($rp) > 0 || $rp = 10;

        $total = $this->model()->getUserList($page, $rp, $search);
        $this->view()->setVariable('total', $total);

        $pagination = $this->getPagination($page, $total, $rp, 'profile/profilepage');
        $this->view()->setVariable('pagination', $pagination);

        $this->model()->setGridRowLink('profile/viewuser', 'id');
        $this->model()->addGridColumn('Imagem','image','Image');
        $this->model()->addGridColumn('Nome','name');
        $this->model()->addGridColumn('Email','email');
        $this->model()->addGridColumn('Telefone','phone_1');
        $this->model()->addGridColumn('Telefone 2','phone_2');

        $this->view()->setVariable('profilelist', $this->model()->dbGrid());
        $this->commitReplace($this->view()->render(), '#content');
        if (Core::isAjax())
            echo Html::AddClass('content-aligned', '#content');
    }

    public function viewUser($id = false) {

        $id || $id = $this->getQueryString('id');
        
    }


}