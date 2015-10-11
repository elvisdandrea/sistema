<div class="col-md-12">
<div class="box box-solid">
    <div class="box-body pad table-responsive">
        <button type="submit" class="btn btn-success" title="Salvar" onclick="$('#category-form').submit()" style="width:150px;">Cadastrar categoria</button>
    </div><!-- /.box -->
</div><!-- /.col -->
    <div class="row">
        <form id="category-form" action="{$smarty.const.BASEDIR}categories/addNewCategory" changeurl="{$smarty.const.BASEDIR}categories">
            <div class="col-md-8 col-sm-12">

                <div class="box">
                    <div class="box-header">
                        <h3 class="box-title">Dados da categoria</h3>
                    </div><!-- /.box-header -->

                    <div class="box-body">
                        <div class="row">
                            <div class="form-group col-md-12">
                                <div class="form-group col-md-12">
                                    <label>Nome:</label>
                                    <input type="text" class="form-control" name="category_name"/>
                                </div>
                                <div class="form-group col-md-6 col-sm-6">
                                    <label id="cpf_cnpj">Categoria pai</label>
                                    <select class="form-control" name="parent_id">
                                        <option value="">Sem categoria pai</option>
                                        {foreach from=$parentsList key="key" item="value"}
                                            <option value="{$value['id']}">{$value['category_name']}</option>
                                        {/foreach}
                                    </select>
                                </div>
                            </div>
                        </div>

                    </div><!-- /.box-body -->
                </div><!-- /.box -->
            </div>
        </form>
    </div>

</div>
