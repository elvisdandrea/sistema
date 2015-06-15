<?php

/**
 * Class homeControl
 *
 * This is the Home Controller
 *
 * This controller will handle the first execution.
 * This will automatically identify if the request
 * is running over ajax and will render exactly
 * what's necessary.
 *
 * In other words, if you call an action by URL,
 * this will render the whole site along with the
 * content of the action. But when the home page
 * is already loaded and you call the actions,
 * this will render the action content only and
 * will add/replace where it should.
 *
 * This is also an scaffold for you other modules.
 *
 * @author  Elvis D'Andrea
 * @email   <elvis.vista@gmail.com.br>
 */

class homeControl extends Control {

    /**
     * The module title
     *
     * This will be automatically
     * rendered on the Template Title bar
     */
    const module_title = 'Bem vindo ao Orbit';

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


    /**
     * The home page
     *
     * This is where the "magic" happens
     *
     * Always drop a $page_content in your templates
     * so this function can manage to put the content
     * of the action when it's not an ajax request.
     *
     * Prefer a different variable name? Just rename it.
     *
     * @param   array   $uri        - The URI array
     */
    public function itStarts($uri = array()) {

        $this->view()->loadTemplate('home');
        $this->view()->appendJs('sidebar');

        if (count($uri) == 0)
            $uri = array('request','requestpage');

        $request = new requestControl();
        $this->view()->setVariable('countNewRequests', $request->countNewRequests());
        $this->view()->setVariable('newRequests',      $request->listNewRequests());

        $content = Core::getMethodContent($uri);

        $this->view()->setVariable('page_content', $content);
        echo $this->view()->render(true, false);

        $this->view()->loadTemplate('keepalive');
        echo $this->view()->render(true, false);

        echo Core::getController()->view()->injectJSFiles();

        $this->terminate();
    }

    /**
     * When returning the home page, loads the inner content only
     *
     * You can always create a modulePage function that
     * is called when the module is called without an action.
     */
    public function homePage() {

        $this->view()->loadTemplate('dashboard');
        $this->commitReplace($this->view()->render(), '#content', true);
    }

    /**
     * RESTful GET call example
     */
    public function getHome() {

        #debug($this->view()->getModuleName());     // Example of a code debug

        #throw new ExceptionHandler('teste', 400);  // Example of Exception Handling
        #$this->view('')->lol();                    // Example of Fatal Error Handling

        $result = RestServer::response(array(
            'execution'     => 'Hooray, green test!',
            'working_id'    => $this->getId()
        ));

        return $result;
    }

    /**
     * When an ajax Method is not found
     *
     * @param   array       $url        - The URL in case you need
     */
    public function notFound($url) {

        $this->view()->setVariable('url', $url);
        $this->commitReplace($this->view()->get404(), '#content');
        $this->terminate();
    }

    /**
     * The view to create a database connection file
     */
    public function createDb() {

        $this->view()->loadTemplate('createdb');
        $this->commitReplace($this->view()->render(), '#main');
    }

    /**
     * The action to save a database connection file
     */
    public function saveDbFile() {

        $this->validatePost('conname', 'host', 'user', 'pass', 'db') ||
            $this->commitReplace('Please fill all information.', '#alert', false);

        $this->model()->generateConnectionFile(
            $this->getPost('conname'),
            $this->getPost('host'),
            $this->getPost('user'),
            $this->getPost('pass'),
            $this->getPost('db')
        );
        $this->commitReplace('Created!', '#alert');
    }


    /**
     * Good bye
     */
    public function logout() {

        UID::logout();
        $this->terminate();
    }

    /**
     * Keep Alive Ajax Request
     *
     * This request should be called
     * asynchronously and with fixed time
     * to keep current session alive
     */
    public function keepAlive() {

        if (UID::isLoggedIn()) {
            $current = date('d/m/Y h:i:s');
            UID::set('alive', $current);
            Html::logConsole('last Checked: ' . $current);
            $this->terminate();
        }

        Html::refresh();

    }



}