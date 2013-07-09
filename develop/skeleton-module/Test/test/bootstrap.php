<?php
/**
 * Kapitchi Zend Framework 2 Modules (http://kapitchi.com/)
 *
 * @copyright Copyright (c) 2012-2013 Kapitchi Open Source Team (http://kapitchi.com/open-source-team)
 * @license   http://opensource.org/licenses/LGPL-3.0 LGPL 3.0
 * 
 * Copied from: https://github.com/Ocramius/ProxyManager/blob/master/tests/Bootstrap.php
 */

chdir(__DIR__);

$loader = null;
if (file_exists('../vendor/autoload.php')) {
    $loader = include '../vendor/autoload.php';
} else if (file_exists('../../../autoload.php')) {
    $loader = include '../../../autoload.php';
} else {
    throw new RuntimeException('vendor/autoload.php could not be found. Did you run `php composer.phar install`?');
}

$loader->add('KapitchiEntityStub', __DIR__);
//$loader->add('KapitchiEntity', __DIR__);

//if (!$config = @include 'configuration.php') {
//    $config = require 'configuration.php.dist';
//}

//unset($files, $file, $loader);