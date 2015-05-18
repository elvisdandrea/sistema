<?php

/**
 * Class profileControl
 *
 *
 */
class profileControl extends Control {

    /**
     * The module title
     *
     * This will be automatically
     * rendered on the Template Title bar
     */
    const module_title = 'Usuários';

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

        $pagination = $this->getPagination($page, $total, $rp, 'profile');
        $this->view()->setVariable('pagination', $pagination);

        $this->model()->setGridRowLink('profile/viewuser', 'id');
        $this->model()->addGridColumn('Imagem','image','Image');
        $this->model()->addGridColumn('Nome','name');
        $this->model()->addGridColumn('Email','email');
        $this->model()->addGridColumn('Telefone','phone_1');
        $this->model()->addGridColumn('Telefone 2','phone_2');

        $this->view()->setVariable('profilelist', $this->model()->dbGrid());
        $this->commitReplace($this->view()->render(), '#content');

    }

    public function viewUser($id = false) {

        $id || $id = $this->getQueryString('id');
        $this->model()->getProfile($id);

        $profile = $this->model()->getRow(0);

        if (intval($profile['uid']) > 0) {
            $auth = new authControl();
            $auth->model('auth')->getUserData($profile['uid']);
            $user = $auth->model('auth')->getRow(0);
            $this->view()->setVariable('user', $user);
        }

        $this->view()->loadTemplate('edituser');
        $this->view()->setVariable('profile', $profile);
        $this->commitReplace($this->view()->render(), '#content');
        echo Html::addImageUploadAction('read64', 'profile-img');
    }

    /**
     * View for editing a client
     */
    public function editUser() {

        $id = $this->getQueryString('id');
        $this->setId($id);
        $user = $this->updateUser();

        if ($user['status'] != 200) {
            $this->commitAdd($this->view()->showAlert('error', '', 'Ocorreu um problema ao editar este perfil, contate nosso suporte.'), 'body');
            $this->terminate();
        }

        $this->model()->getProfile($id);
        $profile = $this->model()->getRow(0);

        if (intval($profile['uid']) > 0) {
            $auth = new authControl();
            $auth->updateUser(array(
                'name'      => $profile['name'],
                'email'     => $profile['email'],
                'image'     => $profile['image']
            ), $profile['uid']);

            if ($profile['uid'] == UID::get('uid')) {
                UID::set('image', $profile['image']);
                $this->view()->loadTemplate('profileimg');
                $this->view()->setVariable('profile', $profile);
                $this->commitReplace($this->view()->render(), '#profileimg');
            }
        }

        $this->profilePage();
    }

    /**
     * Rest handler for updating a client
     *
     * @return  array|string        - The client data
     * @throws  ExceptionHandler
     */
    public function updateUser() {
        $post = $this->getPost();

        $userData = array(
            'name'              => $post['name'],
            'email'             => $post['email'],
            'phone_1'           => $post['phone_1'],
            'phone_2'           => $post['phone_2'],
            'street_address'    => $post['street_address'],
            'street_number'     => $post['street_number'],
            'street_additional' => $post['street_additional'],
            'hood'              => $post['hood'],
            'city'              => $post['city']
        );

//        $validation = $this->validateDataForClient($clientData);
//        if(!$validation['valid'])
//            return RestServer::throwError(implode(', ', $validation['message']));

        $image      = $post['image64'];
        $imageFile  = $image;

        if (!Html::isUrl($image)) {

            $base64 = explode(',', $image);
            $imageFile = $this->uploadBase64File($base64[1]);

            if (!$imageFile) {
                $imageFile = 'Nao foi possivel efetuar o upload da imagem. Contate o Suporte.';
            } else {
                $userData['image'] = $imageFile;
            }
        }

        $this->model()->updateUser($userData, $this->getId());

        if (!$this->model()->queryOk()) {
            return RestServer::throwError(Language::QUERY_ERROR(), 500);
        }

        return RestServer::response(array(
            'status'    => 200,
            'message'   => 'Cadastro atualizado!',
            'id'        => $this->getId(),
            'image'     => $imageFile
        ), 200);
    }

    /**
     * View for adding new user
     */
    public function newUser() {
        $this->view()->loadTemplate('newuser');
        $this->commitReplace($this->view()->render(), '#content');
        echo Html::addImageUploadAction('read64', 'profile-img');
    }


    public function postAddUser() {

        $post = $this->getPost();

        $userData = array(
            'name'              => $post['name'],
            'email'             => $post['email'],
            'phone_1'           => $post['phone_1'],
            'phone_2'           => $post['phone_2'],
            'street_address'    => $post['street_address'],
            'street_number'     => $post['street_number'],
            'street_additional' => $post['street_additional'],
            'hood'              => $post['hood'],
            'city'              => $post['city']
        );

        $image      = $post['image64'];
        $imageFile  = $image;

        if (!Html::isUrl($image)) {
            $base64 = explode(',', $image);
            $imageFile = $this->uploadBase64File($base64[1]);

            if (!$imageFile) {
                $imageFile = 'Nao foi possivel efetuar o upload da imagem. Contate o Suporte.';
            } else {
                $clientData['image'] = $imageFile;
            }
        }

        $this->model()->addUser($userData);

        if (!$this->model()->queryOk()) {
            if (in_array($this->model()->getErrorCode(), array(23000, 1062)))
                return RestServer::throwError(Language::USER_ALREADY_TAKEN(), 400);
            else
                return RestServer::throwError(Language::QUERY_ERROR(), 500);
        }

        $newId = $this->model()->getLastInsertId();

        return RestServer::response(array(
            'status'    => 200,
            'id'       => $newId,
            'message'   => 'Cadastro realizado!',
            'image'     => $imageFile
        ), 200);
    }

    public function addNewUser() {
        $result = $this->postAddUser();
        if ($result['status'] != 200) {
            $this->commitAdd(
                $this->view()->showAlert('error', 'Ops! Verifique seu cadastro', $result['message'])
                , '#content');
            $this->terminate();
        }
        $id = $result['id'];
        $this->editUser($id);

    }

    public function authUser() {

        $username   = $this->getPost('username');
        $email      = $this->getPost('email');
        $passwd     = CR::encodeText($this->getPost('passwd'));
        $name       = $this->getPost('name');
        $uid        = $this->getQueryString('uid');
        $id         = $this->getQueryString('id');

        $auth = new authControl();

        if (intval($uid) > 0) {
            $userData = array(
                'passwd'    => $passwd
            );
            $auth->model('auth')->updateUser($userData, $uid);
            if (!$this->model()->queryOk()) {
                if (in_array($this->model()->getErrorCode(), array(23000, 1062))) {
                    $this->commitAdd($this->view()->showAlert('danger', 'Oh não!', 'Estes dados já estão em uso'), 'body');
                } else {
                    $this->commitAdd($this->view()->showAlert('danger', 'Oh não!', 'Não foi possível alterar este usuário, contate nosso suporte.'), 'body');
                }
            }
        } else {
            $userData = array(
                'username'   => $username,
                'email'      => $email,
                'company_id' => UID::get('company_id'),
                'passwd'     => $passwd,
                'name'       => $name
            );
            $auth->model('auth')->insertUser($userData);
            if (!$auth->model()->queryOk()) {
                if (in_array($this->model()->getErrorCode(), array(23000, 1062))) {
                    $this->commitReplace($this->view()->showAlert('danger', 'Oh não!', 'Estes dados já estão em uso'), 'body');
                } else {
                    $this->commitReplace($this->view()->showAlert('danger', 'Oh não!', 'Não foi possível alterar este usuário, contate nosso suporte.'), 'body');
                }
            } else {
                $this->model()->updateUser(array(
                    'uid'   => $auth->model('auth')->getLastInsertId()
                ), $id);
            }
        }

        $this->viewUser($id);
        $this->commitAdd($this->view()->showAlert('success', '', 'Usuário alterado com sucesso'), 'body');

    }


}