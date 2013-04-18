<?php
/**
 * Kapitchi Zend Framework 2 Modules (http://kapitchi.com/)
 *
 * @copyright Copyright (c) 2012-2013 Kapitchi Open Source Team (http://kapitchi.com/open-source-team)
 * @license   http://opensource.org/licenses/GPL-3.0 GPL 3.0
 */

chdir(dirname(__DIR__));

// Composer autoloading
if (!include_once('vendor/autoload.php')) {
    throw new RuntimeException('vendor/autoload.php could not be found. Did you run `php composer.phar install`?');
}

// Get application stack configuration
$configuration = include 'config/application.config.php';

//loads local config if available
if(is_readable('config/application.local.php')) {
    $localConfig = include 'config/application.local.php';
    $configuration = array_merge_recursive($configuration, $localConfig);
}

// Run application
KapitchiApp\Mvc\Application::init($configuration)->run()->send();
