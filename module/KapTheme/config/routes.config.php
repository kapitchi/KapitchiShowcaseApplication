<?php

return array(
    'theme' => array(
        'type' => 'Literal',
        'options' => array(
            'route'    => '/theme',
            'defaults' => array(
                '__NAMESPACE__' => 'KapTheme\Controller',
            ),
        ),
        'may_terminate' => false,
        'child_routes' => array(
            'api' => array(
                'type'    => 'Literal',
                'options' => array(
                    'route'    => '/api',
                    'defaults' => array(
                        '__NAMESPACE__' => 'KapTheme\Controller\Api',
                    ),
                ),
                'may_terminate' => false,
                'child_routes' => array(
                    'plugin' => array(
                        'type'    => 'Segment',
                        'options' => array(
                            'route'    => '/template/:version/:action/:name',
                            'constraints' => array(
                                'action'     => '[a-zA-Z][a-zA-Z0-9_-]*',
                                'name'     => '[a-zA-Z][a-zA-Z0-9_-]*',
                            ),
                            'defaults' => array(
                                'controller' => 'Template',
                            ),
                        ),
                    ),
                ),
            ),
        ),
    ),
);