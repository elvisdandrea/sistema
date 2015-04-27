<tr>
    <td><img  src="{$item['image']}" width="50px" alt="{$item['product_name']}" /></td>
    <td>{$item['product_name']}</td>
    <td>{$item['category_name']}</td>
    <td>
        <button class="btn btn-primary label"><i class="fa fa-minus"></i></button>
        <label>{$item['weight']}</label>
        <button class="btn btn-primary label"><i class="fa fa-minus"></i></button>
    </td>
    <td>{String::convertTextFormat($item['price'], 'currency')}</td>
    <td><button type="button" class="btn label btn-danger">Retirar</button></td>
</tr>