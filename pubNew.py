import ssl
import sys
import random
import time
import paho.mqtt.client
import paho.mqtt.publish
import datetime
import numpy as np
import json

def on_connect(client, userdata, flags, rc):
	print('connected')

def main():
	client = paho.mqtt.client.Client("Sambil", False)
	client.on_connect = on_connect
	client.qos = 0 			
	client.connect(host='localhost')

	start_dt = datetime.date.today().replace(day=1, month=1).toordinal()
	end_dt = datetime.date.today().toordinal()
	random_day = datetime.date.fromordinal(random.randint(start_dt, end_dt))	
	dia = random_day.day
	mes = random_day.month

	saliendo = 0; #En un principio no va haber personas en el Sambil;
	entrando = 0
	#todos estos valores son de prueba y auxiliares
	camaras=["1","2","3"] #auxiliar
	tiendas = ["1","2","3","4","5"] #auxiliar
	nombresTiendas = ["Electronicos","Ropa","Zapatos","Electrodomesticos","Libros"] #auxiliar
	mesas = ["1","2","3","4","5"]
	#ubicacion de tiendas no estoy seguro de si sea necesario
	venta = 0 #las ventas del dia o totales
	while(True):

		entrante = int(np.random.uniform(1,4)) #Pueden entrar cualquier cantidad de personas por comodidad pongamos que sea de 1 a 3
		entrando = entrante
		fechaInicial = datetime.datetime.now().replace(month=mes,day=dia,hour=int(np.random.uniform(8,18)),minute=int(np.random.uniform(0,60)), second=int(np.random.uniform(0,60))) #la hora entrante, falta el dia
		acceso = int(np.random.uniform(0,len(camaras))) #luego no hara falta poner len(camaras) porque ya sabremos cuantas camaras hay en el centro Comercial
		#idcamara, depende de la camara, por ahora las uso con el array
		#Aqui va un query que inserte  estos datos en la tabla CamaraData

		for i in range(entrante):					# Genera los datos para las "n" personas que entraron [0,n]
			
			#los metodos del acceso
			detectoRasgos =  np.random.rand()		# Random para ver si la camara pudo detectar los rasgos de la persona (edad,sexo)
			if(detectoRasgos > 0.4):
				sexoAux = int(np.random.uniform(0,2))
				edad = int(np.random.uniform(12,81))
				uid = int(np.random.uniform(0,999999))

				if sexoAux == 0:
					sexo = "F"
				else:
					sexo = "M"
				# Se debe hacer un query que inserte esto en la tabla Rasgos
				payloadR = {
					"idrasgos": uid,
					"edad": edad,
					"sexo": sexo 	
				}

				client.publish('Sambil/rasgos',json.dumps(payloadR), qos=0)
				#print(payloadR)

			else:
				print("No se detectaron los rasgos de la persona") # Se puede quitar

			tieneTelefono = np.random.rand()		#Random para si la persona tiene telefono
			tieneMAC = None

			if(tieneTelefono > 0.3):
				mac = int(np.random.uniform(0,9999999))
				tieneMAC = True
			
				payloadU = {
					"mac": mac
				}

				client.publish('Sambil/usuario',json.dumps(payloadU), qos=0)
				#print("U",payloadU)

			else:
				tieneMAC = False
				print("El usuario que ingreso no tiene telefono") # Se puede quitar

			if(detectoRasgos > 0.4 and tieneMAC == True): #TIENE MAC Y SE DETECTARON SUS RASGOS
				payloadUR = {
					"usuariofk": mac,
					"rasgosfk": uid
				}

				#print(payloadUR)
				client.publish('Sambil/usuariorasgo',json.dumps(payloadUR), qos=0)
	
			#los metodos de compra
			entroTienda = np.random.rand()
			if(entroTienda > 0.5):
				for j in range(len(tiendas)):
					#por ahora
					idTienda = tiendas[j]
					idtorniquete = idTienda #por ahora
					nombre = nombresTiendas[j]
					#ubicacion sigo pensando que no
					dateEntrada = datetime.datetime.now().replace(month=mes,day=dia,hour=int(np.random.uniform(int(np.random.uniform(fechaInicial.hour)),18)),minute=int(np.random.uniform(0,60)), second=int(np.random.uniform(0,60)))
					#creo que eso funciona
					#entradas de torniquete para ese torniquete+=1
					#hacer el payload del torniquete?
					payloadT = {
						"idTorniquete": idtorniquete,
						"hentrada": str(dateEntrada),
						"tiendafk": idTienda
					}

					client.publish('Sambil/torniquete',json.dumps(payloadT), qos=0)
					#print(payloadT)

					compro = np.random.rand()
					if(compro > 0.4):
						monto = int(np.random.uniform(1,1000))
						payloadV = {
							"monto": monto,
							"tiendafk": idTienda,
						}

						client.publish('Sambil/venta',json.dumps(payloadV), qos=0)
						
						if (tieneMAC == True):
							payloadVU = {
								"monto": monto,
								"tiendafk": idTienda,
							}
			
					else:
						print("No compro en la tienda "+nombre)
					#salidas de torniquete para ese torniquete+=1
			else:
				print("No entro a tiendas")
			
			#vamos a la feria
			fueFeria = np.random.rand()
			if(fueFeria > 0.5):
				idmesa = int(np.random.uniform(0,len(mesas)))
				fechaOcupada = datetime.datetime.now().replace(month=mes,day=dia,hour=int(np.random.uniform(int(np.random.uniform(fechaInicial.hour)),18)),minute=int(np.random.uniform(0,60)), second=int(np.random.uniform(0,60)))
				fechaDesocupada = fechaOcupada + datetime.timedelta(minutes=np.random.uniform(2,60)) 
				payloadM = {
						"nmesa": idmesa,
						"fechaocupada": str(fechaOcupada),
						"fechadesocupada": str(fechaDesocupada)
				}	
				client.publish('Sambil/mesa',json.dumps(payloadM), qos=0)
				#print(payloadM)

			else:
				print("No fue a la feria")

			saliendo+=1
			time.sleep(3)

		dia+=1
	
if __name__ == '__main__':
	main()