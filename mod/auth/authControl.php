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
        $this->newModel('auth');
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

            if (!$this->validateQueryString('token'))
                return RestServer::throwError(Language::UNAUTHORIZED(), 401);

            return $this->tokenValidation($queryString['token']);
        }

        if (!$this->validateQueryString('id', 'secret'))
            return RestServer::throwError(Language::UNAUTHORIZED(), 401);

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
        FileManager::rmkdir(TOKENDIR);
        $tokenFile  = TOKENDIR . '/' . $token;
        $tomorrow   = new DateTime('now');
        $tomorrow->modify('+1 day');
        $tokenData  = array(
            'access_token'  => $token,
            'expires'       => $tomorrow->format('Y-m-d h:i:s'),
            'remote_addr'   => Core::getRemoteAddress(),
            'uid'           => $data['uid'],
            'company_id'    => $data['company_id'],
            'db_connection' => $data['db_connection']
        );

        $tokenContent = json_encode($tokenData, JSON_UNESCAPED_UNICODE);

        if (!file_put_contents($tokenFile, $tokenContent))
            return RestServer::throwError(Language::CANNOT_ACCESS_DIR(), 500);

        return $tokenData;

    }

    /**
     * Validates the authentication token
     *
     * @param   string      $token      - The access token
     * @return  array
     * @throws  ExceptionHandler
     */
    public function tokenValidation($token) {

        $tokenFile = TOKENDIR . '/' . $token;

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

        return $content;
    }

    public function getTokenIsAlive() {
        return RestServer::response(array(
            'status'    => 200
        ));
    }

    /**
     * Restful POST Method to create new user
     */
    public function postAddUser($convert_md5 = true) {

        $post = $this->getPost();

        if (!$this->validatePost('name', 'user', 'pass'))
            return RestServer::throwError(Language::CANNOT_BE_BLANK('Name, User and Pass'), 400);

        !$convert_md5 || $post['pass'] = md5($post['pass']);

        $userData = array(
            'name'      => $post['name'],
            'username'  => $post['user'],
            'passwd'    => CR::encodeText($post['pass']),
            'email'     => $post['email']
        );

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

        $user = $this->postAddUser(false);
        $this->commitReplace($user['message'], '#alert', false);
    }

    /**
     * Renders the login page
     */
    public function loginPage() {

        $this->view()->loadTemplate('login');
        $this->view()->appendJs('login');
        return $this->view()->render();
    }

    /**
     * Form user login
     *
     * This authentication method requires
     * user and password and will not generate
     * access token or refresh token
     */
    public function login() {

        if (!$this->validatePost('user', 'pass')) {
            $this->commitReplace('Desculpe, alguns dados não estão corretos.', '#msgbox');
            return;
        }

        $post = $this->getPost();
        $logged = $this->model('auth')->checkLogin($post['user'], $post['pass']);

        if (!$logged) {
            $this->commitReplace('Desculpe, login ou senha inválido.', '#msgbox');
            return;
        }

        $auth = $this->model('auth')->getRow(0);
        UID::set($auth);
        UID::set('remote_address', Core::getRemoteAddress());

        $profile = new profileControl();
        $profile->model()->getProfileByUid($auth['uid']);
        $user = $profile->model()->getRow(0);

        UID::set('profile', $user);
        Html::refresh();
        $this->terminate();

    }

    /**
     * Rest Handler for updating user data
     *
     * @param   array               $userData       - The user data
     * @param   bool                $uid            - The user UID
     * @return  array|string
     */
    public function updateUser(array $userData = array(), $uid = false) {

        $uid || $uid = $this->getPost('uid');
        if (count($userData) == 0) {
            $userData = array(
                'name'  => $this->getPost('name'),
                'email' => $this->getPost('email'),
                'image' => $this->getPost('image')
            );
        }

        $this->model('auth')->updateUser($userData, $uid);

        if (!$this->model('auth')->queryOk()) {
            return RestServer::throwError(Language::QUERY_ERROR(), 500);
        }

        return RestServer::response(array(
            'status'    => 200,
            'uid'       => $uid,
            'message'   => 'User updated!'
        ), 200);

    }


}