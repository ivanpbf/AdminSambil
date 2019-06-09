PGDMP     .    %        	        w            ladilla    11.2    11.2     8           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            9           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            :           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            ;           1262    65716    ladilla    DATABASE     �   CREATE DATABASE ladilla WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Spanish_Venezuela.1252' LC_CTYPE = 'Spanish_Venezuela.1252';
    DROP DATABASE ladilla;
             postgres    false            �            1259    65735    venta    TABLE     �   CREATE TABLE public.venta (
    "idVenta" integer NOT NULL,
    monto integer NOT NULL,
    tiendafk integer NOT NULL,
    cedula integer NOT NULL,
    mac integer,
    descuento integer
);
    DROP TABLE public.venta;
       public         postgres    false            �            1259    65769    venta_idVenta_seq    SEQUENCE     �   CREATE SEQUENCE public."venta_idVenta_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public."venta_idVenta_seq";
       public       postgres    false    201            <           0    0    venta_idVenta_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public."venta_idVenta_seq" OWNED BY public.venta."idVenta";
            public       postgres    false    212            �
           2604    65774    venta idVenta    DEFAULT     r   ALTER TABLE ONLY public.venta ALTER COLUMN "idVenta" SET DEFAULT nextval('public."venta_idVenta_seq"'::regclass);
 >   ALTER TABLE public.venta ALTER COLUMN "idVenta" DROP DEFAULT;
       public       postgres    false    212    201            4          0    65735    venta 
   TABLE DATA               S   COPY public.venta ("idVenta", monto, tiendafk, cedula, mac, descuento) FROM stdin;
    public       postgres    false    201   [       =           0    0    venta_idVenta_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public."venta_idVenta_seq"', 131, true);
            public       postgres    false    212            �
           2606    65786    venta venta_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.venta
    ADD CONSTRAINT venta_pkey PRIMARY KEY ("idVenta");
 :   ALTER TABLE ONLY public.venta DROP CONSTRAINT venta_pkey;
       public         postgres    false    201            �
           2620    65801    venta validardescuento    TRIGGER     x   CREATE TRIGGER validardescuento BEFORE INSERT ON public.venta FOR EACH ROW EXECUTE PROCEDURE public.validardescuento();
 /   DROP TRIGGER validardescuento ON public.venta;
       public       postgres    false    201            �
           2606    65834    venta venta_tiendafk_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.venta
    ADD CONSTRAINT venta_tiendafk_fkey FOREIGN KEY (tiendafk) REFERENCES public.tienda(idtienda);
 C   ALTER TABLE ONLY public.venta DROP CONSTRAINT venta_tiendafk_fkey;
       public       postgres    false    201            4   ;   x�342�460�4�? �24��417E��43FQ�Y"t�[���,�b���� +n)     