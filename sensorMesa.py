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
	#client.qos = 0
	#client.connect(host='localhost')
    		
	personas = ["1","2","3","4","5","6","7","8","9","10"]
	#de algun modo recibe la persona
	mesas = ["1","2","3","4","5"]
	#eventualmente habra que hacer un for o algo similar que llene personas con una cantidad mayor, usemos 10 por ahora para pruebas

	while(True): #este en un dia activo
		#aqui usamos la persona que """recibe"
		entrante = int(np.random.uniform(0,len(personas))) 
		#esta es la persona entrante
		#aqui debe hacerse una verificacion de si ya esta en la base de datos
		horaOcupada = datetime.datetime.now().replace(hour=int(np.random.uniform(8,18)),minute=int(np.random.uniform(0,61)), second=int(np.random.uniform(0,61))) #la hora entrante, OJO que no deberia ser now, deberia ser la que llegue del usuario, antes de su salida
		#esto es solo de prueba
		#en la bdd cambien de fechaocupada a hora ocupada
		#igual con desocupada
		
		idmesa = int(np.random.uniform(0,len(mesas)))
		#hacemos algo que verifique si la persona tiene telefono
		#esto que hago es auxiliar
		telefono = int(np.random.uniform(0,2))
		if telefono == 0:
    		#MAC = usuario.telefono.MAC o algo asi
			print("MAC")
		else:    
			print("No telefono")
			
		horaDesocupada = horaOcupada + datetime.timedelta(minutes=np.random.uniform(2,61)) #tal vez es asi
		payload = {
				"id": int(idmesa),# Falta hacerlo Unique
				"fechaocupada": str(horaOcupada), #datetime? es date en postgre, verificar
				"fechadesocupada": str(horaDesocupada)
			}
			#entra mas cosas tambien supongo pero por ahora esto creo
		#client.publish('',json.dumps(payload),qos=0)		
		print(payload)
		time.sleep(5)
		
if __name__ == '__main__':
	main()
	sys.exit(0)