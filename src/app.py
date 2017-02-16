# -*- encoding: utf-8 -*-
from __future__ import print_function

# HACK: load geos libraries manually before import shapely
import os
import ctypes

LAMBDA_TASK_ROOT = os.getenv('LAMBDA_TASK_ROOT')
LIBRARIES = ['libgeos-3.6.1.so', 'libgeos_c.so']
if LAMBDA_TASK_ROOT is not None:  # then we are in lambda
    for lib in LIBRARIES:
        lib = os.path.join(LAMBDA_TASK_ROOT, lib)
        print(lib)
        ctypes.cdll.LoadLibrary(lib)
from shapely.geometry import mapping, Point


def lambda_handler(event, context):
    print('REQUEST RECEIVED: ', event)

    patch = Point(event['lon'], event['lat']).buffer(event['buffer'])

    return mapping(patch)

# if __name__ == '__main__':
#     print(lambda_handler({}, {}))
