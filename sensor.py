import ssl
import sys
import random
import time
import paho.mqtt.client
import paho.mqtt.publish
import datetime
import numpy as np

def on_connect(client, userdata, flags, rc):
	print('connected')

def main:
    client = paho.mqtt.client.Client("", False) ##la base de datos aqui
	client.on_connect = on_connect
	client.qos = 1 ##estoy pensando que seria 1
	client.connect(host='localhost')
    		
	hora = datetime.datetime.now().replace(minute=0, second=0) ##nuestra
	personas = ["1","2","3","4","5","6","7","8","9","10"]
	tiendas = ["1","2","3","4","5"]
	mesa = ["1","2","3","4","5"]
	##eventualmente habra que hacer un for o algo similar que llene personas con una cantidad mayor, usemos 10 por ahora para pruebas

	while(True): ##condicion para cual se sigue haciendo, por ejemplo, creo que deberiamos poner aqui el dia, cuando se cumpla un mes, para?
		entrante = int(np.random.uniform(0,len(personas))) ##creo que ese 0 va ahi
		#esta es la persona entrante
		#aqui debe hacerse una verificacion de si ya esta en la base de datos

		#de no estarlo, se crea
		#if no esta
		#esto es si creamos sus atributos
		#vamos a los rasgos
		edad = int(np.random.uniform(12,81)) #pongo 12 como edad minima
		sexo = int(np.random.uniform(0,2))
    	if sexo == 0:
    		#mujer
		else:
			#hombre
		#fk es el id de entrante basicamente

		aux = int(np.random.uniform(0,2))
		telefono = None
		if aux == 0:
    		telefono = True
			#ojo, el MAC es el ID
			#no creo que nos tengamos que complicar formateando un MAC de verdad, por lo tanto, vayamos con un MAC aleatorio
			MAC = int(np.random.uniform(1,9999999)) #poco probable que se repita pero cuidado
			#se relaciona con usuario fk
		else:
    		telefono = False

		acceso = int(np.random.uniform(1,4))
		#guardar hora de entrada y generar tambien hora de salida
		#entre estas horas pasa lo demas

		#generar mas randoms de los movimientos de la persona
		#misma manera, elige una tienda en base a un numero, siendo 0 el que no entra a una tienda
		#puede pasar multiples veces si no es 0
		#lo mismo con mesa