<!-- Buttons (Options) -->
<div class="col-md-12">

    <div class="box box-solid">
        <div class="box-body pad table-responsive">
            <button class="btn btn-success" onclick="{$smarty.const.BASEDIR}client/newclient">Clique aqui e adicione um novo cliente
        </div><!-- /.box -->
    </div><!-- /.col -->

</div><!-- ./row -->

<div class="col-md-12">
    <div class="box">
        <!-- search form -->
        <form action="#" method="get" class="sidebar-form">
            <div class="input-group">
                <input type="text" name="q" class="form-control" placeholder="Localizar dentro da lista"/>
                                    <span class="input-group-btn">
                                        <button type='submit' name='seach' id='search-btn' class="btn btn-flat">
                                            <i class="fa fa-search"></i>
                                        </button>
                                    </span>
            </div>
        </form>
        <!-- /.search form -->
        {$clientlist}

        {$pagination}


    </div><!-- /.box -->