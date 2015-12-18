#!/usr/bin/env python

import argparse
import os
import json
import requests

from elasticsearch import Elasticsearch



def collectArgs():
    descr = 'Collect / Aggregate Feature Files'
    parser = argparse.ArgumentParser(
        description=descr,
        formatter_class=argparse.RawDescriptionHelpFormatter
    )
    parser.add_argument("-s", "--server", dest="server",
                        required=True,
                        help="ES server")
    parser.add_argument("-q", "--query", dest="query",
                        required=True,
                        help="query string to post to ES")
    parser.add_argument("-f", "--fields", dest="fields", nargs="+",
                        required=True,
                        help="fields to keep.")
    parser.add_argument("-o", "--output_file", dest="output_file",
                        required=True,
                        help="tab separated values will be written to this \
                        file")
    return parser


def postQuery(es, query):
    response = es.search(index="aggregated_resource", body=query)
    return response


def parseResponse(response):
    
    return parsed_response

if __name__ == '__main__':
    parser = collectArgs()
    args = parser.parse_args()
    es = Elasticsearch([{"host": args.server, "port": 9200}])
