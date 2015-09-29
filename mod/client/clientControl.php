<?php

/**
 * Class clientControl
 *
 *
 */
class clientControl extends Control {

    /**
     * The module title
     *
     * This will be automatically
     * rendered on the Template Title bar
     */
    const module_title = 'Clientes';

    /**
     * Constructor
     */
    public function __construct() {
        parent::__construct();
    }


    /**
     * Renders the client main page
     */
    public function clientPage() {
        $this->view()->loadTemplate('clientpage');

        $page   = $this->getQueryString('page');
        $rp     = $this->getQueryString('rp');
        $search = $this->getQueryString('search');

        $page || $page = 1;
        intval($rp) > 0 || $rp = 10;

        $total = $this->model()->getClientList($page, $rp, $search);

        $this->view()->setVariable('total',  $total);
        $this->view()->setVariable('search', $search);

        $pagination = $this->getPagination($page, $total, $rp, 'client/clientpage');
        $this->view()->setVariable('pagination', $pagination);

        $this->newView('table');
        $this->view('table')->loadTemplate('clienttable');
        $this->view('table')->setVariable('list', $this->model()->getRows(0));

        $this->view()->setVariable('clientlist', $this->view('table')->render());
        $this->commitReplace($this->view()->render(), '#content');

    }

    public function getClient() {

        $result = $this->model()->getClient($this->getId());

        if (!$result)
            return RestServer::throwError('Cliente não encontrado');

        return RestServer::response(array(
            'status'    => 200,
            'client'    => $this->model()->getRow(0)
        ));
    }

    public function getAddressList() {

        $result = $this->model()->getClientAddrList($this->getId());

        if (!$result)
            return RestServer::throwError('Cliente não encontrado');

        return RestServer::response(array(
            'status'    => 200,
            'client'    => $this->getId(),
            'address'   => $this->model()->getRows()
        ));
    }

    public function getAddress() {

        $result = $this->model()->getAddress($this->getId());

        if (!$result)
            return RestServer::throwError('Endereço não encontrado');

        return RestServer::response(array(
            'status'    => 200,
            'address'   => $this->model()->getRows()
        ));
    }


    /**
     * View for adding a client
     */
    public function newClient() {
        $this->view()->loadTemplate('newclient');
        $this->view()->appendJs('client');
        $this->view()->appendJs('/client');
        $this->commitReplace($this->view()->render(), '#content');
    }

    /**
     * Handler for adding a client
     */
    public function addNewClient(){
        $status = $this->postAddClient();
        if ($status['status'] != 200) {
            $this->commitAdd(
                $this->view()->showAlert('error', 'Ops! Verifique seu cadastro', $status['message'])
            , '#content');
            $this->terminate();
        }
        $clientId = $status['uid'];
        echo Html::redirect(BASEDIR . 'request/newrequest/client_id=' . $clientId);
    }

    /**
     * Rest handler for adding a client
     *
     * @return array|string
     * @throws ExceptionHandler
     */
    public function postAddClient(){
        $post = $this->getPost();

        $clientData = array(
            'client_name'   => $post['client_name'],
            'description'   => $post['description'],
            'client_type'   => $post['client_type'],
            'cpf_cnpj'      => $post['cpf_cnpj'],
            'email'         => $post['email'],
            'contact'       => $post['contact'],
            'passwd'        => $post['passwd'],
            'corporate_name'             => $post['corporate_name'],
            'state_registration'         => $post['state_registration'],
            'municipal_registration'     => $post['municipal_registration']
        );

        $valitation = $this->validateDataForClient($clientData);

        if($valitation['valid'] === FALSE) {
            $message = implode(', ', $valitation['message']);
            return RestServer::throwError($message, 400);
        }

        $phoneData = array(
            'phone_type'     => $post['phone_type'],
            'phone_number'   => String::convertTextFormat($post['phone_number'], 'fone'),
        );

        $addrData = array(
            'address_type'      => $post['address_type'],
            'zip_code'          => $post['zip_code'],
            'street_addr'       => $post['street_addr'],
            'hood'              => $post['hood'],
            'city'              => $post['city'],
            'street_number'     => $post['street_number'],
            'street_additional' => $post['street_additional'],
            'state'             => $post['state'],
            'addr_main'         => 1
        );

        $validation = $this->validatePhone($phoneData);

        if($validation['valid'] === false) {
            $message = implode(', ', $validation['message']);
            return RestServer::throwError($message, 400);
        }

        $image      = $this->getPost('image64');
        $imageFile  = $image;

        if ($image && !Html::isUrl($image)) {
            $base64 = explode(',', $image);
            $imageFile = $this->uploadBase64File($base64[1]);

            if (!$imageFile) {
                $imageFile = 'Nao foi possivel efetuar o upload da imagem. Contate o Suporte.';
            } else {
                $clientData['image'] = $imageFile;
            }
        }

        $this->model()->addClient($clientData);

        if (!$this->model()->queryOk()) {
            if (in_array($this->model()->getErrorCode(), array(23000, 1062)))
                return RestServer::throwError(Language::USER_ALREADY_TAKEN(), 400);
            else
                return RestServer::throwError(Language::QUERY_ERROR(), 500);
        }

        $newUserId = $this->model()->getLastInsertId();

        $this->model()->addClientPhone($phoneData, $newUserId);

        if (!$this->model()->queryOk())
            return RestServer::throwError(Language::QUERY_ERROR(), 500);

        $this->model()->addClientAddress($addrData, $newUserId);
        $address_id = $this->model()->getLastInsertId();

        if (!$this->model()->queryOk())
            return RestServer::throwError(Language::QUERY_ERROR(), 500);

        return RestServer::response(array(
            'status'     => 200,
            'uid'        => $newUserId,
            'address_id' => $address_id,
            'message'    => 'Cadastro realizado!',
            'image'      => $imageFile
        ), 200);

    }

