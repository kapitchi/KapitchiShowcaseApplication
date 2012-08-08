<?php
return array(
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
                'application' => array(
                'type'    => 'Literal',
                'options' => array(
                    'route'    => '/test',
                    'defaults' => array(
                        '__NAMESPACE__' => 'Test\Controller',
                        'controller'    => 'Index',
                        'action'        => 'index',
                    ),
                ),
                'may_terminate' => true,
                'child_routes' => array(
                    'default' => array(
                        'type'    => 'Segment',
                        'options' => array(
                            'route'    => '/[:controller[/:action]]',
                            'constraints' => array(
                                'controller' => '[a-zA-Z][a-zA-Z0-9_-]*',
                                'action'     => '[a-zA-Z][a-zA-Z0-9_-]*',
                            ),
                            'defaults' => array(
                            ),
                        ),
                    ),
                ),
            ),
            ),
        ),
    ),
);
