<div id="clienttable" class="box-body">
    {foreach from=$list key="index" item="row"}
    <div class="form-group">
        <!-- Client profile -->
        <div class="list-itens">
            <!-- /.Itens -->
            <div>
                <a href="{$smarty.const.BASEDIR}categories/viewcategory?id={$row['id']}" changeurl>
                    <h5>
                        <span>Nome:&nbsp;&nbsp;<strong>{$row['category_name']}</strong></span>
                    </h5>
                    <h5>
                        <span>Categoria pai: <strong>{if ($row['parent_name'] != '' )} {$row['parent_name']} {else}Sem categoria pai {/if}</strong></span>
                    </h5>
                </a>
            </div>
            
        </div>
    </div>
    <hr />
    {/foreach}
</div>