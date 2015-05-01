<tr>
    <td><img  src="{$item['image']}" width="50px" alt="{$item['product_name']}" /></td>
    <td>{$item['product_name']}</td>
    <td>{$item['category_name']}</td>
    <td>
        <button type="button" class="btn btn-primary" onclick="Main.quickLink('/orbit/request/dropitemportion?id={$item['id']}&amount={$item['weight']}&plate_id={$plate_id}&request_id={$request_id}&action={$action}')"><i class="fa fa-minus-circle"></i></button>
        <label id="amount_{$plate_id}_{$id}" style="width: 60px; text-align: center;">{$item['weight']}{$item['unit']}</label>
        <button type="button" class="btn btn-primary" onclick="Main.quickLink('/orbit/request/additemportion?id={$item['id']}&amount={$item['weight']}&plate_id={$plate_id}&request_id={$request_id}&action={$action}')"><i class="fa fa-plus-circle"></i></button>
    </td>
    <td id="price_{$plate_id}_{$item['id']}">{String::convertTextFormat($item['price'], 'currency')}</td>
    <td><button type="button" class="btn label btn-danger">Retirar</button></td>
</tr>