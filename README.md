Zend Framework 2 - Kapitchi Showcase Application
================================================

!!! WORK IN PROGRESS !!!
This application is not working yet! Follow us on twitter to get updates about the progress.  
We are experimenting and working on theme based on Twitter Bootstrap and AngularJS

Version: 0.1-dev
Author:  Kapitchi Team  
Website: http://kapitchi.com   


Introduction
============

Demo application for ZF2 modules developed or maintained by [Kapitchi Team](http://kapitchi.com).  

Installation
============

This applies to Win OS presuming you have [git](http://msysgit.github.com/) and php set in [path environment variable](http://blog.countableset.ch/2012/06/07/adding-git-to-windows-7-path/).  
We don't think it's necessary to explain what to do for Linux "super users".

1. Get the application source code under your www folder: `git clone https://github.com/kapitchi/KapitchiShowcaseApplication.git`
2. Change your working directory `cd KapitchiShowcaseApplication`
3. Create module-dev folder (folder for your modules to test, develop, break and play!) `mkdir module-dev`
4. Run composer - `php composer.phar install`
5. ... this will take some time... so in the meantime you can continue with following steps below
6. Create database "kapichi_showcase"
7. Run SQL script to create schemas and some sample records on the db: deploy/mysql-install.sql
8. Create db config file `copy config\autoload\database.local.php.dist config\autoload/database.local.php`
9. Your done! - [http://localhost/KapitchiShowcaseApplication/public/](http://localhost/KapitchiShowcaseApplication/public/)
