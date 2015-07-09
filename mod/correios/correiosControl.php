<?php

/**
 * Class correiosControl
 *
 * This is the Home Controller
 *
 * @author  Elvis D'Andrea
 * @email   <elvis.vista@gmail.com.br>
 */

class correiosControl extends Control {

    /**
     * The module title
     *
     * This will be automatically
     * rendered on the Template Title bar
     */
    const module_title = 'Correios';

    /**
     * The constructor
     *
     * The parent constructor is the
     * base for the controller functionality
     *
     * This will automatically handle the instantiation
     * of the module Model and View
     */
    public function __construct() {
        parent::__construct();
    }


}