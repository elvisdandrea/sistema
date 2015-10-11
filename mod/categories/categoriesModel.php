<?php


class categoriesModel extends Model {

    public function getCountCategories() {
        $this->addField('COUNT(id) AS total');
        $this->addFrom('categories');
        $this->runQuery();
        $result = $this->getRow(0);
        return $result['total'];
    }

    public function getCategoriesList($page = 1, $rp = 10, $search = false){
        $total = $this->getCountCategories();

        $fields = array(
            'cat.id',
            'cat.category_name',
            'cat.parent_id',
        );

        $this->addField('cat.id');
        $this->addField('cat.category_name');
        $this->addField('cat.parent_id');
        $this->addField('parent.category_name parent_name');

        $this->addFrom('categories cat');
        $this->addFrom('left join categories parent on parent.id = cat.parent_id');

        if ($search) {
            foreach ($fields as $field)
                $this->addWhere($field . ' like "%' . str_replace(' ','%',$search) . '%"', 'OR');
        }

        $offset = intval(($page - 1) * $rp);

        $this->addLimit($offset . ',' . $rp);
        $this->runQuery();

        return $total;
    }

    public function getCategory($id){
        $this->addField('cat.id');
        $this->addField('cat.category_name');
        $this->addField('cat.parent_id');

        $this->addFrom('categories cat');
        $this->addWhere('cat.id = "' . $id . '"');

        $this->runQuery();
        return !$this->isEmpty();
    }

    public function getParentCateoriesList($id = null){
        $this->addField('cat.id');
        $this->addField('cat.category_name');

        $this->addFrom('categories cat');
        if($id != NULL)
            $this->addWhere("(cat.parent_id IS NULL OR cat.parent_id = 0) AND cat.id NOT IN ({$id})");
        else
            $this->addWhere('cat.parent_id IS NULL OR cat.parent_id = 0');

        $this->runQuery();
        return !$this->isEmpty();

    }

    public function updateCategory($data, $id) {
        foreach ($data as $field => $value)
            $this->addUpdateSet($field, $value);

        $this->setUpdateTable('categories');
        $this->addUpdateWhere('id = "' . $id . '"');
        $this->runUpdate();
    }

    public function addCategory($data){
        array_walk($data, function($item, $key) {
            $this->addInsertSet($key, $item);
        });

        $this->setInsertTable('categories');
        $this->runInsert();
    }
}