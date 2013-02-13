<?php

namespace KapAngularTheme\View\Helper;

/**
 * TODO this logic needs to be implemented in Angular service so both
 * controller plugin and view helper can use the same logic.
 * TBD: what about generic request context service?
 * 
 * @author Matus Zeman <mz@kapitchi.com>
 */
class Angular extends \Zend\View\Helper\AbstractHelper
{
    protected $request;
    
    public function __invoke()
    {
        return $this;
    }
    
    public function isTemplateRequest()
    {
        $accept = $this->getRequest()->getHeaders()->get('accept');
        $matchedFormat = $accept->match('text/ng-template')->getFormat();
        
        if($matchedFormat == 'ng-template') {
            return true;
        }
        
        return false;
    }
    
    protected function getRequest()
    {
        return $this->request;
    }

    public function setRequest($request)
    {
        $this->request = $request;
    }
    
}