<?php
/**
 * Kapitchi Zend Framework 2 Modules (http://kapitchi.com/)
 *
 * @copyright Copyright (c) 2012-2013 Kapitchi Open Source Team (http://kapitchi.com/open-source-team)
 * @license   http://opensource.org/licenses/LGPL-3.0 LGPL 3.0
 */

namespace KapTheme;

use Zend\EventManager\EventInterface,
    Zend\ModuleManager\Feature\ServiceProviderInterface,
    Zend\ModuleManager\Feature\ViewHelperProviderInterface,
	KapitchiBase\ModuleManager\AbstractModule;

class Module extends AbstractModule
    implements ServiceProviderInterface, ViewHelperProviderInterface
{

	public function onBootstrap(EventInterface $e) {
		parent::onBootstrap($e);
		
        
	}
    
    public function getControllerConfig()
    {
        return array(
            'factories' => array(
                //API
                'KapTheme\Controller\Api\Template' => function($sm) {
                    $cont = new Controller\Api\TemplateController();
                    return $cont;
                },
            )
        );
    }
    
    public function getViewHelperConfig()
    {
        return array(
            'factories' => array(
                'formRenderer' => function($sm) {
                    $ins = new View\Helper\FormRenderer();
                    return $ins;
                },
                'event' => function($sm) {
                    $sl = $sm->getServiceLocator();
                    $ins = new View\Helper\Event();
                    $ins->setEventManager($sl->get('EventManager'));
                    return $ins;
                }
            )
        );
    }
    
    public function getServiceConfig()
    {
        return array(
            'invokables' => array(
                //'KapAuction\Entity\Auction' => 'KapAuction\Entity\Auction',
            ),
            'factories' => array(
//                'KapAuction\Form\Auction' => function ($sm) {
//                    $ins = new Form\Auction();
//                    return $ins;
//                },
            )
        );
    }
    
    public function getDir() {
        return __DIR__;
    }

    public function getNamespace() {
        return __NAMESPACE__;
    }

}