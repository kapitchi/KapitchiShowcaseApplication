<?php
/**
 * Kapitchi Zend Framework 2 Modules (http://kapitchi.com/)
 *
 * @copyright Copyright (c) 2012-2013 Kapitchi Open Source Team (http://kapitchi.com/open-source-team)
 * @license   http://opensource.org/licenses/LGPL-3.0 LGPL 3.0
 */

namespace KapTheme\View\Helper;

use Zend\Form\View\Helper\AbstractHelper,
    Zend\EventManager\EventManagerInterface,
    Zend\Form\FormInterface;

/**
 *
 * @author Matus Zeman <mz@kapitchi.com>
 */
class Event extends AbstractHelper implements \Zend\EventManager\EventManagerAwareInterface
{
    protected $eventManager;
    
    public function __invoke($event = null)
    {
        if($event) {
            return $this->render($event);
        }
        
        return $this;
    }
    
    public function render($event, $params = null, $prefixWithTemplate = true)
    {
        if($prefixWithTemplate) {
            $viewModel = $this->getView()->plugin('viewModel')->getCurrent();
            $id = $viewModel->getTemplate();
            $event = $id . '.' . $event;
        }
        
        $params = (array)$params;
        
        $eventRet = $this->getEventManager()->trigger($event, $this->getView(), $params);
        $ret = '';
        //TODO prefix postfix
        foreach($eventRet as $cont) {
            $ret .= $cont;
        }
        
        return $ret;
    }

    public function getEventManager()
    {
        return $this->eventManager;
    }

    public function setEventManager(EventManagerInterface $eventManager)
    {
        $eventManager->setIdentifiers(array(
            //'template_event',//TODO what event id to use?
            __CLASS__,
            get_called_class(),
        ));
        $this->eventManager =  $eventManager;
        $this->attachDefaultListeners();
        return $this;
    }
    
    protected function attachDefaultListeners() {
        
    }
    
}