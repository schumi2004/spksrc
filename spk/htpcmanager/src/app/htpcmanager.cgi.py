#!/usr/local/htpcmanager/env/bin/python
import os
import ConfigParser


config = ConfigParser.ConfigParser()
config.read('/usr/local/htpcmanager/var/config.cfg')
protocol = 'http'
port = int(config.get('htpc', 'my_port'))

print 'Location: %s://%s:%d' % (protocol, os.environ['SERVER_NAME'], port)
print
