<?php


class categoriesControl extends Control {

    public function categoriesPage(){
        $this->view()->loadTemplate('categoriespage');

        $page   = $this->getQueryString('page');
        $rp     = $this->getQueryString('rp');
        $search = $this->getQueryString('search');

        $page || $page = 1;
        intval($rp) > 0 || $rp = 10;

        $total = $this->model()->getCategoriesList($page, $rp, $search);

        $this->view()->setVariable('total',  $total);
        $this->view()->setVariable('search', $search);

        $pagination = $this->getPagination($page, $total, $rp, 'categories/categoriespage');
        $this->view()->setVariable('pagination', $pagination);

        $this->newView('table');
        $this->view('table')->loadTemplate('categoriestable');
        $this->view('table')->setVariable('list', $this->model()->getRows(0));

        $this->view()->setVariable('categorieslist', $this->view('table')->render());

        $this->commitReplace($this->view()->render(), '#content');
    }

    public function viewCategory(){
        $id = $this->getQueryString('id');

        $this->model()->getCategory($id);
        $category = $this->model()->getRow(0);

        $this->model()->getParentCateoriesList($id);
        $parentsList = $this->model()->getRows(0);

        $this->view()->setVariable('category', $category);
        $this->view()->setVariable('parentsList', $parentsList);
        $this->view()->loadTemplate('editcategory');

        $this->commitReplace($this->view()->render(), '#content');
    }

    public function editCategory() {
        $id = $this->getQueryString('id');
        $this->setId($id);
        $category = $this->updateCategory();

        if ($category['status'] != 200) {
            $this->commitAdd($this->view()->showAlert('error', '', $category['message']), 'body');
            $this->terminate();
        }
        $this->categoriesPage();
    }

    public function updateCategory() {
        $post = $this->getPost();

        $categoryData = array(
            'category_name'   => $post['category_name'],
            'parent_id'   => $post['parent_id'],
        );

        $validation = $this->validateData($categoryData);
        if(!$validation['valid'])
            return RestServer::throwError(implode(', ', $validation['message']));

        $this->model()->updateCategory($categoryData, $this->getId());

        if (!$this->model()->queryOk()) {
            return RestServer::throwError(Language::QUERY_ERROR(), 500);
        }

        return RestServer::response(array(
            'status'    => 200,
            'message'   => 'Cadastro atualizado!',
        ), 200);
    }

    private function validateData($postData){
        $return = array(
            'valid'     => true,
            'message'   => '',
        );

        if(empty($postData['category_name'])) {
            $return['valid'] = false;
            $return['message'][] = "O campo 'Nome' não pode ser vazio";
        }

        return $return;
    }

    public function newCategory() {
        $this->view()->loadTemplate('newcategory');

        $this->model()->getParentCateoriesList();
        $parentsList = $this->model()->getRows(0);
        
        $this->view()->setVariable('parentsList', $parentsList);
        $this->commitReplace($this->view()->render(), '#content');
    }

    public function addNewCategory(){
        $status = $this->postAddCategory();
        if ($status['status'] != 200) {
            $this->commitAdd(
                $this->view()->showAlert('error', 'Ops! Verifique seu cadastro', $status['message'])
                , '#content');
            $this->terminate();
        }
        echo Html::redirect(BASEDIR . 'categories');
    }

    /**
     * Rest handler for adding a client
     *
     * @return array|string
     * @throws ExceptionHandler
     */
    public function postAddCategory(){
        $post = $this->getPost();

        $categoryData = array(
            'category_name'   => $post['category_name'],
            'parent_id'   => $post['parent_id'],
        );

        $validation = $this->validateData($categoryData);

        if($validation['valid'] === FALSE) {
            $message = implode(', ', $validation['message']);
            return RestServer::throwError($message, 400);
        }

        $this->model()->addCategory($categoryData);

        if (!$this->model()->queryOk()) {
            if (in_array($this->model()->getErrorCode(), array(23000, 1062)))
                return RestServer::throwError(Language::USER_ALREADY_TAKEN(), 400);
            else
                return RestServer::throwError(Language::QUERY_ERROR(), 500);
        }

        $newCategoryId = $this->model()->getLastInsertId();

        return RestServer::response(array(
            'status'     => 200,
            'id'         => $newCategoryId,
            'message'    => 'Cadastro realizado!',
        ), 200);

    }

}