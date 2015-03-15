<?php


/**
 * Class CR
 *
 * Sorry, not many docs from here
 *
 * The encryption hash is generated dynamically,
 * so only this class can decrypt what's encrypted from here
 */
class CR {

    private static $fixedHash = 'z731w&k';

    /**
     * Encrypts a text
     *
     * @param   string      $str        - Some plain text
     * @return  string                  - The encrypted text
     */
    public static function encrypt($str)
    {
        $pass = uniqid();

        srand((double) microtime() * 1000000);
        $td = mcrypt_module_open('des', '', 'cfb', '');
        $key = substr($pass, 0, mcrypt_enc_get_key_size($td));
        $iv_size = mcrypt_enc_get_iv_size($td);
        $iv = mcrypt_create_iv($iv_size, MCRYPT_RAND);

        if (mcrypt_generic_init($td, $key, $iv) != -1) {
            $c_t = mcrypt_generic($td, $str);

            mcrypt_generic_deinit($td);
            mcrypt_module_close($td);

            return '!' . $pass . '$' . strrev(rtrim(base64_encode($iv . $c_t), '=='));
        } else {
            return false;
        }
    }

    /**
     * Decrypts a text
     *
     * @param   string      $str        - The encrypted text
     * @return  string                  - The decrypted text
     */
    public static function decrypt($str)
    {
        if ($str == '') return false;
        $str = substr($str, 1);
        $str = explode('$', $str);
        $pass = $str[0];
        $str = strrev($str[1]) . '==';
        $str = base64_decode($str);
        $lib = mcrypt_module_open('des', '', 'cfb', '');
        $iv_size = mcrypt_enc_get_iv_size($lib);
        $key = substr($pass, 0, mcrypt_enc_get_key_size($lib));
        $iv = substr($str, 0, $iv_size);
        $str = substr($str, $iv_size);

        if (mcrypt_generic_init($lib, $key, $iv) != -1) {
            $c_t = mdecrypt_generic($lib, $str);

            mcrypt_generic_deinit($lib);
            mcrypt_module_close($lib);

            return $c_t;
        } else {
            return false;
        }
    }


    /**
     * Encryption for fixed text
     *
     * @param  string     $str      - The plain text
     * @return string               - The encoded text
     */
    public static function encodeText($str) {

        $aux = mcrypt_encrypt(MCRYPT_BLOWFISH, self::$fixedHash, "xxxxxxx".$str, MCRYPT_MODE_ECB);
        $base64 = base64_encode($aux);
        return trim( str_replace(array("+","=","/","$") , array("7abc9","7abc8","a1b2c3d","3s2s1s0") , $base64)  );
    }

    /**
     * Decryption for fixed text
     *
     * @param   string      $str    - The encoded text
     * @return  string              - The plain text
     */
    public static function decodeText($str){
        if(strlen(trim($str)) <= 2){
            return $str;
        }

        $base64 = base64_decode( str_replace( array("7abc9","7abc8","a1b2c3d","3s2s1s0") , array("+","=","/","$") ,  $str ) , false);
        if(trim($base64) != ""){
            if(mb_detect_encoding($base64) == 'ASCII'){
                return $str;
            }
            $aux = ltrim(mcrypt_decrypt(MCRYPT_BLOWFISH, self::$fixedHash, $base64, MCRYPT_MODE_ECB),"xxxxxxx");
            return trim(iconv("UTF-8", "CP1252",$aux));
        }else{
            return $str;
        }
    }

}
?>
