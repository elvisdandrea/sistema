{foreach from=$list key="index" item="row"}
    <!-- Lista de clientes -->
    <div id="list-clients" class="list-itens">
        <div class="list-imgs">
            <img src="{if (!empty($row['image']))}{$row['image']}{else}{$smarty.const.T_IMGURL}/no-image.jpg{/if}" alt="{$row['station_name']}" />
        </div>
        <!-- /.Itens -->
        <div style="width:100%">
            <a href="{$smarty.const.BASEDIR}stations/viewstation?id={$row['id']}" changeurl>
                <div class="row">
                    <div class="col-md-5 col-sm-12">
                        <i class="fa circle fa-user"></i>
                        <h5>
                            <span>Loja:</span>&nbsp;
                            <strong>{$row['station_name']}</strong>
                        </h5>
                    </div>
                    <div class="col-md-7 col-sm-12">
                        <i class="fa circle fa-phone"></i>
                        <h5>
                            <span>{$row['phone']}</span>
                        </h5>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-5 col-sm-5">
                        <i class="fa circle fa-angle-right"></i>
                        <h5>
                            <span>Endereco:&nbsp;&nbsp;<strong>{$row['street_address']}</strong></span>
                        </h5>
                    </div>
                </div>
            </a>
        </div>
    </div>
    <hr/>
{/foreach}