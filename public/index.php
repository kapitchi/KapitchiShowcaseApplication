<?php
use Zend\ServiceManager\ServiceManager,
    Zend\Mvc\Service\ServiceManagerConfiguration;

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

// Setup service manager
$serviceManager = new ServiceManager(new ServiceManagerConfiguration($configuration['service_manager']));
$serviceManager->setService('ApplicationConfiguration', $configuration);
$serviceManager->get('ModuleManager')->loadModules();

// Run application
$serviceManager->get('Application')->bootstrap()->run()->send();
