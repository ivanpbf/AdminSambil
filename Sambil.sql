PGDMP         )                w            Proyecto1BD    11.2    11.2 ?    r           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            s           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            t           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            u           1262    24761    Proyecto1BD    DATABASE     �   CREATE DATABASE "Proyecto1BD" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'English_United States.1252' LC_CTYPE = 'English_United States.1252';
    DROP DATABASE "Proyecto1BD";
             postgres    false            �            1255    32979    validardescuento()    FUNCTION     �  CREATE FUNCTION public.validardescuento() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
cont INT4;
BEGIN
	
	IF (new.monto <400) THEN
	   new.descuento = 0;
	   return new;

	ELSIF  (new.monto >=400 AND new.monto <600) THEN
	   new.descuento = new.monto * 0.05;
	   return new;

	ELSIF (new.monto >=600 AND new.monto <800) THEN
	   new.descuento = new.monto * 0.10;
	   return new;
	
	ELSIF (new.monto >=800) THEN
	   new.descuento = new.monto * 0.12;
	   return new;
		
	END IF;

End;
$$;
 )   DROP FUNCTION public.validardescuento();
       public       postgres    false            �            1255    24872    validarmac()    FUNCTION       CREATE FUNCTION public.validarmac() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
cont INT4;
BEGIN

	cont := (SELECT COUNT(mac) FROM  usuario WHERE mac = new.mac );
	
	IF (cont = 0) THEN
	   return new;
	END IF;
	
	IF (cont > 0) THEN
	   return null;
	END IF;

End;
$$;
 #   DROP FUNCTION public.validarmac();
       public       postgres    false            �            1255    32977    validarmesavacia()    FUNCTION     H  CREATE FUNCTION public.validarmesavacia() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
cont INT4;
BEGIN

	cont := (SELECT COUNT(id) FROM  mesa WHERE (nmesa = new.nmesa) AND (new.fechaocupada < fechadesocupada) );
	
	IF (cont = 0) THEN
	   return new;
	END IF;
	
	IF (cont > 0) THEN
	   return null;
	END IF;

