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
    		
	saliendo = 0; #En un principio no va haber personas en el Sambil;

	while(True):

		entrante = int(np.random.uniform(0,4)) #Pueden entrar cualquier cantidad de personas por comodidad pongamos que sea de 0 a 3
		fecha = datetime.datetime.now().replace(hour=int(np.random.uniform(8,18)),minute=int(np.random.uniform(0,60)), second=int(np.random.uniform(0,60))) #la hora entrante, falta el dia
		acceso = int(np.random.uniform(0,len(camaras))) #luego no hara falta poner len(camaras) porque ya sabremos cuantas camaras hay en el centro Comercial

		#Aqui va un query que inserte  estos datos en la tabla CamaraData

		for i in range(entrante):					# Genera los datos para las "n" personas que entraron [0,n]
			
			detectoRasgos =  np.random.rand()		# Random para ver si la camara pudo detectar los rasgos de la persona (edad,sexo)
			if(detectoRasgos > 0.4):
			 	edad = int(np.random.uniform(12,81))
				sexoAux = int(np.random.uniform(0,2))
				if sexoAux == 0:
					sexo = "F"
				else:
					sexo = "M"

				# Se debe hacer un query que inserte esto en la tabla Rasgos
				payload = {
					"edad": edad
					"sexo": sexo 	
				}

			else:
				print("No se detectaron los rasgos de la persona") # Se puede quitar


			tieneTelefono = np.random.rand()		#Random para si la persona tiene telefono
			if(tieneTelefono > 0.3):
			 	if aux == 0:
					MAC = int(np.random.uniform(1,9999999))

				#Se debe hacer un query que inserte esto en la tabla Usuario verificando que ya no este registrado (trigger)

				payload = {
					"mac": MAC 	
				}

			else:
				print("El usuario que ingreso no tiene telefono") # Se puede quitar

		#entra mas cosas tambien supongo pero por ahora esto creo
		#client.publish('',json.dumps(payload),qos=0)		
		print(payload)
		time.sleep(5)
		
if __name__ == '__main__':
	main()