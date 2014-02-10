#Faktory

Full rails 3.2.16 app with authentication (via devise) and testing structure in place. Can be used as a testbed for new testing ideas or as a jumping off place for new apps in the future. the app is not much different than any new rails app generatied with ```rails new```; it just has some testing and layout/styling stuff added.

##CI

__Travis__ [![Build Status](https://travis-ci.org/QuantumGeordie/faktory.png?branch=master)](https://travis-ci.org/QuantumGeordie/faktory)

##Layout/Style

Standard [Foundation](http://foundation.zurb.com/).

##Testing

Aside from the basics a new rails app gets you, tests have been added with [Capybara](http://jnicklas.github.io/capybara/), [Selenium](http://docs.seleniumhq.org/projects/webdriver/) and the [AePageObjects](https://github.com/appfolio/ae_page_objects) implementation of the page object pattern.

###Selenium

####standard

```rake test:selenium``` will run the selenium tests like expected.

####other browser sizes

```rake test:selenium BROWSER_SIZE=WIDTHxHEIGHT``` will set the browser window size before every test case. for example ```rake test:selenium BROWSER_SIZE=640x1020``` will run the selenium test in a 640 by 1020 browser window.

####SauceLabs

```rake test:selenium SAUCE=true``` will run on the [SauceLabs](https://saucelabs.com) VMs. the saucelabs authentication information is set in a few system environment variables (```SAUCE_USERNAME``` and ```SAUCE_ACCESS_KEY```).

the test is configured to run the tests on one iPhone and one Android device. this can be easily modified for a variety of devices in the ```selenium_helper``` file.

```
  config[:browsers] = [
      ['OS X 10.9', 'iPhone', '7'],
      ['Linux', 'Android', '4.0']
  ]
```


