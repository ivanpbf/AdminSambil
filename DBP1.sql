PGDMP         (    
            w            Sambil     11.3    11.3 R    m           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            n           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            o           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            p           1262    16646    Sambil     DATABASE     �   CREATE DATABASE "Sambil " WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Spanish_Spain.1252' LC_CTYPE = 'Spanish_Spain.1252';
    DROP DATABASE "Sambil ";
             postgres    false            �            1259    16678 
   camaradata    TABLE     �   CREATE TABLE public.camaradata (
    id integer NOT NULL,
    fecha date NOT NULL,
    nsalidas integer NOT NULL,
    nentradas integer NOT NULL,
    acceso integer NOT NULL
);
    DROP TABLE public.camaradata;
       public         postgres    false            �            1259    16676    camaradata_id_seq    SEQUENCE     �   CREATE SEQUENCE public.camaradata_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.camaradata_id_seq;
       public       postgres    false    201            q           0    0    camaradata_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.camaradata_id_seq OWNED BY public.camaradata.id;
            public       postgres    false    200            �            1259    16686    datamesa    TABLE     }   CREATE TABLE public.datamesa (
    id integer NOT NULL,
    fechaocupada date NOT NULL,
    fechadesocupada date NOT NULL
);
    DROP TABLE public.datamesa;
       public         postgres    false            �            1259    16684    datamesa_id_seq    SEQUENCE     �   CREATE SEQUENCE public.datamesa_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.datamesa_id_seq;
       public       postgres    false    203            r           0    0    datamesa_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.datamesa_id_seq OWNED BY public.datamesa.id;
            public       postgres    false    202            �            1259    16694    mesausuario    TABLE        CREATE TABLE public.mesausuario (
    id integer NOT NULL,
    datamesafk integer NOT NULL,
    telefonofk integer NOT NULL
);
    DROP TABLE public.mesausuario;
       public         postgres    false            �            1259    16692    mesausuario_id_seq    SEQUENCE     �   CREATE SEQUENCE public.mesausuario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.mesausuario_id_seq;
       public       postgres    false    205            s           0    0    mesausuario_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.mesausuario_id_seq OWNED BY public.mesausuario.id;
            public       postgres    false    204            �            1259    16655    rasgopersona    TABLE     |   CREATE TABLE public.rasgopersona (
    edad integer NOT NULL,
    sexo character varying NOT NULL,
    usuariofk integer
);
     DROP TABLE public.rasgopersona;
       public         postgres    false            �            1259    16666    telefono    TABLE     [   CREATE TABLE public.telefono (
    mac integer NOT NULL,
    usuariofk integer NOT NULL
);
    DROP TABLE public.telefono;
       public         postgres    false            �            1259    16712    tienda    TABLE     �   CREATE TABLE public.tienda (
    idtienda integer NOT NULL,
    nombre character varying NOT NULL,
    categoria character varying NOT NULL
);
    DROP TABLE public.tienda;
       public         postgres    false            �            1259    16710    tienda_idtienda_seq    SEQUENCE     �   CREATE SEQUENCE public.tienda_idtienda_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.tienda_idtienda_seq;
       public       postgres    false    207            t           0    0    tienda_idtienda_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.tienda_idtienda_seq OWNED BY public.tienda.idtienda;
            public       postgres    false    206            �            1259    16754 
   torniquete    TABLE     �   CREATE TABLE public.torniquete (
    idtorniquete integer NOT NULL,
    hentrada date NOT NULL,
    hsalida date NOT NULL,
    tiendafk integer NOT NULL
);
    DROP TABLE public.torniquete;
       public         postgres    false            �            1259    16752    torniquete_idtorniquete_seq    SEQUENCE     �   CREATE SEQUENCE public.torniquete_idtorniquete_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.torniquete_idtorniquete_seq;
       public       postgres    false    213            u           0    0    torniquete_idtorniquete_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.torniquete_idtorniquete_seq OWNED BY public.torniquete.idtorniquete;
            public       postgres    false    212            �            1259    16767    torniqueteusuario    TABLE     �   CREATE TABLE public.torniqueteusuario (
    id integer NOT NULL,
    torniquetefk integer NOT NULL,
    telefonofk integer NOT NULL
);
 %   DROP TABLE public.torniqueteusuario;
       public         postgres    false            �            1259    16765    torniqueteusuario_id_seq    SEQUENCE     �   CREATE SEQUENCE public.torniqueteusuario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.torniqueteusuario_id_seq;
       public       postgres    false    215            v           0    0    torniqueteusuario_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.torniqueteusuario_id_seq OWNED BY public.torniqueteusuario.id;
            public       postgres    false    214            �            1259    16649    usuario    TABLE     @   CREATE TABLE public.usuario (
    idusuario integer NOT NULL
);
    DROP TABLE public.usuario;
       public         postgres    false            �            1259    16647    usuario_idusuario_seq    SEQUENCE     �   CREATE SEQUENCE public.usuario_idusuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.usuario_idusuario_seq;
       public       postgres    false    197            w           0    0    usuario_idusuario_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.usuario_idusuario_seq OWNED BY public.usuario.idusuario;
            public       postgres    false    196            �            1259    16723    venta    TABLE     w   CREATE TABLE public.venta (
    idventa integer NOT NULL,
    monto integer NOT NULL,
    tiendafk integer NOT NULL
);
    DROP TABLE public.venta;
       public         postgres    false            �            1259    16721    venta_idventa_seq    SEQUENCE     �   CREATE SEQUENCE public.venta_idventa_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.venta_idventa_seq;
       public       postgres    false    209            x           0    0    venta_idventa_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.venta_idventa_seq OWNED BY public.venta.idventa;
            public       postgres    false    208            �            1259    16736    ventausuario    TABLE     t   CREATE TABLE public.ventausuario (
    id integer NOT NULL,
    ventafk integer NOT NULL,
    telefonofk integer
);
     DROP TABLE public.ventausuario;
       public         postgres    false            �            1259    16734    ventausuario_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ventausuario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.ventausuario_id_seq;
       public       postgres    false    211            y           0    0    ventausuario_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.ventausuario_id_seq OWNED BY public.ventausuario.id;
            public       postgres    false    210            �
           2604    16681    camaradata id    DEFAULT     n   ALTER TABLE ONLY public.camaradata ALTER COLUMN id SET DEFAULT nextval('public.camaradata_id_seq'::regclass);
 <   ALTER TABLE public.camaradata ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    200    201    201            �
           2604    16689    datamesa id    DEFAULT     j   ALTER TABLE ONLY public.datamesa ALTER COLUMN id SET DEFAULT nextval('public.datamesa_id_seq'::regclass);
 :   ALTER TABLE public.datamesa ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    202    203    203            �
           2604    16697    mesausuario id    DEFAULT     p   ALTER TABLE ONLY public.mesausuario ALTER COLUMN id SET DEFAULT nextval('public.mesausuario_id_seq'::regclass);
 =   ALTER TABLE public.mesausuario ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    205    204    205            �
           2604    16715    tienda idtienda    DEFAULT     r   ALTER TABLE ONLY public.tienda ALTER COLUMN idtienda SET DEFAULT nextval('public.tienda_idtienda_seq'::regclass);
 >   ALTER TABLE public.tienda ALTER COLUMN idtienda DROP DEFAULT;
       public       postgres    false    206    207    207            �
           2604    16757    torniquete idtorniquete    DEFAULT     �   ALTER TABLE ONLY public.torniquete ALTER COLUMN idtorniquete SET DEFAULT nextval('public.torniquete_idtorniquete_seq'::regclass);
 F   ALTER TABLE public.torniquete ALTER COLUMN idtorniquete DROP DEFAULT;
       public       postgres    false    213    212    213            �
           2604    16770    torniqueteusuario id    DEFAULT     |   ALTER TABLE ONLY public.torniqueteusuario ALTER COLUMN id SET DEFAULT nextval('public.torniqueteusuario_id_seq'::regclass);
 C   ALTER TABLE public.torniqueteusuario ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    214    215    215            �
           2604    16652    usuario idusuario    DEFAULT     v   ALTER TABLE ONLY public.usuario ALTER COLUMN idusuario SET DEFAULT nextval('public.usuario_idusuario_seq'::regclass);
 @   ALTER TABLE public.usuario ALTER COLUMN idusuario DROP DEFAULT;
       public       postgres    false    196    197    197            �
           2604    16726    venta idventa    DEFAULT     n   ALTER TABLE ONLY public.venta ALTER COLUMN idventa SET DEFAULT nextval('public.venta_idventa_seq'::regclass);
 <   ALTER TABLE public.venta ALTER COLUMN idventa DROP DEFAULT;
       public       postgres    false    209    208    209            �
           2604    16739    ventausuario id    DEFAULT     r   ALTER TABLE ONLY public.ventausuario ALTER COLUMN id SET DEFAULT nextval('public.ventausuario_id_seq'::regclass);
 >   ALTER TABLE public.ventausuario ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    210    211    211            \          0    16678 
   camaradata 
   TABLE DATA               L   COPY public.camaradata (id, fecha, nsalidas, nentradas, acceso) FROM stdin;
    public       postgres    false    201   [       ^          0    16686    datamesa 
   TABLE DATA               E   COPY public.datamesa (id, fechaocupada, fechadesocupada) FROM stdin;
    public       postgres    false    203   *[       `          0    16694    mesausuario 
   TABLE DATA               A   COPY public.mesausuario (id, datamesafk, telefonofk) FROM stdin;
    public       postgres    false    205   G[       Y          0    16655    rasgopersona 
   TABLE DATA               =   COPY public.rasgopersona (edad, sexo, usuariofk) FROM stdin;
    public       postgres    false    198   d[       Z          0    16666    telefono 
   TABLE DATA               2   COPY public.telefono (mac, usuariofk) FROM stdin;
    public       postgres    false    199   �[       b          0    16712    tienda 
   TABLE DATA               =   COPY public.tienda (idtienda, nombre, categoria) FROM stdin;
    public       postgres    false    207   �[       h          0    16754 
   torniquete 
   TABLE DATA               O   COPY public.torniquete (idtorniquete, hentrada, hsalida, tiendafk) FROM stdin;
    public       postgres    false    213   �[       j          0    16767    torniqueteusuario 
   TABLE DATA               I   COPY public.torniqueteusuario (id, torniquetefk, telefonofk) FROM stdin;
    public       postgres    false    215   �[       X          0    16649    usuario 
   TABLE DATA               ,   COPY public.usuario (idusuario) FROM stdin;
    public       postgres    false    197   �[       d          0    16723    venta 
   TABLE DATA               9   COPY public.venta (idventa, monto, tiendafk) FROM stdin;
    public       postgres    false    209   \       f          0    16736    ventausuario 
   TABLE DATA               ?   COPY public.ventausuario (id, ventafk, telefonofk) FROM stdin;
    public       postgres    false    211   /\       z           0    0    camaradata_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.camaradata_id_seq', 1, false);
            public       postgres    false    200            {           0    0    datamesa_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.datamesa_id_seq', 1, false);
            public       postgres    false    202            |           0    0    mesausuario_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.mesausuario_id_seq', 1, false);
            public       postgres    false    204            }           0    0    tienda_idtienda_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.tienda_idtienda_seq', 1, false);
            public       postgres    false    206            ~           0    0    torniquete_idtorniquete_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.torniquete_idtorniquete_seq', 1, false);
            public       postgres    false    212                       0    0    torniqueteusuario_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.torniqueteusuario_id_seq', 1, false);
            public       postgres    false    214            �           0    0    usuario_idusuario_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.usuario_idusuario_seq', 1, false);
            public       postgres    false    196            �           0    0    venta_idventa_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.venta_idventa_seq', 1, false);
            public       postgres    false    208            �           0    0    ventausuario_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.ventausuario_id_seq', 1, false);
            public       postgres    false    210            �
           2606    16683    camaradata camaradata_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.camaradata
    ADD CONSTRAINT camaradata_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.camaradata DROP CONSTRAINT camaradata_pkey;
       public         postgres    false    201            �
           2606    16691    datamesa datamesa_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.datamesa
    ADD CONSTRAINT datamesa_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.datamesa DROP CONSTRAINT datamesa_pkey;
       public         postgres    false    203            �
           2606    16699    mesausuario mesausuario_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.mesausuario
    ADD CONSTRAINT mesausuario_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.mesausuario DROP CONSTRAINT mesausuario_pkey;
       public         postgres    false    205            �
           2606    16670    telefono telefono_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.telefono
    ADD CONSTRAINT telefono_pkey PRIMARY KEY (mac);
 @   ALTER TABLE ONLY public.telefono DROP CONSTRAINT telefono_pkey;
       public         postgres    false    199            �
           2606    16720    tienda tienda_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.tienda
    ADD CONSTRAINT tienda_pkey PRIMARY KEY (idtienda);
 <   ALTER TABLE ONLY public.tienda DROP CONSTRAINT tienda_pkey;
       public         postgres    false    207            �
           2606    16759    torniquete torniquete_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.torniquete
    ADD CONSTRAINT torniquete_pkey PRIMARY KEY (idtorniquete);
 D   ALTER TABLE ONLY public.torniquete DROP CONSTRAINT torniquete_pkey;
       public         postgres    false    213            �
           2606    16772 (   torniqueteusuario torniqueteusuario_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.torniqueteusuario
    ADD CONSTRAINT torniqueteusuario_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.torniqueteusuario DROP CONSTRAINT torniqueteusuario_pkey;
       public         postgres    false    215            �
           2606    16654    usuario usuario_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (idusuario);
 >   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_pkey;
       public         postgres    false    197            �
           2606    16728    venta venta_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.venta
    ADD CONSTRAINT venta_pkey PRIMARY KEY (idventa);
 :   ALTER TABLE ONLY public.venta DROP CONSTRAINT venta_pkey;
       public         postgres    false    209            �
           2606    16741    ventausuario ventausuario_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.ventausuario
    ADD CONSTRAINT ventausuario_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.ventausuario DROP CONSTRAINT ventausuario_pkey;
       public         postgres    false    211            �
           2606    16700 '   mesausuario mesausuario_datamesafk_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.mesausuario
    ADD CONSTRAINT mesausuario_datamesafk_fkey FOREIGN KEY (datamesafk) REFERENCES public.datamesa(id);
 Q   ALTER TABLE ONLY public.mesausuario DROP CONSTRAINT mesausuario_datamesafk_fkey;
       public       postgres    false    203    205    2759            �
           2606    16705 '   mesausuario mesausuario_telefonofk_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.mesausuario
    ADD CONSTRAINT mesausuario_telefonofk_fkey FOREIGN KEY (telefonofk) REFERENCES public.telefono(mac);
 Q   ALTER TABLE ONLY public.mesausuario DROP CONSTRAINT mesausuario_telefonofk_fkey;
       public       postgres    false    199    205    2755            �
           2606    16661 (   rasgopersona rasgopersona_usuariofk_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.rasgopersona
    ADD CONSTRAINT rasgopersona_usuariofk_fkey FOREIGN KEY (usuariofk) REFERENCES public.usuario(idusuario);
 R   ALTER TABLE ONLY public.rasgopersona DROP CONSTRAINT rasgopersona_usuariofk_fkey;
       public       postgres    false    197    198    2753            �
           2606    16671     telefono telefono_usuariofk_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.telefono
    ADD CONSTRAINT telefono_usuariofk_fkey FOREIGN KEY (usuariofk) REFERENCES public.usuario(idusuario);
 J   ALTER TABLE ONLY public.telefono DROP CONSTRAINT telefono_usuariofk_fkey;
       public       postgres    false    2753    197    199            �
           2606    16760 #   torniquete torniquete_tiendafk_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.torniquete
    ADD CONSTRAINT torniquete_tiendafk_fkey FOREIGN KEY (tiendafk) REFERENCES public.tienda(idtienda);
 M   ALTER TABLE ONLY public.torniquete DROP CONSTRAINT torniquete_tiendafk_fkey;
       public       postgres    false    2763    213    207            �
           2606    16778 3   torniqueteusuario torniqueteusuario_telefonofk_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.torniqueteusuario
    ADD CONSTRAINT torniqueteusuario_telefonofk_fkey FOREIGN KEY (telefonofk) REFERENCES public.telefono(mac);
 ]   ALTER TABLE ONLY public.torniqueteusuario DROP CONSTRAINT torniqueteusuario_telefonofk_fkey;
       public       postgres    false    199    215    2755            �
           2606    16773 5   torniqueteusuario torniqueteusuario_torniquetefk_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.torniqueteusuario
    ADD CONSTRAINT torniqueteusuario_torniquetefk_fkey FOREIGN KEY (torniquetefk) REFERENCES public.torniquete(idtorniquete);
 _   ALTER TABLE ONLY public.torniqueteusuario DROP CONSTRAINT torniqueteusuario_torniquetefk_fkey;
       public       postgres    false    2769    213    215            �
           2606    16729    venta venta_tiendafk_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.venta
    ADD CONSTRAINT venta_tiendafk_fkey FOREIGN KEY (tiendafk) REFERENCES public.tienda(idtienda);
 C   ALTER TABLE ONLY public.venta DROP CONSTRAINT venta_tiendafk_fkey;
       public       postgres    false    207    2763    209            �
           2606    16747 )   ventausuario ventausuario_telefonofk_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.ventausuario
    ADD CONSTRAINT ventausuario_telefonofk_fkey FOREIGN KEY (telefonofk) REFERENCES public.telefono(mac);
 S   ALTER TABLE ONLY public.ventausuario DROP CONSTRAINT ventausuario_telefonofk_fkey;
       public       postgres    false    211    199    2755            �
           2606    16742 &   ventausuario ventausuario_ventafk_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.ventausuario
    ADD CONSTRAINT ventausuario_ventafk_fkey FOREIGN KEY (ventafk) REFERENCES public.venta(idventa);
 P   ALTER TABLE ONLY public.ventausuario DROP CONSTRAINT ventausuario_ventafk_fkey;
       public       postgres    false    2765    211    209            \      x������ � �      ^      x������ � �      `      x������ � �      Y      x������ � �      Z      x������ � �      b      x������ � �      h      x������ � �      j      x������ � �      X      x������ � �      d      x������ � �      f      x������ � �     