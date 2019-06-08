PGDMP                         w            Proyecto1BD    11.2    11.2 &    ,           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            -           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            .           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            /           1262    24761    Proyecto1BD    DATABASE     �   CREATE DATABASE "Proyecto1BD" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'English_United States.1252' LC_CTYPE = 'English_United States.1252';
    DROP DATABASE "Proyecto1BD";
             postgres    false            �            1259    24818    acceso    TABLE     �   CREATE TABLE public.acceso (
    idacceso integer NOT NULL,
    entrada integer NOT NULL,
    salida integer NOT NULL,
    horaacceso date NOT NULL,
    horasalida date NOT NULL,
    cedula integer NOT NULL
);
    DROP TABLE public.acceso;
       public         postgres    false            �            1259    24816    acceso_idacceso_seq    SEQUENCE     �   CREATE SEQUENCE public.acceso_idacceso_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.acceso_idacceso_seq;
       public       postgres    false    205            0           0    0    acceso_idacceso_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.acceso_idacceso_seq OWNED BY public.acceso.idacceso;
            public       postgres    false    204            �            1259    24802    mesa    TABLE     �   CREATE TABLE public.mesa (
    id integer NOT NULL,
    nmesa integer NOT NULL,
    fechaocupada date NOT NULL,
    fechadesocupada date NOT NULL,
    mac integer
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
       public       postgres    false    201            1           0    0    mesa_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE public.mesa_id_seq OWNED BY public.mesa.id;
            public       postgres    false    200            �            1259    24762    rasgos    TABLE     _   CREATE TABLE public.rasgos (
    cedula integer NOT NULL,
    edad integer,
    sexo "char"
);
    DROP TABLE public.rasgos;
       public         postgres    false            �            1259    24810 
   torniquete    TABLE     �   CREATE TABLE public.torniquete (
    id integer NOT NULL,
    idtorniquete integer NOT NULL,
    hentrada date NOT NULL,
    hsalida date NOT NULL,
    tiendafk integer NOT NULL
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
       public       postgres    false    203            2           0    0    torniquete_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.torniquete_id_seq OWNED BY public.torniquete.id;
            public       postgres    false    202            �            1259    24767    usuario    TABLE     W   CREATE TABLE public.usuario (
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
       public       postgres    false    199            3           0    0    venta_idVenta_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public."venta_idVenta_seq" OWNED BY public.venta."idVenta";
            public       postgres    false    198            �
           2604    24824    acceso idacceso    DEFAULT     r   ALTER TABLE ONLY public.acceso ALTER COLUMN idacceso SET DEFAULT nextval('public.acceso_idacceso_seq'::regclass);
 >   ALTER TABLE public.acceso ALTER COLUMN idacceso DROP DEFAULT;
       public       postgres    false    205    204    205            �
           2604    24825    mesa id    DEFAULT     b   ALTER TABLE ONLY public.mesa ALTER COLUMN id SET DEFAULT nextval('public.mesa_id_seq'::regclass);
 6   ALTER TABLE public.mesa ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    200    201    201            �
           2604    24826    torniquete id    DEFAULT     n   ALTER TABLE ONLY public.torniquete ALTER COLUMN id SET DEFAULT nextval('public.torniquete_id_seq'::regclass);
 <   ALTER TABLE public.torniquete ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    203    202    203            �
           2604    24827    venta idVenta    DEFAULT     r   ALTER TABLE ONLY public.venta ALTER COLUMN "idVenta" SET DEFAULT nextval('public."venta_idVenta_seq"'::regclass);
 >   ALTER TABLE public.venta ALTER COLUMN "idVenta" DROP DEFAULT;
       public       postgres    false    198    199    199            )          0    24818    acceso 
   TABLE DATA               [   COPY public.acceso (idacceso, entrada, salida, horaacceso, horasalida, cedula) FROM stdin;
    public       postgres    false    205   �&       %          0    24802    mesa 
   TABLE DATA               M   COPY public.mesa (id, nmesa, fechaocupada, fechadesocupada, mac) FROM stdin;
    public       postgres    false    201   �&                  0    24762    rasgos 
   TABLE DATA               4   COPY public.rasgos (cedula, edad, sexo) FROM stdin;
    public       postgres    false    196   �&       '          0    24810 
   torniquete 
   TABLE DATA               S   COPY public.torniquete (id, idtorniquete, hentrada, hsalida, tiendafk) FROM stdin;
    public       postgres    false    203    '       !          0    24767    usuario 
   TABLE DATA               .   COPY public.usuario (mac, cedula) FROM stdin;
    public       postgres    false    197   '       #          0    24794    venta 
   TABLE DATA               H   COPY public.venta ("idVenta", monto, tiendafk, cedula, mac) FROM stdin;
    public       postgres    false    199   :'       4           0    0    acceso_idacceso_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.acceso_idacceso_seq', 79, true);
            public       postgres    false    204            5           0    0    mesa_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.mesa_id_seq', 34, true);
            public       postgres    false    200            6           0    0    torniquete_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.torniquete_id_seq', 197, true);
            public       postgres    false    202            7           0    0    venta_idVenta_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public."venta_idVenta_seq"', 116, true);
            public       postgres    false    198            �
           2606    24823    acceso acceso_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.acceso
    ADD CONSTRAINT acceso_pkey PRIMARY KEY (idacceso);
 <   ALTER TABLE ONLY public.acceso DROP CONSTRAINT acceso_pkey;
       public         postgres    false    205            �
           2606    24807    mesa mesa_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.mesa
    ADD CONSTRAINT mesa_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.mesa DROP CONSTRAINT mesa_pkey;
       public         postgres    false    201            �
           2606    24766    rasgos rasgos_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.rasgos
    ADD CONSTRAINT rasgos_pkey PRIMARY KEY (cedula);
 <   ALTER TABLE ONLY public.rasgos DROP CONSTRAINT rasgos_pkey;
       public         postgres    false    196            �
           2606    24815    torniquete torniquete_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.torniquete
    ADD CONSTRAINT torniquete_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.torniquete DROP CONSTRAINT torniquete_pkey;
       public         postgres    false    203            �
           2606    24771    usuario usuario_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (mac);
 >   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_pkey;
       public         postgres    false    197            �
           2606    24799    venta venta_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.venta
    ADD CONSTRAINT venta_pkey PRIMARY KEY ("idVenta");
 :   ALTER TABLE ONLY public.venta DROP CONSTRAINT venta_pkey;
       public         postgres    false    199            )      x������ � �      %      x������ � �             x������ � �      '      x������ � �      !      x������ � �      #      x������ � �     