    public function getLogin() {

        $client = $this->model()->checkLogin(
            $this->getQueryString('email'),
            $this->getQueryString('passwd')
        );

        if ($client) {
            return RestServer::response(array(
                'status'    => 200,
                'uid'       => $this->model()->getRow(0)
            ));
        }

        return RestServer::response(array(
            'status'    => 400,
            'message'   => 'Usuário ou senha invalidos'
        ));

    }

    public function getCountFav() {

        $fav = $this->model()->getCountFavourites($this->getQueryString('id'));
        return RestServer::response(array(
            'status'    => 200,
            'fav'       => $fav
        ));
    }

    public function getCountCart() {
        $cart = $this->model()->getCountCart($this->getQueryString('id'));
        return RestServer::response(array(
            'status'    => 200,
            'cart'      => $cart
        ));
    }

    public function getCartItems() {
        $result = $this->model()->getCartItems($this->getQueryString('id'));

        if (!$result) {
            return RestServer::response(array(
                'status'    => 400,
                'message'   => 'Nenhum item no carrinho'
            ));
        }

        return RestServer::response(array(
            'status'    => 200,
            'cart'      => $this->model()->getRows()
        ));
    }

    /**
     * New client data validation
     *
     * @param   $postData
     * @return  array
     */
    private function validateDataForClient($postData){
        $return = array(
            'valid'     => true,
            'message'   => '',
        );

        if(empty($postData['client_name'])){
            $return['valid']     = false;
            $return['message'][] = "O campo 'Nome' não pode ser vazio";
        }

        if(!empty($postData['email']) && !filter_var($postData['email'], FILTER_VALIDATE_EMAIL)){
            $return['valid']     = false;
            $return['message'][] = "Email inválido";
        }

        if($postData['client_type'] == 'F' && !String::validateCpf($postData['cpf_cnpj'])){
            $return['valid']     = false;
            $return['message'][] = "CPF inválido";
        }

        if($postData['client_type'] == 'J' && !String::validateCnpj($postData['cpf_cnpj'])){
            $return['valid']     = false;
            $return['message'][] = "CNPJ inválido";
        }

        return $return;
    }

    /**
     * View of a client
     *
     * @param   bool|int    $id     - The client Id
     */
    public function viewClient($id = false){
        if($id == false) {
            $id = $this->getQueryString('id');
        }

        $this->model()->getClient($id);
        $client = $this->model()->getRow(0);

        $this->view()->setVariable('client', $client);
        $this->view()->loadTemplate('editclient');
        $this->view()->appendJs('client');

        $this->model()->getClientAddrList($id);
        $addrList = $this->model()->getRows();
        $this->model()->getClientPhoneList($id);
        $phoneList = $this->model()->getRows();

        $this->view()->setVariable('addrList', $addrList);
        $this->view()->setVariable('phoneList', $phoneList);

        $this->commitReplace($this->view()->render(), '#content');
    }

    /**
     * View for editing a client
     */
    public function editClient() {
        $id = $this->getQueryString('id');
        $this->setId($id);
        $client = $this->updateClient();

        if ($client['status'] != 200) {
            $this->commitAdd($this->view()->showAlert('error', '', $client['message']), 'body');
            $this->terminate();
        }
        $this->clientPage();
    }

