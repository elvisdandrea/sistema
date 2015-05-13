<script>
    function keepThisAlive() {
        setTimeout(function(){
            Html.Post('{$smarty.const.BASEDIR}home/keepalive', {

            }, function(a){
                eval(a);
                keepThisAlive();
            });
        }, 60000);
    }
    keepThisAlive();
</script>