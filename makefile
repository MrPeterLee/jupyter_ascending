CURRENT_DIR := $(shell pwd)

JUPYTER_ASCENDING_PYCHARM_VERSION := 1.0
PYCHARM_VERSION := 2019.3

install_dev:
	poetry install
	jupyter nbextension install --py --symlink --sys-prefix jupyter_ascending
	jupyter nbextension enable jupyter_ascending --py --sys-prefix
	jupyter serverextension enable jupyter_ascending --sys-prefix --py

pycharm_install:
	echo "This probably will not work for you."
	echo "Ask TJ how to install the plugin..."
	echo ""
	mkdir -p ~/$(PYCHARM_VERSION)/config/plugins/jupyter_ascending/lib/
	ls -s $(CURRENT_DIR) ./plugins/pycharm/build/idea-sandbox/plugins/jupyter_ascending/lib/jupyter_ascending-$(JUPYTER_ASCENDING_PYCHARM_VERSION)-SNAPSHOT.jar ~/$(PYCHARM_VERSION)/ ~/.PyCharm2019.3/config/plugins/jupyter_ascending/lib/jupyter_ascending-1.0-SNAPSHOT.jar

clean:
	echo "Remove all existing jupyter_ascending packages from the self-hosted PyPi-Server"
	sudo rm -f /lab/data/docker/pypiserver/packages/jupyter_ascending*

build:
	echo "Build and publish to internal pypi-server @ 10.1.1.100:10020"
	poetry config repositories.finclab_pypi http://10.1.1.100:10020/
	poetry config http-basic.finclab_pypi $$finclab_finclab_pypi_username $$finclab_finclab_pypi_password
	yes | poetry publish --repository finclab_pypi --build

# test:
# 	pytest tests/
