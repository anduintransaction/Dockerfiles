#!/usr/bin/env python

import sys
import json

viewName = sys.argv[1]
mapFile = sys.argv[2]

with open(mapFile) as fm:
    mapFunction = fm.read()
    viewContent = {
        'views': {
            viewName: {
                'map': mapFunction,
            }
        }
    }
    print json.dumps(viewContent)
