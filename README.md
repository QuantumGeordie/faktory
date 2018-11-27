#Faktory

Full rails 4.1.6 app with authentication (via devise) and testing structure in place. Can be used as a testbed for new testing ideas or as a jumping off place for new apps in the future. the app is not much different than any new rails app generatied with ```rails new```; it just has some testing and layout/styling stuff added.

## Code Climate

[![Code Climate](https://codeclimate.com/github/QuantumGeordie/faktory/badges/gpa.svg)](https://codeclimate.com/github/QuantumGeordie/faktory)

##CI

[![Build Status](https://travis-ci.org/QuantumGeordie/faktory.svg?branch=master)](https://travis-ci.org/QuantumGeordie/faktory)

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

```rake test:selenium:sauce``` will run on the [SauceLabs](https://saucelabs.com) VMs. the saucelabs authentication information is set in a few system environment variables (```SAUCE_USERNAME``` and ```SAUCE_ACCESS_KEY```).

the test is configured to run on a few devices/browsers. this can be easily modified for a variety of devices in the ```selenium_helper``` file. the platforms available can be found [here](https://saucelabs.com/platforms).

```
  config[:browsers] = [
    ['OS X 10.8', 'iphone', '6.1'],
    ['OS X 10.8', 'iphone', '6.1'],
    ['Windows 8.1', 'Internet Explorer', '11'],
    ['Windows 8.1', 'firefox', '29']
  ]
```

commit 1. Testing Webhook.
commit 2. More testing of the webhook.
commit 3. More testing. this time for branch name. (AGAIN) * 3.2
