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
    
    public function isAngularRequest()
    {
        return $this->isPageRequest() || $this->isTemplateRequest();
    }
    
    public function isTemplateRequest()
    {
        $accept = $this->getRequest()->getHeaders()->get('accept');
        $matched = $accept->match('text/ng-template');
        
        if($matched && $matched->getFormat()== 'ng-template') {
            return true;
        }
        
        return false;
    }
    
    public function isPageRequest()
    {
        $accept = $this->getRequest()->getHeaders()->get('accept');
        $matched = $accept->match('application/kap-page');
        
        if($matched && $matched->getFormat()== 'kap-page') {
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