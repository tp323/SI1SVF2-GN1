--ex3 a ex2 a
SELECT dataviagem, horapartida
FROM VIAGEM
where ( VIAGEM.estpartida in
        (SELECT ESTACAO.nome
        from (ESTACAO join LOCALIDADE L on L.codpostal = ESTACAO.localidade)
        where L.nome = 'Lisboa')
    AND VIAGEM.estchegada in (SELECT ESTACAO.nome
        from (ESTACAO join LOCALIDADE L on L.codpostal = ESTACAO.localidade )
            where L.nome = 'Porto'))

--ex3 a ex c
SELECT B.marca, B.modelo, AT.nlugares
from AUTOCARROTIPO AT join
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










