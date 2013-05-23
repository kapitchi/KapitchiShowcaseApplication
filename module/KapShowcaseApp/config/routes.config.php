<?php
/**
 * Kapitchi Zend Framework 2 Modules (http://kapitchi.com/)
 *
 * @copyright Copyright (c) 2012-2013 Kapitchi Open Source Team (http://kapitchi.com/open-source-team)
 * @license   http://opensource.org/licenses/LGPL-3.0 LGPL 3.0
 */

return array(
    'home' => array(
        'type' => 'Zend\Mvc\Router\Http\Literal',
        'options' => array(
            'route'    => '/',
            'defaults' => array(
                'controller' => 'KapShowcaseApp\Controller\Index',
                'action'     => 'index',
            ),
        ),
    ),
    // The following is a route to simplify getting started creating
    // new controllers and actions without needing to create a new
    // module. Simply drop new controllers in, and you can access them
    // using the path /application/:controller/:action
    'showcase-app' => array(
        'type'    => 'Literal',
        'options' => array(
            'route'    => '/showcase-app',
            'defaults' => array(
                '__NAMESPACE__' => 'KapShowcaseApp\Controller',
                'controller'    => 'Index',
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
);