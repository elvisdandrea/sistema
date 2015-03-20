<?php

/**
 * Class HTML
 *
 * A library to manipulate Dynamic HTML
 *
 * This class returns the functions used by
 * the frontend to manipulate dynamic HTML
 * directly from the backend
 *
 * Author: Elvis D'Andrea
 * E-mail: elvis@vistasoft.com.br
 *
 */

class Html {

    /**
     * Returns the function to dynamically
     * append some HTML on screen
     *
     * @param   string      $html       - The inner HTML to be rendered
     * @param   string      $block      - The element to contain the HTML
     * @return  string
     */
    public static function AddHtml($html, $block) {

        return 'Html.Add(\'' . String::BuildStringNewLines(String::AddSQSlashes($html)) . '\',\'' . $block . '\');';
    }

    /**
     * Returns the function to dynamically
     * replace some HTML on screen
     *
     * @param   string      $html       - The inner HTML to be rendered
     * @param   string      $block      - The element to contain the HTML
     * @return  string
     */
    public static function ReplaceHtml($html, $block) {

        return 'Html.Replace(\'' . String::BuildStringNewLines(String::AddSQSlashes($html)) . '\',\'' . $block . '\');';
    }

    /**
     * Returns the function to dynamically
     * make some HTML visible
     *
     * @param   string      $block      - The element that contains the HTML
     * @return  string
     */
    public static function ShowHtml($block) {
        return 'Html.Show(\''.$block.'\');';
    }

    /**
     * Returns the function to dynamically
     * make some HTML invisible
     *
     * @param   string      $block      - The element that contains the HTML
     * @return  string
     */
    public static function HideHtml($block) {
        return 'Html.Hide(\''.$block.'\');';
    }

    /**
     * Still to be implemented
     *
     */
    public static function PushHtml($html) {
        return $html;
    }

    /**
     * Function to Asynchronously load
     * a select input content
     *
     * @param   string      $id     - The select input Id
     * @return  string
     */
    public static function AsyncLoadList($id, $selected = false) {
        return 'Html.AsyncLoadList(\'' . $id . '\'' . ($selected ? ',' . $selected : '') . ');';
    }

    /**
     * Refreshes Current Page
     */
    public static function refresh() {

        echo 'window.location.href = "' . $_SERVER['HTTP_REFERER'] . '"';
    }

    /**
     * A static function to statically get
     * a POST value when not in controllers
     *
     * Not Recommended, really
     *
     * @param   string      $name       - The field name in the POST
     * @return  bool
     */
    public static function GetPost($name) {

        if (isset($_POST[$name])) {
            return $_POST[$name];
        }
        return false;
    }

}

?>
