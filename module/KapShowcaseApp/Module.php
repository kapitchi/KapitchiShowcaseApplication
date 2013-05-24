<?php
/**
 * Kapitchi Zend Framework 2 Modules (http://kapitchi.com/)
 *
 * @copyright Copyright (c) 2012-2013 Kapitchi Open Source Team (http://kapitchi.com/open-source-team)
 * @license   http://opensource.org/licenses/GPL-3.0 GPL 3.0
 */

namespace KapShowcaseApp;

use Zend\Mvc\ModuleRouteListener;
use Zend\ModuleManager\Feature\ServiceProviderInterface;
use Zend\EventManager\EventInterface;

class Module extends \KapitchiBase\ModuleManager\AbstractModule implements ServiceProviderInterface
{
    public function onBootstrap(EventInterface $e)
    {
        $eventManager = $e->getApplication()->getEventManager();
        $sm = $e->getApplication()->getServiceManager();
        $sharedEm = $eventManager->getSharedManager();
        $moduleRouteListener = new ModuleRouteListener();
        $moduleRouteListener->attach($eventManager);
        
        //@todo move this to KapApp?
        $router = $e->getApplication()->getServiceManager()->get('Router');
        \Zend\Navigation\Page\Mvc::setDefaultRouter($router);
        
        
        $this->onBoostrapTest($e);
    }
    
    protected function onBoostrapTest(EventInterface $e)
    {
        $eventManager = $e->getApplication()->getEventManager();
        $sm = $e->getApplication()->getServiceManager();
        $sharedEm = $eventManager->getSharedManager();

        //TODO mz: this is for testing purposes here - it should be moved into separate module?
        $sharedEm->attach('KapitchiContact\Controller\ContactController', 'update.post', function($e) use ($sm) {
            $entity = $e->getParam('entity');
            $sm->get('KapPage\Service\Page')->setCurrentPageModel(array(
                'title' => $entity->getDisplayName(),
                'parentPageId' => 'contact/contact',
            ));
        });
        
        $sharedEm->attach('KapitchiIdentity\Controller\IdentityController', 'update.post', function($e) use ($sm) {
            $entity = $e->getParam('entity');
            $sm->get('KapPage\Service\Page')->setCurrentPageModel(array(
                'title' => $entity->getDisplayName(),
                'parentPageId' => 'identity/identity',
            ));
        });

        
        //KapitchiContact
        $type = new \KapitchiContact\Service\Storage\StorageTypeListener(
                $sm,
                'email',
                'KapitchiContact\Service\Individual',
                'KapitchiContact\Form\Individual',
                'KapitchiContact\Form\IndividualInputFilter',
                array(
                    array(
                        'tag' => 'personal',
                        'label' => 'Personal email',
                        'required' => true,
                    ),
                    array(
                        'tag' => 'work',
                        'label' => 'Work email',
                    ),
                )
        );
        $sharedEm->attachAggregate($type);
        
        //$s = $sm->get('KapitchiContact\Form\Individual');
    }
    
    /**
     * Dummy method to support navigation translation for PoEdit
     * 
     * @param type $msg
     * @return type
     */
    public function translate($msg)
    {
        return $msg;
    }

    public function getServiceConfig()
    {
        return array(
            'factories' => array(
                'DefaultNavigation' => 'Zend\Navigation\Service\DefaultNavigationFactory'
            )
        );
    }
    
    public function getAutoloaderConfig()
    {
        return array(
            'Zend\Loader\StandardAutoloader' => array(
                'namespaces' => array(
                    __NAMESPACE__ => __DIR__ . '/src/' . __NAMESPACE__,
                ),
            ),
        );
    }

    public function getDir()
    {
        return __DIR__;
    }

    public function getNamespace()
    {
        return __NAMESPACE__;
    }
}
