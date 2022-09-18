__author__ = 'mykolagr'

import requests
import re

lines = tuple(open('hosts', 'r'))


print "\n The checking node can be added in hosts.txt file. \n \n The status of node can be: \n 1 -->  OK       (OK means node alive and handles the requests from end users) \n 2 -->  NMC      (NMC means node not handles requests from end users) \n 3 --> \"Unknown\" (It means node is down, need investigation) \n"


#Check the status of application

print "Check the status of application\n"

for line in lines:
    print '\n' + line + "-----------------------------------------------------\n"
    if re.match(r'.*?.ptec$', line, flags=0):
        url = 'http://'+ line.strip() + ':8080/healthCheck'
    elif re.match(r'.*?.ptdev.eu$', line):
        url = 'http://'+ line.strip() + '/healthCheck'
        urlssl = 'https://' + line.strip()
    elif re.match(r'.*?.(es|com|uk|mx|ua|net)$', line):
        url = 'http://'+ line.strip() + '/healthCheck'
        urlssl = 'https://' + line.strip()
    try:
        r = requests.get(url, timeout=2)
    except requests.Timeout, e:
        print "The request faild due to timeout error when try to establish connection to " + line
    except requests.HTTPError, e:
        print "Invalid HTTP response was gotten for " + line
    except requests.TooManyRedirects, e:
        print "The request faild due to a big amount of redirects for " + line
    except requests.ConnectionError, e:
        print "The problem with DNS, firewall or other network issue was detected for " + line
    except NameError:pass
#Greate the object for SSL cert verification
    try:
        r2 = requests.get(urlssl, verify=True)
    except requests.Timeout, e: pass
    except requests.HTTPError, e: pass
    except requests.TooManyRedirects, e: pass
    except requests.ConnectionError, e: pass
    except NameError: pass
#Check the status of java application, gzip, content-length
    try:
        print
        s = re.match(r'.*?OK$', r.text, flags=0)
        s2 = re.match(r'.*?NMC$', r.text, flags=0)
        D = {}
        D = r.headers
        for key,value in D.items():
            s3 = re.match(r'(.*?gzip)|(^gzip.*?)|gzip', value, flags=0)
            if s3:
                print "GZIP : ON"
        if s:
            print r.text
        elif s2:
            print r.text
        else:
            print "Status: Unknown"
        del s,s2,url,r
    except NameError:pass
#Print the status of certificate, gzip, content-length
    try:
        D2 = {}
        D2 = r2.headers
        for key,value in D2.items():
            s2 = re.match(r'(.*?gzip)|(^gzip.*?)|gzip', value, flags=0)
            if s2:
                print "GZIP : ON"
        s = str(r2.status_code)
        if s == '200':
            print 'Cert : Valid\n'
        elif not s:
            print 'Cert : Invalid\n'
        else:
            print 'Cert : Invalid\n'
    except NameError: pass