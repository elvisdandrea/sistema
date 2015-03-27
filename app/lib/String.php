<?php

/**
 * Class String
 *
 * A library to manipulate and convert string values
 *
 * Author: Elvis D'Andrea
 * E-mail: elvis@vistasoft.com.br
 *
 */

class String {

    /**
     * Preventing string from having string injections
     *
     * @param   string      $string     - The original string
     * @return  string                  - The escaped string
     */
    public static function ClearString( $string ) {
        //TODO: It's begging for a real anti-injection algorith

        strpos($string, 'data:image') !== false ||
                            $string = addslashes($string);

        #$string = mysql_real_escape_string($string);
        return $string;
    }


    /**
     * Cleans an entire array recursively
     * from having string injection
     *
     * @param   array       $array      - The original array
     * @return  array                   - The escaped array
     */
    public static function ClearArray( $array ) {

        array_walk_recursive($array, function(&$item){
            $item = String::ClearString($item);
        });
        return $array;
    }

    /**
     * Remove new line characters from a string
     *
     * @param   string      $string     - The original string
     * @return  string                  - The string without new lines
     */
    public static function RemoveNewLines( $string ) {
        return preg_replace( '/\s+/', ' ', trim( $string ) );
    }

    /**
     * Concatenates each line of a string into slashes
     * and a concatenation character
     *
     * @param   string    $string           - The original string
     * @param   string    $concat_char      - The concatenation character
     * @return  string                      - The converted string
     */
    public static function BuildStringNewLines( $string, $concat_char = '+' ) {
        return preg_replace( '/' . PHP_EOL . '+/', '\'' . PHP_EOL . $concat_char .'"\\' . PHP_EOL .'"' . $concat_char . '\'', trim( $string ));
    }

    /**
     * An "addslashes" for single quotes only
     *
     * @param   string      $string     - The original string
     * @return  string
     */
    public static function AddSQSlashes( $string ) {
        return str_replace( '\'', '\\\'', $string );
    }

    /**
     * A non-validation version to format string dates
     * from dd/mm/yyyy to yyyy-mm-dd
     *
     * The purpose is to do it fast, so it's not secure
     * if the incoming string isn't correct
     *
     * @param   string      $date       - The original string date in dd/mm/yyyy format
     * @return  string                  - The string formatted to yyyy-mm-dd
     */
    public static function formatDateToSave($date) {
        if (strpos($date, '/') !== false) {
            $date = explode('/', $date);
            return $date[2] . '-' . $date[1] . '-' . $date[0];
        }
        return '0000-00-00';
    }

    /**
     * A non-validation version to format string dates
     * from dd/mm/yyyy hh:mm:ss to yyyy-mm-dd hh:mm:ss
     *
     * The purpose is to do it fast, so it's not secure
     * if the incoming string isn't correct
     *
     * @param   string      $date       - The original string date in dd/mm/yyyy format
     * @param   string      $time       - The original time in hh:mm:ss
     * @return  string                  - The string formatted to yyyy-mm-dd hh:mm:ss
     */
    public static function formatDateTimeToSave($date, $time) {
        $date = self::formatDateToSave($date);
        if (strpos($time, ':') === false) $time = '00:00:00';
        return $date . ' ' . $time;
    }

    /**
     * A non-validation version to format string dates
     * from yyyy-mm-dd to dd/mm/yyyy
     *
     * The purpose is to do it fast, so it's not secure
     * if the incoming string isn't correct
     *
     * @param   string      $date       - The original string date in yyyy-mm-dd format
     * @return  string                  - The string formatted to dd/mm/yyyy
     */
    public static function formatDateToLoad($date) {
        if (strpos($date, '-') !== false) {
            $date = explode('-', $date);
            return $date[2] . '/' . $date[1] . '/' . $date[0];
        }
        return '00/00/0000';
    }

    /**
     * A non-validation version to format string dates
     * from yyyy-mm-dd hh:mm:ss to dd/mm/yyyy hh:mm:ss
     *
     * The purpose is to do it fast, so it's not secure
     * if the incoming string isn't correct
     *
     * @param   string      $datetime       - The original string date in yyyy-mm-ddd hh:mm:ss format
     * @param   string      $separator      - Character to separate the date from time (optional)
     * @return  string                      - The string formatted to dd/mm/yyyy hh:mm:ss
     */
    public static function formatDateTimeToLoad($datetime, $separator = '') {
        $date = explode(' ',$datetime);
        if (count($date) > 1) {
            $fdate = self::formatDateToLoad($date[0]);
            $ftime = explode(':', $date[1]);
            $ftime = $ftime[0] . ':' . $ftime[1];
            return $fdate . ' ' . $separator. ' ' . $ftime;
        }
        return '00/00/0000 '.$separator.' 00:00';
    }

    /**
     * Applies any mask based on # character
     *
     * Such a wow I just did
     *
     * @param   string      $val        - The number value
     * @param   string      $mask       - The desired mask
     * @return  string
     */
    public static function mask($val, $mask) {

        $val = preg_replace('/[^a-z0-9]/i','', $val);
        $masked = '';
        $k = strlen($val) - 1;
        for($i = strlen($mask)-1; $i>=0; $i--) {
            if ($k < 0) break;
            $mask[$i] != '#' || $masked = $val[$k--] . $masked;
            $mask[$i] == '#' || $masked = $mask[$i]  . $masked;
        }
        return $masked;
    }

