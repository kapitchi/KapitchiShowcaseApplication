<?php

namespace KapAngularTheme;

use Zend\EventManager\EventInterface,
    Zend\ModuleManager\Feature\ServiceProviderInterface,
    Zend\ModuleManager\Feature\ViewHelperProviderInterface,
    Zend\ModuleManager\Feature\ControllerPluginProviderInterface,
	KapitchiBase\ModuleManager\AbstractModule;

class Module extends AbstractModule
    implements ServiceProviderInterface, ViewHelperProviderInterface, ControllerPluginProviderInterface
{

	public function onBootstrap(EventInterface $e) {
		parent::onBootstrap($e);
		
        
	}
    
    public function getControllerPluginConfig()
    {
        return array(
            'factories' => array(
                'angular' => function($sm) {
                    $ins = new Mvc\Controller\Plugin\Angular();
                    return $ins;
                },
            )
        );
    }
    
    public function getControllerConfig()
    {
        return array(
            'factories' => array(
                //API
                'KdsfsdfdsapTheme\Controller\Api\Template' => function($sm) {
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
                'angular' => function($sm) {
                    $sl = $sm->getServiceLocator();
                    $ins = new View\Helper\Angular();
                    $ins->setRequest($sl->get('Request'));
                    return $ins;
                },
                //XXX TODO -- mz: needed because response is not injected into helper in ZF2
                'json' => function($sm) {
                    $sl = $sm->getServiceLocator();
                    $ins = new \Zend\View\Helper\Json();
                    $ins->setResponse($sl->get('response'));
                    return $ins;
                }    
            )
        );
    }
    
    public function getServiceConfig()
    {
        return array(
            'invokables' => array(
                //'KapitchiAuction\Entity\Auction' => 'KapitchiAuction\Entity\Auction',
            ),
            'factories' => array(
//                'KapitchiAuction\Form\Auction' => function ($sm) {
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