<?php
return array(
    'navigation' => require 'navigation.config.php',
    'router' => array(
        'routes' => require 'routes.config.php'
    ),
    'controllers' => array(
        'invokables' => array(
            'KapShowcaseApp\Controller\Index' => 'KapShowcaseApp\Controller\IndexController',
            'KapShowcaseApp\Controller\Help' => 'KapShowcaseApp\Controller\HelpController',
        ),
    ),
    'view_manager' => array(
        'display_not_found_reason' => true,
        'display_exceptions'       => true,
        'doctype'                  => 'HTML5',
        'not_found_template'       => 'error/404',
        'exception_template'       => 'error/index',
        'template_map' => array(
            //'layout/layout'           => __DIR__ . '/../view/layout/layout.phtml',
            //'application/index/index' => __DIR__ . '/../view/application/index/index.phtml',
            //'error/404'               => __DIR__ . '/../view/error/404.phtml',
            //'error/index'             => __DIR__ . '/../view/error/index.phtml',
        ),
        'template_path_stack' => array(
            __DIR__ . '/../view',
        ),
        'strategies' => array(
            'ViewJsonStrategy', // register JSON renderer strategy
            //'ViewFeedStrategy', // register Feed renderer strategy
        ),
    ),
);
