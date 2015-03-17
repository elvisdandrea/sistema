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

    public function addNewCliente(){
        $status = $this->postAddClient();


        $this->commitReplace($status['message'], '#message');
    }

    public function postAddClient(){
        $post = $this->getPost();

        $userData = array(
            'client_name'   => $post['client_name'],
            'phone_1'       => String::convertTextFormat($post['phone_1'], 'fone'),
            'phone_2'       => String::convertTextFormat($post['phone_2'], 'fone'),
            'description'   => $post['description']
        );

        $valitation = $this->validateDataForNewClient($userData);

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
            'message'   => 'Client created!'
        ), 200);

    }

    private function validateDataForNewClient($postData){
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
}