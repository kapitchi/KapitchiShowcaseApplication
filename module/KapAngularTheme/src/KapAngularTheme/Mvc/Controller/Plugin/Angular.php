<?php

namespace KapAngularTheme\Mvc\Controller\Plugin;

/**
 *
 * @author Matus Zeman <mz@kapitchi.com>
 */
class Angular extends \Zend\Mvc\Controller\Plugin\AbstractPlugin
{
    public function __invoke()
    {
        return $this;
    }
    
    public function isTemplateRequest()
    {
        $accept = $this->getController()->getRequest()->getHeaders()->get('accept');
        $matchedFormat = $accept->match('text/ng-template')->getFormat();
        
        if($matchedFormat == 'ng-template') {
            return true;
        }
        
        return false;
    }
}