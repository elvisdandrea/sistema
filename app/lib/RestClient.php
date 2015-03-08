<?php
//TODO: The entire class is just on the beggining (format, security, etc..)
/**
 * Class RestClient
 *
 */
class RestClient {

    /**
     * The Rest Parameters List
     *
     * @var array
     */
    private $params;

    /**
     * The Rest Method
     *
     * @var string
     */
    private $method = 'get';

    /**
     * The Rest URL
     *
     * @var string
     */
    private $url;

    /**
     * The Rest URI
     *
     * @var string
     */
    private $uri;

    /**
     * The Request Headers
     *
     * @var array
     */
    private $headers;

    /**
     * The Rest Response
     *
     * @var
     */
    private $response;

    /**
     * The Response Format
     *
     * @var
     */
    private $format = 'html';

    /**
     * The Constructor
     *
     * @param $url
     */
    public function __construct($url) {
        $this->url = $url;
    }

    /**
     * @return mixed
     */
    public function getParams() {
        return $this->params;
    }

    /**
     * Adds a param to the request body
     *
     * @param string $param         - The param name
     * @param string $value         - The param value
     */
    public function addParam($param, $value) {
        $this->params[$param] = $value;
    }

    /**
     * @param $format
     */
    public function setFormat($format) {

        !in_array($format, array('json', 'html', 'xml')) || $this->format = $format;
    }

    /**
     * @return mixed
     */
    public function getMethod() {
        return $this->method;
    }

    /**
     * @param mixed $method
     */
    public function setMethod($method) {
        !in_array($method, array('get', 'post', 'put', 'delete', 'update')) || $this->method = $method;
    }

    /**
     * @return mixed
     */
    public function getUrl() {
        return $this->url;
    }

    /**
     * @param mixed $url
     */
    public function setUrl($url) {
        $this->url = $url;
    }

    /**
     * @return mixed
     */
    public function getUri() {
        return $this->uri;
    }

    /**
     * @param mixed $uri
     */
    public function setUri($uri) {
        $this->uri = $uri;
    }

    /**
     * @return mixed
     */
    public function getHeaders() {
        return $this->headers;
    }

    /**
     * Adds a Request Header
     *
     * @param string $header
     * @param string $value
     */
    public function addHeader($header, $value) {
        $this->headers[$header] = $value;
    }

    /**
     * Returns the Request Response
     *
     * @return mixed
     */
    public function getResponse() {
        return $this->response;
    }

    /**
     * Executes a ReST request
     */
    public function execute() {

        $url = $this->url . $this->uri;

        $ch = curl_init();

        /**
         * Headers
         */
        if (count($this->headers) > 0) {
            $headers = array();
            foreach ($this->headers as $header => $headerValue)
                $headers[] = $header . ':' . $headerValue;
            curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        }

        /**
         * Method
         */
        switch ($this->method) {
            case 'get':
                if (count($this->params) > 0) {
                    $data = urldecode(http_build_query($this->params));
                    $url .= '?' . $data;
                }
                break;
            case 'post' :
                curl_setopt($ch, CURLOPT_POST, true);
                curl_setopt($ch, CURLOPT_POSTFIELDS, $this->params);
                break;
        }

        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

        $this->response = curl_exec($ch);

        switch ($this->format) {
            case 'json':
                $this->response = json_decode($this->response, true);
                break;
            case 'xml':
                $this->response = simplexml_load_string($this->response);
                break;
        }

    }


}