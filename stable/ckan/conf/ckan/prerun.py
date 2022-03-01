"""
Copyright (c) 2016 Keitaro AB

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
"""

import os
import sys
import subprocess
import psycopg2
from sqlalchemy.engine.url import make_url
import urllib.request, urllib.error, urllib.parse
import re

import time

ckan_ini = os.environ.get('CKAN_INI', '/srv/app/production.ini')

RETRY = 5

def check_db_connection(retry=None):

    print('[prerun] Start check_db_connection...')

    if retry is None:
        retry = RETRY
    elif retry == 0:
        print('[prerun] Giving up after 5 tries...')
        sys.exit(1)

    conn_str = os.environ.get('CKAN_SQLALCHEMY_URL', '')
    try:
        db_user = make_url(conn_str).username
        db_passwd = make_url(conn_str).password
        db_host = make_url(conn_str).host
        db_name = make_url(conn_str).database
        connection = psycopg2.connect(user=db_user,
                               host=db_host,
                               password=db_passwd,
                               database=db_name)

    except psycopg2.Error as e:
        print((str(e)))
        print('[prerun] Unable to connect to the database...try again in a while.')
        import time
        time.sleep(10)
        check_db_connection(retry = retry - 1)
    else:
        connection.close()


def check_solr_connection(retry=None):

    print('[prerun] Start check_solr_connection...')

    if retry is None:
        retry = RETRY
    elif retry == 0:
        print('[prerun] Giving up after 5 tries...')
        sys.exit(1)

    protocol = os.environ.get('CKAN_SOLR_URL', '').split('/')[0]
    url = protocol + "//" + os.environ.get('CKAN_SOLR_URL', '').split('/')[2]
    check_existence_url = '{url}/solr/admin/collections?action=LIST&wt=json'.format(url=url)

    try:
        connection = urllib.request.urlopen(check_existence_url)
    except urllib.error.URLError as e:
        print('[prerun] Unable to connect to solr...try again in a while.')
        import time
        time.sleep(10)
        check_solr_connection(retry = retry - 1)
    else:
        import re
        conn_info = connection.read()
        # SolrCloud
        # conn_info = re.sub(r'"zkConnected":true', '"zkConnected":True', conn_info)
        # conn_info = re.sub(r'"zkConnected":false', '"zkConnected":False', conn_info)
        # eval(conn_info)


if __name__ == '__main__':

    maintenance = os.environ.get('MAINTENANCE_MODE', '').lower() == 'true'

    if maintenance:
        print('[prerun] Maintenance mode, skipping setup...')
    else:
        check_db_connection()
        check_solr_connection()
