PGDMP         -                z           metadata    13.4    13.4     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    33767    metadata    DATABASE     S   CREATE DATABASE metadata WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'C';
    DROP DATABASE metadata;
                postgres    false            �            1259    33772    chunk_location    TABLE     �   CREATE TABLE public.chunk_location (
    chunk_location_id bigint NOT NULL,
    path_to_chunk character varying(255),
    chunk_id bigint
);
 "   DROP TABLE public.chunk_location;
       public         heap    postgres    false            �            1259    33770 $   chunk_location_chunk_location_id_seq    SEQUENCE     �   ALTER TABLE public.chunk_location ALTER COLUMN chunk_location_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.chunk_location_chunk_location_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    202            �            1259    33777    file    TABLE     �   CREATE TABLE public.file (
    file_id bigint NOT NULL,
    date_created bigint,
    is_deleted boolean,
    is_directory boolean,
    namespace character varying(255),
    type character varying(255),
    user_id bigint
);
    DROP TABLE public.file;
       public         heap    postgres    false            �            1259    33787 
   file_chunk    TABLE     d   CREATE TABLE public.file_chunk (
    id bigint NOT NULL,
    chunk_id bigint,
    file_id bigint
);
    DROP TABLE public.file_chunk;
       public         heap    postgres    false            �            1259    33785    file_chunk_id_seq    SEQUENCE     �   ALTER TABLE public.file_chunk ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.file_chunk_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    205            �            1259    33768    hibernate_sequence    SEQUENCE     {   CREATE SEQUENCE public.hibernate_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.hibernate_sequence;
       public          postgres    false            �            1259    33794    roles    TABLE     V   CREATE TABLE public.roles (
    id bigint NOT NULL,
    name character varying(60)
);
    DROP TABLE public.roles;
       public         heap    postgres    false            �            1259    33792    roles_id_seq    SEQUENCE     �   ALTER TABLE public.roles ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    207            �            1259    33801    users    TABLE     �   CREATE TABLE public.users (
    user_id bigint NOT NULL,
    email character varying(255),
    password character varying(255),
    username character varying(255),
    role_id bigint
);
    DROP TABLE public.users;
       public         heap    postgres    false            �            1259    33799    users_user_id_seq    SEQUENCE     �   ALTER TABLE public.users ALTER COLUMN user_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    209            F           2606    33776 "   chunk_location chunk_location_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public.chunk_location
    ADD CONSTRAINT chunk_location_pkey PRIMARY KEY (chunk_location_id);
 L   ALTER TABLE ONLY public.chunk_location DROP CONSTRAINT chunk_location_pkey;
       public            postgres    false    202            J           2606    33791    file_chunk file_chunk_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.file_chunk
    ADD CONSTRAINT file_chunk_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.file_chunk DROP CONSTRAINT file_chunk_pkey;
       public            postgres    false    205            H           2606    33784    file file_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.file
    ADD CONSTRAINT file_pkey PRIMARY KEY (file_id);
 8   ALTER TABLE ONLY public.file DROP CONSTRAINT file_pkey;
       public            postgres    false    203            L           2606    33798    roles roles_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.roles DROP CONSTRAINT roles_pkey;
       public            postgres    false    207            N           2606    33812 !   users uk6dotkott2kjsp8vw4d0m25fb7 
   CONSTRAINT     ]   ALTER TABLE ONLY public.users
    ADD CONSTRAINT uk6dotkott2kjsp8vw4d0m25fb7 UNIQUE (email);
 K   ALTER TABLE ONLY public.users DROP CONSTRAINT uk6dotkott2kjsp8vw4d0m25fb7;
       public            postgres    false    209            P           2606    33810 !   users ukr43af9ap4edm43mmtq01oddj6 
   CONSTRAINT     `   ALTER TABLE ONLY public.users
    ADD CONSTRAINT ukr43af9ap4edm43mmtq01oddj6 UNIQUE (username);
 K   ALTER TABLE ONLY public.users DROP CONSTRAINT ukr43af9ap4edm43mmtq01oddj6;
       public            postgres    false    209            R           2606    33808    users users_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    209            T           2606    33818    file fke70ql3orpo0ghvfmqccv27ng    FK CONSTRAINT     �   ALTER TABLE ONLY public.file
    ADD CONSTRAINT fke70ql3orpo0ghvfmqccv27ng FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 I   ALTER TABLE ONLY public.file DROP CONSTRAINT fke70ql3orpo0ghvfmqccv27ng;
       public          postgres    false    203    3154    209            U           2606    33823 &   file_chunk fkeotmam8a701pq5xwwm8dpibpv    FK CONSTRAINT     �   ALTER TABLE ONLY public.file_chunk
    ADD CONSTRAINT fkeotmam8a701pq5xwwm8dpibpv FOREIGN KEY (file_id) REFERENCES public.file(file_id);
 P   ALTER TABLE ONLY public.file_chunk DROP CONSTRAINT fkeotmam8a701pq5xwwm8dpibpv;
       public          postgres    false    205    203    3144            S           2606    33813 *   chunk_location fkiyg2r1hiy7pier9nrvxek5jw8    FK CONSTRAINT     �   ALTER TABLE ONLY public.chunk_location
    ADD CONSTRAINT fkiyg2r1hiy7pier9nrvxek5jw8 FOREIGN KEY (chunk_id) REFERENCES public.file_chunk(id);
 T   ALTER TABLE ONLY public.chunk_location DROP CONSTRAINT fkiyg2r1hiy7pier9nrvxek5jw8;
       public          postgres    false    205    3146    202            V           2606    33828 !   users fkp56c1712k691lhsyewcssf40f    FK CONSTRAINT     �   ALTER TABLE ONLY public.users
    ADD CONSTRAINT fkp56c1712k691lhsyewcssf40f FOREIGN KEY (role_id) REFERENCES public.roles(id);
 K   ALTER TABLE ONLY public.users DROP CONSTRAINT fkp56c1712k691lhsyewcssf40f;
       public          postgres    false    207    209    3148           