    /**
     * Converts to phone format
     *
     * @param   string      $texto
     * @return  string
     */
    public static function phoneFormat($texto) {

        $result = '';
        $s1 = $string = preg_replace('/[^0-9\-]/i','', $texto);
        $p = 0;
        for ($i = strlen($s1); $i > 0; $i--) {
            $p++;
            switch ($p) {
                case 5: $result = '-' . $result;
                    break;
                case 9: if (strlen($s1) == 10 || strlen($s1) == 12)
                    $result = ' ' . $result;
                    break;
                case 10: if (strlen($s1) == 11 || strlen($s1) == 13)
                    $result = ' ' . $result;
            }
            $result = $s1[$i - 1] . $result;
        }
        return ($result == "" ? $texto : $result);
    }

    /**
     * Converte o texto do campo conforme opcao
     *
     * @param   string      $string         - O conteúdo do campo
     * @param   int         $option         - A opcao
     * @return  string
     */
    public static function convertTextFormat($string, $option) {
        switch ($option) {
            case 'ln': //Letras e Números
                $string = preg_replace('/[^a-z0-9\-]/i','',$string);
                break;
            case 'l': //Letras
                $string = preg_replace('/[^a-z\-]/i','',$string);
                break;
            case 'n': //Números
                $string = preg_replace('/[^0-9\-]/i','',$string);
                break;
            case 'fone': //Telefone
                $string = self::phoneFormat($string);
                break;
            case 'ddd': //Telefone com DDD
                $string = self::phoneFormat($string);
                break;
            case 'cnpj': //CNPJ
                $string = self::mask($string, '##.####.###/####-##');
                break;
            case 'cpf': //CPF
                $string = self::mask($string, '###.###.###-##');
                break;
            case 'cep': //CEP
                $string = self::mask($string, '#####-###');
                break;
            case 'email': //E-MAIL
                // Nothing we can do here
                break;
            case 'int': //Numeros Inteiros
                $string = preg_replace('/[^0-9\-]/i','',$string);
                break;
        }

        return $string;
    }

    /**
     * Valida o formato dos dados em um campo de texto
     *
     * @param   string      $string     - O conteúdo
     * @param   int         $option     - O valor da opcao
     * @return  bool
     */
    public static function validateTextFormat($string, $option) {

        switch ($option) {
            case 'ln': //Letras e Números
                return preg_match('/[a-z0-9]/i', $string);
                break;
            case 'l': //Letras
                return preg_match('/[a-z]/i', $string);
                break;
            case 'n': //Números
                return preg_match('/[0-9]/i', $string);
                break;
            case 'fone': //Telefone
                return preg_match('/^(\(0?\d{2}\)\s?|0?\d{2}[\s.-]?)\d{4,5}[\s\-]?\d{4}$/', $string);
                break;
            case 'ddd': //Telefone com DDD
                return preg_match('/^(\(0?\d{2}\)\s?|0?\d{2}[\s.-]?)\d{4,5}[\s\-]?\d{4}$/', $string);
                break;
            case 'cnpj': //CNPJ
                return preg_match('/^(\d{2}\.\d{3}\.\d{3}\/\d{4}-\d{2})$/', $string);
                break;
            case 'cpf': //CPF
                return preg_match('/^(\d{3}\.\d{3}\.\d{3}\-\d{2})$/', $string);
                break;
            case 'cnpjcpf': //CPNJ ou CPF
                return preg_match('/(^\d{3}\.\d{3}\.\d{3}\-d{2}$)|(^\d{2}\.\d{3}\.\d{3}\/\d{4}\-\d{2}$)/', $string);
                break;
            case 'cep': //CEP
                return preg_match('/^(\d{5}\-\d{3})$/', $string);
                break;
            case 'email': //E-MAIL
                return preg_match('/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{1,3})+$/', $string);
                break;
            case 'int': //Numeros Inteiros
                return preg_match('/[0-9\-]/', $string);
                break;
            case 'float':
                return preg_match('/^[0-9]+\.?[0-9]*$/', $string);
                break;
            default:
                return true;
                break;
        }
    }

    public static function cpfValid($cpf) {

        $cpf = preg_replace('/^[a-z0-9]/i', '', $cpf);
        for ($t = 9; $t < 11; $t++) {

            for ($d = 0, $c = 0; $c < $t; $c++) {
                $d += $cpf{$c} * (($t + 1) - $c);
            }
            $d = ((10 * $d) % 11) % 10;
            if ($cpf{$c} != $d) {
                return false;
            }
        }
    }


    /**
     * Removes empty values for arrays
     * with numeric indexes
     *
     * The indexes that contain values will
     * be moved upwards, so numeric indexes
     * will remain in sequence
     *
     * @param   array       $array      - The original array
     */
    public static function arrayTrimNumericIndexed(&$array) {

        $result = array();

        foreach ($array as $value) $value == '' || $result[] = $value;
        $array = $result;
    }

    /**
     * Converts CameCase text to Uppercase-First-Letter words
     *
     * @param   string      $word           - The CamelCased Text
     * @return  string                      - The Uppercase-First-Letter text
     */
    public static function decamelize($word) {
        return preg_replace(
            '/(^|[a-z])([A-Z])/e',
            'strlen("\\1") ? "\\1 \\2" : "\\2"',
            $word
        );
    }

    /**
     * Converts underline_separated_text to CamelCase Text
     *
     * @param   string      $word           - The underlined_separated_text
     * @return  string                      - The CamelCased text
     */
    public static function camelize($word) {
        return preg_replace('/(^|_)([a-z])/e', 'strtoupper("\\2")', $word);
    }

}

?>
