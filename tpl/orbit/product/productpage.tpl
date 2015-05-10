<div class="col-md-12">

    <div class="box box-solid">
        <div class="box-body pad table-responsive">
            <a class="btn btn-success" href="{$smarty.const.BASEDIR}product/newprodduct">Clique aqui e adicione um novo produto</a>
        </div><!-- /.box -->
    </div><!-- /.col -->

    {include "product/productinfo.tpl"}

</div><!-- ./row -->

<div class="col-md-12">
    <div class="box">
        <!-- search form -->
        <form action="{$smarty.const.BASEDIR}product" method="get" class="sidebar-form">
            <div class="input-group">
                <input type="text" name="search" class="form-control" placeholder="Localizar dentro da lista" value="{$search}"/>
                                    <span class="input-group-btn">
                                        <button type='submit' name='seach' id='search-btn' class="btn btn-flat">
                                            <i class="fa fa-search"></i>
                                        </button>
                                    </span>
            </div>
        </form>
        <!-- /.search form -->
        {$productList}
        {$pagination}
    </div><!-- /.box -->

    </section><!-- /.content -->
</div>