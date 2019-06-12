PGDMP     '    .                w            Proyecto1BD    11.2    11.2 ?    r           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
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
    public       postgres    false    199   �X       d          0    24762    rasgos 
   TABLE DATA               4   COPY public.rasgos (cedula, edad, sexo) FROM stdin;
    public       postgres    false    196   �^       m          0    24974    tienda 
   TABLE DATA               <   COPY public.tienda (idtienda, nombre, catalogo) FROM stdin;
    public       postgres    false    209   m`       i          0    24810 
   torniquete 
   TABLE DATA               E   COPY public.torniquete (id, idtienda, hentrada, hsalida) FROM stdin;
    public       postgres    false    201   a       e          0    24767    usuario 
   TABLE DATA               .   COPY public.usuario (mac, cedula) FROM stdin;
    public       postgres    false    197   P�       o          0    32953    venta 
   TABLE DATA               S   COPY public.venta ("idVenta", idtienda, monto, cedula, descuento, mac) FROM stdin;
    public       postgres    false    211   ��       {           0    0    acceso_idacceso_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.acceso_idacceso_seq', 185, true);
            public       postgres    false    202            |           0    0    mesa_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.mesa_id_seq', 98, true);
            public       postgres    false    198            }           0    0    tienda_idtienda_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.tienda_idtienda_seq', 10, true);
            public       postgres    false    208            ~           0    0    torniquete_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.torniquete_id_seq', 922, true);
            public       postgres    false    200                       0    0    venta_idVenta_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public."venta_idVenta_seq"', 543, true);
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
       public       postgres    false    209    2777    211            k   �  x�uZ[�$)��<E_`2�u���9V2�D&0��ՐƖe٠���'��H��O�?����I�����s�ϟr���I�N�[�K������G�Ƕ$�b��O.w+����s}�s��m��f��OJw�Uz���(�{z}_>�~r�6(�I>���n��ȥ��G��J����l����2|��\J���F�o�^R�,��Z�sD��h����U{)�!tB}����`�}��w��u�LÀ\�k��1��n�oJK�A���6@��v���9�}�߭�����-.������<��wU\�p������_���V.�� �^������ �#��ܵw�ؠ�4[@D/�C�B�[w3l�q~�\X�´�A��~<�Ȣ\�E�3�,Ɇ`�	�1k<N`E.�#�z^|`�#�2-�J��É.F&��{&�G3I"�^�q��V�=�8�sk�;c}�z�e9�pg2�"�;��I����F���y@�ڛV�|��� �Qw��B"4��UC *i觼0H&����#�Rô*���eaX�a>�1V�l`�\J��Z^�q `u_�	����*)XeE�%;�S�"Qo-�և�?m]�'��_��[�Ūj�� /ߧ�J$� �ܭ�)q��F��)�HdL Ыب$o��L^I�� 6(���.B�]i��0�lt�Ѷ�|�X� D��lD ����U[�k�<KI&ӅG:kR�  L�.r$�A������G�����b��A�]J.vմɑ�N31�r�Ԝ�U�/��O1�$r��"V��"V��<��(��G$mɰA��V�輣?��ަ%�_u�P�)�$� �@A�P��&�IO4S�)�f��e�����cM�R��DnVP�OK����PC(�B�P��B���+����b�� @A)����WC9�6�s!��m��jiT·�!�����6f����Q�������4�l �E�F|�����ʭ���:������'5cA�������g��6H� ���4�@�q����)�0���e:,(���|��X@Ck"6�����E�@�����,1�Dh��P�I�55t%n�Â,�rt���8]�A���\=�rX��3�,6j�M�$����jK����yJ���Tl S�� ��v*����� �j�$���N@U�$�CoX	C�%�L.�����@vE�!V�]���ς�d���5�
