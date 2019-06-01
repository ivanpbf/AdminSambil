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
				if sexoAux == 0:
					sexo = "F"
				else:
					sexo = "M"
				# Se debe hacer un query que inserte esto en la tabla Rasgos
				payloadR = {
					"edad": edad,
					"sexo": sexo 	
				}
				print(payloadR)

			else:
				print("No se detectaron los rasgos de la persona") # Se puede quitar

			tieneTelefono = np.random.rand()		#Random para si la persona tiene telefono
			tieneMAC = None
			if(tieneTelefono > 0.3):
				MAC = int(np.random.uniform(1,9999999))
				tieneMAC = True
				#Se debe hacer un query que inserte esto en la tabla Usuario verificando que ya no este registrado (trigger)
				payloadU = {
					"mac": MAC,
				}
				print(payloadU)
			else:
				tieneMAC = False
				print("El usuario que ingreso no tiene telefono") # Se puede quitar
			
			#client.publish('',json.dumps(payload),qos=0)	
			#asociar la entrada a los rasgos si existe

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
						"fecha": dateEntrada,
						"tienda": idTienda
					}
					print(payloadT)
					compro = np.random.rand()
					if(compro > 0.6):
						venta+=1
						idVenta = venta
						monto = int(np.random.uniform(1,99999))
						if(tieneMAC):
							payloadV = {
								"idVenta": idVenta,
								"monto": monto,
								"tienda": idTienda,
								"UID": MAC
							}
						else:
							payloadV = {
								"idVenta": idVenta,
								"monto": monto,
								"tienda": idTienda
							}
						print(payloadV)
						#client.publish('',json.dumps(payloadV),qos=0)	
					else:
						print("No compro en tienda "+nombre)
					#salidas de torniquete para ese torniquete+=1
			else:
				print("No entro a tiendas")
    		
			#vamos a la feria
			fueFeria = np.random.rand()
			if(fueFeria > 0.5):
				idmesa = int(np.random.uniform(0,len(mesas)))
				idSensor = idmesa #no? o por ahora
				#el atributo ocupada no me dice mucho, o sea sirve para verificar que nadie mas se siente mientras este ocupada
				#hay que ver como manejar eso
				ocupada = True
				fechaOcupada = datetime.datetime.now().replace(month=mes,day=dia,hour=int(np.random.uniform(int(np.random.uniform(fechaInicial.hour)),18)),minute=int(np.random.uniform(0,60)), second=int(np.random.uniform(0,60)))
				fechaDesocupada = fechaOcupada + datetime.timedelta(minutes=np.random.uniform(2,60)) 
				if(tieneMAC):
					payloadM = {
						"idSensor": idSensor,
						"idmesa": idmesa,
						"UID": MAC,
						"fecha_ocupada": fechaOcupada,
						"fecha_Nocupada": fechaDesocupada
					}
				else:
					payloadM = {
						"idSensor": idSensor,
						"idmesa": idmesa,
						"fecha_ocupada": fechaOcupada,
						"fecha_Nocupada": fechaDesocupada
					}
				print(payloadM)
			else:
				print("No fue a la feria")
			#entra mas cosas tambien supongo pero por ahora esto creo
			saliendo+=1
			time.sleep(10)
		dia+=1
		
if __name__ == '__main__':
	main()