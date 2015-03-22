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

        $total = $this->model()->getClientList();
        $this->view()->setVariable('total', $total);

        $this->model()->setGridRowLink('client/viewclient', 'id');
        $this->model()->addGridColumn('Imagem','image64','Image');
        $this->model()->addGridColumn('Data','client_date');
        $this->model()->addGridColumn('Nome','client_name');
        $this->model()->addGridColumn('Telefone','phone_1');
        $this->model()->addGridColumn('Telefone(alternativo)','phone_2');
        $this->model()->addGridColumn('Descrição','description');

        $this->view()->setVariable('clientlist', $this->model()->dbGrid());
        $this->commitReplace($this->view()->render(), '#content');
    }

    public function newClient() {
        $this->view()->loadTemplate('newclient');
        $this->commitReplace($this->view()->render(), '#content');
        echo Html::addImageUploadAction('read64', 'client-img');
    }

    public function addNewClient(){
        $status = $this->postAddClient();
        $this->commitReplace($status['message'], '#message');
    }

    public function postAddClient(){
        $post = $this->getPost();

        $userData = array(
            'client_name'   => $post['client_name'],
            'phone_1'       => String::convertTextFormat($post['phone_1'], 'fone'),
            'phone_2'       => String::convertTextFormat($post['phone_2'], 'fone'),
            'description'   => $post['description'],
            'image64'       => $post['image64'],
        );

        $valitation = $this->validateDataForClient($userData);

        if($valitation['valid'] === FALSE) {
            $message = implode(', ', $valitation['message']);
            return RestServer::throwError($message, 400);
        }

        $this->model()->addClient($userData);

        if (!$this->model()->queryOk()) {
            if ($this->model()->getErrorCode() == 23000)
                return RestServer::throwError(Language::USER_ALREADY_TAKEN(), 400);
            else
                return RestServer::throwError(Language::QUERY_ERROR(), 500);
        }

        return RestServer::response(array(
            'status'    => 200,
            'uid'       => $this->model()->getLastInsertId(),
            'message'   => 'Cadastro realizado!'
        ), 200);

    }

    private function validateDataForClient($postData){
        $return = array(
            'valid'     => true,
            'message'   => '',
        );

        if(empty($postData['client_name'])){
            $return['valid']     = false;
            $return['message'][] = "O campo 'Nome' não pode ser vazio";
        }

        if(empty($postData['phone_1'])){
            $return['valid']     = false;
            $return['message'][] = "O campo 'Telefone' não pode ser vazio";
        }
        if(!empty($postData['phone_1']) && !String::validateTextFormat($postData['phone_1'], 'fone')){
            $return['valid']     = false;
            $return['message'][] = "O campo 'Telefone' não é um telefone válido";
        }

        if(!empty($postData['phone_2']) && !String::validateTextFormat($postData['phone_2'], 'fone')){
            $return['valid']     = false;
            $return['message'][] = "O campo 'Telefone(alternativo)' não é um telefone válido";
        }

        return $return;
    }

    public function viewClient(){
        $id = $this->getQueryString('id');
        $this->model()->getClient($id);
        $client = $this->model()->getRow(0);
        $this->view()->setVariable('client', $client);
        $this->view()->loadTemplate('editclient');
        $this->commitReplace($this->view()->render(), '#content');
        echo Html::addImageUploadAction('read64', 'client-img');
    }

    public function editClient() {
        $id = $this->getQueryString('id');
        $this->setId($id);
        $client = $this->postEditClient();

        if ($client['status'] != 200) {
            $this->commitReplace($client['message'], '#message');
            $this->commitShow('#message');
            $this->terminate();
        }
        $this->clientPage();
    }

    public function postEditClient() {
        $post = $this->getPost();
        
        $userData = array(
            'client_name'   => $post['client_name'],
            'phone_1'       => String::convertTextFormat($post['phone_1'], 'fone'),
            'phone_2'       => String::convertTextFormat($post['phone_2'], 'fone'),
            'description'   => $post['description'],
            'image64'       => $post['image64'],
        );

        $validation = $this->validateDataForClient($userData);
        if(!$validation['valid'])
            return RestServer::throwError(implode(', ', $validation['message']));

        $this->model()->updateClient($userData, $this->getId());

        if (!$this->model()->queryOk()) {
            return RestServer::throwError(Language::QUERY_ERROR(), 500);
        }

        return RestServer::response(array(
            'status'    => 200,
            'message'   => 'Cadastro atualizado!'
        ), 200);
    }
}