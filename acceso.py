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

def main():
    #client = paho.mqtt.client.Client("Sambil", False)
	#client.on_connect = on_connect
	#client.qos = 0 ##estoy pensando que seria 1
	#client.connect(host='localhost')
    		
	personas = ["1","2","3","4","5","6","7","8","9","10"]
	camaras = ["1","2","3"]
	#eventualmente habra que hacer un for o algo similar que llene personas con una cantidad mayor, usemos 10 por ahora para pruebas
	nsalidas = 0
	nentrante = 0
	while(True):
		entrante = int(np.random.uniform(0,len(personas))) ##creo que ese 0 va ahi
		#esta es la persona entrante
		fecha = datetime.datetime.now().replace(hour=int(np.random.uniform(8,18)),minute=int(np.random.uniform(0,60)), second=int(np.random.uniform(0,60))) #la hora entrante
		#hay que ponerle el dia tambien
		camara = int(np.random.uniform(0,len(camaras)))
		edad = int(np.random.uniform(12,81))
		sexoAux = int(np.random.uniform(0,2))
		if sexoAux == 0:
			sexo = "F"
		else:
			sexo = "M"
		#fk es el id de entrante basicamente

		aux = int(np.random.uniform(0,2))
		telefono = None
		MAC = 0
		if aux == 0:
			telefono = True
			MAC = int(np.random.uniform(1,9999999))
			#asegurarse de que no haya otro
		else:
			telefono = False

		acceso = int(np.random.uniform(1,4)) #por cual puerta?
		#aunque ahora que lo pienso, acceso no deberia ser igual a camara?
		#porque el acceso es el que tiene camaras
		nentrante+=1
		##hace su recorrido
		nsalidas+=1
		payload = {
				"id": int(camara),
				"fecha": str(fecha),
				"nentradas": int(nentrante),
				"nsalidas": int(nsalidas),
				"acceso": int(acceso),
				"edad": int(edad),
				"sexo": str(sexo)
			}
			#entra mas cosas tambien supongo pero por ahora esto creo
		#client.publish('',json.dumps(payload),qos=0)		
		print(payload)
		time.sleep(5)
		
if __name__ == '__main__':
	main()
	sys.exit(0)