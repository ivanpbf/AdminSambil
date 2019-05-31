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
	tiendas = ["1","2","3","4","5"]
	categorias = ["Electronicos","Ropa","Zapatos","Electrodomesticos","Libros"]
	#eventualmente habra que hacer un for o algo similar que llene personas con una cantidad mayor, usemos 10 por ahora para pruebas
	venta = 0
	#un error, esto lo hice mas que nada para la tienda, considerando que el torniquete pertenece a ella
	while(True): #este en un dia activo
		#aqui usamos la persona que """recibe"
		entrante = int(np.random.uniform(0,len(personas))) 
		#esta es la persona entrante

		hentrada = datetime.datetime.now().replace(hour=int(np.random.uniform(8,18)),minute=int(np.random.uniform(0,60)), second=int(np.random.uniform(0,60))) #la hora entrante, OJO que no deberia ser now, deberia ser la que llegue del usuario, antes de su salida
		#esto es solo de prueba
		
		idtienda = int(np.random.uniform(0,len(tiendas)))
		idtorniquete = idtienda
		categoria = categorias[idtienda-1]
		nombre = "Tienda "+str(idtienda)
		#hacemos algo que verifique si la persona tiene telefono
		#esto que hago es auxiliar
		telefono = int(np.random.uniform(0,2))
		if telefono == 0:
    		#MAC = usuario.telefono.MAC o algo asi
			print("MAC")
		else:
			print("No telefono")

		comprara = int(np.random.uniform(0,2))
		if comprara == 0:	
			print("La persona compro")
			monto = int(np.random.uniform(1,99999))
			idventa = venta
			venta+= 1
			#va la info a algun lado de la compra
		else:	
			print("No compro")
			idventa = 0
			monto = 0
			#hacer que la venta sea null, los datos o de hecho, no incluir venta

		hsalida = hentrada + datetime.timedelta(minutes=np.random.uniform(2,61)) #tal vez es asi
		payload = {
				"idtienda": int(idtienda),
				"idtorniquete": int(idtorniquete),
				"hentrada": str(hentrada), #datetime? es date en postgre, verificar
				"hsalida": str(hsalida),
				"idventa": int(idventa),
				"monto": int(monto)
			}
			#entra mas cosas tambien supongo pero por ahora esto creo
		#client.publish('',json.dumps(payload),qos=0)		
		print(payload)
		time.sleep(5)
		
if __name__ == '__main__':
	main()
	sys.exit(0)