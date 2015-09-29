<?php

/**
 * Class stationsControl
 *
 *
 */
class stationsControl extends Control {

    /**
     * The module title
     *
     * This will be automatically
     * rendered on the Template Title bar
     */
    const module_title = 'Lojas';

    /**
     * The constructor
     */
    public function __construct() {
        parent::__construct();
    }

    /**
     * Renders the client main page
     */
    public function stationsPage() {

        $this->view()->loadTemplate('stationspage');

        $search = $this->getQueryString('search');
        $page   = $this->getQueryString('page');
        $rp     = $this->getQueryString('rp');

        $page || $page = 1;
        intval($rp) > 0 || $rp = 10;

        $total = $this->model()->getStationsList($page, $rp, $search);
        $this->view()->setVariable('total', $total);

        $pagination = $this->getPagination($page, $total, $rp, 'profile');
        $this->view()->setVariable('pagination', $pagination);

        $this->newView('table');
        $this->view('table')->loadTemplate('stationstable');
        $this->view('table')->setVariable('list', $this->model()->getRows(0));

        $this->view()->setVariable('stationslist', $this->view('table')->render());
        $this->commitReplace($this->view()->render(), '#content');

    }

    /**
     * View for adding new station
     */
    public function newStation() {
        $this->view()->loadTemplate('newstation');
        $this->newModel('auth');
        $this->model('auth')->getCorreiosUf();
        $ufList = $this->model('auth')->getRows();
        $this->view()->setVariable('ufList', $ufList);
        $this->commitReplace($this->view()->render(), '#content');
        $this->view()->appendJs('station');
    }


    /**
     * Rest handler for adding a station
     *
     * @return array|string
     */
    public function postAddStation() {

        $post = $this->getPost();

        $data = array(
            'station_name'      => $post['station_name'],
            'phone'             => String::convertTextFormat($post['phone'], 'fone'),
            'street_address'    => $post['street_address'],
            'street_number'     => $post['street_number'],
            'street_additional' => $post['street_additional'],
            'hood'              => $post['hood'],
            'city'              => $post['city']
        );

        $image      = $post['image64'];
        $imageFile  = $image;

        $validation = $this->validateData($data);

        if($validation['valid'] === FALSE) {
            $message = implode(', ', $validation['message']);
            return RestServer::throwError($message, 400);
        }

        if (!Html::isUrl($image)) {
            $base64 = explode(',', $image);
            $imageFile = $this->uploadBase64File($base64[1]);

            if (!$imageFile) {
                $imageFile = 'Nao foi possivel efetuar o upload da imagem. Contate o Suporte.';
            } else {
                $data['image'] = $imageFile;
            }
        }

        $this->model()->addStation($data);

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

    /**
     * Handler for adding a station
     */
    public function addNewStation() {
        $result = $this->postAddStation();
        if ($result['status'] != 200) {
            $this->commitAdd(
                $this->view()->showAlert('error', 'Ops! Verifique seu cadastro', $result['message'])
                , '#content');
            $this->terminate();
        }
        $id = $result['id'];
        $this->viewStation($id);

    }

    /**
     * New client data validation
     *
     * @param   $postData
     * @return  array
     */
    private function validateData($postData){
        $return = array(
            'valid'     => true,
            'message'   => '',
        );

        if(empty($postData['station_name'])){
            $return['valid']     = false;
            $return['message'][] = "O campo 'Nome' não pode ser vazio";
        }

        if(empty($postData['phone'])){
            $return['valid']     = false;
            $return['message'][] = "O campo 'numero' não pode ser vazio";
        }

        if(!empty($postData['phone']) && !String::validateTextFormat($postData['phone'], 'fone')) {
            $return['valid'] = false;
            $return['message'][] = "O numero inserido não é um telefone válido";
        }
        return $return;
    }

    public function viewStation($id = false) {

        $id || $id = $this->getQueryString('id');
        $this->model()->getStation($id);

        $station = $this->model()->getRow(0);

        $this->view()->loadTemplate('editstation');
        $this->view()->setVariable('station', $station);
        $this->view()->appendJs('station');
        $this->commitReplace($this->view()->render(), '#content');
    }

    public function getStations() {

        if ($this->getId() == 0) {

            $page   = $this->getQueryString('page');
            $page || $page = 1;
            $rp     = $this->getQueryString('rp');
            $rp || $rp = 10;
            $search = $this->getQueryString('search');


            $result = $this->model()->getStationsList($page, $rp, $search);

            if (!$result)
                return RestServer::throwError('Nenhuma loja não encontrada');

            return RestServer::response(array(
                'status'    => 200,
                'station'   => $this->model()->getRows()
            ));
        }

        $result = $this->model()->getStation($this->getId());

        if (!$result)
            return RestServer::throwError('Loja não encontrada');

        return RestServer::response(array(
            'status'    => 200,
            'station'   => $this->model()->getRow(0)
        ));

    }

    /**
     * View for editing a client
     */
    public function editStation() {

        $id = $this->getQueryString('id');
        $this->setId($id);
        $status = $this->updateStation();

        if ($status['status'] != 200) {
            $this->commitAdd($this->view()->showAlert('error', '', $status['message']), 'body');
            $this->terminate();
        }

        $this->stationsPage();
    }

    /**
     * Rest handler for updating a client
     *
     * @return  array|string        - The client data
     * @throws  ExceptionHandler
     */
    public function updateStation() {
        $post = $this->getPost();

        $data = array(
            'station_name'      => $post['station_name'],
            'phone'             => String::convertTextFormat($post['phone'], 'fone'),
            'street_address'    => $post['street_address'],
            'street_number'     => $post['street_number'],
            'street_additional' => $post['street_additional'],
            'hood'              => $post['hood'],
            'city'              => $post['city'],
            'zip_code'          => $post['zip_code']
        );

        $validation = $this->validateData($data);

        if($validation['valid'] === FALSE) {
            $message = implode(', ', $validation['message']);
            return RestServer::throwError($message, 400);
        }

        $image      = $post['image64'];
        $imageFile  = $image;

        if (!Html::isUrl($image)) {

            $base64 = explode(',', $image);
            $imageFile = $this->uploadBase64File($base64[1]);

            if (!$imageFile) {
                $imageFile = 'Nao foi possivel efetuar o upload da imagem. Contate o Suporte.';
            } else {
                $data['image'] = $imageFile;
            }
        }

        $this->model()->updateStation($data, $this->getId());

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
}