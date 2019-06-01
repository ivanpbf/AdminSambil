import ssl
import sys
import psycopg2
import paho.mqtt.client
import json
import time
import datetime
import numpy as np

myConnection = psycopg2.connect(host = 'localhost', user= 'postgres', port='5432' ,password ='pass123', dbname= 'labadmin') #estos son los mios

def doQuery(a):
    cur = myConnection.cursor()
    #cur.execute("")
    myConnection.commit()

def on_connect(client, userdata, flags, rc):    
    print('Conectado ID (%s)' % client._client_id)
    client.subscribe(topic='labadmin/#', qos = 0)        

def on_message(client, userdata, message):   
    a = json.loads(message.payload)
    print(a) 
    print(message.qos)   
    print('------------------------------')     
    doQuery(a)

def main():	
	client = paho.mqtt.client.Client()
	client.on_connect = on_connect
	#client.message_callback_add('unimet/admin/bd', on_message)
	client.connect(host='localhost') 
	client.loop_forever()


if __name__ == '__main__':
	main()
	sys.exit(0)

