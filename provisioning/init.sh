echo -e "root soft nofile 65536 \nroot hard nofile 65536 \n* soft nofile 65536 \n* hard nofile 65536"\
		>> /etc/security/limits.conf; # Sets the limits on max open files for elasticsearch - Check with ulimit -n
wget http://packages.treasure-data.com/debian/RPM-GPG-KEY-td-agent;
apt-key add ./RPM-GPG-KEY-td-agent; # Adds td-agent repo
apt-get update && apt-get install -y vim curl ruby;
apt-get install -y openjdk-7-jre-headless make ruby1.9.1 ruby1.9.1-dev libcurl3 libcurl3-gnutls libcurl4-openssl-dev;
curl -L http://toolbelt.treasuredata.com/sh/install-ubuntu-precise.sh | sh; # Downloads the td-agent (fluentd packaged version)
mkdir -p /opt/elasticsearch; # Sets up the directory for elasticsearch and Kibana UI
cd /opt/elasticsearch;
wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.3.2.tar.gz;
tar xzvf elasticsearch-1.3.2.tar.gz;
mv elasticsearch-1.3.2/* .; rm elasticsearch-1.3.2.tar.gz; rm -rf elasticsearch-1.3.2;
/usr/lib/fluent/ruby/bin/fluent-gem install fluent-plugin-elasticsearch;
echo "*.* @127.0.0.1:42185" >> /etc/rsyslog.conf;
apt-get install -y python-software-properties python g++ make;
add-apt-repository ppa:chris-lea/node.js;
apt-get update;
apt-get install -y nodejs;
cd /opt/elasticsearch;
git clone https://github.com/fangli/kibana-authentication-proxy;
cd /opt/elasticsearch/kibana-authentication-proxy && git submodule init && git submodule update;
npm install; cd kibana && git checkout master && git pull;
service rsyslog restart;
bash /vagrant/kibana-bootstrap.sh start;