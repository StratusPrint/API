# API ![Build Status](https://travis-ci.org/StratusPrint/API.svg?branch=dev)

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
