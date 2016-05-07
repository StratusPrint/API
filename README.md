# API ![Build Status](https://travis-ci.org/StratusPrint/WebAPI.svg?branch=master) [![Coverage Status](https://coveralls.io/repos/github/StratusPrint/API/badge.svg?branch=dev)](https://coveralls.io/github/StratusPrint/API?branch=dev)

Commits pushed to the <b>master</b> branch are automatically deployed to [https://api.stratusprint.com](https://api.stratusprint.com).

Commits pushed to the <b>dev</b> branch are automatically deployed to [https://dev.api.stratusprint.com](https://dev.api.stratusprint.com).

Running locally
---------------
0. If you have not done so already, install both [Vagrant](http://www.vagrantup.com) and [VirtualBox](http://www.virtualbox.org).

1. Clone this repo:
	```sh
	git clone git@github.com:StratusPrint/API.git
	```

2. Start the virtual machine:
	```sh
	vagrant up
	```

3. SSH in to the virtual machine:
	```sh
	vagrant ssh
	```

4. Access the the API locally at [http://localhost:8081/](http://localhost:8081/)   

Queueing backend
---------------
Background jobs created by the API are configured to run on [Sidekiq](http://sidekiq.org/). Sidekiq can be started by running:
```
bundle exec sidekiq
```
inside the Rails application directory.