End;
$$;
 )   DROP FUNCTION public.validarmesavacia();
       public       postgres    false            �            1259    24818    acceso    TABLE        CREATE TABLE public.acceso (
    idacceso integer NOT NULL,
    entrada integer NOT NULL,
    salida integer NOT NULL,
    cedula integer NOT NULL,
    horaacceso timestamp without time zone NOT NULL,
    horasalida timestamp without time zone NOT NULL
);
    DROP TABLE public.acceso;
       public         postgres    false            �            1259    24762    rasgos    TABLE     _   CREATE TABLE public.rasgos (
    cedula integer NOT NULL,
    edad integer,
    sexo "char"
);
    DROP TABLE public.rasgos;
       public         postgres    false            �            1259    24844    AccesosFemeninos    VIEW     �   CREATE VIEW public."AccesosFemeninos" AS
 SELECT acceso.idacceso,
    rasgos.cedula,
    rasgos.sexo
   FROM (public.acceso
     JOIN public.rasgos ON ((acceso.cedula = rasgos.cedula)))
  WHERE (rasgos.sexo = 'F'::"char");
 %   DROP VIEW public."AccesosFemeninos";
       public       postgres    false    203    196    196    203            �            1259    24840    AccesosMasculinos    VIEW     �   CREATE VIEW public."AccesosMasculinos" AS
 SELECT acceso.idacceso,
    rasgos.cedula,
    rasgos.sexo
   FROM (public.acceso
     JOIN public.rasgos ON ((acceso.cedula = rasgos.cedula)))
  WHERE (rasgos.sexo = 'M'::"char");
 &   DROP VIEW public."AccesosMasculinos";
       public       postgres    false    203    196    196    203            �            1259    32953    venta    TABLE     �   CREATE TABLE public.venta (
    "idVenta" integer NOT NULL,
    idtienda integer NOT NULL,
    monto integer NOT NULL,
    cedula integer NOT NULL,
    descuento integer,
    mac integer
);
    DROP TABLE public.venta;
       public         postgres    false            �            1259    32985    DescuentosTotales    VIEW     �   CREATE VIEW public."DescuentosTotales" AS
 SELECT sum(venta.descuento) AS cantidaddescuentototal,
    sum(venta.monto) AS montototalvendido
   FROM public.venta;
 &   DROP VIEW public."DescuentosTotales";
       public       postgres    false    211    211            �            1259    24852    Top10EdadesComunes    VIEW     �   CREATE VIEW public."Top10EdadesComunes" AS
 SELECT rasgos.edad
   FROM public.rasgos
  WHERE (rasgos.edad IS NOT NULL)
  GROUP BY rasgos.edad
  ORDER BY (count(*)) DESC
 LIMIT 10;
 '   DROP VIEW public."Top10EdadesComunes";
       public       postgres    false    196            �            1259    24974    tienda    TABLE     �   CREATE TABLE public.tienda (
    idtienda integer NOT NULL,
    nombre character varying NOT NULL,
    catalogo character varying NOT NULL
);
    DROP TABLE public.tienda;
       public         postgres    false            �            1259    32981    Top3Tiendas    VIEW     �   CREATE VIEW public."Top3Tiendas" AS
 SELECT tienda.nombre,
    count(venta.idtienda) AS count
   FROM (public.tienda
     JOIN public.venta ON ((tienda.idtienda = venta.idtienda)))
  GROUP BY tienda.nombre
  ORDER BY (count(*)) DESC
 LIMIT 3;
     DROP VIEW public."Top3Tiendas";
       public       postgres    false    211    209    209            �            1259    24836    Top5accesos    VIEW     �   CREATE VIEW public."Top5accesos" WITH (security_barrier='false') AS
 SELECT acceso.cedula,
    count(acceso.cedula) AS count
   FROM public.acceso
  GROUP BY acceso.cedula
  ORDER BY (count(*)) DESC
 LIMIT 5;
     DROP VIEW public."Top5accesos";
       public       postgres    false    203            �            1259    32993    UsuariosMyF    VIEW     �   CREATE VIEW public."UsuariosMyF" AS
 SELECT rasgos.sexo,
    count(rasgos.sexo) AS count
   FROM public.rasgos
  WHERE (rasgos.sexo IS NOT NULL)
  GROUP BY rasgos.sexo;
     DROP VIEW public."UsuariosMyF";
       public       postgres    false    196            �            1259    32963    VentaNoTelefono    VIEW     �   CREATE VIEW public."VentaNoTelefono" AS
 SELECT venta."idVenta",
    venta.monto,
    venta.idtienda AS tiendafk,
    venta.cedula,
    venta.mac
   FROM public.venta
  WHERE (venta.mac IS NULL);
 $   DROP VIEW public."VentaNoTelefono";
       public       postgres    false    211    211    211    211    211            �            1259    32967    VentaTelefono    VIEW     �   CREATE VIEW public."VentaTelefono" AS
 SELECT venta."idVenta",
    venta.monto,
    venta.idtienda AS tiendafk,
    venta.cedula,
    venta.mac
   FROM public.venta
  WHERE (venta.mac IS NOT NULL);
 "   DROP VIEW public."VentaTelefono";
       public       postgres    false    211    211    211    211    211            �            1259    32989    VentasConYSinTelefono    VIEW     �   CREATE VIEW public."VentasConYSinTelefono" AS
 SELECT count(venta."idVenta") AS cantidad
   FROM public.venta
  GROUP BY (venta.mac IS NULL);
 *   DROP VIEW public."VentasConYSinTelefono";
       public       postgres    false    211    211            �            1259    24816    acceso_idacceso_seq    SEQUENCE     �   CREATE SEQUENCE public.acceso_idacceso_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.acceso_idacceso_seq;
       public       postgres    false    203            v           0    0    acceso_idacceso_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.acceso_idacceso_seq OWNED BY public.acceso.idacceso;
            public       postgres    false    202            �            1259    24802    mesa    TABLE     �   CREATE TABLE public.mesa (
    id integer NOT NULL,
    nmesa integer NOT NULL,
    mac integer,
    fechaocupada timestamp without time zone NOT NULL,
    fechadesocupada timestamp without time zone NOT NULL
);
    DROP TABLE public.mesa;
       public         postgres    false            �            1259    24800    mesa_id_seq    SEQUENCE     �   CREATE SEQUENCE public.mesa_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.mesa_id_seq;
       public       postgres    false    199            w           0    0    mesa_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE public.mesa_id_seq OWNED BY public.mesa.id;
            public       postgres    false    198            �            1259    24972    tienda_idtienda_seq    SEQUENCE     �   CREATE SEQUENCE public.tienda_idtienda_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.tienda_idtienda_seq;
       public       postgres    false    209            x           0    0    tienda_idtienda_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.tienda_idtienda_seq OWNED BY public.tienda.idtienda;
            public       postgres    false    208            �            1259    24810 
   torniquete    TABLE     �   CREATE TABLE public.torniquete (
    id integer NOT NULL,
    idtienda integer NOT NULL,
    hentrada timestamp without time zone NOT NULL,
    hsalida timestamp without time zone NOT NULL
);
    DROP TABLE public.torniquete;
       public         postgres    false            �            1259    24808    torniquete_id_seq    SEQUENCE     �   CREATE SEQUENCE public.torniquete_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.torniquete_id_seq;
       public       postgres    false    201            y           0    0    torniquete_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.torniquete_id_seq OWNED BY public.torniquete.id;
            public       postgres    false    200            �            1259    24767    usuario    TABLE     W   CREATE TABLE public.usuario (
    mac integer NOT NULL,
    cedula integer NOT NULL
);
    DROP TABLE public.usuario;
       public         postgres    false            �            1259    32951    venta_idVenta_seq    SEQUENCE     �   CREATE SEQUENCE public."venta_idVenta_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public."venta_idVenta_seq";
       public       postgres    false    211            z           0    0    venta_idVenta_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public."venta_idVenta_seq" OWNED BY public.venta."idVenta";
            public       postgres    false    210            �
           2604    32869    acceso idacceso    DEFAULT     r   ALTER TABLE ONLY public.acceso ALTER COLUMN idacceso SET DEFAULT nextval('public.acceso_idacceso_seq'::regclass);
 >   ALTER TABLE public.acceso ALTER COLUMN idacceso DROP DEFAULT;
       public       postgres    false    203    202    203            �
           2604    32870    mesa id    DEFAULT     b   ALTER TABLE ONLY public.mesa ALTER COLUMN id SET DEFAULT nextval('public.mesa_id_seq'::regclass);
 6   ALTER TABLE public.mesa ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    198    199    199            �
           2604    24977    tienda idtienda    DEFAULT     r   ALTER TABLE ONLY public.tienda ALTER COLUMN idtienda SET DEFAULT nextval('public.tienda_idtienda_seq'::regclass);
 >   ALTER TABLE public.tienda ALTER COLUMN idtienda DROP DEFAULT;
       public       postgres    false    208    209    209            �
           2604    32871    torniquete id    DEFAULT     n   ALTER TABLE ONLY public.torniquete ALTER COLUMN id SET DEFAULT nextval('public.torniquete_id_seq'::regclass);
 <   ALTER TABLE public.torniquete ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    200    201    201            �
           2604    32956    venta idVenta    DEFAULT     r   ALTER TABLE ONLY public.venta ALTER COLUMN "idVenta" SET DEFAULT nextval('public."venta_idVenta_seq"'::regclass);
 >   ALTER TABLE public.venta ALTER COLUMN "idVenta" DROP DEFAULT;
       public       postgres    false    211    210    211            k          0    24818    acceso 
   TABLE DATA               [   COPY public.acceso (idacceso, entrada, salida, cedula, horaacceso, horasalida) FROM stdin;
    public       postgres    false    203   �I       g          0    24802    mesa 
   TABLE DATA               M   COPY public.mesa (id, nmesa, mac, fechaocupada, fechadesocupada) FROM stdin;
    public       postgres    false    199   �I       d          0    24762    rasgos 
   TABLE DATA               4   COPY public.rasgos (cedula, edad, sexo) FROM stdin;
    public       postgres    false    196   J       m          0    24974    tienda 
   TABLE DATA               <   COPY public.tienda (idtienda, nombre, catalogo) FROM stdin;
    public       postgres    false    209   !J       i          0    24810 
   torniquete 
   TABLE DATA               E   COPY public.torniquete (id, idtienda, hentrada, hsalida) FROM stdin;
    public       postgres    false    201   �J       e          0    24767    usuario 
   TABLE DATA               .   COPY public.usuario (mac, cedula) FROM stdin;
    public       postgres    false    197   �J       o          0    32953    venta 
   TABLE DATA               S   COPY public.venta ("idVenta", idtienda, monto, cedula, descuento, mac) FROM stdin;
    public       postgres    false    211   K       {           0    0    acceso_idacceso_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.acceso_idacceso_seq', 246, true);
            public       postgres    false    202            |           0    0    mesa_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.mesa_id_seq', 131, true);
            public       postgres    false    198            }           0    0    tienda_idtienda_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.tienda_idtienda_seq', 10, true);
            public       postgres    false    208            ~           0    0    torniquete_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.torniquete_id_seq', 1044, true);
            public       postgres    false    200                       0    0    venta_idVenta_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public."venta_idVenta_seq"', 615, true);
            public       postgres    false    210            �
           2606    24823    acceso acceso_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.acceso
    ADD CONSTRAINT acceso_pkey PRIMARY KEY (idacceso);
 <   ALTER TABLE ONLY public.acceso DROP CONSTRAINT acceso_pkey;
       public         postgres    false    203            �
           2606    24807    mesa mesa_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.mesa
    ADD CONSTRAINT mesa_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.mesa DROP CONSTRAINT mesa_pkey;
       public         postgres    false    199            �
           2606    24766    rasgos rasgos_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.rasgos
    ADD CONSTRAINT rasgos_pkey PRIMARY KEY (cedula);
 <   ALTER TABLE ONLY public.rasgos DROP CONSTRAINT rasgos_pkey;
       public         postgres    false    196            �
           2606    24982    tienda tienda_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.tienda
    ADD CONSTRAINT tienda_pkey PRIMARY KEY (idtienda);
 <   ALTER TABLE ONLY public.tienda DROP CONSTRAINT tienda_pkey;
       public         postgres    false    209            �
           2606    24815    torniquete torniquete_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.torniquete
    ADD CONSTRAINT torniquete_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.torniquete DROP CONSTRAINT torniquete_pkey;
       public         postgres    false    201            �
           2606    24771    usuario usuario_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (mac);
 >   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_pkey;
       public         postgres    false    197            �
           2606    32958    venta venta_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.venta
    ADD CONSTRAINT venta_pkey PRIMARY KEY ("idVenta");
 :   ALTER TABLE ONLY public.venta DROP CONSTRAINT venta_pkey;
       public         postgres    false    211            �
           1259    32976    fki_idtienda    INDEX     B   CREATE INDEX fki_idtienda ON public.venta USING btree (idtienda);
     DROP INDEX public.fki_idtienda;
       public         postgres    false    211            �
           2620    32980    venta validardescuento    TRIGGER     x   CREATE TRIGGER validardescuento BEFORE INSERT ON public.venta FOR EACH ROW EXECUTE PROCEDURE public.validardescuento();
 /   DROP TRIGGER validardescuento ON public.venta;
       public       postgres    false    211    220            �
           2620    24873    usuario validarmac    TRIGGER     n   CREATE TRIGGER validarmac BEFORE INSERT ON public.usuario FOR EACH ROW EXECUTE PROCEDURE public.validarmac();
 +   DROP TRIGGER validarmac ON public.usuario;
       public       postgres    false    218    197            �
           2620    32978    mesa validarmesavacia    TRIGGER     w   CREATE TRIGGER validarmesavacia BEFORE INSERT ON public.mesa FOR EACH ROW EXECUTE PROCEDURE public.validarmesavacia();
 .   DROP TRIGGER validarmesavacia ON public.mesa;
       public       postgres    false    219    199            �
           2606    32971    venta idtienda    FK CONSTRAINT     u   ALTER TABLE ONLY public.venta
    ADD CONSTRAINT idtienda FOREIGN KEY (idtienda) REFERENCES public.tienda(idtienda);
 8   ALTER TABLE ONLY public.venta DROP CONSTRAINT idtienda;
       public       postgres    false    209    2777    211            k      x������ � �      g      x������ � �      d      x������ � �      m   �   x�5��
�0Dד�	ַ��P-.�M�^K�MJ�o��Ü�w5�d{T��5��DM���[�l�SM*�j��Z�v�F
�?٠5j��[H^r�q%�N�a;	I^�α=d�v�p<�9�.ѫƐ�J�)8o�W�@���'�Y|q��G9�      i      x������ � �      e      x������ � �      o      x������ � �     