<div class="box-body">
    {foreach from=$list key="index" item="row"}
        <div class="form-group">
            <!-- Lista de clientes -->
            <div id="list-clients" class="list-itens">
                <div class="list-imgs" style="background:url({if (!empty($row['image']))}{$row['image']}{else}{$smarty.const.T_IMGURL}/no-image.jpg{/if})" alt="{$row['product_name']}"></div>
                <!-- /.Itens -->
                <div style="width:100%">
                    <a href="{$smarty.const.BASEDIR}product/viewproduct?id={$row['id']}" changeurl>
                        <div class="row">
                            <div class="col-md-5 col-sm-12">
                                <i class="fa circle fa-cutlery"></i>
                                <h5>
                                    <span>Produto:</span>&nbsp;
                                    <strong>{$row['product_name']}</strong>
                                </h5>
                            </div>
                            <div class="col-md-5 col-sm-12">
                                <i class="fa circle fa-cutlery"></i>
                                <h5>
                                    <span>{$row['category_name']}</span>
                                </h5>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-5 col-sm-5">
                                <i class="fa circle fa-angle-right"></i>
                                <h5>
                                    <span>Peso:&nbsp;&nbsp;<strong>{$row['weight']}</strong>{$row['unit']}</span>
                                </h5>
                            </div>
                            <div class="col-md-5 col-sm-7">
                                <i class="fa circle fa-usd"></i>
                                <h5>
                                    <span>{String::convertTextFormat($row['price'], 'currency')}</span>
                                </h5>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
            <hr/>
        {/foreach}
    </div>
</div>