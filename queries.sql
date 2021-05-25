

SELECT PASSAGEIRO.nome FROM 
	(((((VIAGEM JOIN ESTACAO ON estchegada = nome)
	JOIN LOCALIDADE ON localidade = codpostal)
	JOIN RESERVA ON VIAGEM.ident = viagem)
	JOIN BILHETE ON RESERVA.ident = reserva) 
	JOIN PASSAGEIRO ON BILHETE.passageiro = nid)
		WHERE LOCALIDADE.nome = 'seixal'
		ORDER BY PASSAGEIRO.nome

		
SELECT PASSAGEIRO.nome FROM 
	(((((VIAGEM JOIN ESTACAO ON estchegada = nome)
	JOIN LOCALIDADE ON localidade = codpostal)
	JOIN RESERVA ON VIAGEM.ident = viagem)
	JOIN BILHETE ON RESERVA.ident = reserva) 
	JOIN PASSAGEIRO ON BILHETE.passageiro = nid)
		WHERE LOCALIDADE.nome = 'seixal'
		ORDER BY PASSAGEIRO.dtnascimento 	DESC

;