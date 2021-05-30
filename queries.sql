--ex3 a ex2 a
SELECT dataviagem, horapartida
FROM VIAGEM
WHERE (estpartida in
        (SELECT ESTACAO.nome
        FROM (ESTACAO join LOCALIDADE L on L.codpostal = ESTACAO.localidade)
        WHERE L.nome = 'Lisboa')
    AND estchegada in (SELECT ESTACAO.nome
        FROM (ESTACAO join LOCALIDADE L on L.codpostal = ESTACAO.localidade )
            WHERE L.nome = 'Porto'))

--ex3 a ex c
SELECT B.marca, B.modelo, AT.nlugares
FROM AUTOCARROTIPO AT join
    (select marca, modelo
    from (AUTOCARRO
        join (select ident
        from TRANSPORTE
        where viagem is not null and atrdiscriminante = 'A')
            as A on AUTOCARRO.transporte = A.ident)) as B on B.modelo = AT.modelo
union
select marca, tipo as modelo, nlugares
from LOCOMOTIVA LO join
    (select transporte, tipo, ( E.nlugares1+ nlugares2)as nlugares
        from
        (select transporte, tipo, convert(int,nlugclasse1) as nlugares1,convert(int,nlugclasse2) as nlugares2
        from COMBOIOTIPO join
            (select transporte, tipo
            from COMBOIO join
                (select ident
                from TRANSPORTE
                where viagem is not null and atrdiscriminante = 'C')
                as C on COMBOIO.transporte = C.ident)
                as D on D.tipo = COMBOIOTIPO.id)  as E)
                as F on F.transporte = LO.comboio

--ex3 a ex b
SELECT nome, YEAR(CURRENT_TIMESTAMP) - YEAR(dtnascimento) as idade, nlugar
FROM BILHETE join PASSAGEIRO P on P.nid = BILHETE.passageiro

--ex3 a ex d

SELECT H.transporte, (nlugares - ocupados) as vazios
FROM (SELECT nlugares, transporte
     FROM AUTOCARROTIPO join
         (SELECT modelo, transporte
         FROM AUTOCARRO join
             (SELECT TRANSPORTE.ident
             FROM TRANSPORTE join
                 (SELECT ident
                 FROM VIAGEM join
                     (SELECT ESTACAO.nome
                     FROM ESTACAO join
                         LOCALIDADE L on ESTACAO.localidade = L.codpostal
                         WHERE L.nome = 'Lisboa')
                         as A on estpartida = A.nome)
                         as B on B.ident = viagem
                         WHERE atrdiscriminante = 'A')
                         as C on transporte = C.ident)
                         as D on AUTOCARROTIPO.modelo = D.modelo) as H join
     (SELECT F.transporte, COUNT(F.transporte) as ocupados
     FROM BILHETE join
         (SELECT transporte
          FROM LUGAR join
              (SELECT TRANSPORTE.ident
              FROM TRANSPORTE join
                 (SELECT ident
                 FROM VIAGEM join
                     (SELECT ESTACAO.nome
                     FROM ESTACAO join
                         LOCALIDADE L on ESTACAO.localidade = L.codpostal
                         WHERE L.nome = 'Lisboa')
                         as A on estpartida = A.nome)
                         as B on B.ident = viagem
                         WHERE atrdiscriminante = 'A')
                         as E on transporte = E.ident)
                         as F on F.transporte = BILHETE.transporte
                         GROUP BY (F.transporte)) as G on H.transporte = G.transporte

--ex 3 a ex f

SELECT COUNT(preco) as soma
FROM LUGARTIPO
WHERE nome = 'adulto'
GROUP BY nome

--ex 3 a ex g

SELECT B.reserva, B.datareserva, AVG(B.idade) as average
FROM (SELECT reserva, datareserva, (YEAR(current_timestamp) - YEAR(dtnascimento)) as idade
     FROM PASSAGEIRO join
        (SELECT reserva, datareserva, passageiro
        FROM BILHETE join RESERVA R2 on BILHETE.reserva = R2.ident)
            as A on passageiro = nid) as B
