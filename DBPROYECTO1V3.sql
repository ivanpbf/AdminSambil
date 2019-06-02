PGDMP     %                    w            Proyecto1BD    11.2    11.2 O    m           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            n           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            o           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            p           1262    49152    Proyecto1BD    DATABASE     �   CREATE DATABASE "Proyecto1BD" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Spanish_Venezuela.1252' LC_CTYPE = 'Spanish_Venezuela.1252';
    DROP DATABASE "Proyecto1BD";
             postgres    false            �            1259    49351    usuariorasgo    TABLE     t   CREATE TABLE public.usuariorasgo (
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
       public       postgres    false    205            q           0    0    Usuariorasgo_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public."Usuariorasgo_id_seq" OWNED BY public.usuariorasgo.id;
            public       postgres    false    204            �            1259    49195 
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
            public       postgres    false    196            �            1259    49468    datamesa    TABLE     �   CREATE TABLE public.datamesa (
    id integer NOT NULL,
    nmesa integer NOT NULL,
    fechaocupada character varying NOT NULL,
    fechadesocupada character varying NOT NULL
);
    DROP TABLE public.datamesa;
       public         postgres    false            �            1259    49466    datamesa_id_seq    SEQUENCE     �   CREATE SEQUENCE public.datamesa_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.datamesa_id_seq;
       public       postgres    false    216            s           0    0    datamesa_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.datamesa_id_seq OWNED BY public.datamesa.id;
            public       postgres    false    215            �            1259    49369    mesausuario    TABLE     l   CREATE TABLE public.mesausuario (
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
       public       postgres    false    207            t           0    0    mesausuario_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.mesausuario_id_seq OWNED BY public.mesausuario.id;
            public       postgres    false    206            �            1259    49385    rasgos    TABLE     ~   CREATE TABLE public.rasgos (
    idrasgos integer NOT NULL,
    sexo character varying NOT NULL,
    edad integer NOT NULL
);
    DROP TABLE public.rasgos;
       public         postgres    false            �            1259    49457    tienda    TABLE     �   CREATE TABLE public.tienda (
    idtienda integer NOT NULL,
    nombre character varying NOT NULL,
    categoria character varying NOT NULL
);
    DROP TABLE public.tienda;
       public         postgres    false            �            1259    49455    tienda_idtienda_seq    SEQUENCE     �   CREATE SEQUENCE public.tienda_idtienda_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.tienda_idtienda_seq;
       public       postgres    false    214            u           0    0    tienda_idtienda_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.tienda_idtienda_seq OWNED BY public.tienda.idtienda;
            public       postgres    false    213            �            1259    49445 
   torniquete    TABLE     �   CREATE TABLE public.torniquete (
    idtorniquete integer NOT NULL,
    hentrada character varying NOT NULL,
    tiendafk integer NOT NULL
);
    DROP TABLE public.torniquete;
       public         postgres    false            �            1259    49443    torniquete_idtorniquete_seq    SEQUENCE     �   CREATE SEQUENCE public.torniquete_idtorniquete_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.torniquete_idtorniquete_seq;
       public       postgres    false    212            v           0    0    torniquete_idtorniquete_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.torniquete_idtorniquete_seq OWNED BY public.torniquete.idtorniquete;
            public       postgres    false    211            �            1259    49316    torniqueteusuario    TABLE     ~   CREATE TABLE public.torniqueteusuario (
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
       public       postgres    false    203            w           0    0    torniqueteusuario_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.torniqueteusuario_id_seq OWNED BY public.torniqueteusuario.id;
            public       postgres    false    202            �            1259    49429    usuario    TABLE     S   CREATE TABLE public.usuario (
    id integer NOT NULL,
    mac integer NOT NULL
);
    DROP TABLE public.usuario;
       public         postgres    false            �            1259    49427    usuario_id_seq    SEQUENCE     �   CREATE SEQUENCE public.usuario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.usuario_id_seq;
       public       postgres    false    210            x           0    0    usuario_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.usuario_id_seq OWNED BY public.usuario.id;
            public       postgres    false    209            �            1259    49272    venta    TABLE     n   CREATE TABLE public.venta (
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
       public       postgres    false    199            y           0    0    venta_idventa_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.venta_idventa_seq OWNED BY public.venta.idventa;
            public       postgres    false    198            �            1259    49285    ventausuario    TABLE     }   CREATE TABLE public.ventausuario (
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
       public       postgres    false    201            z           0    0    ventausuario_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.ventausuario_id_seq OWNED BY public.ventausuario.id;
            public       postgres    false    200            �
           2604    49198    camaradata id    DEFAULT     n   ALTER TABLE ONLY public.camaradata ALTER COLUMN id SET DEFAULT nextval('public.camaradata_id_seq'::regclass);
 <   ALTER TABLE public.camaradata ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    197    196    197            �
           2604    49471    datamesa id    DEFAULT     j   ALTER TABLE ONLY public.datamesa ALTER COLUMN id SET DEFAULT nextval('public.datamesa_id_seq'::regclass);
 :   ALTER TABLE public.datamesa ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    215    216    216            �
           2604    49372    mesausuario id    DEFAULT     p   ALTER TABLE ONLY public.mesausuario ALTER COLUMN id SET DEFAULT nextval('public.mesausuario_id_seq'::regclass);
 =   ALTER TABLE public.mesausuario ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    207    206    207            �
           2604    49460    tienda idtienda    DEFAULT     r   ALTER TABLE ONLY public.tienda ALTER COLUMN idtienda SET DEFAULT nextval('public.tienda_idtienda_seq'::regclass);
 >   ALTER TABLE public.tienda ALTER COLUMN idtienda DROP DEFAULT;
       public       postgres    false    214    213    214            �
           2604    49448    torniquete idtorniquete    DEFAULT     �   ALTER TABLE ONLY public.torniquete ALTER COLUMN idtorniquete SET DEFAULT nextval('public.torniquete_idtorniquete_seq'::regclass);
 F   ALTER TABLE public.torniquete ALTER COLUMN idtorniquete DROP DEFAULT;
       public       postgres    false    211    212    212            �
           2604    49319    torniqueteusuario id    DEFAULT     |   ALTER TABLE ONLY public.torniqueteusuario ALTER COLUMN id SET DEFAULT nextval('public.torniqueteusuario_id_seq'::regclass);
 C   ALTER TABLE public.torniqueteusuario ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    203    202    203            �
           2604    49432 
   usuario id    DEFAULT     h   ALTER TABLE ONLY public.usuario ALTER COLUMN id SET DEFAULT nextval('public.usuario_id_seq'::regclass);
 9   ALTER TABLE public.usuario ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    210    209    210            �
           2604    49354    usuariorasgo id    DEFAULT     t   ALTER TABLE ONLY public.usuariorasgo ALTER COLUMN id SET DEFAULT nextval('public."Usuariorasgo_id_seq"'::regclass);
 >   ALTER TABLE public.usuariorasgo ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    205    204    205            �
           2604    49275    venta idventa    DEFAULT     n   ALTER TABLE ONLY public.venta ALTER COLUMN idventa SET DEFAULT nextval('public.venta_idventa_seq'::regclass);
 <   ALTER TABLE public.venta ALTER COLUMN idventa DROP DEFAULT;
       public       postgres    false    198    199    199            �
           2604    49288    ventausuario id    DEFAULT     r   ALTER TABLE ONLY public.ventausuario ALTER COLUMN id SET DEFAULT nextval('public.ventausuario_id_seq'::regclass);
 >   ALTER TABLE public.ventausuario ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    200    201    201            W          0    49195 
   camaradata 
   TABLE DATA               L   COPY public.camaradata (id, fecha, nsalidas, nentradas, acceso) FROM stdin;
    public       postgres    false    197   �S       j          0    49468    datamesa 
   TABLE DATA               L   COPY public.datamesa (id, nmesa, fechaocupada, fechadesocupada) FROM stdin;
    public       postgres    false    216   �S       a          0    49369    mesausuario 
   TABLE DATA               @   COPY public.mesausuario (id, datamesafk, usuariofk) FROM stdin;
    public       postgres    false    207   �S       b          0    49385    rasgos 
   TABLE DATA               6   COPY public.rasgos (idrasgos, sexo, edad) FROM stdin;
    public       postgres    false    208   �S       h          0    49457    tienda 
   TABLE DATA               =   COPY public.tienda (idtienda, nombre, categoria) FROM stdin;
    public       postgres    false    214   �U       f          0    49445 
   torniquete 
   TABLE DATA               F   COPY public.torniquete (idtorniquete, hentrada, tiendafk) FROM stdin;
    public       postgres    false    212   �U       ]          0    49316    torniqueteusuario 
   TABLE DATA               I   COPY public.torniqueteusuario (id, torniquetefk, telefonofk) FROM stdin;
    public       postgres    false    203   �[       d          0    49429    usuario 
   TABLE DATA               *   COPY public.usuario (id, mac) FROM stdin;
    public       postgres    false    210   �[       _          0    49351    usuariorasgo 
   TABLE DATA               ?   COPY public.usuariorasgo (id, usuariofk, rasgosfk) FROM stdin;
    public       postgres    false    205   ]       Y          0    49272    venta 
   TABLE DATA               9   COPY public.venta (idventa, monto, tiendafk) FROM stdin;
    public       postgres    false    199   ^       [          0    49285    ventausuario 
   TABLE DATA               ?   COPY public.ventausuario (id, ventafk, telefonofk) FROM stdin;
    public       postgres    false    201   v^       {           0    0    Usuariorasgo_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public."Usuariorasgo_id_seq"', 27, true);
            public       postgres    false    204            |           0    0    camaradata_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.camaradata_id_seq', 1, false);
            public       postgres    false    196            }           0    0    datamesa_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.datamesa_id_seq', 1, false);
            public       postgres    false    215            ~           0    0    mesausuario_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.mesausuario_id_seq', 1, false);
            public       postgres    false    206                       0    0    tienda_idtienda_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.tienda_idtienda_seq', 10, true);
            public       postgres    false    213            �           0    0    torniquete_idtorniquete_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.torniquete_idtorniquete_seq', 132, true);
            public       postgres    false    211            �           0    0    torniqueteusuario_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.torniqueteusuario_id_seq', 1, false);
            public       postgres    false    202            �           0    0    usuario_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.usuario_id_seq', 66, true);
            public       postgres    false    209            �           0    0    venta_idventa_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.venta_idventa_seq', 10, true);
            public       postgres    false    198            �           0    0    ventausuario_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.ventausuario_id_seq', 1, false);
            public       postgres    false    200            �
           2606    49200    camaradata camaradata_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.camaradata
    ADD CONSTRAINT camaradata_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.camaradata DROP CONSTRAINT camaradata_pkey;
       public         postgres    false    197            �
           2606    49476    datamesa datamesa_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.datamesa
    ADD CONSTRAINT datamesa_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.datamesa DROP CONSTRAINT datamesa_pkey;
       public         postgres    false    216            �
           2606    49374    mesausuario mesausuario_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.mesausuario
    ADD CONSTRAINT mesausuario_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.mesausuario DROP CONSTRAINT mesausuario_pkey;
       public         postgres    false    207            �
           2606    49392    rasgos rasgos_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.rasgos
    ADD CONSTRAINT rasgos_pkey PRIMARY KEY (idrasgos);
 <   ALTER TABLE ONLY public.rasgos DROP CONSTRAINT rasgos_pkey;
       public         postgres    false    208            �
           2606    49465    tienda tienda_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.tienda
    ADD CONSTRAINT tienda_pkey PRIMARY KEY (idtienda);
 <   ALTER TABLE ONLY public.tienda DROP CONSTRAINT tienda_pkey;
       public         postgres    false    214            �
           2606    49453    torniquete torniquete_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.torniquete
    ADD CONSTRAINT torniquete_pkey PRIMARY KEY (idtorniquete);
 D   ALTER TABLE ONLY public.torniquete DROP CONSTRAINT torniquete_pkey;
       public         postgres    false    212            �
           2606    49321 (   torniqueteusuario torniqueteusuario_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.torniqueteusuario
    ADD CONSTRAINT torniqueteusuario_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.torniqueteusuario DROP CONSTRAINT torniqueteusuario_pkey;
       public         postgres    false    203            �
           2606    49434    usuario usuario_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_pkey;
       public         postgres    false    210            �
           2606    49394    usuariorasgo usuariorasgo_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.usuariorasgo
    ADD CONSTRAINT usuariorasgo_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.usuariorasgo DROP CONSTRAINT usuariorasgo_pkey;
       public         postgres    false    205            �
           2606    49277    venta venta_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.venta
    ADD CONSTRAINT venta_pkey PRIMARY KEY (idventa);
 :   ALTER TABLE ONLY public.venta DROP CONSTRAINT venta_pkey;
       public         postgres    false    199            �
           2606    49290    ventausuario ventausuario_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.ventausuario
    ADD CONSTRAINT ventausuario_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.ventausuario DROP CONSTRAINT ventausuario_pkey;
       public         postgres    false    201            �
           2606    49395 '   usuariorasgo usuariorasgo_rasgosfk_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.usuariorasgo
    ADD CONSTRAINT usuariorasgo_rasgosfk_fkey FOREIGN KEY (rasgosfk) REFERENCES public.rasgos(idrasgos);
 Q   ALTER TABLE ONLY public.usuariorasgo DROP CONSTRAINT usuariorasgo_rasgosfk_fkey;
       public       postgres    false    2770    205    208            �
           2606    49291 &   ventausuario ventausuario_ventafk_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.ventausuario
    ADD CONSTRAINT ventausuario_ventafk_fkey FOREIGN KEY (ventafk) REFERENCES public.venta(idventa);
 P   ALTER TABLE ONLY public.ventausuario DROP CONSTRAINT ventausuario_ventafk_fkey;
       public       postgres    false    199    2760    201            W      x������ � �      j      x������ � �      a      x������ � �      b   �  x�5Rɑ@{��������lU?(�AHS1���(� ��l��x߼�*�64�Q�G�7kʞ@N���^#�U��L�"��U��LaP�d�w]	u�mC%��&�H�����z�Q����#�0Ѐ�N��Ĕn�/m���iԴw����Mp����22V�a��>����ۋ0�w1�j5�#.��þ�jԜ�eo
�˜����9���tJ�Å��c�K	�c��P,�olo݅�:W���+e0MX�T�y�X��PhOh����=Q ���~	+��pB��!�|;_�9i�H�a]8��f���΁�
q�0,+�ǝ�מ��rꯐ)��Y�+� {�/٥��-m�eQ���9g��,_����E�vm-5�g_���$����k���|R��@͈Gؿ?D�盐N      h   5   x�3�,(*MMJ�L��\F���&���f��������"1z\\\ R�9�      f   �  x��W˵�:\_G1	\ �cy�����iK���E��4����#~i]bgI˔=��e�V�����_�Ӧ<m�o��e�܏X`�b\-�8��?��.�������ez.�TPOX�5�#���K�=����T����%��7��|^0qx����m���|h�u�-����r�>�p=��~���Y�C��b9�����W#���!^'����)RYN~�����6��HT�4���W;��9�N��h��A�,O1�bl�[��+�GpX�_�����)n07�0F�=�3&G�<�ե�/8RC.��q��|��{7��Z��@�����A���w���o,�������_m�Ռ���n,,�J'��W.
~���[�7�-�K�|�=,��l��+�Uw��V����a~Xl�G�E�q��p(3~7���S�S_���k����_m��_Ⴋ��k��������?R��b����m�������k�?�/��ϗ�E�7e�J�[?��ס��:;����_��l����/�ٺ�筟�g}�� H~���C�>*���?�K���_膣��vf�+���������U0��_g����~���|���>rq��G|L�w���<ٿ�/�p!�\��h��[��[��m3��'
���WO����/�dk;�,x2��-�z�躝G���'� ����_�������~��=o����I~ݗ���ߕ#ٚ�����__��?�'�����ㅃ�C�|�G�֨l��^n}�ߒ>X�)����io܎�'}]���h1��m9����|�W�?��9�������@1�t��_<qo���ɯo�?i������W�'�7�+σ�G?�9���E���~Yn�/���q�Y�q��L����ĩ�2����7چ�Y?�P��G?���S��7|�m�_��� �x���������?JȀW:�w�r�\L���7���������#;���/��_=J6��䗌 ��Q\&?�����ڂw���_���_}�C}ayJ�=ʾ���9��q��߿��s?c�q�7�������p����@7����`�}3���1�0��1k�,*��a��)4�K�f�I��6��,������@���*iל�o>E��/�}��$��`7F���1�ҏ������J��>�;�A�_��� ���`.(ؗ�̧���ˀ^|JZ��Rsd�-7�Z���s��&O�9��� �n��S�6 �֖����2�1s�}���t���wb�}1(>]��#��n����m@��i�w����&����$��6D&ɇ���m`8v�&�z��|o'��g��l7�y��:p�R��`���`Tk��L���X���q�j�	�      ]      x������ � �      d   q  x�ER��@����p�\�u�����2�Ԅ���d�홦T��*dqfZ�6�ڂ�p����m����[O"z�O��cu��6L��`7PO�����%^k9�Z���^}��i�3*��O�j�I�dݳI*��bW#�63o4R�WsH�2�`Kq�4���ص���ܵ�����h�pT-ˠS��MRҺ�R�Qb�f�� ߄~v��j�L[ D��+B�d��&� �R�������	�H��Xo0$�d��1݀�0��ˮe$���Ӣw$�¥�k�������Kb������9���&��e�E��I��W���N�~%Mtކ��w>i��Dk�M3�䥐ve1_�#�=����?O�y�      _   �   x���q@1�PL!~�%�����,�5i��� ����[kp�˺���)��66:��ʏaw_�m.|Ři�7��� ���Mҟu�Ɯm$��݉���t��ґ�;�����7j;h�I%J򸬶�-(J�i��T���TX��-sm� �١�]�>J�Y�!��S��?~�~�z蛾
�	��;�J5�ϓvO���X7�Ҭ��g�zʗ�����iM=�j���Ş�9������KG      Y   J   x���A��d�4��e��c�VF9�����P (T��Zm]+tg<�M�"9�\��Bi��n�͚��G�ӹ�      [      x������ � �     