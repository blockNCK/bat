# -*- coding: utf-8 -*-
"""
Created on Tue Mar 24 21:00:00 2020

@author: chathurangi
"""

import pymongo

myclient = pymongo.MongoClient("mongodb://localhost:27017/")
mydb = myclient["nck"]
mycol = mydb["batches"]

for x in mycol.find():
  print(x)