<?php


class categoryModel extends Model {

    public function __construct($connection = DEFAULT_CONNECTION) {
        parent::__construct($connection);
    }


    /**
     * Returns the category list
     *
     * @param   bool|array|string   $filters
     * @param   bool                $all
     * @return  array
     */
    public function getCategories($filters = false, $all = true) {

        $this->addField('c.id');
        $this->addField('c.category_name');
        $this->addField('c.description');
        $this->addField('c.icon');
        $this->addFrom('categories c');

        if (!$all) $this->addFrom('inner join products p on p.category_id = c.id');

        if ($filters) {
            $this->addWhere($filters);
        }

        $this->runQuery();
        return $this->getRows();
    }
}