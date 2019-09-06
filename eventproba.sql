PGDMP         &                w            eventify    11.4 (Debian 11.4-1.pgdg90+1)    11.3 /    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            �           1262    16384    eventify    DATABASE     x   CREATE DATABASE eventify WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';
    DROP DATABASE eventify;
             postgres    false            �            1259    16385    ban_info    TABLE     �   CREATE TABLE public.ban_info (
    id uuid NOT NULL,
    admin_which_banned_user uuid,
    admin_which_unbanned_user uuid,
    from_date timestamp without time zone,
    reason_for_ban character varying(255),
    to_date timestamp without time zone
);
    DROP TABLE public.ban_info;
       public         postgres    false            �            1259    16428    event    TABLE     C  CREATE TABLE public.event (
    event_id uuid NOT NULL,
    description character varying(255),
    event_date_time timestamp without time zone,
    event_name character varying(255),
    event_type character varying(255),
    profile_picture character varying(255),
    source character varying(255),
    place_id uuid
);
    DROP TABLE public.event;
       public         postgres    false            �            1259    16436    event_hosts    TABLE     b   CREATE TABLE public.event_hosts (
    event_event_id uuid NOT NULL,
    hosts_id uuid NOT NULL
);
    DROP TABLE public.event_hosts;
       public         postgres    false            �            1259    16441    event_prices    TABLE     [   CREATE TABLE public.event_prices (
    event_event_id uuid NOT NULL,
    prices integer
);
     DROP TABLE public.event_prices;
       public         postgres    false            �            1259    16444    host    TABLE     3   CREATE TABLE public.host (
    id uuid NOT NULL
);
    DROP TABLE public.host;
       public         postgres    false            �            1259    16449 
   host_names    TABLE     `   CREATE TABLE public.host_names (
    host_id uuid NOT NULL,
    names character varying(255)
);
    DROP TABLE public.host_names;
       public         postgres    false            �            1259    16452    place    TABLE     �   CREATE TABLE public.place (
    id uuid NOT NULL,
    city character varying(255),
    latitude double precision NOT NULL,
    longitude double precision NOT NULL
);
    DROP TABLE public.place;
       public         postgres    false            �            1259    16457    place_names    TABLE     b   CREATE TABLE public.place_names (
    place_id uuid NOT NULL,
    names character varying(255)
);
    DROP TABLE public.place_names;
       public         postgres    false            �            1259    16390    user_account    TABLE     5  CREATE TABLE public.user_account (
    id uuid NOT NULL,
    email character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    password character varying(255),
    role character varying(255),
    sex character varying(255),
    username character varying(255)
);
     DROP TABLE public.user_account;
       public         postgres    false            �            1259    16398 )   user_account_event_ids_that_user_organize    TABLE     �   CREATE TABLE public.user_account_event_ids_that_user_organize (
    user_account_id uuid NOT NULL,
    event_ids_that_user_organize uuid
);
 =   DROP TABLE public.user_account_event_ids_that_user_organize;
       public         postgres    false            �            1259    16401    user_ban_info    TABLE     <   CREATE TABLE public.user_ban_info (
    id uuid NOT NULL
);
 !   DROP TABLE public.user_ban_info;
       public         postgres    false            �            1259    16406    user_ban_info_ban_infos    TABLE     t   CREATE TABLE public.user_ban_info_ban_infos (
    user_ban_info_id uuid NOT NULL,
    ban_infos_id uuid NOT NULL
);
 +   DROP TABLE public.user_ban_info_ban_infos;
       public         postgres    false            v          0    16385    ban_info 
   TABLE DATA               ~   COPY public.ban_info (id, admin_which_banned_user, admin_which_unbanned_user, from_date, reason_for_ban, to_date) FROM stdin;
    public       postgres    false    196   8       {          0    16428    event 
   TABLE DATA               �   COPY public.event (event_id, description, event_date_time, event_name, event_type, profile_picture, source, place_id) FROM stdin;
    public       postgres    false    201   68       |          0    16436    event_hosts 
   TABLE DATA               ?   COPY public.event_hosts (event_event_id, hosts_id) FROM stdin;
    public       postgres    false    202   $;       }          0    16441    event_prices 
   TABLE DATA               >   COPY public.event_prices (event_event_id, prices) FROM stdin;
    public       postgres    false    203   �;       ~          0    16444    host 
   TABLE DATA               "   COPY public.host (id) FROM stdin;
    public       postgres    false    204   U<                 0    16449 
   host_names 
   TABLE DATA               4   COPY public.host_names (host_id, names) FROM stdin;
    public       postgres    false    205   �<       �          0    16452    place 
   TABLE DATA               >   COPY public.place (id, city, latitude, longitude) FROM stdin;
    public       postgres    false    206   =       �          0    16457    place_names 
   TABLE DATA               6   COPY public.place_names (place_id, names) FROM stdin;
    public       postgres    false    207   >       w          0    16390    user_account 
   TABLE DATA               g   COPY public.user_account (id, email, first_name, last_name, password, role, sex, username) FROM stdin;
    public       postgres    false    197   �>       x          0    16398 )   user_account_event_ids_that_user_organize 
   TABLE DATA               r   COPY public.user_account_event_ids_that_user_organize (user_account_id, event_ids_that_user_organize) FROM stdin;
    public       postgres    false    198   �?       y          0    16401    user_ban_info 
   TABLE DATA               +   COPY public.user_ban_info (id) FROM stdin;
    public       postgres    false    199   @       z          0    16406    user_ban_info_ban_infos 
   TABLE DATA               Q   COPY public.user_ban_info_ban_infos (user_ban_info_id, ban_infos_id) FROM stdin;
    public       postgres    false    200   3@       �
           2606    16389    ban_info ban_info_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.ban_info
    ADD CONSTRAINT ban_info_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.ban_info DROP CONSTRAINT ban_info_pkey;
       public         postgres    false    196            �
           2606    16440    event_hosts event_hosts_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.event_hosts
    ADD CONSTRAINT event_hosts_pkey PRIMARY KEY (event_event_id, hosts_id);
 F   ALTER TABLE ONLY public.event_hosts DROP CONSTRAINT event_hosts_pkey;
       public         postgres    false    202    202            �
           2606    16435    event event_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.event
    ADD CONSTRAINT event_pkey PRIMARY KEY (event_id);
 :   ALTER TABLE ONLY public.event DROP CONSTRAINT event_pkey;
       public         postgres    false    201            �
           2606    16448    host host_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.host
    ADD CONSTRAINT host_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.host DROP CONSTRAINT host_pkey;
       public         postgres    false    204            �
           2606    16456    place place_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.place
    ADD CONSTRAINT place_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.place DROP CONSTRAINT place_pkey;
       public         postgres    false    206            �
           2606    16412 4   user_ban_info_ban_infos uk_6hoq8ktl2jke8kum83tral8in 
   CONSTRAINT     w   ALTER TABLE ONLY public.user_ban_info_ban_infos
    ADD CONSTRAINT uk_6hoq8ktl2jke8kum83tral8in UNIQUE (ban_infos_id);
 ^   ALTER TABLE ONLY public.user_ban_info_ban_infos DROP CONSTRAINT uk_6hoq8ktl2jke8kum83tral8in;
       public         postgres    false    200            �
           2606    16461 (   event_hosts uk_b6ubvfk5koxf8wkg3cvk06k7s 
   CONSTRAINT     g   ALTER TABLE ONLY public.event_hosts
    ADD CONSTRAINT uk_b6ubvfk5koxf8wkg3cvk06k7s UNIQUE (hosts_id);
 R   ALTER TABLE ONLY public.event_hosts DROP CONSTRAINT uk_b6ubvfk5koxf8wkg3cvk06k7s;
       public         postgres    false    202            �
           2606    16397    user_account user_account_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.user_account
    ADD CONSTRAINT user_account_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.user_account DROP CONSTRAINT user_account_pkey;
       public         postgres    false    197            �
           2606    16410 4   user_ban_info_ban_infos user_ban_info_ban_infos_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.user_ban_info_ban_infos
    ADD CONSTRAINT user_ban_info_ban_infos_pkey PRIMARY KEY (user_ban_info_id, ban_infos_id);
 ^   ALTER TABLE ONLY public.user_ban_info_ban_infos DROP CONSTRAINT user_ban_info_ban_infos_pkey;
       public         postgres    false    200    200            �
           2606    16405     user_ban_info user_ban_info_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.user_ban_info
    ADD CONSTRAINT user_ban_info_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.user_ban_info DROP CONSTRAINT user_ban_info_pkey;
       public         postgres    false    199            �
           2606    16477 (   event_prices fk753e0n8mv3rrq75nlg1o9hydy    FK CONSTRAINT     �   ALTER TABLE ONLY public.event_prices
    ADD CONSTRAINT fk753e0n8mv3rrq75nlg1o9hydy FOREIGN KEY (event_event_id) REFERENCES public.event(event_id);
 R   ALTER TABLE ONLY public.event_prices DROP CONSTRAINT fk753e0n8mv3rrq75nlg1o9hydy;
       public       postgres    false    2795    201    203            �
           2606    16467 '   event_hosts fkacnixqko7qjr9rv0q705t9lfy    FK CONSTRAINT     �   ALTER TABLE ONLY public.event_hosts
    ADD CONSTRAINT fkacnixqko7qjr9rv0q705t9lfy FOREIGN KEY (hosts_id) REFERENCES public.host(id);
 Q   ALTER TABLE ONLY public.event_hosts DROP CONSTRAINT fkacnixqko7qjr9rv0q705t9lfy;
       public       postgres    false    2801    202    204            �
           2606    16487 '   place_names fkefysvuphmp102sxuatlst31c0    FK CONSTRAINT     �   ALTER TABLE ONLY public.place_names
    ADD CONSTRAINT fkefysvuphmp102sxuatlst31c0 FOREIGN KEY (place_id) REFERENCES public.place(id);
 Q   ALTER TABLE ONLY public.place_names DROP CONSTRAINT fkefysvuphmp102sxuatlst31c0;
       public       postgres    false    207    206    2803            �
           2606    16482 &   host_names fkfrdsh91aqa65fhre5tlyx069o    FK CONSTRAINT     �   ALTER TABLE ONLY public.host_names
    ADD CONSTRAINT fkfrdsh91aqa65fhre5tlyx069o FOREIGN KEY (host_id) REFERENCES public.host(id);
 P   ALTER TABLE ONLY public.host_names DROP CONSTRAINT fkfrdsh91aqa65fhre5tlyx069o;
       public       postgres    false    2801    204    205            �
           2606    16472 '   event_hosts fkhd60cbx40ejbbp2fxc4oyn010    FK CONSTRAINT     �   ALTER TABLE ONLY public.event_hosts
    ADD CONSTRAINT fkhd60cbx40ejbbp2fxc4oyn010 FOREIGN KEY (event_event_id) REFERENCES public.event(event_id);
 Q   ALTER TABLE ONLY public.event_hosts DROP CONSTRAINT fkhd60cbx40ejbbp2fxc4oyn010;
       public       postgres    false    2795    202    201            �
           2606    16423 3   user_ban_info_ban_infos fkmyh6o29etou289oxhrv2dgwuu    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_ban_info_ban_infos
    ADD CONSTRAINT fkmyh6o29etou289oxhrv2dgwuu FOREIGN KEY (user_ban_info_id) REFERENCES public.user_ban_info(id);
 ]   ALTER TABLE ONLY public.user_ban_info_ban_infos DROP CONSTRAINT fkmyh6o29etou289oxhrv2dgwuu;
       public       postgres    false    2789    199    200            �
           2606    16462 !   event fkpuvix4lexrakgdlt8si1tbtxv    FK CONSTRAINT     �   ALTER TABLE ONLY public.event
    ADD CONSTRAINT fkpuvix4lexrakgdlt8si1tbtxv FOREIGN KEY (place_id) REFERENCES public.place(id);
 K   ALTER TABLE ONLY public.event DROP CONSTRAINT fkpuvix4lexrakgdlt8si1tbtxv;
       public       postgres    false    201    206    2803            �
           2606    16413 E   user_account_event_ids_that_user_organize fkr6xdyvrkoqkvdclvs0fmgk7fv    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_account_event_ids_that_user_organize
    ADD CONSTRAINT fkr6xdyvrkoqkvdclvs0fmgk7fv FOREIGN KEY (user_account_id) REFERENCES public.user_account(id);
 o   ALTER TABLE ONLY public.user_account_event_ids_that_user_organize DROP CONSTRAINT fkr6xdyvrkoqkvdclvs0fmgk7fv;
       public       postgres    false    198    2787    197            �
           2606    16418 3   user_ban_info_ban_infos fksd6kuemyjaj3js4pt02c59mt8    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_ban_info_ban_infos
    ADD CONSTRAINT fksd6kuemyjaj3js4pt02c59mt8 FOREIGN KEY (ban_infos_id) REFERENCES public.ban_info(id);
 ]   ALTER TABLE ONLY public.user_ban_info_ban_infos DROP CONSTRAINT fksd6kuemyjaj3js4pt02c59mt8;
       public       postgres    false    196    200    2785            v      x������ � �      {   �  x����n�6��W��DR��]�uf'M�4
�8tK�&�v�%`i���0`�@�<�|�����	.� T V�G�O�	*����0��AgBB1%ǧH	����>�\߮��ah��<?�N�����f�iwȺ>?��6��C~h�F�>�����8UBS���o�1�k�iv17�w��JR:ĸP1�
�BS(�F��Qʁ-=b�D*�2���/�w<���M���6��)R5Q��C5.�:����a��8Y�1��߾�ʇl�m��!�0"��<�nlL݄�Ne6�c���L'���JϬ#%�RqD��Ns陰3�
G�)��q`Rid�����DB1O>�������h�~���������W"��0������lf�����g�X
E�m�o㻪t���ό��Ni�pX:�(�1�=RK���b��ɼ;tM:n��~G]�a��@�Ա��o�����n�����9������+�ђb��HqN�3���]�δ�TF5*�F��(�/���������}l]B/��i�=�ڇQ����b�Z����o�vC�/���m�q��|���zX}�����-���]�/����eQ�>.V���|���_�w��e?:�t��8_������}�m���U�m�l+���q��D��nN��@P),S�Y�1�@�,بB�ƔA*��Y#��[\$�
ߖɲ9���E�᥅�6�Cg���߲�l�7N���      |   V   x�����0ѳ�'�Ћ�~�/�T�x��Ӄ� �TR�I�K�D�Qہ�P`5b���}2d@rF@�H�"�7�������E)      }   �   x��ӻC1�:ޅ����.i���gKyR�4TG�
	b�DK�pP��B�l6Z`E�� ,�S͘zm�������9�AgL���3���@}wu�.[Ye���3����Ѻgkp�$�V�C��)Ud5'�Oڭ�u�7���.�1�5e��u >*В���Ϲ�����a)�׳���3�      ~   G   x�}ʱ�0��]�w���Zjcw����\X�Ep��#��*Zӭ�:4��^)��o�6"��� 5         Y   x�K5K1L�0J�MNM3�54L�ԵH���S�R���SM8���<���RS,̌-�*u�tvu�J37J20LMFR��df�a,W� �($\      �   �   x�e�1j1��>E.�Œ%[js�4i��#9vaϟ!�@������.m1u�Á	;L5l�|H_ܶ���ᑨ��̤�{�'�e�rt��.�5;(�J���Vj�́�V�p�#?*JEl��y���wؔp�@ж�o&%��Wx\�vNh��	����־�R
`�&�����5������:<u}i�8�5l�4�^�OP�N{�N�y�5��R=X:�&(�N8��r����e      �   �   x�-�Kj�@D��S�
n�Oچ 0Yf�n�a2�����슂z�J�=bI�(D�*q�����cn�E��=wY]
]c���9H���z4b�U��1�x�E�Os����@#�CB`4�[d���b�ױ��Ksy��j�p���$4����<h��m�`�O��q��Rm7���S2��2T�c*�@v�^q�Z����n�w���c����s���Ol      w   �   x����N�0 ���ܖ
)܉��C�D��G[�"�e{zM����!-q��{�o��8��[,��ԕ-���<��->�c�e�$z��yԪ����t����ٵ{!:f�$�S���U�tPa<W]�e���,��u�-;�{Ƈ�@��5A �I.���	� �;�ܗ�"@�����;_��u�o��Ѳ��\'�.� �N���\�������G�x;����ߖa���`O      x      x������ � �      y      x������ � �      z      x������ � �     