    /**
     * Rest handler for updating a client
     *
     * @return  array|string        - The client data
     * @throws  ExceptionHandler
     */
    public function updateClient() {
        $post = $this->getPost();

        $clientData = array(
            'client_name'   => $post['client_name'],
            'description'   => $post['description'],
            'client_type'   => $post['client_type'],
            'cpf_cnpj'      => $post['cpf_cnpj'],
            'email'         => $post['email'],
            'contact'       => $post['contact'],
            'corporate_name'             => $post['corporate_name'],
            'state_registration'         => $post['state_registration'],
            'municipal_registration'     => $post['municipal_registration']
        );

        $validation = $this->validateDataForClient($clientData);
        if(!$validation['valid'])
            return RestServer::throwError(implode(', ', $validation['message']));

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

        $this->model()->updateClient($clientData, $this->getId());

        if (!$this->model()->queryOk()) {
            return RestServer::throwError(Language::QUERY_ERROR(), 500);
        }

        return RestServer::response(array(
            'status'    => 200,
            'message'   => 'Cadastro atualizado!',
            'image'     => $imageFile
        ), 200);
    }

    /**
     * Handler of adding a client
     */
    public function addClientAddr(){
        $id = $this->getQueryString('id');
        if(empty($id))
            $id = $this->getPost('client_id');
        $this->setId($id);
        $status = $this->postAddClientAddr();
        if($status['status'] == 200){
            $this->viewClient();
        }
    }

    /**
     * Rest handler for adding a client
     *
     * @return  array|string        - The client data
     * @throws  ExceptionHandler
     */
    public function postAddClientAddr(){
        $post = $this->getPost();

        $userData = array(
            'address_type'      => $post['address_type'],
            'zip_code'          => $post['zip_code'],
            'street_addr'       => $post['street_addr'],
            'hood'              => $post['hood'],
            'city'              => $post['city'],
            'street_number'     => $post['street_number'],
            'street_additional' => $post['street_additional'],
            'state'             => $post['state'],
            'addr_main'         => '0'
        );

        $this->model()->addClientAddress($userData, $this->getId());

        if (!$this->model()->queryOk()) {
            return RestServer::throwError(Language::QUERY_ERROR(), 500);
        }

        return RestServer::response(array(
            'status'    => 200,
            'message'   => 'Cadastro atualizado!'
        ), 200);
    }

    /**
     * Handler for removing an address
     */
    public function removeAddr(){
        $addr_id = $this->getQueryString('addr_id');
        $this->setId($addr_id);
        $status = $this->deleteClientAddr();
        if($status['status'] == 200){
            $this->viewClient();
        }
    }

    /**
     * Rest Handler for removing an adress
     *
     * @return  array|string
     * @throws  ExceptionHandler
     */
    public function deleteClientAddr(){
        $id = $this->getId();
        $this->model()->removeClientAddr($id);

        if (!$this->model()->queryOk()) {
            return RestServer::throwError(Language::QUERY_ERROR(), 500);
        }

        return RestServer::response(array(
            'status'    => 200,
            'message'   => 'Cadastro removido!'
        ), 200);
    }

    /**
     * Handler for adding a client
     */
    public function addClientPhone(){
        $id = $this->getQueryString('id');
        $this->setId($id);
        $status = $this->postAddClientPhone();
        if ($status['status'] != 200) {
            $this->commitReplace($status['message'], '#message');
            $this->commitShow('#message');
            $this->terminate();
        }
        $this->viewClient();
    }

    /**
     * Rest Handler for adding a client
     *
     * @return array|string
     * @throws ExceptionHandler
     */
    public function postAddClientPhone(){
        $post = $this->getPost();

        $userData = array(
            'phone_type'     => $post['phone_type'],
            'phone_number'   => String::convertTextFormat($post['phone_number'], 'fone'),
        );

        $valitation = $this->validatePhone($userData);

        if($valitation['valid'] === false) {
            $message = implode(', ', $valitation['message']);
            return RestServer::throwError($message, 400);
        }

        $this->model()->addClientPhone($userData, $this->getId());

        if (!$this->model()->queryOk()) {
            return RestServer::throwError(Language::QUERY_ERROR(), 500);
        }

        return RestServer::response(array(
            'status'    => 200,
            'message'   => 'Cadastro atualizado!'
        ), 200);
    }

    /**
     * Validation for adding a client phone
     *
     * @param   $postData       - The phone data
     * @return  array
     */
    private function validatePhone($postData){
        $return = array(
            'valid'     => true,
            'message'   => '',
        );

        if(empty($postData['phone_type'])){
            $return['valid']     = false;
            $return['message'][] = "O tipo de telefone não pode ser vazio";
        }

        if(empty($postData['phone_number'])){
            $return['valid']     = false;
            $return['message'][] = "O campo 'numero' não pode ser vazio";
        }

        if(!empty($postData['phone_number']) && !String::validateTextFormat($postData['phone_number'], 'fone')) {
            $return['valid'] = false;
            $return['message'][] = "O numero inserido não é um telefone válido";
        }

        $this->model()->findPhoneByNumber($postData['phone_number']);
        $phoneNumber = $this->model()->getRows();
        if(!empty($phoneNumber)){
            $return['valid']     = false;
            $return['message'][] = "Este numero de telefone já esta cadastrado";
        }

        return $return;
    }

