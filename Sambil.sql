PGDMP     5                    w            Proyecto1BD    11.2    11.2                 0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            !           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            "           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            #           1262    24761    Proyecto1BD    DATABASE     �   CREATE DATABASE "Proyecto1BD" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'English_United States.1252' LC_CTYPE = 'English_United States.1252';
    DROP DATABASE "Proyecto1BD";
             postgres    false            �            1259    24787    acceso    TABLE     �   CREATE TABLE public.acceso (
    "idAcceso" integer NOT NULL,
    entrada integer NOT NULL,
    salida integer NOT NULL,
    "horaAcceso" date NOT NULL,
    "horaSalida" date NOT NULL,
    cedula integer NOT NULL
);
    DROP TABLE public.acceso;
       public         postgres    false            �            1259    24782    mesa    TABLE     �   CREATE TABLE public.mesa (
    nmesa integer NOT NULL,
    fechaocupada date NOT NULL,
    fechadesocupada date NOT NULL,
    mac integer
);
    DROP TABLE public.mesa;
       public         postgres    false            �            1259    24762    rasgos    TABLE     _   CREATE TABLE public.rasgos (
    cedula integer NOT NULL,
    edad integer,
    sexo "char"
);
    DROP TABLE public.rasgos;
       public         postgres    false            �            1259    24772 
   torniquete    TABLE     �   CREATE TABLE public.torniquete (
    "idTorniquete" integer NOT NULL,
    hentrada date NOT NULL,
    hsalida date NOT NULL,
    tiendafk integer NOT NULL
);
    DROP TABLE public.torniquete;
       public         postgres    false            �            1259    24767    usuario    TABLE     W   CREATE TABLE public.usuario (
    mac integer NOT NULL,
    cedula integer NOT NULL
);
    DROP TABLE public.usuario;
       public         postgres    false            �            1259    24794    venta    TABLE     �   CREATE TABLE public.venta (
    "idVenta" integer NOT NULL,
    monto integer NOT NULL,
    tiendafk integer NOT NULL,
    cedula integer NOT NULL,
    mac integer
);
    DROP TABLE public.venta;
       public         postgres    false            �            1259    24792    venta_idVenta_seq    SEQUENCE     �   CREATE SEQUENCE public."venta_idVenta_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public."venta_idVenta_seq";
       public       postgres    false    202            $           0    0    venta_idVenta_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public."venta_idVenta_seq" OWNED BY public.venta."idVenta";
            public       postgres    false    201            �
           2604    24797    venta idVenta    DEFAULT     r   ALTER TABLE ONLY public.venta ALTER COLUMN "idVenta" SET DEFAULT nextval('public."venta_idVenta_seq"'::regclass);
 >   ALTER TABLE public.venta ALTER COLUMN "idVenta" DROP DEFAULT;
       public       postgres    false    202    201    202                      0    24787    acceso 
   TABLE DATA               a   COPY public.acceso ("idAcceso", entrada, salida, "horaAcceso", "horaSalida", cedula) FROM stdin;
    public       postgres    false    200   .                 0    24782    mesa 
   TABLE DATA               I   COPY public.mesa (nmesa, fechaocupada, fechadesocupada, mac) FROM stdin;
    public       postgres    false    199   K                 0    24762    rasgos 
   TABLE DATA               4   COPY public.rasgos (cedula, edad, sexo) FROM stdin;
    public       postgres    false    196   h                 0    24772 
   torniquete 
   TABLE DATA               Q   COPY public.torniquete ("idTorniquete", hentrada, hsalida, tiendafk) FROM stdin;
    public       postgres    false    198   �                 0    24767    usuario 
   TABLE DATA               .   COPY public.usuario (mac, cedula) FROM stdin;
    public       postgres    false    197   �                 0    24794    venta 
   TABLE DATA               H   COPY public.venta ("idVenta", monto, tiendafk, cedula, mac) FROM stdin;
    public       postgres    false    202   �       %           0    0    venta_idVenta_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public."venta_idVenta_seq"', 1, false);
            public       postgres    false    201            �
           2606    24791    acceso acceso_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.acceso
    ADD CONSTRAINT acceso_pkey PRIMARY KEY ("idAcceso");
 <   ALTER TABLE ONLY public.acceso DROP CONSTRAINT acceso_pkey;
       public         postgres    false    200            �
           2606    24786    mesa mesa_pkey 
   CONSTRAINT     O   ALTER TABLE ONLY public.mesa
    ADD CONSTRAINT mesa_pkey PRIMARY KEY (nmesa);
 8   ALTER TABLE ONLY public.mesa DROP CONSTRAINT mesa_pkey;
       public         postgres    false    199            �
           2606    24766    rasgos rasgos_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.rasgos
    ADD CONSTRAINT rasgos_pkey PRIMARY KEY (cedula);
 <   ALTER TABLE ONLY public.rasgos DROP CONSTRAINT rasgos_pkey;
       public         postgres    false    196            �
           2606    24776    torniquete torniquete_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.torniquete
    ADD CONSTRAINT torniquete_pkey PRIMARY KEY ("idTorniquete");
 D   ALTER TABLE ONLY public.torniquete DROP CONSTRAINT torniquete_pkey;
       public         postgres    false    198            �
           2606    24771    usuario usuario_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (mac);
 >   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_pkey;
       public         postgres    false    197            �
           2606    24799    venta venta_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.venta
    ADD CONSTRAINT venta_pkey PRIMARY KEY ("idVenta");
 :   ALTER TABLE ONLY public.venta DROP CONSTRAINT venta_pkey;
       public         postgres    false    202                  x������ � �            x������ � �            x������ � �            x������ � �            x������ � �            x������ � �     