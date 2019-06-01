PGDMP         8                w            Proyecto1BD    11.2    11.2 P    l           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            m           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            n           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            o           1262    49152    Proyecto1BD    DATABASE     �   CREATE DATABASE "Proyecto1BD" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Spanish_Venezuela.1252' LC_CTYPE = 'Spanish_Venezuela.1252';
    DROP DATABASE "Proyecto1BD";
             postgres    false            �            1259    49261    tienda    TABLE     �   CREATE TABLE public.tienda (
    idtienda integer NOT NULL,
    nombre character varying NOT NULL,
    categoria character varying NOT NULL
);
    DROP TABLE public.tienda;
       public         postgres    false            �            1259    49259    Tienda_idtienda_seq    SEQUENCE     �   CREATE SEQUENCE public."Tienda_idtienda_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public."Tienda_idtienda_seq";
       public       postgres    false    201            p           0    0    Tienda_idtienda_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public."Tienda_idtienda_seq" OWNED BY public.tienda.idtienda;
            public       postgres    false    200            �            1259    49351    usuariorasgo    TABLE     t   CREATE TABLE public.usuariorasgo (
    id integer NOT NULL,
    usuariofk integer NOT NULL,
    rasgosfk integer
);
     DROP TABLE public.usuariorasgo;
       public         postgres    false            �            1259    49349    Usuariorasgo_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Usuariorasgo_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public."Usuariorasgo_id_seq";
       public       postgres    false    212            q           0    0    Usuariorasgo_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public."Usuariorasgo_id_seq" OWNED BY public.usuariorasgo.id;
            public       postgres    false    211            �            1259    49195 
   camaradata    TABLE     �   CREATE TABLE public.camaradata (
    id integer NOT NULL,
    fecha date NOT NULL,
    nsalidas integer NOT NULL,
    nentradas integer NOT NULL,
    acceso integer NOT NULL
);
    DROP TABLE public.camaradata;
       public         postgres    false            �            1259    49193    camaradata_id_seq    SEQUENCE     �   CREATE SEQUENCE public.camaradata_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.camaradata_id_seq;
       public       postgres    false    197            r           0    0    camaradata_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.camaradata_id_seq OWNED BY public.camaradata.id;
            public       postgres    false    196            �            1259    49203    datamesa    TABLE     }   CREATE TABLE public.datamesa (
    id integer NOT NULL,
    fechaocupada date NOT NULL,
    fechadesocupada date NOT NULL
);
    DROP TABLE public.datamesa;
       public         postgres    false            �            1259    49201    datamesa_id_seq    SEQUENCE     �   CREATE SEQUENCE public.datamesa_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.datamesa_id_seq;
       public       postgres    false    199            s           0    0    datamesa_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.datamesa_id_seq OWNED BY public.datamesa.id;
            public       postgres    false    198            �            1259    49369    mesausuario    TABLE     l   CREATE TABLE public.mesausuario (
    id integer NOT NULL,
    datamesafk integer,
    usuariofk integer
);
    DROP TABLE public.mesausuario;
       public         postgres    false            �            1259    49367    mesausuario_id_seq    SEQUENCE     �   CREATE SEQUENCE public.mesausuario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.mesausuario_id_seq;
       public       postgres    false    214            t           0    0    mesausuario_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.mesausuario_id_seq OWNED BY public.mesausuario.id;
            public       postgres    false    213            �            1259    49385    rasgos    TABLE     ~   CREATE TABLE public.rasgos (
    idrasgos integer NOT NULL,
    sexo character varying NOT NULL,
    edad integer NOT NULL
);
    DROP TABLE public.rasgos;
       public         postgres    false            �            1259    49303 
   torniquete    TABLE     �   CREATE TABLE public.torniquete (
    idtorniquete integer NOT NULL,
    hentrada date NOT NULL,
    hsalida date NOT NULL,
    tiendafk integer NOT NULL
);
    DROP TABLE public.torniquete;
       public         postgres    false            �            1259    49301    torniquete_idtorniquete_seq    SEQUENCE     �   CREATE SEQUENCE public.torniquete_idtorniquete_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.torniquete_idtorniquete_seq;
       public       postgres    false    207            u           0    0    torniquete_idtorniquete_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.torniquete_idtorniquete_seq OWNED BY public.torniquete.idtorniquete;
            public       postgres    false    206            �            1259    49316    torniqueteusuario    TABLE     ~   CREATE TABLE public.torniqueteusuario (
    id integer NOT NULL,
    torniquetefk integer NOT NULL,
    telefonofk integer
);
 %   DROP TABLE public.torniqueteusuario;
       public         postgres    false            �            1259    49314    torniqueteusuario_id_seq    SEQUENCE     �   CREATE SEQUENCE public.torniqueteusuario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.torniqueteusuario_id_seq;
       public       postgres    false    209            v           0    0    torniqueteusuario_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.torniqueteusuario_id_seq OWNED BY public.torniqueteusuario.id;
            public       postgres    false    208            �            1259    49333    usuario    TABLE     :   CREATE TABLE public.usuario (
    mac integer NOT NULL
);
    DROP TABLE public.usuario;
       public         postgres    false            �            1259    49272    venta    TABLE     n   CREATE TABLE public.venta (
    idventa integer NOT NULL,
    monto integer NOT NULL,
    tiendafk integer
);
    DROP TABLE public.venta;
       public         postgres    false            �            1259    49270    venta_idventa_seq    SEQUENCE     �   CREATE SEQUENCE public.venta_idventa_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.venta_idventa_seq;
       public       postgres    false    203            w           0    0    venta_idventa_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.venta_idventa_seq OWNED BY public.venta.idventa;
            public       postgres    false    202            �            1259    49285    ventausuario    TABLE     }   CREATE TABLE public.ventausuario (
    id integer NOT NULL,
    ventafk integer NOT NULL,
    telefonofk integer NOT NULL
);
     DROP TABLE public.ventausuario;
       public         postgres    false            �            1259    49283    ventausuario_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ventausuario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.ventausuario_id_seq;
       public       postgres    false    205            x           0    0    ventausuario_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.ventausuario_id_seq OWNED BY public.ventausuario.id;
            public       postgres    false    204            �
           2604    49198    camaradata id    DEFAULT     n   ALTER TABLE ONLY public.camaradata ALTER COLUMN id SET DEFAULT nextval('public.camaradata_id_seq'::regclass);
 <   ALTER TABLE public.camaradata ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    197    196    197            �
           2604    49206    datamesa id    DEFAULT     j   ALTER TABLE ONLY public.datamesa ALTER COLUMN id SET DEFAULT nextval('public.datamesa_id_seq'::regclass);
 :   ALTER TABLE public.datamesa ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    199    198    199            �
           2604    49372    mesausuario id    DEFAULT     p   ALTER TABLE ONLY public.mesausuario ALTER COLUMN id SET DEFAULT nextval('public.mesausuario_id_seq'::regclass);
 =   ALTER TABLE public.mesausuario ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    214    213    214            �
           2604    49264    tienda idtienda    DEFAULT     t   ALTER TABLE ONLY public.tienda ALTER COLUMN idtienda SET DEFAULT nextval('public."Tienda_idtienda_seq"'::regclass);
 >   ALTER TABLE public.tienda ALTER COLUMN idtienda DROP DEFAULT;
       public       postgres    false    201    200    201            �
           2604    49306    torniquete idtorniquete    DEFAULT     �   ALTER TABLE ONLY public.torniquete ALTER COLUMN idtorniquete SET DEFAULT nextval('public.torniquete_idtorniquete_seq'::regclass);
 F   ALTER TABLE public.torniquete ALTER COLUMN idtorniquete DROP DEFAULT;
       public       postgres    false    207    206    207            �
           2604    49319    torniqueteusuario id    DEFAULT     |   ALTER TABLE ONLY public.torniqueteusuario ALTER COLUMN id SET DEFAULT nextval('public.torniqueteusuario_id_seq'::regclass);
 C   ALTER TABLE public.torniqueteusuario ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    208    209    209            �
           2604    49354    usuariorasgo id    DEFAULT     t   ALTER TABLE ONLY public.usuariorasgo ALTER COLUMN id SET DEFAULT nextval('public."Usuariorasgo_id_seq"'::regclass);
 >   ALTER TABLE public.usuariorasgo ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    211    212    212            �
           2604    49275    venta idventa    DEFAULT     n   ALTER TABLE ONLY public.venta ALTER COLUMN idventa SET DEFAULT nextval('public.venta_idventa_seq'::regclass);
 <   ALTER TABLE public.venta ALTER COLUMN idventa DROP DEFAULT;
       public       postgres    false    202    203    203            �
           2604    49288    ventausuario id    DEFAULT     r   ALTER TABLE ONLY public.ventausuario ALTER COLUMN id SET DEFAULT nextval('public.ventausuario_id_seq'::regclass);
 >   ALTER TABLE public.ventausuario ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    204    205    205            W          0    49195 
   camaradata 
   TABLE DATA               L   COPY public.camaradata (id, fecha, nsalidas, nentradas, acceso) FROM stdin;
    public       postgres    false    197   XW       Y          0    49203    datamesa 
   TABLE DATA               E   COPY public.datamesa (id, fechaocupada, fechadesocupada) FROM stdin;
    public       postgres    false    199   uW       h          0    49369    mesausuario 
   TABLE DATA               @   COPY public.mesausuario (id, datamesafk, usuariofk) FROM stdin;
    public       postgres    false    214   �W       i          0    49385    rasgos 
   TABLE DATA               6   COPY public.rasgos (idrasgos, sexo, edad) FROM stdin;
    public       postgres    false    215   �W       [          0    49261    tienda 
   TABLE DATA               =   COPY public.tienda (idtienda, nombre, categoria) FROM stdin;
    public       postgres    false    201   �W       a          0    49303 
   torniquete 
   TABLE DATA               O   COPY public.torniquete (idtorniquete, hentrada, hsalida, tiendafk) FROM stdin;
    public       postgres    false    207   X       c          0    49316    torniqueteusuario 
   TABLE DATA               I   COPY public.torniqueteusuario (id, torniquetefk, telefonofk) FROM stdin;
    public       postgres    false    209   !X       d          0    49333    usuario 
   TABLE DATA               &   COPY public.usuario (mac) FROM stdin;
    public       postgres    false    210   >X       f          0    49351    usuariorasgo 
   TABLE DATA               ?   COPY public.usuariorasgo (id, usuariofk, rasgosfk) FROM stdin;
    public       postgres    false    212   _X       ]          0    49272    venta 
   TABLE DATA               9   COPY public.venta (idventa, monto, tiendafk) FROM stdin;
    public       postgres    false    203   �X       _          0    49285    ventausuario 
   TABLE DATA               ?   COPY public.ventausuario (id, ventafk, telefonofk) FROM stdin;
    public       postgres    false    205   �X       y           0    0    Tienda_idtienda_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public."Tienda_idtienda_seq"', 1, false);
            public       postgres    false    200            z           0    0    Usuariorasgo_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public."Usuariorasgo_id_seq"', 2, true);
            public       postgres    false    211            {           0    0    camaradata_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.camaradata_id_seq', 1, false);
            public       postgres    false    196            |           0    0    datamesa_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.datamesa_id_seq', 1, false);
            public       postgres    false    198            }           0    0    mesausuario_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.mesausuario_id_seq', 1, false);
            public       postgres    false    213            ~           0    0    torniquete_idtorniquete_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.torniquete_idtorniquete_seq', 1, false);
            public       postgres    false    206                       0    0    torniqueteusuario_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.torniqueteusuario_id_seq', 1, false);
            public       postgres    false    208            �           0    0    venta_idventa_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.venta_idventa_seq', 1, false);
            public       postgres    false    202            �           0    0    ventausuario_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.ventausuario_id_seq', 1, false);
            public       postgres    false    204            �
           2606    49269    tienda Tienda_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.tienda
    ADD CONSTRAINT "Tienda_pkey" PRIMARY KEY (idtienda);
 >   ALTER TABLE ONLY public.tienda DROP CONSTRAINT "Tienda_pkey";
       public         postgres    false    201            �
           2606    49200    camaradata camaradata_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.camaradata
    ADD CONSTRAINT camaradata_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.camaradata DROP CONSTRAINT camaradata_pkey;
       public         postgres    false    197            �
           2606    49208    datamesa datamesa_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.datamesa
    ADD CONSTRAINT datamesa_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.datamesa DROP CONSTRAINT datamesa_pkey;
       public         postgres    false    199            �
           2606    49374    mesausuario mesausuario_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.mesausuario
    ADD CONSTRAINT mesausuario_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.mesausuario DROP CONSTRAINT mesausuario_pkey;
       public         postgres    false    214            �
           2606    49392    rasgos rasgos_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.rasgos
    ADD CONSTRAINT rasgos_pkey PRIMARY KEY (idrasgos);
 <   ALTER TABLE ONLY public.rasgos DROP CONSTRAINT rasgos_pkey;
       public         postgres    false    215            �
           2606    49308    torniquete torniquete_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.torniquete
    ADD CONSTRAINT torniquete_pkey PRIMARY KEY (idtorniquete);
 D   ALTER TABLE ONLY public.torniquete DROP CONSTRAINT torniquete_pkey;
       public         postgres    false    207            �
           2606    49321 (   torniqueteusuario torniqueteusuario_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.torniqueteusuario
    ADD CONSTRAINT torniqueteusuario_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.torniqueteusuario DROP CONSTRAINT torniqueteusuario_pkey;
       public         postgres    false    209            �
           2606    49337    usuario usuario_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (mac);
 >   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_pkey;
       public         postgres    false    210            �
           2606    49394    usuariorasgo usuariorasgo_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.usuariorasgo
    ADD CONSTRAINT usuariorasgo_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.usuariorasgo DROP CONSTRAINT usuariorasgo_pkey;
       public         postgres    false    212            �
           2606    49277    venta venta_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.venta
    ADD CONSTRAINT venta_pkey PRIMARY KEY (idventa);
 :   ALTER TABLE ONLY public.venta DROP CONSTRAINT venta_pkey;
       public         postgres    false    203            �
           2606    49290    ventausuario ventausuario_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.ventausuario
    ADD CONSTRAINT ventausuario_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.ventausuario DROP CONSTRAINT ventausuario_pkey;
       public         postgres    false    205            �
           2606    49375 '   mesausuario mesausuario_datamesafk_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.mesausuario
    ADD CONSTRAINT mesausuario_datamesafk_fkey FOREIGN KEY (datamesafk) REFERENCES public.datamesa(id);
 Q   ALTER TABLE ONLY public.mesausuario DROP CONSTRAINT mesausuario_datamesafk_fkey;
       public       postgres    false    214    199    2755            �
           2606    49380 &   mesausuario mesausuario_usuariofk_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.mesausuario
    ADD CONSTRAINT mesausuario_usuariofk_fkey FOREIGN KEY (usuariofk) REFERENCES public.usuario(mac);
 P   ALTER TABLE ONLY public.mesausuario DROP CONSTRAINT mesausuario_usuariofk_fkey;
       public       postgres    false    2767    214    210            �
           2606    49309 #   torniquete torniquete_tiendafk_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.torniquete
    ADD CONSTRAINT torniquete_tiendafk_fkey FOREIGN KEY (tiendafk) REFERENCES public.tienda(idtienda);
 M   ALTER TABLE ONLY public.torniquete DROP CONSTRAINT torniquete_tiendafk_fkey;
       public       postgres    false    201    207    2757            �
           2606    49322 5   torniqueteusuario torniqueteusuario_torniquetefk_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.torniqueteusuario
    ADD CONSTRAINT torniqueteusuario_torniquetefk_fkey FOREIGN KEY (torniquetefk) REFERENCES public.torniquete(idtorniquete);
 _   ALTER TABLE ONLY public.torniqueteusuario DROP CONSTRAINT torniqueteusuario_torniquetefk_fkey;
       public       postgres    false    209    207    2763            �
           2606    49395 '   usuariorasgo usuariorasgo_rasgosfk_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.usuariorasgo
    ADD CONSTRAINT usuariorasgo_rasgosfk_fkey FOREIGN KEY (rasgosfk) REFERENCES public.rasgos(idrasgos);
 Q   ALTER TABLE ONLY public.usuariorasgo DROP CONSTRAINT usuariorasgo_rasgosfk_fkey;
       public       postgres    false    212    2773    215            �
           2606    49278    venta venta_tiendafk_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.venta
    ADD CONSTRAINT venta_tiendafk_fkey FOREIGN KEY (tiendafk) REFERENCES public.tienda(idtienda);
 C   ALTER TABLE ONLY public.venta DROP CONSTRAINT venta_tiendafk_fkey;
       public       postgres    false    2757    203    201            �
           2606    49291 &   ventausuario ventausuario_ventafk_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.ventausuario
    ADD CONSTRAINT ventausuario_ventafk_fkey FOREIGN KEY (ventafk) REFERENCES public.venta(idventa);
 P   ALTER TABLE ONLY public.ventausuario DROP CONSTRAINT ventausuario_ventafk_fkey;
       public       postgres    false    205    2759    203            W      x������ � �      Y      x������ � �      h      x������ � �      i   (   x�346246���42�2�M9�@l#c ����qqq ���      [      x������ � �      a      x������ � �      c      x������ � �      d      x����=... �	      f      x�3�NCc#CcC�=... )xx      ]      x������ � �      _      x������ � �     