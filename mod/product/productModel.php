<?php

/**
 * Class productModel
 *
 */
class productModel extends Model {

    /**
     * The constructor
     *
     * You may specify the connection name
     * ob the object instantiation
     *
     * @param   string      $connection     - The connection name used by this model
     */
    public function __construct($connection = DEFAULT_CONNECTION) {
        parent::__construct($connection);
    }

    public function getCategoryList() {

        $this->addField('id');
        $this->addField('category_name');
        $this->addFrom('categories');
        $this->runQuery();

        return !$this->isEmpty();
    }

    public function getCountProducts() {

        $this->addField('count(id) as total');
        $this->addFrom('products');
        $this->runQuery();
        $result = $this->getRow(0);
        return $result['total'];
    }

    public function getProductList($page = 1, $rp = 10) {

        $total = $this->getCountProducts();

        $this->addField('p.id');
        $this->addField('c.category_name');
        $this->addField('p.product_name');
        $this->addField('p.weight');
        $this->addField('p.price');
        $this->addField('p.description');
        $this->addField('p.image64');

        $this->addFrom('products p');
        $this->addFrom('left join categories c on c.id = p.category_id');

        $offset = intval($total / $rp * $page);

        $this->addLimit($offset . ',' . $rp);
        $this->runQuery();

        return $total;
    }

    public function getProduct($id) {

        $this->addField('p.id');
        $this->addField('p.category_id');
        $this->addField('p.product_name');
        $this->addField('p.weight');
        $this->addField('p.price');
        $this->addField('p.description');
        $this->addField('p.image64');

        $this->addFrom('products p');
        $this->addWhere('p.id = "' . $id . '"');
        $this->runQuery();

        return !$this->isEmpty();
    }

    public function insertProduct($data) {

        foreach ($data as $field => $value)
            $this->addInsertSet($field, $value);

        $this->setInsertTable('products');
        $this->runInsert();

    }

    public function updateProduct($data, $id) {

        foreach ($data as $field => $value)
            $this->addUpdateSet($field, $value);

        $this->setUpdateTable('products');
        $this->addUpdateWhere('id = "' . $id . '"');
        
        $this->runUpdate();

    }


}