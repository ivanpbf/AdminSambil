import ssl
import sys
import random
import time
import psycopg2
import paho.mqtt.client
import paho.mqtt.publish
import datetime
import numpy as np
import simplejson as json

myConnection = psycopg2.connect(host = 'localhost', user= 'postgres',password ='pass123', dbname= 'Proyecto1BD') #estos son los mios

def on_connect(client, userdata, flags, rc):
	print('connected')

def main():
	client = paho.mqtt.client.Client("Sambil", False)
	client.on_connect = on_connect
	client.qos = 0 			
	client.connect(host='localhost')
	cur = myConnection.cursor()

	start_dt = datetime.date.today().replace(day=1, month=1).toordinal()
	end_dt = datetime.date.today().toordinal()
	random_day = datetime.date.fromordinal(random.randint(start_dt, end_dt))	
	dia = random_day.day
	mes = random_day.month

	saliendo = 0; #En un principio no va haber personas en el Sambil;
	entrando = 0
	#todos estos valores son de prueba y auxiliares
	camaras=["1","2","3"] #auxiliar
	tiendas = ["1","2","3","4","5","6","7","8","9","10"] #auxiliar
	nombresTiendas = ["Electronicos","Ropa","Zapatos","Electrodomesticos","Libros","Perfumes","Mercado","Muebles","Accesorios","Juguetes"] #auxiliar
	mesas = ["1","2","3","4","5","6","7","8","9","10"]
	fechaI = datetime.datetime.now().replace(month=mes,day=dia) #la hora entrante, falta el dia
	#ubicacion de tiendas no estoy seguro de si sea necesario
	venta = 0 #las ventas del dia o totales
	while(True):
		entrante = int(np.random.uniform(1,21)) #Pueden entrar cualquier cantidad de personas por comodidad pongamos que sea de 1 a 20
		entrando = entrante

		for i in range(entrante):					# Genera los datos para las "n" personas que entraron [0,n]

			acceso = int(np.random.uniform(1,len(camaras)+1)) #luego no hara falta poner len(camaras) porque ya sabremos cuantas camaras hay en el centro Comercial
			#idcamara, depende de la camara, por ahora las uso con el array
			horaAccesoE = fechaI.replace(hour=int(np.random.uniform(8,18)),minute=int(np.random.uniform(0,60)), second=int(np.random.uniform(0,60)))
			auxHoraultima = horaAccesoE #esta la usare para marcar la ultima actividad

			#creamos la cedula para la persona
			#por ahora hasta 20 para tener un control mejor de las personas
			cedula = int(np.random.uniform(1,251)) #incremente a 250
			#siempre va a haber la cedula
			cur.execute('SELECT * FROM "rasgos" WHERE "cedula" = %s', [cedula])
			#esto en realidad es buscar la persona
			persona = cur.fetchone()
			seEncontro = False
			if persona is None:
				detectoRasgos =  np.random.rand()		# Random para ver si la camara pudo detectar los rasgos de la persona (edad,sexo)
				if(detectoRasgos > 0.6):
					sexoAux = int(np.random.uniform(0,2))
					edad = int(np.random.uniform(12,81))
					if sexoAux == 0:
						sexo = "F"
					else:
						sexo = "M"
					payloadR = {
						"cedula": cedula,
						"edad": edad,
						"sexo": sexo 	
					}
					client.publish('Sambil/rasgos',json.dumps(payloadR), qos=0)
				else:
					payloadNR = {
						"cedula": cedula
					}
					client.publish('Sambil/rasgos',json.dumps(payloadNR), qos = 0) #publica los rasgos que consiguio, cedula siempre se "consigue"
			else:
				seEncontro = True
				cur.execute('SELECT edad FROM "rasgos" WHERE "cedula" = %s', [cedula])
				edadr = cur.fetchone()
				if edadr is None:
					detectoRasgos =  np.random.rand()		# Random para ver si la camara pudo detectar los rasgos de la persona, ya que ha pasado antes, incrementa el chance
					if(detectoRasgos > 0.5):
						sexoAux = int(np.random.uniform(0,2))
						edad = int(np.random.uniform(12,61))	
						if sexoAux == 0:
							sexo = "F"
						else:
							sexo = "M"
						#payloadSE = {
						#	"cedula": cedula,
						#	"edad": edad,
						#	"sexo": sexo
						#}
						#client.publish('Sambil/rasgos',json.dumps(payloadSE), qos = 0) 
						cur.execute('UPDATE rasgos SET "edad" = %s, "sexo" = %s WHERE "cedula" = %s;', (edad, sexo, cedula))
			tieneMAC = None
			if seEncontro:
				cur.execute('SELECT mac FROM "usuario" WHERE "cedula" = %s', [cedula])
				macaux = cur.fetchone()
				if macaux is None:
					tieneTelefono = np.random.rand()		#tal vez ahora tendra un telefono
					if(tieneTelefono > 0.4):
						mac = int(np.random.uniform(0,9999999))
						tieneMAC = True
						#payloadUMU = {
						#	"mac": mac,
						#	"cedula": cedula
						#}
						#client.publish('Sambil/usuario',json.dumps(payloadUMU), qos=0)
						cur.execute('UPDATE usuario SET "mac" = %s WHERE "cedula" = %s;', (mac, cedula))
				else:
					mac = macaux[0]
					tieneMAC = True
			else:
				tieneTelefono = np.random.rand()		#Random para si la persona tiene telefono
				if(tieneTelefono > 0.3):
					mac = int(np.random.uniform(0,9999999))
					tieneMAC = True
					payloadU = {
						"mac": mac,
						"cedula": cedula
					}
					client.publish('Sambil/usuario',json.dumps(payloadU), qos=0)
			
			#los metodos de compra y tiendas
			entroTienda = np.random.rand()
			if(entroTienda > 0.5):
				for j in range(len(tiendas)):
					#por ahora
					idTienda = tiendas[j]
					nombre = nombresTiendas[j]

					dateEntrada = auxHoraultima + datetime.timedelta(hours=np.random.uniform(int(np.random.uniform(auxHoraultima.hour)),18), minutes=np.random.uniform(auxHoraultima.minute,60), seconds=np.random.uniform(0,60))

					dateSalida = dateEntrada + datetime.timedelta(minutes=np.random.uniform(2,31))
					auxHoraultima = dateSalida
					#entradas de torniquete para ese torniquete+=1
					#hacer el payload del torniquete?
					payloadT = {
						"idtienda": idTienda,
						"hentrada": str(dateEntrada),
						"hsalida": str(dateSalida)
					}

					client.publish('Sambil/torniquete',json.dumps(payloadT), qos=0)
					#print(payloadT)

					compro = np.random.rand()
					if(compro > 0.4):
						monto = int(np.random.uniform(1,1000))
						if tieneMAC == True:
							payloadV = {
								"monto": monto,
								"idtienda": idTienda,
								"cedula": cedula,
								"mac": mac
							}
							client.publish('Sambil/venta',json.dumps(payloadV), qos=0)
						else:
							payloadV = {
								"monto": monto,
								"idtienda": idTienda,
								"cedula": cedula
							}
							client.publish('Sambil/venta',json.dumps(payloadV), qos=0)
			
					#else:
					#	print("No compro en la tienda "+nombre)
					#salidas de torniquete para ese torniquete+=1
			
			#vamos a la feria
			fueFeria = np.random.rand()
			if(fueFeria > 0.5):
				idmesa = int(np.random.uniform(1,len(mesas)+1))
				fechaOcupada = auxHoraultima + datetime.timedelta(hours=np.random.uniform(int(np.random.uniform(auxHoraultima.hour)),18), minutes=np.random.uniform(auxHoraultima.minute,60), seconds=np.random.uniform(0,60))

				fechaDesocupada = fechaOcupada + datetime.timedelta(minutes=np.random.uniform(2,60))
				auxHoraultima = fechaDesocupada

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
					payloadMU = {
						"nmesa": idmesa,
						"fechaocupada": str(fechaOcupada),
						"fechadesocupada": str(fechaDesocupada)
					}	
					client.publish('Sambil/mesa',json.dumps(payloadMU), qos=0)
					#print(payloadM)

			horaAccesoS = auxHoraultima + datetime.timedelta(hours=np.random.uniform(int(np.random.uniform(auxHoraultima.hour)),18), minutes=np.random.uniform(auxHoraultima.minute,60), seconds=np.random.uniform(0,60))
			salida = int(np.random.uniform(1,len(camaras)+1)) #luego no hara falta poner len(camaras) porque ya sabremos cuantas camaras hay en el centro Comercial
			payloadA = {
				"entrada": acceso,
				"salida": salida,
				"horaacceso": str(horaAccesoE),
				"horasalida": str(horaAccesoS),
				"cedula": cedula
			}
			client.publish('Sambil/acceso',json.dumps(payloadA), qos=0)
			saliendo+=1
			time.sleep(3)

		fechaI = fechaI + datetime.timedelta(days = 1)
	
if __name__ == '__main__':
	main()