<?php

/**
 * Kapitchi Zend Framework 2 Modules (http://kapitchi.com/)
 *
 * @copyright Copyright (c) 2012-2013 Kapitchi Open Source Team (http://kapitchi.com/open-source-team)
 * @license   http://opensource.org/licenses/LGPL-3.0 LGPL 3.0
 */

return array(
    'default' => array(
        array(
            'id' => 'identity/identity',
            'label' => $this->translate('Identities'),
            'route' => 'identity/identity',
            'action' => 'index',
        ),
        array(
            'id' => 'contact/contact',
            'label' => $this->translate('Contacts'),
            'route' => 'contact/contact',
            'action' => 'index',
        ),
        array(
            'label' => $this->translate('Help'),
            'route' => 'showcase-app/default',
            'controller' => 'help',
            'action' => 'documentation',
            'order' => 100,
            'pages' => array(
                array(
                    'label' => $this->translate('Developer Documentation'),
                    'route' => 'showcase-app/default',
                    'controller' => 'help',
                    'action' => 'documentation',
                ),
            )
        ),
    )
);