<?php

/**
 * Class Aws
 *
 * Autor: Elvis D'Andrea
 *
 * Classe para upload de arquivos utilizando a tecnologia S3 da Amazon
 *
 */

define('AUTH_FILE', IFCDIR . '/data/' . md5('orbit_s3'));


require 'aws.phar';

use Aws\S3\S3Client;
use Aws\S3\Exception\S3Exception;

class Aws {

    /**
     * Bucket Name
     *
     * @var
     */
    private $bucket;

    /**
     * Destination file
     *
     * @var
     */
    private $path;

    /**
     * Authentication on Aws
     *
     * @var
     */
    private $authentication;

    /**
     * Error Messages
     *
     * @var
     */
    private $errors = array();


    public function __construct() {
        $this->loadAuthentication();
    }

    /**
     * Authentication
     *
     */
    private function loadAuthentication() {

        if (!is_file(AUTH_FILE))
            return !$this->errors[] = 'Authentication File Missing';


        $authContent = file_get_contents(AUTH_FILE);
        $decrypted   = CR::decrypt($authContent);
        $auth        = json_decode($decrypted, true);

        if (!$auth)
            return !$this->errors[] = 'Authentication File is Broken';

        $this->authentication = $auth;

    }

    /**
     * Sets the bucket
     *
     * @param $bucket
     */
    final public function setBucket($bucket) {

        $this->bucket = $bucket;
    }

    /**
     * Sets the destination directorys
     *
     * @param $path
     */
    final public function setPath($path) {
        $this->path = $path;
    }

    /**
     * Loads the Factory
     *
     * @return S3Client
     */
    private function getFactory() {

        $factory = false;

        try {
            $factory = S3Client::factory($this->authentication);
        } catch (S3Exception $e) {
            $this->errors[] = $e->getMessage();
        }

        return $factory;
    }

    /**
     * Uploads
     *
     * @param   string      $sourceFile     - The Source File Name
     * @param   string      $fileName       - The Destination File Name
     * @param   string      $permission     - The File permissions
     *
     * @return \Guzzle\Service\Resource\Model
     */
    public function upload($sourceFile, $fileName, $permission = 'public-read') {

        $factory = $this->getFactory();
        $result  = false;

        if (!$factory)
            return false;

        try {
            $result = $factory->putObject(
                array(
                    'Bucket'        => $this->bucket,
                    'Key'           => $this->path . '/' . $fileName,
                    'SourceFile'    => $sourceFile,
                    'ACL'           => $permission
                )
            );
        } catch (S3Exception $e) {
            $this->errors[] = $e->getMessage();
            debug($this->errors);
        }

        return $result['ObjectURL'];
    }


}