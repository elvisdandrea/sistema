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
     * @param   array       $uri        - The uri we're running on
     * @return  array
     */
    public function authenticate(array $uri) {

        $queryString = $this->getQueryString();

        if (count($uri) == 0)
            return RestServer::throwError(Language::UNAUTHORIZED(), 401);

        if ($uri[0] != 'apilogin') {

            if (!$this->validateQueryString('id', 'token'))
                return RestServer::throwError(Language::UNAUTHORIZED(), 401);

            return $this->tokenValidation($queryString['id'], $queryString['token']);
        }

        if (!$this->validateQueryString('id', 'secret'))
            return RestServer::throwError(Language::UNAUTHORIZED(), 401);

        $this->newModel('auth');
        $auth = $this->model('auth')->authUser(
            $queryString['id'],
            $queryString['secret']
        );

        if ($auth)
            return $this->generateToken($this->model('auth')->getRow(0));

        return RestServer::throwError(Language::UNAUTHORIZED(), 401);

    }

    /**
     * When authentication is ok, let's
     * generate an access token
     *
     * @param   array               $data       - The user data
     * @return  array|string                    - The token data
     * @throws  ExceptionHandler
     */
    private function generateToken(array $data) {


        $token      = md5(CR::encrypt(uniqid()));
        $tokenFile  = TOKENDIR . '/' . $data['uid'] . '/' . $token;
        $tomorrow   = new DateTime('now');
        $tomorrow->modify('+1 day');
        $tokenData  = array(
            'access_token'  => $token,
            'expires'       => $tomorrow->format('Y-m-d h:i:s'),
            'remote_addr'   => Core::getRemoteAddress(),
            'uid'           => $data['uid']
        );

        $tokenContent = json_encode($tokenData, JSON_UNESCAPED_UNICODE);

        if (!file_put_contents($tokenFile, $tokenContent))
            return RestServer::throwError(Language::CANNOT_ACCESS_DIR(), 500);

        return RestServer::response($tokenData);

    }

    /**
     * Validates the authentication token
     *
     * @param   string      $id         - The user uid
     * @param   string      $token      - The access token
     * @return  array
     * @throws  ExceptionHandler
     */
    public function tokenValidation($id, $token) {

        $tokenFile = TOKENDIR . '/' . $id . '/' . $token;

        if (!is_file($tokenFile))
            return RestServer::throwError(Language::UNAUTHORIZED(), 401);

        $content = file_get_contents($tokenFile);
        $content = json_decode($content, true);

        if (!$content)
            return RestServer::throwError(Language::UNAUTHORIZED(), 401);

        foreach (array('expires', 'remote_addr') as $validation)
            if (!in_array($validation, array_keys($content)))
                return RestServer::throwError(Language::UNAUTHORIZED(), 401);

        if ($content['remote_addr'] != Core::getRemoteAddress())
            return RestServer::throwError(Language::UNAUTHORIZED(), 401);

        $tokenExpires = new DateTime($content['expires']);
        $currentDate  = new DateTime('now');

        if ($currentDate > $tokenExpires)
            return RestServer::throwError(Language::EXPIRED(), 401);

        return true;
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
     * Restful POST Method to create new user
     */
    public function postAddUser() {

        $post = $this->getPost();

        if (!$this->validatePost('name', 'user', 'pass'))
            return RestServer::throwError(Language::CANNOT_BE_BLANK('Name, User and Pass'), 400);


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
            'uid'       => $this->model('auth')->getLastInsertId(),
            'message'   => 'User created!'
        ), 200);
    }

    /**
     * View Post Method to create a new user
     */
    public function createUser() {

        if ($this->getPost('pass') != $this->getPost('passrepeat'))
            $this->commitReplace('Password does not match!', '#alert', false);

        $user = $this->postAddUser();
        $this->commitReplace($user['message'], '#alert', false);
    }

}