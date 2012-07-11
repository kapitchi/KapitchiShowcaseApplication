<?php
return array(
    'controllers' => array(
        'invokables' => array(
            'Test\Controller\Index' => 'Test\Controller\IndexController'
        ),
    ),
    'controller_plugins' => array(
        'classes' => array(
            //'test' => 'Test\Controller\Plugin\Test'
        ),
    ),
    'view_manager' => array(
        'template_map' => array(
            'test/index/index'   => __DIR__ . '/../view/test/index/index.phtml',
        ),
        'template_path_stack' => array(
            'test' => __DIR__ . '/../view',
        ),
        'helper_map' => array(
            //'js'        => 'Test\View\Helper\Js',
            //'jsJquery'        => 'Test\View\Helper\JsQuery',
        ),

    ),
    'router' => array(
        'routes' => array(
            'test' => array(
                'type'    => 'Zend\Mvc\Router\Http\Segment',
                'options' => array(
                    'route'    => '/test[/:action]',
                    'constraints' => array(
                        'action'     => '[a-zA-Z][a-zA-Z0-9_-]*',
                    ),
                    'defaults' => array(
                        'controller' => 'Test\Controller\Index',
                        'action'     => 'index',
                    ),
                ),
            ),
        ),
    ),
);
