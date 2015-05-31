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

    public function getCategoryList($page = false, $rp = false) {

        $this->addField('c.id');
        $this->addField('c.category_name');
        $this->addField('count(p.id) as product_count');
        $this->addFrom('categories c');
        $this->addFrom('left join products p on p.category_id = c.id');
        $this->addGroup('c.id');

        if ($page && $rp) {

            $offset = intval(($page - 1) * $rp);
            $this->addLimit($offset . ',' . $rp);
        }

        $this->runQuery();

        return !$this->isEmpty();
    }

    public function getCountCategories() {

        $this->addField('count(c.id) as total');
        $this->addFrom('categories c');
        $this->runQuery();

        $result = $this->getRow(0);
        return $result['total'];
    }


    public function getNutrictionProductList() {

        $this->addField('*');
        $this->addFrom('nutri_facts');
        $this->runQuery();
    }

    public function getNutrictionFacts($product_id) {

        $this->addField('f.id');
        $this->addField('f.product');
        $this->addField('f.serving');
        $this->addField('i.fact_per_serving');
        $this->addField('concat(i.fact_per_serving, t.unit) as fact_unit');
        $this->addField('t.fact_type');
        $this->addField('t.unit');
        $this->addField('t.vd');
        $this->addField('CAST(((i.fact_per_serving * 100) / t.vd) AS UNSIGNED) as fact_vd');

        $this->addFrom('nutri_facts f');
        $this->addFrom('inner join nutri_facts_item i on i.product_id = f.id');
        $this->addFrom('inner join nutri_facts_types t on t.id = i.type_id');

        $this->addWhere('f.id = "' . $product_id . '"');

        $this->runQuery();

    }

    public function getCountProducts($search = false) {

        $fields = array(
            'p.id',
            'c.category_name',
            'p.product_name',
            'p.weight',
            'p.price',
            'p.description'
        );

        $this->addField('count(p.id) as total');
        $this->addField('sum(p.price) as totalprice');
        $this->addFrom('products p');
        $this->addFrom('left join categories c on c.id = p.category_id');

        if ($search) {
            foreach ($fields as $field)
                $this->addWhere($field . ' like "%' . str_replace(' ','%',$search) . '%"', 'OR');
        }

        $this->runQuery();
        $result = $this->getRow(0);
        return $result;
    }

    public function getProductList($page = 1, $rp = 10, $search = false) {

        $total = $this->getCountProducts($search);

        $fields = array(
            'p.id',
            'c.category_name',
            'p.product_name',
            'p.weight',
            'p.price',
            'p.unit',
            'p.description'
        );

        foreach ($fields as $field)
                $this->addField($field);

        $this->addField('p.image');

        $this->addFrom('products p');
        $this->addFrom('left join categories c on c.id = p.category_id');

        if ($search) {
            foreach ($fields as $field)
                $this->addWhere($field . ' like "%' . str_replace(' ','%',$search) . '%"', 'OR');
        }

        $offset = intval(($page - 1) * $rp);

        $this->addLimit($offset . ',' . $rp);
        #debug($this->getQuery());

        $this->runQuery();

        return $total;
    }

    public function getProduct($id) {

        $this->addField('p.id');
        $this->addField('p.category_id');
        $this->addField('c.category_name');
        $this->addField('p.product_name');
        $this->addField('p.weight');
        $this->addField('p.price');
        $this->addField('p.cost');
        $this->addField('p.unit');
        $this->addField('group_concat(i.ingredient_name) as ingredients');
        $this->addField('p.description');
        $this->addField('p.image');
        $this->addField('p.product_fact');

        $this->addFrom('products p');
        $this->addFrom('left join categories c on c.id = p.category_id');
        $this->addFrom('left join product_ingredients i on i.product_id = p.id');

        $this->addWhere('p.id = "' . $id . '"');
        $this->addGroup('p.id');

        $this->runQuery();

        return !$this->isEmpty();
    }

    public function insertProduct($data) {

        foreach ($data as $field => $value)
            $this->addInsertSet($field, $value);

        $this->setInsertTable('products');
        $this->runInsert();

    }

    public function insertIngredient($product_id, $ingredient_name) {

        $this->addInsertSet('product_id', $product_id);
        $this->addInsertSet('ingredient_name', $ingredient_name);
        $this->setInsertTable('product_ingredients');

        $this->runInsert(false);
    }

    public function getIngredientList() {

        $this->addField('distinct ingredient_name');
        $this->addFrom('product_ingredients');
        $this->addLimit('300');

        $this->runQuery();
    }

    public function updateProduct($data, $id) {

        foreach ($data as $field => $value)
            $this->addUpdateSet($field, $value);

        $this->setUpdateTable('products');
        $this->addUpdateWhere('id = "' . $id . '"');
        $this->runUpdate();

    }

    public function updateCategory($id, $value) {

        $this->addUpdateSet('category_name', $value);
        $this->setUpdateTable('categories');
        $this->addUpdateWhere('id = "' . $id . '"');

        $this->runUpdate();
    }

    public function addCategory($name) {

        $this->addInsertSet('category_name', $name);
        $this->setInsertTable('categories');
        $this->runInsert();

    }

    public function deleteCategory($id) {

        $this->setDeleteFrom('categories');
        $this->addDeleteWhere('id = "' . $id . '"');

        $this->runDelete();
    }


}
