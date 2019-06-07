import ssl
import sys
import psycopg2
import paho.mqtt.client
import json
import time
import datetime
import numpy as np

myConnection = psycopg2.connect(host = 'localhost', user= 'postgres',password ='pass123', dbname= 'Proyecto1BD') #estos son los mios

def insertarRasgos(r):
    cur = myConnection.cursor()
    cur.execute("INSERT INTO rasgos (cedula, edad, sexo) VALUES (%s, %s, %s);", (r["cedula"], r["edad"], r["sexo"])) #INSERTAR EN LA TABLA rasgos
    myConnection.commit()

def insertarUsuario(u):
    cur = myConnection.cursor()
    cur.execute("INSERT INTO usuario (mac, cedula) VALUES (%s,%s);", (u["mac"],u["cedula"])) #INSERTAR EN LA TABLA usuario
    myConnection.commit()

def insertarTorniquete(t):
    cur = myConnection.cursor()
    cur.execute("INSERT INTO torniquete (idTorniquete, hentrada, hsalida, tiendafk) VALUES (%s,%s,%s,%s);", (t["idTorniquete"],t["hentrada"], t["hsalida"],t["tiendafk"])) #INSERTAR EN LA TABLA torniquete
    myConnection.commit()

def insertarVenta(v):
    cur = myConnection.cursor()
    cur.execute("INSERT INTO venta (monto, tiendafk, cedula) VALUES (%s,%s,%s);", (v["monto"], v["tiendafk"], v["cedula"])) #INSERTAR EN LA TABLA venta
    myConnection.commit()

def insertarVentaMAC(vu):
    cur = myConnection.cursor()
    cur.execute("INSERT INTO venta (monto, tiendafk, cedula, mac) VALUES (%s,%s,%s,%s);", (vu["monto"], vu["tiendafk"], vu["cedula"], vu["mac"])) #INSERTAR EN LA TABLA venta
    myConnection.commit()

def insertarMesa(m):
    cur = myConnection.cursor()
    cur.execute("INSERT INTO mesa (nmesa, fechaocupada, fechadesocupada) VALUES (%s,%s,%s);", (m["nmesa"], m["fechaocupada"], m["fechadesocupada"])) #INSERTAR EN LA TABLA mesa
    myConnection.commit()

def insertarMesaMAC(mu):
    cur = myConnection.cursor()
    cur.execute("INSERT INTO mesa (nmesa, fechaocupada, fechadesocupada, mac) VALUES (%s,%s,%s,%s);", (mu["nmesa"], mu["fechaocupada"], mu["fechadesocupada"], mu["mac"])) #INSERTAR EN LA TABLA mesa
    myConnection.commit()

def insertarAcceso(a):
    cur = myConnection.cursor()
    cur.execute("INSERT INTO acceso (entrada, salida, horaAcceso, horaSalida, cedula) VALUES (%s,%s,%s,%s,%s);", (a["entrada"], a["salida"], a["horaAcceso"], a["horaSalida"], a["cedula"])) #INSERTAR EN LA TABLA acceso
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
    t = json.loads(message.payload)
    print(t) 
    print('------------------------------')     
    insertarTorniquete(t)

def on_message4(client, userdata, message):   
    v = json.loads(message.payload)
    print(v) 
    print('------------------------------')     
    insertarVenta(v)

def on_message5(client, userdata, message):   
    vu = json.loads(message.payload)
    print(vu) 
    print('------------------------------')     
    insertarVentaMAC(vu)

def on_message6(client, userdata, message):   
    m = json.loads(message.payload)
    print(m) 
    print('------------------------------')     
    insertarMesa(m)

def on_message7(client, userdata, message):   
    mu = json.loads(message.payload)
    print(mu) 
    print('------------------------------')     
    insertarMesaMAC(mu)

def on_message8(client, userdata, message):   
    a = json.loads(message.payload)
    print(a) 
    print('------------------------------')     
    insertarAcceso(a)

def main():	
    client = paho.mqtt.client.Client()
    client.on_connect = on_connect
    client.message_callback_add('Sambil/rasgos',  on_message)
    client.message_callback_add('Sambil/usuario', on_message2)
    client.message_callback_add('Sambil/torniquete', on_message3)
    client.message_callback_add('Sambil/venta', on_message4)
    client.message_callback_add('Sambil/venta', on_message5)
    client.message_callback_add('Sambil/mesa', on_message6)
    client.message_callback_add('Sambil/mesa', on_message7)
    client.message_callback_add('Sambil/acceso', on_message8)
    client.connect(host='localhost') 
    client.loop_forever()

if __name__ == '__main__':
    main()
    sys.exit(0)

