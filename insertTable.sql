
        insert into PASSAGEIRO values
            ('66666666','lucifer','2000-01-01','office@hell','NF'),
            ('17797797','Quim Roscas','1987-05-19','palco@vox','M'),
            ('87654321','Zeca Estaleca','1987-05-20','also@vox','M'),
            ('74281234','Abrilhantador Fairy','1999-09-09','lava@loica','F'),
            ('23845211','Tito Lasanha','1956-04-30','probably@italy','NF'),
            ('64728729','Paulo Robalo','2003-12-27','swimming@sea','M')

        insert into LOCALIDADE values
            (2650888,'Amadora'),
            (1325984,'Bairro do Cerco'),
            (1975634,'Vale dos Lobos'),
            (9874652,'Seixal'),
            (8997774,'Rossio'),
            (1111111,'Portas de Sol')

        insert into AUTOCARROTIPO values
            ('MAN','City C', 102),
            ('MAN','City L', 124),
            ('VOLVO','9700', 46),
            ('VOLVO','9900', 60),
            ('IVECO','12.8', 87),
            ('IVECO','PRO', 150),
            ('TEMSA','SAFARI',68),
            ('TEMSA','METROP',68)

        insert into COMBOIOTIPO values
            ('AP','alfa-pendular',50,249),
            ('IC','inter-cidades',100,220),
            ('IR','inter-regional',60,100),
            ('R','regional',15,100)

        insert into LUGARTIPO values
            (878,'militar',1,10.8),
            (884,'crianca',2,3.5),
            (468,'adulto',2,5.3),
            (223,'adulto',1,17.6),
            (321,'senior',2,4.5),
            (322,'jovem',2,6.2),
            (12,'jovem',1,16.9),
            (964,'militar',2,6.1)

        insert into ESTACAO values
            ('Amadora','paragem',4,2650888),
            ('Santarem','terminal',8,1111111),
            ('Urbanizacao','paragem',2,1975634),
            ('Vermelha','paragem',3,9874652),
            ('Agua Doce','paragem',5,9874652),
            ('Baixa', 'terminal',9,8997774)

        insert into VIAGEM values
            (645,'2021-12-05','14:00:00', '16:30:00',120,'Amadora','Vermelha'),
            (456,'2021-08-15','11:00:00', '17:15:00',600,'Agua Doce','Urbanizacao'),
            (768,'2021-11-19','09:00:00', '09:30:00',25,'Vermelha','Agua Doce'),
            (123,'2021-06-30','19:45:00', '22:05:00',300,'Santarem','Baixa')

        insert into RESERVA values
            (2231,'2021-11-19 19:00:00','MB',645),
            (8774,'2021-02-10 07:30:00','Pay Pal',768),
            (1357,'2021-07-05 10:45:30','CC',456),
            (9348,'2021-05-23 12:15:45','MB',123)

        insert into TRANSPORTE values
            (2,645,100,'2020-01-20','A'),
            (3,456,120,'2020-09-15','C'),
            (4,768,90,'2020-04-19','A'),
            (5,123,150,'2020-11-30','C'),
            (6,123,140,'2020-10-29','C'),
            (7,123,120,'2020-11-14','C'),
            (8,123,125,'2020-09-03','C'),
            (9,456,130,'2020-08-21','C')

        insert into AUTOCARRO values
            ('CF 01 RF',2,'2022-03-26','VOLVO','9900'),
            ('BC 97 HD',4,'2022-02-02','IVECO','PRO')

        insert into COMBOIO values
            (3,'AP',8),
            (5,'R',3),
            (6,'IR',6),
            (7,'IC',4),
            (8,'IR',5),
            (9,'AP',7)

        insert into LUGAR values
            (217,3,878),
            (129,3,884),
            (997,2,468),
            (1445,4,223),
            (8888,5,321),
            (350,4,322),
            (481,2,12),
            (6874,5,964)

        insert into PAGMBWAY values
            (2231,'+351910654852'),
            (9348,'+351964710325')

        insert into BILHETE values
            ('66666666',217,878,3,2231),
            ('17797797',129,884,3,2231),
            ('87654321',997,468,2,8774),
            ('74281234',1445,223,4,1357),
            ('23845211',8888,321,5,9348),
            ('64728729',6874,964,5,9348)

        insert into LOCOMOTIVA values
            (465,5,'Stadler'),
            (897,6,'Roco'),
            (145,7,'Stadler'),
            (345,8,'Medway'),
            (741,4,'Mehano'),
            (648,9,'Medway')

        insert into ALFAPENDULAR values
            (741,4,8),
            (648,9,10)