%�Ŕ�>�㧦� R��0��qew�P{�z�j�*gDJ�݇�8�mHeWQ��a�CR�h��	������b���nl���� �#4\6���\?h��C4VY�j� �}-�{XrO�G�g�v���% ��rx�t{!��[���� ��|���K$�.��C�L,�����Sz���g
vL���,~���r���[jX�"S�f)AK�1���|�?|^'*�{C¢�C���*u�t�_����]y
��3�u�<YbC�2.�^Y'��B�<��T�!u��+� ����?���#7��g�?&;�I����������`A1h�N.��� �&v$�����k	?�`g��	j���g�m�ʑ>�FI8�E}�k�c��A�D�1���3���c���BRdl�@��^/�C��r �9��p����p@y��..1���q6�YԐ����1{�� ��00
dAGT��/5H�� $��O`=e�3������joD�ݕ̘|J���R�%e(�%�\�7��`L��]8��JYN@�rBqN�
X���ɄZ�ÓiL�8���%c.���v��H1a��9[���4M9��Q3O(JD1V�뜍=Z�����!���D���B
�,�9ع�D!��.��u4���`1C<�Q��K
u���g�-U�NIrz+\�!�Ɣ]5��<�EI8��}�a{�Ig�pATJcKe�b��p)?|�(%�G�p:X�b]�\���<�d�@�Φ�zTc�d^�s¹�Pbr��!�D��W�)s���$��;0���
�Ԥ4��^��hob����h=qМ��ぐ�����D"��{V�4�L�,�iT�1�m�B�u��4=�݌D:M*�3$��@XW�0������e�M�O�	o����`\�d��t텟 S�-r�N�!���b��Cw�1��}JCJ	/��TX���Np����i �eT��W���%A�G�����Sb��c.���Ǹ��OD��@S�,�_�'j�S�R�C#Y�D���,�z� ,s"�j)��A�J{M	����MZ�itb�fȩ�Yd�79���)U��|�)+R"������370���������H�9�ɧ+0�F?f�F�o���[��v�	��W�䖩�$Ůi��鿹��y�@��C�䩶Dާh�R?���Ѐ�!8��w@ϹO�=�f~ �P��d�1��l0ݽl�D4�!��(��|�!/;�JvC�{���@-�;v����Py#���a+��p���N���l��g ��l4>��9�6H����{�C����n2t���c;b)��qVUk�t�cA����1Z�n9Zg���8�d�bw�����[�x���ۆ1�9ކ�����x�� �9��G�CBH����f:4���]���m1���(��Ԏ(�����>J�8J�I�l�z�pԲW�SϱIǝ�D(�T�i9+�垔c��.4�:�ǟ��&,��^������\��m|1�y�u0��#�)I!����d�|����y�^@�`h�3//PU��Я	�����W�#�����cV��5n,���G�I���}�4ٛI΄�K�fOHK��T�}�v�2c&��$jO	��qI�H�R�Wv?����C��	��k62,�CD/ł/P����G{ېH��x��}ΝГ[Л}�)��p�SL��o(�	I4���W;:+(��Q9�m�76>t��İ��!6��Bz9E47�G[���O;��t�໪������m���#�E�+C�_~��x�c{���-}��6�G"��8��/�pa�P���ܜ�p�w޺���G�������
���X�H�^n��ݘ1�|�j�9��7�bʿ�'F+�P|x �BF�����tBӐ�F��;����,�!�@m�!��	x���e�z4��ug�M��l�� ��9��_;�Ju�D�Gz���f����`':�Q���)�k���
i��+��b�G�^�ҍ̻�ǸOC)󿣈�!5~���G�3[[��3���ch�"C�o?�����}sb̭[iJ�5�q<������c�Q�ֺ2��=$�Đ���g<����(}���u��g�!ϩ!��f�4u|D������,��(��E(��ۺ�tK�K�����2m(��க?���{ ��C|U��2�D���HAa��<{H�d�� ���u�C�.<ż���0�á�ь�4��ԃj�������YGg�S�k��V������a��mf4�)��3��Ԁ�@��vjh񴪳�RӒ���@�%}}oMǨC�'�����C^���u�H���j밡�1%(�	�lns�rx�V*�e�����{�,�M�[���|��ҒS^��AN�z/�u�^(M�\�k����(T�Vc�J0v]�`�$:j4e_���������P�L      g   �  x�uWٵ�6��x	�N��b"p�qJ����oPd-(��t����.!�_d�H~�>�㛙�c����ᾣJ,W��F��v,?����Z���?R��n�z��H��9��ⱼ��B�Ѹ%C�V�(j�����!�G�@�n��֕~�U8T��9��ٍ�"���v+�u�U����B����Jx���ַij�ʾ��f)��\�3Ք��W0���������5���ℌ?�+�Km��7#�g�I��Y����?n���Uq��l�M�9�r9�R��d���\�VՔ��ȫ^1o!	�zu۫D�C�"L���B���ԋV����N
qBVO&(���v�����$B��ݧ��i܀ y�U �QJ�,O?-nnO�BL�v%�j���UD�0 �;S�k��[`8%��i���� �/��3=�R
R; �gʕ�})j�l�[�c6���ⴌ�6�T�D�r�������#��4�̛2�s�~s�9�
x�Y��6H?�]]" o��_�O�x��&��o�*�F�p!0���-@��U�(����=$�.	7@GIt;�����	�n�Cr�&��
!0	԰
	�9)�? �i��@W�i�ԁj�.Ho"�ɋ��r��U�F�񵁣(���2(>��4���GW	-s> ��3:�xg�?:�j�$�T4: ��9�1����<��f-3� �����Qe�i��`�Dp�4=!�a�j�-�ђ�bzQ��O�T����q �O*]2Cx��g
 ��$�Zu@�AЦ��\bS
�|!O7�F��y�!?�Q�a��$����dao`2���^�!B���/��.�s,��#����$�tf���,7������º;���h�&b�x$$��l{�F�Yoq�w7h��� >��p�=�B���UiG!a6������y�x�R�t���\`;�AP�G�����o|�X͟s�h��{S�[�hD3��&���Y4mO!�(�oU�g���ʊ�#�>V�D���mD�����A7��;˂	#X?��v�V��T06HF�Ɵ��a3έ!�>�8�HIc�z�@�^��T/�y�ΗA���1�8ַ<!,(g�~�>rX�(qL��������
4��X�_'n�PՏ+�k3	���Ƣ;�)$�|"�W�X�byKlBo^~!�2�꿬ſ�����U��j�:����|�Ai:�_�D���4B�;�r=��F �:���նA��/ױ+&/�}+���8��_A��� O[)v�X�F��	ӛ>��(HH�K��� 0���G��Q=cC��n���� .�ߙi���Xţ���9W��#q�&��]k��B��<A�@0��U���JC!p+�r%�e���Y}�*����i��nIB[ .n����S4
�)'ԏ�GK��Y]<�z������]A�J7��}�S��k�s.�����$��\���5T_Ȟ�[V<v�ɜ���WZfс'��,0����{����ߧ      d   �  x�MTAn1;3��I ���������J+-
�6��v���.��t��|_����%��s�U%�W��V�{�29�!� �n$��%ޑs����%�^ҼP�?A$�N�Q�9�k"��i�����)���D�W�+�=4��)��v�� PS>�#5����wL!}��i�ޱ��$N��Y��BXo���e�q�@��YPAj{;-�%3׃��f���\���5�ԍ�ލ03k�:,q���8X�)6�ð�8�]�����-s�_BI߫f��0��c%}MцX�[{ʕ�ǌW;ެj�F��}4�͊��;�������.�yDq��9�c�p��9�|F�-g��[�b]U=A��J�3F]�c�{Ks���*� ��(.'�z���>7��94��'1��2��'|��9KH��|�=��I��� �
v4��x*~�����8�      m   �   x�5��
�0Dד�	ַ��P-.�M�^K�MJ�o��Ü�w5�d{T��5��DM���[�l�SM*�j��Z�v�F
�?٠5j��[H^r�q%�N�a;	I^�α=d�v�p<�9�.ѫƐ�J�)8o�W�@���'�Y|q��G9�      i      x�m�Y�$;�+�]>�3�K�f����,2]������pw3������V����������j�/�gg۫���Y~�l#�'�׾�8���:��{^��_�����l8���}��Ϳ[�1j�&�'��j�3�w��n֟�rW���_�?���3����:�q8��F��E��+�g�:v����?�V������/�O��ȸD�?|l��s�3��淘�4�eK�\����~}��*�O�}�O-�[�|��r--G�U<����s|j�����u��u�Z��oe��{�Om�����/?�՟�gԻ��b�O�=���ES�q�G��&jx��gεW~�È�_m?��i����_��j@"�
~/ƞ_��b���5k��o(�����4˜�]��O��hk��7� ��|'��K�����`��L�_
�qr�_w�"�~J��r.45�0�kO���L�O��(�څ��M�_j�=M�g8f]��O�����&?��݌�}������9�v�7�B�o`��h�0 Q+uΜ�Ӻ�����.%zs��_m��:��^��G�&���G|\��Z���I��1뜗�	/�׵�1�^��:~vk-��"��fn<&S���)3v:D��2~�̱���j"؀⅗3Z�&���͘��B�����Q�.b�N<���n��������V�� 	\�eM����,�Z~Z��\�
�DS���o4uBH���ͪ_�xD���� �&(��+۰�tQ��h��>���~+\�2\��QV)G�h�8s��&$���Z��;���:ς�.�DmQWV�,��]5Qo�S�hcL��ٙ{�� ��/��.���_x���h���<
y�Ƌ��Ŝ?	��'L5�7޹�7��DT��8�a8���4U׌4	�.��#Ж�� <{�k����h��0;ǿM����~?�#��� ��/��L�w��7&�U�2���䕄�ǣ�{_�!���J�o���v�<b�m"зF���ޟp�T	~�TܷKKċ�6��p�5S�������R��g�
�}°�Ј\� PM�I�~��9�']3�Aᵔo;'�$�����W�IS'�q%gmm���Z�s����0���v��64��O����k�B���0��$Q�29-�O��-�_p=��o&��qm���д��75i��$����P����y�?�V��AEZaq��p��F�`����=��o{C���i�V�[��'<M�+�
��o
ΟJ����B@�C�&�0,�,��c������{�������1����W�������/�e/֘�EЇP�t�����T��.iT�?Y��p�J��A��m,���w��aX��q��H�Th������p_.�~d[��^Jm������T�\V��Qx7L��ݲ�a�LxJ0��r6�9��$
^�k&��V��:L�Qi�2{�LGӠ$d��m�Dt&��	��k�J�D206ޟ��N��<�B��� ����Q�������6u-1�4�z�e�R���� ����v��Ϥ�-�p���9:�@SB#���9�/'c���s���t��Ip��K�ܓ��)�,E��^����������Q��֙s]���06�
.��L�L�)A^�9X�J����,�LU��[]x����	U	D,s�xQܡG�=MDEK�v���,7sxs���Xa�,
�@߭�Y�!�4�Y5���n���F~���$o����M�D8���|�7�����(a"r(D�ҳ��	��Qӑ���D�Z�jx�/�B��3��`��i�(H��'<����M�J�Z���(�^��{g���*����Nd���M[j�4{���Mc�;���g;��-��Vh��!^��%>��&��
�Ү�����Za�6������y"\��n��G�gz~�é�~�/���ES�j��|���� �KA��O|��4��}MMaRE���.�T�9�X��M759V�����a�S�U�.�ڎ������q��U�-x���C�=Դ�(`� �K7I�����Ϭ��m��B_H-�?�(���I�	g=�$L�w�_/���b3@�#���8��� 𭤉�C��Q>T9�s��M$b-��q�RǼ�\�B?e�Dz��1�`��Qac��"x ^e�]�^�����xФm&b�0�ޒѵZ.X5"�*3;tQ7~2H�fĵ\�j��!Ĭ�L%�������Xr��A9>�D��l�^|���!�Ƨy���6�����S�x����.|�K�p"L�5�+j�0&I��1q�0o6�)~h_���k!��Y;LĘ
�`4xXՀ%�(���𒨋��o������n�;6Et(��^�NX`&(��ٜ`�8]N~g�qh8�������
ʌ=�������"�˾E�:�҉�SX�OtP�Q����3�)���wt<헢ď*�E��-`�f��-�(��D0��?�Z|<�K�BI��o��r5J�P��j���aܼ�U�?Ѓ��;���������J�fM�u���Y���z)�"����`'ϚƢ��2�`�w>��q�T}́5d��xЮ&bP�;{&��J����͵LԔ����w�����ve�o};Շᜀ5��(�n
�z���\�J6d����z7�D�pU?�4� m�D����u|�������A_�1L��75&h��a�D\��i"�=PL��܀UwXM~18��hZ���C�e@Ov�Ua�
dp��"fhqvu*��p��`R�8m�"2�~ ��aE�/1�,=L�;�:i̺B:�ʺ�I�e"�?�F�jw\�B��}e�X^�!]�d+���pSבF1#&�Mq�"q��`�T �Yr94Rv�q�e���Xƙ&:yz���j8����c�w�&
E�@�b0;�*�, cF�̛��b@8;^/?�}�-r��a���*T&�@
>5W�r���g�(OTln]�p/0���w���'D� 
�Ps8kĝϊ!�n�Q�"T@g>�Lzd �J�z�D|Vs�"�N�U��=XXp��~87\B5�~�`e�����	��:�`F͗��O�|�]����������c4�4v��J�d�:Cq�zE�O���w ���s�z��	�4e��S���y� ��F��7�[�F��	`lx�(�.�*�z�Џ�b�T�em�DL6.f��~�Aj��a��L�;���͟{a*����E��m%:E!�0���ø�)�`@����R��A��@���"����}�����z��\�V����$�����'�%N��7��H�.��M�2�����\��j�P�I��o�A
�̉-\�<�U&�����r�+�CV����j)&8�.����'Z���p�Q�'՜�1�L�z!�&*��0T�?���He(�\��Y��V�w2d>�kO��@�C����S%����tQWZ}��i��k��e���z9u�:��VC%-
e��.ڲcm��O�����,j�����,K�����Z�B��^y�II+��^�j�N*>��~��^9N����+;���
P��m����C� NGU�c�NV�^�(pP��U��eF�(����n�B;u�Q�','~���H�������VVEŅ	�0��A��reuR���"|vI�zo�|��<�fܑN������q�3w��IER����--�3��~Z�����E�?z7ó������V?�"ΰ������[���,��`u��y�K�Uf(T�Vߌ0,��p����m����	�{�e��<���qb�g����Xt󕺂�?r�JBvo�a���J5#h/X�0Q(�u�mV��;���e"�.)qS�����T�	,h�j��p�-�����¸	^���m"�G6�0���X��)�d��]�T�����
VŘ�Oa��G	�B��u\�:�CWK1�r�UM$��Sϯ5G�)����Ư�.���%7�����x��u`�a�S���K#���I���`a	��=>���
��75Q2r�G][�j�4��zQn��)�[����V    @�RVsѦ]s�9���ڪ�04�6{_�9,�)D�=0�VSMq��.o�t��:/6ϺT%j2�_}��x� 8Ŵ�6P�nж�f5d�nB�@�������$Rn�� �r{��K�q֭�Ph��lx��"=��gV� e�]�S+Y:K�k�O��Sީ�2�0�>�^xx�չ��ZPV$}ƺ�B"�e���V_�Z����x��DL���,��`%�jͼB�q���&�/X��h��]��8��~�G�����S��q��ʦw9�;�m�l 	{��rݚ�Hr�p���|�J��a��2,�sATs۟vG��:����&��Ι���T)?����ȓ�T:�;���˽c�4&E$���w�h�&d(>�� .�c�_�|��K�T^�5Z�%�7�����Ӆ��(�;{��aSVd��@�=%��
-�Oh4�sQA'���D��AG��LY)"�{ Bps��Z�s�A%r�Z�Z�n&J��\��_����ê���
��g�X�!x�D9�z<�!�UJ(��a�9�\��>���n��*�_��&��� ڵ���U�|w_e�Ƴ105���_�J-8�	���D�#m�^Ń��n�b]�l_0��X��&���*����&�����k|E�t��y�*�H���v�Ύ
��`%ެ*���8Y�	B�t�US��v��D]e����uSUJ�6W&�Lt�.����.TI߄
������Q��'LS��̞��;!Q�7�P�����+�n&��u�D��� ���5�6K6��w�7EC�&�	���?*P�^�/�)۩�QhO�r�0P��w���.w������i��sT��,,��f"�h��Y����Nq���w��6�4o���)\W�%6���z75E� ��MW�[V?��{�H:��7j�p��1e���)�
��
䧥�@Yf��	�M�~2��w��S��R��	W'ه�?x��eU�NF����z�����aWV�i��	�تY*Y��Y�terz��=��B��dеI'V���������bN�1��t\��t���aR,���R���M�UUM�X[�QM�r.��T���+*g�j�M;G��kj0�8�RhP�Z��jr{
����í S�$l��/q�	hI/�Q���+�\�4ӽl�-dtÍ�Q�,1a4Q��O�8��J�c!$L�Z.ZLF,����:�R
pF��$>�/���6���Ք�����q{�z{�J3'��U�*��e��O�!M�J����T��߄KR����\���M��|Pt�B5QW��eI�8�*����W�D]����M�V'4�ϝ���JtrM�!lLi�M�S�z�d�6�RF�E�?p�e�<W����6Qș^�
И�z�3P߫\��y�� u��;�~ھ6�Sc��r폑��`�`��UQ4%�p5�Ӵ8WI����J��,�*�Jr��e�}�x;��������~�W�����Ou]�{����%g��	*�MUQ�7�>X�0�����h��k*%1Ԭ3�J��C�@,����MPUĆ1L3��je�z�u����y��уFU���y�XT����TT���.WT�ve�;,�Z�4�+�Ͼ^WT�����b�(O��(��xp���gbH}����sCw����X�<��x�:�'�F��G${p�*Bn�1���*��&!�]�/��-^&b!�`s%�<�N��D~Q������$$κ�9f�X�&R��o��\W���p������染�h�lj��?�:&i*���j|V��*R),�a?'Y�Wۓ6���c '�`ז����=�����q$`<厛��۪�Ҁ��U��I�~T�Cr4D�ƣ�7�HB՝`ř�V�1&)���)e�Ng���ծ=*��>�8�u��6�k3Q*{5���YG��3�#�&�%a�<��p����Dʒ#:�h�Vv?XP�aXu��a��#��g���{�j��U����B;��  8��-���۫�)�4f_�$�Jʌ�o_Q���Hڊ��o}C��2�Zy���o�]���XW��?�ν]��g��Ua�p�Z�Q����VƬ��b8[=x���	�61{z^x���Uq�f���@�\��ξ��I��������I�T�Wl=�2���5QS9��=��\?u�%����u�O�M������ÌؾU�N�+������^-`E&x^p-�HV�C����]����z>�`���T��rޛ�_����S��$u��z�a8,d��=&���o:�Lh�$��;�>�@��k��&R#�9"�{��N�&k�|���0_��8��K6R���v���LMb�ǀ��a'�be�,GvU�-�.����������:M�8����=�]����G1�U�tDS�[�n)��NU!<����%:�-�d�k����b/"�����[������H���IP^���B�֢7�՟F��R]��N/�ӻÊ6A�]���$T�.�FY}q�P�oXip�Zn�SH̰<��g�X� ��"��*�Oޅ;���i�����<EqX����_�R]~���c8E}m�[�j�ӻK�L4.�͝�%��,���;��!�똛����E�(Z��v�W�iـZY��m���:�v��䎻 &���,�M��B��5�$f�Wu p��Y�羂�Cv�%�q��I���q��x�c�'�)}���S�v�>.�;�~Zn`��q��"X���{���W�9�a"*���h ���Nq`SiR�&zFBx!0a���t�U��Ý��V-X"k�xk,)qv+���?�E�G3����KmR�>��=u��^���`W��T��W���
�^�����(8��4����f;Gj�T��b��I����(W�����������,,u�2Q(���~p�e	��÷�����v|P:i
��q��pN��D�'���N]���晳x'~�4���>�JWX',���z���A:���o��ϝ|3��H�Y˪�Ş��~g��W��EO�'HG�%��7X羊�V��A�k��r`)y�^.論&:N����~#J�D�,G$�n	5}����mEOk)�bXl��%<36k�l&jg�^es���x:����,�*j��5���a���8�4��tQ���\Z�;̞�����Қ�8*��/iE��`L��n����h�;�>�����]�f���:vakޚ�J�LaxxG��(�q�j'������58��Fm7IjOY7�r�A����S�ka����IS���˙vw�}�>��{92�O�YB��e�O1${�W^e@���x���ⰣJ���?�Q$���� ���tN���/���2�n��������AUT�ˁ�a�����Ԃ[4][�s�k`.��R���w�iڪ���f�/�ͽ�)��5`xc�TǪ�Jk��h��k+̮��R^����l����:+����b�W���kh ˴h^��������n�|�dwa_+� Br�[`���k�c�0�ʠ�z���۞&b[���͹�)�<�����7��gV.n���;�~#�vl��ʖ?��ht��8���T_���7�ѐF*�=��W6U��\&+9�um�R���q��+_��
��"��K�������]o]UUS<f���$RC+cS�W�]W)`CE���km�aT|�혒+�nخ	3K���qb�M;�_�����������J�>Wh;��bȕ��Y�ک�$*r;���Y���Rw�Npi�~��j?��2n�����+1�S��
����&:z�P�cW��iuݸ�m�(4��ܔJ�h�	:���H�4ɔ�m�)_�:Ss�I	��[����j��儠O�Q�3�TC�X%;L����[��ߠ��w������sDM�� 9��@�!B�yT��/*����0��,f���5/��Z��� ��Dyk�<�@�|պ���^�E1�w\*���	�7�)��e	�'�k��.�ŔB5V�� O�g�A�ڃȻ���-�G�@���T1��H1�����!�WvE����q/�,4Q��dP��u��j�T��~G�֓1h�"񝫩*M)�S�s��{�^���b"    �k��Y�Z��=˳}���~��㰡�i)���1sFDM�N�'�[U�i�]u/�<S`K`������\�\"˻���~\�|̮�仐(����i�,d�5�D5]E_M4^�n�DM�6SE5�wfS����[���)T�8{�J�R��I?�i��`���`Ň��6��l�s�PWpp�W�!��L�m��̙&a��f/$TD{��Tڵ�~?�#j�)t3k�î�tUB�ۊ��Sb�7T�����p��[�V豟�z p�Ds]��R��q�i��S��R��U�� ���������4v⬣*�vV�I���|�h��\*�sL��.z�~�9�B���q;W��ѫp=�����O��Kf�(ԧ��ʳoV�8�����~���IȢ��?��q�S˚V�i$g�z��-���Pl��~ձ��Xz�)ur]�_��dU�ǋ���������a꬘���vC%"+9"�wx]��SX:��z��l����&2���z:�`6�em{��zt�F�Y�U��J���{�����rFst�U��>�5�Eg*i����a��p��'��DM�j�`*1�x�*����]&	�� c�莮���j����\�D�� �����*�r�q��ͧ������CU�Na� �^\D�5Q��7�Һ*���7��H;l��a܄pX�:��"�q�ꙕڸ~�q>z8���������jVЫDs�}��)V8_����b��gUg�9�l�H�$#cvT�Wp�������\��q�N���sx"Uj�b��]�#�2A�ȩ�����I���wx)�T��L��/\pz^���T�LA������,�EGk�/Z�tb�DpX�W/�pD�[�`�a�"M�ꎜ,L"3Ul��J�J����/�Dg
)^^ю�ՙ�\0�V8bbs�p��@�6U��Z����а�N�]+��4QW�������m�*$��e~D��k]xy�\�U�*���x��$��J�hᬫ���FY�w��{P���nU�E�,�_
u��[�Mn5��8姺H=��}R��)�FQ9��=�s�-�"��X@�h��t��K��װvLc�1��D F��pc�gg�3�[��$��:!��Br. ��>�4X�$1+&JΑ&:E�\o����N&�Kuљ��QI�B�ygk��9-�,ZY`�8찊�6q�s�������wv�i�t8�,M��l�S��i������m�~��0w`]�T��J�ć��&�QQSMG�|S괨ᬘ/��	x�|�o^��f%պy�s����[L��)�8�#���gGܩY�ܳ�e��ȇi���d�xR4bW\��'�%Őߡ�#
ML��g7,7�gV�"�Q�t���~�Y�M�#�'nD��F����k��K\U�ifS���#�,gc��h����l��h(��i�������c�����v��ov�x�w�� q�QX=�8Tu�p%�I>�o���aPV#'�E��j��CX�����[��i���&��S@�k+Kb}<�!�RypL�Y�V������<�EA���V]��1���PE!��J�][)e����W��K����y���53���=�����D����q�p�9$M�Ysn��'�A��q��s]&�SL�5j���j�r�����:����v\\�;����R����w�1c�M��Y>dWV��R�2��.�*a�X���:�R���w�q���Y�V�i��ίҐ�����G�e���:!�Y�EB�9I׳8]W3��dY�E3�������*OJg�l�rNT��H��dygl�6���vs�ꎡOuU���|�}����ST�>p�UUy&bsw�0��1�o�ǫ�s^��Gr>���<B>c�TU�(�/Q8��D��:̨mnɲ�U��"��kUʉu�����d� �"�t���UNƲ-�&ɳ�(��P�9��I�#R!1��K��7��F�qaǺ�ʌ�]��3�[@��Z���z�Dr���z��nϖ��Y�&9�('sf<ꚪ?i�J1M�4�(D����~�0���r��!*�r&c�7]�(*�e�Mі��*�{U��J�/cm�(5F�_���Ug� nЕ\��0��~�O6�,��d>�0ƭ���J��y�_��z�����]��3��	i8|�j>u��;�g����3��+�x2��3��T�L&�wp]��e$�qK���axK%򎮟7q�]���]��R�:8{�JU=\���LZ���|�^��z��RZ��V��i�Nr�?�V��gS�U�=f�2P¥�����'Y4�L���T�O/|RYu7���ckyg���D�g	/��E�5ٔ�,�&⾺zh$~n����dI��Q%�v,��n���T;0�a���4��kT�?�fc~�p�թzR�˼���\ϐ$.O�.JM4�u�u��b�=Lt��z�Ʃ������U�']�Ozd���2�}�HQ�w�S
���6�]�s|�K����[���W_�-��	��H��<W�X
	
�+i�8;A�q�B�Y�Yp��f��.�n����yG�׳b���qO��C��8����򎬟BB����Ki�7w���v֘1��	/.�goc�����S����YKm"�6���(	�^�Jz��Ed5��{D�B�C�7���Қ���`�M���z�_���E;��eX��Gc���c\�!����K��+b�g�O�+
�wes�:�~�
��ls������f� ���Y��V55Y�t�P��;����ޑ�S�g\|}���ơB@�4X�z?Y�Rj3Q�RP�7|V߰z
��.'�D�El�f[}�02�`�T(2�׿���(���E-�f�X�A`1}V�7l��H��VX�5�4QS�~pQ ��0x^�c��o+�2���Ʃ�9We?+�UZ�(�q��hƸqu�&���(¯���� HQ] �p`�g2�����\�[�m������U�c9�T��w8����gO^3Q	����l���x���	�Uu���cWg���s��{��L�b�JI���VWg�6�����'ߪٲܿ�һ�+m a)LK3)�."Ѩ`���Yl�q�"����Ω�0][�BC2�nѯ(Oz1KCr�K[�ծ+���N�GrJ�tT���{��L�9��C��ج s�IԹ���(���%lWa:�46��L�!�[�,��$�Ls��~�`U���S��$=HsB�M�V�dd�HuQ?\^� 2�?��f20�__�J#�*��������,-�k��sn%��'�㪨����{��u�A����:�X8r��ɉ��^��W�=���[�G�O@��=8�R�3$7�S�gPY�2<�5X1(U��|�)�3�hV���2��P�Vx26�	�r'P�Z�Q���-賖��6{s���v0���P��;�@�����'W���u;\U�C4�y/�5��sB������A���#�[��z�ɩ��˝]<�r�����2�V5c�c߫�BU�C�g��
�q�P��ݖ~D���Cg�P��w�� v�X{�a���r;k���N�����g�/K�8�y;�t������Į�:��'<k���~�M��q��.F�"�<�����
�9F7IӖ�$��M؎�C�8:o��&
U���>�On�Vg'}=H��k&�̩_�QU�Y�W����#�ړ�������#-�(.�@����q�Ԋ��#�8��D��r�r��g.4e)l�W�#�=��k~��J�¬ς+�]��Oe�@ꬻ��t��3�՝�ͯ4��p��*�?3����_�E[u�a5�]���nW~�}-��*�QW�g�|^��e����sDO�b����[��w��s�����oru�
�8G7Q;�m���ַ'x�9�"]�O6orlξl�~�4W���[�L;^,������zb�=��9���@M���QUU�v��w�`P擃���gU
0�X�71���Ul`98����kL�E�� �dTǔh�р��REg����6�u�~�+r\y߽�h�
o��cJf���N�c)޸8��3����N_nd^i"V�qh_	�@uF�0    B ε��X�N��,.�:�j{6�p���׫Z�4n-��qG��SUͭ�оs�(��gD~F3/�֧�.�5��(����n\��S���Y��GuQh �;�	͝�ӡS��A�ysh��8B���:_�ԨN4��]Tǳ���A����Ls��t�r�	[D�_T����c���$]�s�:0��/P55y����?�$ZʵBAm�/P�ߚjf�g��DGe��t����������w��fD��O��j�(ǴZ�a��g�;WWs��:��c���f7Y3wǨ|tGթBf�Uk�E��mqe���J=���8���� 1��U���aր��&:}]�r���E�o��_��+�B`2}U�Pu�-8z��_QW�f�s��R90ݦ����#�p��Rꓻ��M}�(T}ǵ�ɳ/\�af�2�Z��N+po�x�c��rXdsʭ$�J�85�3՟���J��F�rZ��j�͆��"��԰F�� }�76X��n]5��o�&�q�=�+-H�]aV� U�A�o	�Ah��J)5�r߰Ҽ��As���#VM�2L���F*��3�F��j��`���4��T�D~����v��q&��t��$�ƽ��z�@dFi�H��5n�_'�4�e�Y�J�z�l��vo<��x�*a4Y�&:;F�PX=0<�^���e�yp]�p�8�3�\O5Juvy{�ҸxP\Z�����O�5�0Q�����G�S1L.���~<"�V������1�N�,m���e�t���)�s�k�L�&�fS�)���c�5�"�s�㆖�Qe���(�Jvq��Y�6⤨͠�Ϊ4��p;�^�$$>�hci����Y�N`��nV�F&�!� �0Euj�IP;�n5��)����;�~��x�F��zH�ŏ�h>+STg�J�x_b�Dg
�l��UmO�0�nY�Z{�Xz7W�<�J�qD
�n�����S��i���鄅�l�uM����T�4�i�a�c���DM�&�p�1]Q5���?'G�4ۋ.��oP
s*��W��]�Y�.��+��ן�ͭӅ�&jy&�p��g\��S�x����=�3���O�v�霎*-a�whT�Ŗ���,�+��Ka��C���|�[�>c��*�@g�2��:�_���;D{j�d�K$o*������BU_&��D�pщ��X|T�퟊��CE~{��?�]9�1$����S
�n��N�Wp�3~�2euP�*D+w�G[��i�$�^�r\i�*;/{��&�8Y��˻LY)�B��G,�J�ke��3��J�͘����i��W�)�T��15��˝-���1�ǆx� �Tr�j��JV����8x,�������[��W(��t�v�O)�?q���1�ZD���z�Bq�\�����Tj=r;��O��v�&j��!-�V?ay�,�,��3�J���
���ǫ�&�3O���W\�Ofi���ۙ�^�J8����a�gVc���Hd����b8{��=�A��
m�D]��=�Iy�V�wL���a]G4�ʺZ����^���8b
��;w����E�I���U<��,��%�v%jZs59�9?󎬟�p�;	�2�}��դ)�B�i�����	�$ǳ��A.��f��S�2�6Q�5�9)�,�������E�p��r��y��|��{���u��c3q�V}�m�,��7\Ϛƫ��g֩��S[�I��E��jg/`�ǿT����M�
T��Y���IRS�7�NE|��ځ�\W]�C
��K���c�J�xA�Pu�����:+��g�@}AR��� )����Ne?d���qصթub�}}��T��M�:9��jj�8j]��"V����(�5P�I�^��D!%P	0d����P5f��o�����c������Sa&h�(�7�ޞYT�-f̣�0Q���s�謆�Ҟ"�'�;�ٟN4����ٌX���­��_ѩ���aĳ�z�$�.�,������G|e�kB��p��Ӏg-�*n`�g��<iϸ��o�ڶ��:��V�p�U�{����g�����rm��j�m����E�
�jnC�	���5Q�+Xg��?tU��# |a�8�H��uX� ���'Eg��JN���Qu���@k�4Q����Xu��[���|Yƾ��J���s�;��c��[�&�Z��&���Js4�L���u��rz�T��ifwX�w��Y���䳥��W�;��:2�4��-�O�-x���u�����/��;cPԪ6:]w�@;�3��?���j+Rf7eŬ��;.����)�Qu�"N�v^&z�Ŝ�ǳ��U�F1�Nt/�����|�pe�Ϯ ��7�E��1/~8��Y��Z�K4sք9�/P���Ne�a�~f��?Lvb�vm�Ҳ�(.r
�G�`CL�{l���I���p8D��\C�ru��L3�x���LR�����v�=q�a՟�	�;V����ؒ�X�^�UQ�oc���VEe����C���х��y���U������5��3�qU��W���֯?���܂��Y�կ3���]�Θ�dc�������{k�XZ!K���K<���y�a1S�{�(5�,�m��� �a#c�Ͼ����4HrI���מyY����,Zi�h�Ժ�ε| V��B�׆�3�D!k��}2���|Y�mO��u]��U�#�g�Rg#�����R�r�M�V�3���M��i(�ڔ�ew�]�:u���2.�Њk4��-�a���?5ʻ��l*׀�,|C��z��G`��4�x�%�zi�Ms�<{`82�~ѫ~�̺m\	����ޛC<V��LD/��K�#���Rw4G>�ԕj��������$9N�l'q��
]u��5|E��:6�(6l��`jLd�;�������[�פ�!�Za����l��]�E��좋\�B�O��6���,���~��}���	�ۛ&kk�e��̺՞%�8�������J�6�9L����[��^��ڜ����6{��tX��,���5)�Õ~�\���ݏɌ������IX"h��R��)�l��rUK@��qN\)�߹*zuK��	w9����J��_Ɨ��N�� c�s:���2�sW[&9d�G��P�4A�����*o��cZ����$t~�������������:�p����h&9+���R��� �����h>��:�,xN�!�^��7�R1M����N��rH-A�r�H��1��Z�ʡ�s]�:�ʕ`��f�'͡��e�u]5���j.�ܼK+|���D%���ۍ���úI표��AԚ{��n�8[`������>-�x���s��%4��u�}���T׍�&Dr��2���a �46�U� љ���Z7w;��)ҁ�VnE����T���K�4a�m�K�U�lZa�hb�7� w��I��:�,�a�g$���SS}\W������,�fWӟ&�g1&���W�]%�$"��%\����a��� ��AkS��r㙐D�7�<�~�g2�5f�H->�\�
gy����ĸ�ߵ0G�ҟʊ�������꩹^��ޖ��>+�8>鳊��&čk�d��ܜܥ0>����jU�/a��P0#f�V1\��ʚ����H���%�|�om�5�v���ly]4�<�:D�c��%�R�`p���>��\� ɍoV�����%����3tog�[$Z,��Y~�^��mL�vE��:��+x6^!v%�7����Wt��"I��+�~�~�b��6�g�=bx�P��#��(�ђ��=Ҡ)�\�a��˳����gV���U���B��p���F^�/���Jи���%]j]?�����ҿf����������?X�����EqV��=��m8�J���,�6_��[�����/Q��<G�ҁ��YJ��?غ��˴�A������(�.r�N�n"*vz���\͔�).��K�'����`�F�g�UG��u�,�۩�9B	�+q��B��#G��Y0`[��f����С� ��8+��`?��J۪	�v&v@����`e�|��6;ͅUۻf���&V�nw�(�;7ke>��:�l6`   �W�f��3\�����GA���%:�'Y�Kg_Ī<�`����<���N�`*b�T��]�u�1Ro��T�wan������k�'��S'��U��P<�xx�1��.V������H�� ��n��ڷ�9Oq�y��lͺ�_?;SZป���S3�qC���S~�q�>�I_�D�,�c	����g#�8a�Z�U�و��@�q�`���
�֦��$��l��p�������0����Y�4�ie���Y�̚R\&�O/���x��,�����j���p�4
�R%Nђ��Lrz�/DΫ�yۙ�h�$=<3ˆ��[���n��e���
:��OV��j�S��hW<�&�wec��W��Bwi�#Rg%k�x��pu6�1�|N���L\�᪩��Q6n�Xj4(���s�QH�U=JѤ��r��g�j2'^?Й�a"��q{7��W��0�w�a�����Fc\�tX�$����6Q���I1+WZ���Gq�n�<}��-8�хx�q��m�fr�2L�+���9{q���m�Y�ʯ�X�gN�X�:��Z��N�R���Yv�&R�������Eu�4��k:M��ޣ�n��AS���?���g�[
��u@r�aյFp�"x�<���H7���VV�n��kw(���n�k��oe*5[(��R �t(W�u#(V��TN8s�8��*_�?bVJ˂,.�����m�곆���@?|�]��Tֲ����8�i�j�3��f�b[�P`���Q���јV�D�~捕������$�����hh�)�\y�E��o�C�+z+Q��J�Õlr:��Nb�1w�z6&ـ�6�5X'���x�,~��m���%��'�N���[�<[OBz뎯��2Va�a"BG�x��5��k�]��DM�c��	<O'WjLb����W?A��}[A6Zr�S��򙜯 ��g�rv���Of~��J��$���|��2�'3n#x����@���z��td����o�Wt�ű����c�Pz5��0�gi|�A���yN�&�J�J0���b��.�sݼ��z*J�A����L�M���/�|�E�E�+�.�H�Z��˺��M*�ZaY 9os�h�����{�����eWw#5���4� U�7�A�j��H9�������{Q�,�и�1�|JW�X*������:쪹U]UK��ؽ�am�V�$�����	�:I~�7���|�pR�l�h��X��d��M8�JI�
,j�"Ͼ��q��~��8H���w���7���RNmj��,��m{�}P녌\���d���̡D}e./Wn��F�-Y2ܣ����̧L�h*�z�Ա5-wnCƩ���x��]�^4�a��'����F� v�G�AV���4�1��+<��*�WX!?�v9����{���.ήT��y�����g��\�]�j:0]���&J�.m���x���Т??����C;-
Gf��?"��\�&9��%��t�v1#�g�*m��P����j6��]=r��ꑣ��ݺ�P�����Z�5v��E���1����]���]�:��43�-9�pW�U�ˈ�z�.�S��O�r���ph�_\m+"Pm�֠7ֵ����E����m��r�V�Ϯ�����6v��2]4gg��g{���g
��mޙ�֟��ɽ��U�<�������t�$չd���1�)����s�(U��xp{wsL�jԢf�=M�2cx�t]w{c�4n�5���T������Q�ĥԪ��DJ�s�A��������|�unf      e   X  x���m�@C��b�G/鿎�	��lE���U��K��lF�N�������r�m;;?�kujKes,��pi����֤�ʌ�LlEr�wG�}^���蝸��<l�S*��{U=?��̸��\����Z Κ޷�����!>������-(�<P�Ƿ$Tw-Y�aJ0!>{��ʅN�~��[ �2[s����U�H��.i�Q�s
H������7٧߭�f��װ8�2�Y&r~�];S�@�.��ȴ�X�T\PP������_ܜO��:�yl��U��3�a�7�카L��M�&��n��Vң��2)�({7mP��KrG1��A�<����I�6wq,��䁻=i߶����<���:z1T�"2k���s�N'"���-��'7ә���:��� ;�����Ո �W����?��Y��˰1~��1�S__��q�3_F[3�{�p��5"�:v}�D<���B�ڮG;�{o@	��|��W��
��	��<'�觛��]E��]�`C�E�ڠux
�EXv�C���y�uC��8��L��F���`� K��E�#Cʒ��} �m=V��.�G\Z�� W�K�#��������      o      x�m�ّ�D�U�Lp_��;NB)���U� ).X ��T�U���B����+_y�/X�r�q���W�����k^sF���+�k����5�FkW���GR�%�?klӈ��B�eM�8�d�L��p����>����b�	��z���4��֤�L�, 5�T�_�#�v�����{��N�m�>F��>x�k��0m��Nf�l�p�Y�4�i�A-�朂b�l'�F�fC�T���v\�~u���ḇ�/�d[S[�r`G�m �T���g��l��l���fz/�m�gP��}��i���N���Y��B����;Z�o~��Tl��[z���c�y1��E��v��G�/Q�~������ls���=_�1�������+��*�����f'5���`�u��iᶵW3�o}ᨉ��+`5��>TιF�f�S�P�	&�� )C�&���j��ImkE�f�G����^�RHɆ����&iU,ÜD.#�Չc�8�h�������l�~Q������ʆV����(en��,x��o�jhdaϒ�k�\ɴ(��z��j��6W��b�/}w�6x�2lo����m�	 ���47�c@u�<�YQ��ѺlR��B�r��<�8Du�x�\�wNضה�V��Ԛs��܆iZ�l=�z4������|�-�GOm�U6�8}�I�x��q���j�D�0��0�H�`CXk/���Mhx���/8-k_4����$f<(�k�Q`8�o�\��B]3���^kV�����돶�_�3��o�����O����
����H9�����?u#�-\��&�����~��9+���i	��l�gCٞ���7|���`Sǅc����P�+'<�$�Ͼl�ڙR|;1��#�3�b��2c���[x���w~:��₸	*|��'X������X�oI�K�٩��&§�܏c���Z���xq7��ӏ����G�٧5�xK�����^͂@~�	R�E��fDK��V��������è�}��9����0C�{���L�A]pf��F[ی���9X��h��D�b�;�^fa��8'�(�;�% 见�`��j����2ǆ3�n
jx�w+fK|w�v���ŋ���[}Q� 'lJ���jjg!���6�T�`(틣̓ ���� m���� ��^l 5��G闇6�r�)df88�ș�.x���oc\~�F&Q�*���@�K=P\0^���3{�Pa8.x���a�����r�� lp瘋�X1���#j ����\)�q +�t���
�[8�i����YXi��Fya��|h�ۗ%y(� -�o� v������i�0��$oo���}�O�F}=(�rpm�o=��N�k�e6��n�e!��޵o�1�-��+1�����Tqf3�lۉB����M��`�$撖@y	nA�S'H>���U,s	8�;(=����rVFiRQVh��b�;�"j�c��î8MS,���^6�pA�b��� m�!�b��վ��p�,��'|�/�b$No���ɛoÈO����e�wv���$X�7�����DK���z,�e �A'4������'`�7�C�� �2ۅ(��	y�H��W�Y����4s)�Y`4����8�܊*4P�%�MO�K�#�Dlپz%ơc��Ѝє-(B�)��M�vC��μ0&g��#x�p�z�CX2�	Xti�Qɺ�A�JJ6&0�������W)|9�k�#���6�����&���)���8����&<�Tlü[���H����c�֝���U,�f���D6\�+y��6/���໲ҡ�HJ�̿84�x�ړ��������#q<<� ezy5�e+쵠�����4lZE��Zu�0���+P�C�����X�v*	e����D(�T�h�}����C��� �$��#зB$c�p�^�+"��[������@\j7�&p�Iz(i��%�.�r�U��i>0�YI���p�74�h[";`
&�;̦��]eE�2z0�3����8d0�"�r�?P��\�7��{�'�3+B�=!*�#��A-l8�9Ӹ{�M"�R~:�7P8�vWR�&��V�l(*�H�4�!��R���^6ɔ�l=:��<q<� �n�t	��]���5�6��Sg�^3ؿ��fҀ'�(;>p1��i,����@x�J�OQP���@����Q��Y�g��S����T�۾�����{�;�
C�V/�p�fT}�)����Yͩ�,E"����������$��9{%~Nx�)�̅����O�����ˏ�2���L��e��§�I�ݟJ���T�`��`�	��T,k�AnZ�K���`�U�(q�K�ۅp�)���v�'Ŗ.QԭQ�҇5ha��Gɪ�!��V|��'�<{`�9�}�}�!6<w�+.����aǦ��J?�u3��߫�u6�.�;�l�~l��g:{s��XO�xɎ�9���6Ud���O4ƒ�&������tX:�\�_|��L���+�X��M��DyMe|q7S�Xu	HMU���y���@�:F>�8"���S��pd����mé��Nf�j���@��b��N&9d��mim�$3'�b	%���\��?^>�_Wq:� �����J\W��v���
�o�G�D�:ƿ,�c!Px�/��v�1|��J��$���t�"����v֡�5��XB�m'A�w]�eAQ��#٢�q�P&gȬq�q�@w��u�V�tH��(Y�yz��5�y4�E��"��밳nÊ-`�b��ίϺ�RQ"o���8�C`�֯�G�z�V�A�q�A+Q/N�� 7Y�7�2�0;���p��e�q��d���.͖��r ����R�� X�2*����F��sn]TO�6|�h���}$Ռ �GՌ(�R���D�z,]�*sN��V
+��c��^�:G��UE���֛XZ�����O��%�8�m�`L�D��$w9�`�����+��QY�Ff��mӭ����³���6���g�I�\�ZZ�4��M6���Y�kWTKZbe�Ô����0^���5\�&��a�'�K�.o~|��C���*&�V�ա���c�u�*~�wq����v�2�7c	^�k� �m�+q��-(<�5|/��h.e.�&�(:�% ���;H�^����4a���j^��fk�ת��;�.^�S��}x��.�K�wp��Ҷ.Q�O��S�gf6|&@���@ K}��0�`����^~(�دc�bU�U�~��J���EE��	�p��U9�����	�z�}��M{)W�MG�Nl���܃RBa^T:�˪c�(c�e�1���\epi� a�:7��B��%I|1S_��,\|q
{{.3�9n���s�m����+�`���JQ�Hd�������Q؜��a�L���an<cS�ts&��`r�]�����6�C�0*��/%)�|:	��*N>�Tk�5�"ŢTm�z��MV��P�1�T�V.+L巺��nYM�?S�ǭ�3a3��R2x�N��Z�ߌ��M�q��P�I��ٙ5��
�Ζ>�qr���n�m����'�5�.x�JG(���� �$z1�O���6��n������t%��c'}�j�'/C��3��{���ݏ�
��η�5I�H>Ȝγ=QgS A��̦�P2l�+�� �d��.e�D�����C���V{�Χ�O���ίk颍I.!m�B����I�Z�g�;��\}���1���T�e�~Yp���]�=E�~��&�)���6�i�������T������#�=��xy��#��Ls)��uxl��h�q����jI7�/Nf0��m���
����q�z��Nc�E��޹p����0��������8յ�}gǷ@w���pY���g�;&.~2L��Y"n:a����_NKa>�	����z��ö,��⊬d*G{�r�b)���ӭ�N)�ˉW� �N^�~%���\�=�E�)�!��g�K���z���˧��[������t^8�L� *�c@j�,VUzjz �   ���.�.�t�z�������\�|_T~Y�v4)"���[��
�x�EJ��0+j�U� �p=m|�ќ`��/I��t�FR����Ϧ�.��_��{�JN~Q?`��h��LcÓ�f��1��A܍���k�!�޼��P��b����d.XeSr�g�u���P��=�^e�.��U�P��
�-�Q����^�Y���������     