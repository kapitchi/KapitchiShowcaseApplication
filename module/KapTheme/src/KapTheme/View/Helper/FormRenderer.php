<?php
namespace KapTheme\View\Helper;

use Zend\Form\View\Helper\AbstractHelper,
    Zend\Form\FormInterface;

/**
 *
 * @author Matus Zeman <mz@kapitchi.com>
 */
class FormRenderer extends AbstractHelper
{
    
    /**
     * Invoke as function
     * 
     * @return Form
     */
    public function __invoke($form = null)
    {
        if($form instanceof FormInterface) {
            return $this->render($form);
        }
        
        return $this;
    }
    
    public function render(FormInterface $form)
    {
        
        $str = $this->renderHeader($form);
        
        $str .= $this->renderElements($form);
        
        $str .= $this->renderFooter($form);
        
        return $str;
    }
    
    public function renderElements($form) {
        $str = '';
        foreach ($form->getIterator() as $element) {
            if($element instanceof \Zend\Form\FieldsetInterface) {
                //we can render basic elements for now
                continue;
            }
            $str .= $this->renderElement($element);
        }
        
        return $str;
    }
    
    public function renderElement($element)
    {
        $view = $this->getView();
        
        $className = get_class($element);
        $type = strtolower(substr(strrchr($className, '\\'), 1));
        
        $sm = $view->getHelperPluginManager();
        $pluginName = 'form' . $type;
        if(!$sm->has($pluginName)) {
            //TODO
            throw new \Exception("How do I render this element type '$type'?");
        }
        $plugin = $sm->get($pluginName);
        
        $str = '';
        
        $elTemplate = '%s';

        //render element
        if($type == 'hidden') {
            $str .= $plugin->render($element);
        }
        else {
            if ($element->getLabel() != null) {
                $str .= $view->formLabel($element);
            }
            $str .= sprintf($elTemplate, $plugin->render($element));
            $str .= $view->formElementErrors($element);
        }
        
        return $str;
    }

    public function renderSubmit($valueAttribute, $idAttribute = null)
    {
        $str = '<input id="' . $idAttribute . '" type="submit" value="' . $valueAttribute . '" class=""/>';
        return $str;
    }
    
    public function renderHeader(FormInterface $form)
    {
        $view = $this->getView();
        $str = $view->form()->openTag($form);
        return $str;
    }
    
    public function renderFooter(FormInterface $form)
    {
        $view = $this->getView();
        $str .= $view->form()->closeTag();
        
        return $str;
    }
}