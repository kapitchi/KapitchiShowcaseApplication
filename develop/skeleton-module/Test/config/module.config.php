<?php
return array(
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
                        'controller' => 'test',
                        'action'     => 'index',
                    ),
                ),
            ),
        ),
    ),
    'controller' => array(
        'classes' => array(
            'test' => 'Test\Controller\IndexController'
        ),
    ),
    'view_manager' => array(
        'template_map' => array(
            'test/index/index'   => __DIR__ . '/../view/test/index/index.phtml',
        ),
        'template_path_stack' => array(
            __DIR__ . '/../view',
        ),
    ),
);
