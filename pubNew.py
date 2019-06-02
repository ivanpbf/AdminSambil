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
	fechaI = datetime.datetime.now().replace(month=mes,day=dia) #la hora entrante, falta el dia
	#ubicacion de tiendas no estoy seguro de si sea necesario
	venta = 0 #las ventas del dia o totales
	while(True):
		entrante = int(np.random.uniform(1,4)) #Pueden entrar cualquier cantidad de personas por comodidad pongamos que sea de 1 a 3
		entrando = entrante

		for i in range(entrante):					# Genera los datos para las "n" personas que entraron [0,n]
			############################################################################ REFERENTE AL ACCESO
			acceso = int(np.random.uniform(0,len(camaras))) #luego no hara falta poner len(camaras) porque ya sabremos cuantas camaras hay en el centro Comercial
			#idcamara, depende de la camara, por ahora las uso con el array
			horaAccesoE = fechaI.replace(hour=int(np.random.uniform(8,18)),minute=int(np.random.uniform(0,60)), second=int(np.random.uniform(0,60)))
			auxHoraultima = horaAccesoE #esta la usare para marcar la ultima actividad
			print("Entro")
			print(horaAccesoE)
			##############################################################################
			#creamos la cedula para la persona
			#por ahora hasta 20 para tener un control mejor de las personas
			cedula = int(np.random.uniform(1,20))
			#siempre va a haber la cedula
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
					"cedula": cedula,
					"edad": edad,
					"sexo": sexo 	
				}
				client.publish('Sambil/rasgos',json.dumps(payloadR), qos=0)
				#print(payloadR)
			else:
				payloadR = {
					"cedula": cedula
				}
				#client.publish('Sambil/rasgos',json.dumps(payloadR, qos = 0)) #publica los rasgos que consiguio, cedula siempre se "consigue"
			

			tieneTelefono = np.random.rand()		#Random para si la persona tiene telefono
			tieneMAC = None

			if(tieneTelefono > 0.3):
				mac = int(np.random.uniform(0,9999999))
				tieneMAC = True
			
				payloadU = {
					"mac": mac,
					"cedula": cedula
				}
				#poner la cedula aca

				client.publish('Sambil/usuario',json.dumps(payloadU), qos=0)
				#print("U",payloadU)

			else:
				tieneMAC = False
				print("El usuario que ingreso no tiene telefono") # Se puede quitar

			###############################################################################
			#cambiemos esto, que siempre se ponga la cedula de la persona, cedula se relaciona con sus rasgos
			if(detectoRasgos > 0.4 and tieneMAC == True): #TIENE MAC Y SE DETECTARON SUS RASGOS
				payloadUR = {
					"usuariofk": mac,
					"cedulafk": cedula
				}
				#ojo rasgos siendo la cedula siempre
				#print(payloadUR)
				client.publish('Sambil/usuariorasgo',json.dumps(payloadUR), qos=0)
			################################################################################

			#los metodos de compra
			entroTienda = np.random.rand()
			if(entroTienda > 0.5):
				for j in range(len(tiendas)):
					#por ahora
					idTienda = tiendas[j]
					idtorniquete = idTienda #por ahora
					nombre = nombresTiendas[j]
					#ubicacion sigo pensando que no
					dateEntrada = auxHoraultima + datetime.timedelta(hours=np.random.uniform(int(np.random.uniform(auxHoraultima.hour)),18), minutes=np.random.uniform(auxHoraultima.minute,60), seconds=np.random.uniform(0,60))
					#dateEntrada = auxHoraultima.replace(hour=int(np.random.uniform(int(np.random.uniform(auxHoraultima.hour)),18)),minute=int(np.random.uniform(auxHoraultima.minute,60)), second=int(np.random.uniform(0,60)))
					#creo que eso funciona, ahora uso de referencia la ultima hora de la persona
					##############################################
					dateSalida = dateEntrada + datetime.timedelta(minutes=np.random.uniform(2,31))
					auxHoraultima = dateSalida
					#entradas de torniquete para ese torniquete+=1
					#hacer el payload del torniquete?
					payloadT = {
						"idTorniquete": idtorniquete,
						"hentrada": str(dateEntrada),
						"hsalida": str(dateSalida),
						"tiendafk": idTienda
					}

					client.publish('Sambil/torniquete',json.dumps(payloadT), qos=0)
					#print(payloadT)

					compro = np.random.rand()
					if(compro > 0.4):
						monto = int(np.random.uniform(1,1000))
						################### siempre la cedula
						payloadV = {
							"monto": monto,
							"tiendafk": idTienda,
							"cedula": cedula
						}

						client.publish('Sambil/venta',json.dumps(payloadV), qos=0)
						#############################
						if (tieneMAC == True):
							payloadVU = {
								"monto": monto,
								"tiendafk": idTienda,
								"cedula": cedula,
								"mac": mac
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
				fechaOcupada = auxHoraultima + datetime.timedelta(hours=np.random.uniform(int(np.random.uniform(auxHoraultima.hour)),18), minutes=np.random.uniform(auxHoraultima.minute,60), seconds=np.random.uniform(0,60))
				#fechaOcupada = auxHoraultima.replace(hour=int(np.random.uniform(int(np.random.uniform(auxHoraultima.hour)),18)),minute=int(np.random.uniform(auxHoraultima.minute,60)), second=int(np.random.uniform(0,60)))
				fechaDesocupada = fechaOcupada + datetime.timedelta(minutes=np.random.uniform(2,60))
				auxHoraultima = fechaDesocupada
				################ojo, el proyecto dice que si la persona tiene telefono, se sabe quien es
				############### como telefono siempre tiene la cedula de la persona, se sabe es por eso
				if(tieneMAC):
					payloadM = {
						"nmesa": idmesa,
						"fechaocupada": str(fechaOcupada),
						"fechadesocupada": str(fechaDesocupada),
						"mac": mac
					}
					client.publish('Sambil/mesa',json.dumps(payloadM), qos=0)
					#print(payloadM)
				else:
					payloadM = {
						"nmesa": idmesa,
						"fechaocupada": str(fechaOcupada),
						"fechadesocupada": str(fechaDesocupada)
					}	
					client.publish('Sambil/mesa',json.dumps(payloadM), qos=0)
					#print(payloadM)
				

			else:
				print("No fue a la feria")

			horaAccesoS = auxHoraultima + datetime.timedelta(hours=np.random.uniform(int(np.random.uniform(auxHoraultima.hour)),18), minutes=np.random.uniform(auxHoraultima.minute,60), seconds=np.random.uniform(0,60))
			print("Salio")
			print(horaAccesoS)
			salida = int(np.random.uniform(0,len(camaras))) #luego no hara falta poner len(camaras) porque ya sabremos cuantas camaras hay en el centro Comercial
			payloadA = {
				"entrada": acceso,
				"salida": salida,
				"horaAcceso": horaAccesoE,
				"horaSalida": horaAccesoS
			}
			saliendo+=1
			time.sleep(3)

		fechaI = fechaI + datetime.timedelta(days = 1)
	
if __name__ == '__main__':
	main()