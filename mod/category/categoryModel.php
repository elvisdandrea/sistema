<?php


class categoryModel extends Model {

    public function __construct($connection = DEFAULT_CONNECTION) {
        parent::__construct($connection);
    }


    /**
     * Returns the category list
     *
     * @param   bool|array|string   $filters
     * @return  array
     */
    public function getCategories($filters = false) {

        $this->addField('id');
        $this->addField('category_name');
        $this->addField('description');
        $this->addField('icon');
        $this->addFrom('categories');

        if ($filters) {
            $this->addWhere($filters);
        }

        $this->runQuery();
        return $this->getRows();
    }
}