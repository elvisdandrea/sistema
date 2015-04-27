<tr>
    <td><img  src="{$item['image']}" width="50px" alt="{$item['product_name']}" /></td>
    <td>{$item['product_name']}</td>
    <td>{$item['category_name']}</td>
    <td>
        <button class="btn btn-primary"><i class="fa fa-minus-circle"></i></button>
        <label style="width: 60px; text-align: center;">{$item['weight']}{$item['unit']}</label>
        <button class="btn btn-primary"><i class="fa fa-plus-circle"></i></button>
    </td>
    <td>{String::convertTextFormat($item['price'], 'currency')}</td>
    <td><button type="button" class="btn label btn-danger">Retirar</button></td>
</tr>