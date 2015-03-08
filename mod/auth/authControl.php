<?php

/**
 * Class authControl
 *
 * The controller of the users
 * authentication
 *
 * The OAuth2 methods are those used
 * by the RESTful server. The non-RESTful
 * usage of this may use normal encrypted
 * authentication
 *
 */
class authControl extends Control {

    public function __construct() {
        parent::__construct();
    }


    /**
     * Authenticate via RESTful method
     *
     * This authentication method requires
     * the specification of the UID and Secret
     * instead of normal user and pass.
     *
     * This will also generate the access token
     * and refresh token to be used on RESTful
     * requests
     *
     */
    public function authenticate() {

        $this->model('auth')->authUser(
            $this->getQueryString('uid'),
            $this->getQueryString('secret')
        );

    }

    /**
     * Form user login
     *
     * This authentication method requires
     * user and password and will not generate
     * access token or refresh token
     */
    public function login() {

    }

    /**
     * POST Method to create new user
     */
    public function postAddUser() {
        $post = $this->getPost();
        if ($post['pass'] != $post['passrepeat'])
            $this->commitReplace('Password does not match!', '#alert', false);

        $userData = array(
            'name'      => $post['name'],
            'username'  => $post['user'],
            'passwd'    => CR::encrypt($post['pass']),
            'email'     => $post['email']
        );

        $this->newModel('auth');
        $this->model('auth')->insertUser($userData);

        if (!$this->model('auth')->queryOk()) {
            if ($this->model('auth')->getErrorCode() == 23000)
                return RestServer::throwError(Language::USER_ALREADY_TAKEN(), 400);
            else
                return RestServer::throwError(Language::QUERY_ERROR(), 500);
        }

        return RestServer::response(array(
            'status'    => 200,
            'message'   => 'User created!'
        ), 200);
    }

    public function createUser() {

        $user = $this->postAddUser();
        $this->commitReplace($user['message'], '#alert', false);
    }

}