    /**
     * Handler for removing a client phone
     */
    public function removePhone(){
        $addr_id = $this->getQueryString('addr_id');
        $this->setId($addr_id);
        $status = $this->deleteClientPhone();
        if ($status['status'] != 200) {
            $this->commitReplace($status['message'], '#message');
            $this->commitShow('#message');
            $this->terminate();
        }
        $this->viewClient();
    }

    /**
     * Rest Handler for removing a client phone
     *
     * @return array|string
     * @throws ExceptionHandler
     */
    public function deleteClientPhone(){
        $id = $this->getId();
        $this->model()->removeClientPhone($id);

        if (!$this->model()->queryOk()) {
            return RestServer::throwError(Language::QUERY_ERROR(), 500);
        }

        return RestServer::response(array(
            'status'    => 200,
            'message'   => 'Cadastro removido!'
        ), 200);
    }

    public function checkPhoneExists(){
        $postData = $this->getPost();
        $phoneNumber = String::convertTextFormat($postData['phone_number'], 'fone');

        $this->model()->findPhoneByNumber($phoneNumber);
        $phoneNumbers = $this->model()->getRows();
        if(!empty($phoneNumbers)){
            $this->commitAdd($this->view()->showAlert('error', '', 'Este numero de telefone já esta cadastrado'), '#content');
            $this->terminate();
        }
    }

    public function validateCpf(){
        $postData = $this->getPost();

        if(!String::validateCpf($postData['cpf_cnpj'])){
            $this->commitAdd($this->view()->showAlert('error', '', 'CPF inválido'), '#content');
            $this->terminate();
        }
    }

    public function validateCnpj(){
        $postData = $this->getPost();

        if(!String::validateCnpj($postData['cpf_cnpj'])){
            $this->commitAdd($this->view()->showAlert('error', '', 'CNPJ inválido'), '#content');
            $this->terminate();
        }
    }

    public function validateEmail(){
        $postData = $this->getPost();

        if(!filter_var($postData['email'], FILTER_VALIDATE_EMAIL)){
            $this->commitAdd($this->view()->showAlert('error', '', 'Email inválido'), '#content');
            $this->terminate();
        }
    }

    public function fbSearch(){
        $postData = $this->getPost();
        if(!empty($postData['access_token']))
            UID::set('fb_access_token', $postData['access_token']);

        if(!empty($postData['fb-search'])) {
            $httpHandler = HttpHandler::Create('https://graph.facebook.com/search', 'GET');
            $httpHandler->setSSL(true);
            $httpHandler->addParam('q', $postData['fb-search']);
            $httpHandler->addParam('type', 'user');
            $httpHandler->addParam('access_token', UID::get('fb_access_token'));
            $httpHandler->execute();
            $response = $httpHandler->getContent();

            $data = json_decode($response, true);

            $usersData = array();
            foreach($data['data'] as $value){
                $usersData[] = array(
                    'name' => $value['name'],
                    'uid' => $value['id'],
                    'picture' => 'https://graph.facebook.com/'.$value['id'].'/picture'
                );
            }

            $this->view()->setVariable('data', $usersData);
            $this->view()->loadTemplate('fbsearchtable');
            $this->commitReplace($this->view()->render(), '#fb-matches');
        } else {
            $this->view()->appendJs('facebook');
            $this->view()->loadTemplate('fbsearch');
            $this->commitAdd($this->view()->render(), '#content');
        }
    }

    public function fbGetUserData(){
        $user = $this->getQueryString('user');
        $httpHandler = HttpHandler::Create('https://graph.facebook.com/'.$user, 'GET');

        $httpHandler->setSSL(true);
        $httpHandler->addParam('access_token', UID::get('fb_access_token'));
        $httpHandler->addParam('redirect', false);
        $httpHandler->execute();
        $response = $httpHandler->getContent();

        $userData = json_decode($response, true);

        $httpHandler->setURL('https://graph.facebook.com/v2.3/'.$user.'/picture');
        $httpHandler->addParam('redirect', false);
        $httpHandler->addParam('width', 640);
        $httpHandler->execute();
        $fileInfo = $httpHandler->getContent();

        $file = file_get_contents($fileInfo['data']['url']);
        $file = base64_encode($file);

        $returnData = array(
            'name' => $userData['name'],
            'image' => $file
        );

        echo json_encode($returnData);
    }

    public function changeClientMainAddr(){
        $addr_id = $this->getQueryString('addr_id');
        $client_id = $this->getQueryString('id');
        $this->model()->changeClientMainAddr($addr_id, $client_id);

        $this->viewClient();
    }
}