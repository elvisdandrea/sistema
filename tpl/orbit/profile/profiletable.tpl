{foreach from=$list key="index" item="row"}
    <!-- Lista de clientes -->
    <div id="list-clients" class="list-itens">
        <div class="list-imgs">
            <img src="{if (!empty($row['image']))}{$row['image']}{else}{$smarty.const.T_IMGURL}/no-profile.jpg{/if}" alt="{$row['client_name']}" />
        </div>
        <!-- /.Itens -->
        <div style="width:100%">
            <a href="{$smarty.const.BASEDIR}profile/viewuser?id={$row['id']}" changeurl>
                <div class="row">
                    <div class="col-md-5 col-sm-12">
                        <i class="fa circle fa-user"></i>
                        <h5>
                            <span>Cliente:</span>&nbsp;
                            <strong>{$row['name']}</strong>
                        </h5>
                    </div>
                    <div class="col-md-7 col-sm-12">
                        <i class="fa circle fa-phone"></i>
                        <h5>
                            <span>{$row['phone_1']}</span>
                        </h5>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-5 col-sm-5">
                        <i class="fa circle fa-angle-right"></i>
                        <h5>
                            <span>CPF:&nbsp;&nbsp;<strong>{$row['cpf']}</strong></span>
                        </h5>
                    </div>
                    <div class="col-md-7 col-sm-7">
                        <i class="fa circle fa-envelope-o"></i>
                        <h5>
                            <span>{$row['email']}</span>
                        </h5>
                    </div>
                </div>
            </a>
        </div>
    </div>
    <hr/>
{/foreach}