import ssl
import sys
import psycopg2
import paho.mqtt.client
import json
import time
import datetime
import numpy as np

myConnection = psycopg2.connect(host = 'localhost', user= 'postgres',password ='password', dbname= 'Proyecto1BD') #estos son los mios

def insertarRasgos(r):
    cur = myConnection.cursor()
    cur.execute("INSERT INTO rasgos (idrasgos, edad, sexo) VALUES (%s, %s, %s);", (r["idrasgos"], r["edad"], r["sexo"])) #INSERTAR EN LA TABLA rasgos
    myConnection.commit()

def insertarUsuario(u):
    cur = myConnection.cursor()
    cur.execute("INSERT INTO usuario (mac) VALUES (%s);", (u["mac"],)) #INSERTAR EN LA TABLA usuario
    myConnection.commit()

def insertarUsuarioRasgo(ur):
    cur = myConnection.cursor()
    cur.execute("INSERT INTO usuariorasgo (usuariofk, rasgosfk) VALUES (%s,%s);", (ur["usuariofk"], ur["rasgosfk"])) #INSERTAR EN LA TABLA usuariorasgo
    myConnection.commit()

def insertarTorniquete(t):
    cur = myConnection.cursor()
    cur.execute("INSERT INTO torniquete (hentrada, tiendafk) VALUES (%s,%s);", (t["hentrada"], t["tiendafk"])) #INSERTAR EN LA TABLA torniquete
    myConnection.commit()

def insertarVenta(v):
    cur = myConnection.cursor()
    cur.execute("INSERT INTO venta (monto, tiendafk) VALUES (%s,%s);", (v["monto"], v["tiendafk"])) #INSERTAR EN LA TABLA venta
    myConnection.commit()

def insertarMesa(m):
    cur = myConnection.cursor()
    cur.execute("INSERT INTO datamesa (nmesa, fechaocupada, fechadesocupada) VALUES (%s,%s,%s);", (m["nmesa"], m["fechaocupada"], m["fechadesocupada"])) #INSERTAR EN LA TABLA datamesa
    myConnection.commit()


def on_connect(client, userdata, flags, rc):    
    print('Conectado ID (%s)' % client._client_id)
    client.subscribe(topic='Sambil/#', qos=0)    

def on_message(client, userdata, message):   
    r = json.loads(message.payload)
    print(r)  
    print('------------------------------')     
    insertarRasgos(r)

def on_message2(client, userdata, message):   
    u = json.loads(message.payload)
    print(u) 
    print('------------------------------')     
    insertarUsuario(u)

def on_message3(client, userdata, message):   
    ur = json.loads(message.payload)
    print(ur) 
    print('------------------------------')     
    insertarUsuarioRasgo(ur)

def on_message4(client, userdata, message):   
    t = json.loads(message.payload)
    print(t) 
    print('------------------------------')     
    insertarTorniquete(t)

def on_message5(client, userdata, message):   
    v = json.loads(message.payload)
    print(v) 
    print('------------------------------')     
    insertarVenta(v)

def on_message6(client, userdata, message):   
    m = json.loads(message.payload)
    print(m) 
    print('------------------------------')     
    insertarMesa(m)

def main():	
    client = paho.mqtt.client.Client()
    client.on_connect = on_connect
    client.message_callback_add('Sambil/rasgos',  on_message)
    client.message_callback_add('Sambil/usuario', on_message2)
    client.message_callback_add('Sambil/usuariorasgo', on_message3)
    client.message_callback_add('Sambil/torniquete', on_message4)
    client.message_callback_add('Sambil/venta', on_message5)
    client.message_callback_add('Sambil/mesa', on_message6)
    client.connect(host='localhost') 
    client.loop_forever()

if __name__ == '__main__':
    main()
    sys.exit(0)