GROUP BY B.reserva, B.datareserva
;


--3B
SELECT PASSAGEIRO.nome AS nome_pass FROM 
	(((((VIAGEM JOIN ESTACAO ON estchegada = nome)
	JOIN LOCALIDADE ON localidade = codpostal)
	JOIN RESERVA ON VIAGEM.ident = viagem)
	JOIN BILHETE ON RESERVA.ident = reserva) 
	JOIN PASSAGEIRO ON BILHETE.passageiro = nid)
		WHERE LOCALIDADE.nome = 'Lisboa'
		ORDER BY PASSAGEIRO.nome

SELECT PASSAGEIRO.nome FROM 
	(((((VIAGEM JOIN ESTACAO ON estchegada = nome)
	JOIN LOCALIDADE ON localidade = codpostal)
	JOIN RESERVA ON VIAGEM.ident = viagem)
	JOIN BILHETE ON RESERVA.ident = reserva) 
	JOIN PASSAGEIRO ON BILHETE.passageiro = nid)
		WHERE LOCALIDADE.nome = 'Lisboa'
		ORDER BY PASSAGEIRO.dtnascimento 	DESC

;

--3C
SELECT LOCALIDADE.nome estacaochegada , b.nome estacaopartida, Viagem.ident viagem 
	FROM VIAGEM JOIN ESTACAO ON estchegada = nome JOIN LOCALIDADE ON ESTACAO.localidade = LOCALIDADE.codpostal 
	JOIN ESTACAO a ON estpartida = a.nome JOIN LOCALIDADE b ON a.localidade = b.codpostal 
	WHERE LOCALIDADE.nome = 'Porto' AND b.nome = 'Lisboa' AND horapartida >= '06:00:00' AND horachegada <= '12:00:00'
;

--3D
SELECT PASSAGEIRO.nome, RESERVA.modopagamento, datediff(YEAR , PASSAGEIRO.dtnascimento, CURRENT_TIMESTAMP) 
	FROM PASSAGEIRO JOIN BILHETE ON nid = passageiro JOIN RESERVA ON reserva = ident;

SELECT modopagamento, AVG(datediff(YEAR , PASSAGEIRO.dtnascimento, CURRENT_TIMESTAMP)) AS avg_age_by_payment_method
	FROM (PASSAGEIRO JOIN BILHETE ON nid = passageiro JOIN RESERVA ON reserva = ident)
	GROUP BY modopagamento;

--3E
SELECT PASSAGEIRO.nome, COUNT(reserva) 
	FROM PASSAGEIRO JOIN BILHETE ON nid = passageiro 
	GROUP BY PASSAGEIRO.nome
	ORDER BY COUNT(reserva) DESC;


--3F
CREATE VIEW reservationinfo (identification, dateofreservation, paymentmethod, trip) as
    SELECT ident, datareserva, modopagamento, viagem
    FROM RESERVA
    WHERE YEAR(CURRENT_TIMESTAMP) - YEAR(datareserva) = 1

drop view reservationinfo



--3G
CREATE VIEW tripinfo (identification, startstation, endstation, inicialhour, duration_in_min) as
    SELECT ident, horapartida, estpartida, estchegada, datediff(minute, horapartida, horachegada) as duracao
    FROM VIAGEM
    WHERE datediff(day,CURRENT_TIMESTAMP,dataviagem) = 0 and datediff(second , horapartida, cast(CURRENT_TIMESTAMP as time (0))) > 0 and datediff(second, cast(CURRENT_TIMESTAMP as time (0)), horachegada ) > 0

drop view tripinfo


--4
UPDATE VIAGEM
	SET estpartida = 'Parque das Nacoes', estchegada = 'Beja', horapartida = '12:00:00', horachegada  = '14:18:00', distancia = 138
	FROM VIAGEM JOIN TRANSPORTE ON VIAGEM.ident = TRANSPORTE.viagem JOIN COMBOIO ON TRANSPORTE.ident = COMBOIO.transporte
	WHERE horapartida = '10:30:00' AND COMBOIO.tipo = 'IR';


