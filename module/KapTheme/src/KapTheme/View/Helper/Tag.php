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
class Tag extends \Zend\View\Helper\AbstractHtmlElement
{
    
    public function __invoke($event = null)
    {
        return $this;
    }
    
    public function renderAttrs(array $attrs)
    {
        return $this->htmlAttribs($attrs);
    }
}