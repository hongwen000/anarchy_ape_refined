PREFIX=/usr/local/bin
JAR=target/anarchy_ape.jar

all: install_remote

${JAR}: pom.xml
	mvn package

install: ${JAR}
	cp ${JAR}  ${PREFIX}/
	echo '#!/bin/sh' > ${PREFIX}/ape
	echo 'java -jar ${PREFIX}/anarchy_ape.jar "$$*"' >> ${PREFIX}/ape
	chmod 755 ${PREFIX}/ape
install_remote: ${PREFIX}/ape
	ansible-playbook install_ansible.yml
clean:
	rm -rf target
