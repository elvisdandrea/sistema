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

        $this->view()->loadTemplate('edituser');
        $this->view()->setVariable('profile', $this->model()->getRow(0));
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
            'image'     => $imageFile
        ), 200);
    }


}