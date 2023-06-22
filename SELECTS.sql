-- SELECTs do trabalho de Banco de Dados do 2º Bimestre.
-- Alunos:
-- 		VICTOR FAGUNDES RAMOS       RA: 00239823
-- 		LUCAS PESSOLI               RA: 00229058
-- 		NICOLAS LEANDRO             RA: 00238714
-- 		ADRIAN LUCAS                RA: 00230994
-- 		RENAN AUGUSTO MENDES CARLOS RA: 00234708
-- 		ERICK DANIEL TEIXEIRA VIER  RA: 00235908
-- 		ALAN HENRIQUE RIBEIRO       RA: 00233005


	
-- Alunos
SELECT al.id_aluno AS "ID", ps.nome AS "Nome", tm.descricao AS "Turma", nt.nota AS "Nota" 
  FROM pessoa ps
  INNER JOIN alunos al ON al.id_pessoa = ps.id_pessoa
  INNER JOIN turma tm ON tm.id_turma = al.id_turma
  INNER JOIN notas nt ON  nt.id_aluno = al.id_aluno
  ORDER BY al.id_aluno;

-- Alunos por turma
SELECT al.id_aluno AS "ID", ps.nome AS "Nome", tm.descricao AS "Turma"
  FROM pessoa ps
  INNER JOIN alunos al ON al.id_pessoa = ps.id_pessoa
  INNER JOIN turma tm ON tm.id_turma = al.id_turma
  ORDER BY tm.descricao asc, ps.nome;

-- Professores
SELECT pf.id_professor AS "ID", ps.nome AS "Nome", dc.descricao AS "Disciplina"
  FROM pessoa ps
  INNER JOIN professor pf ON pf.id_pessoa = ps.id_pessoa
  INNER JOIN disciplina dc ON dc.id_professor = pf.id_professor
  ORDER BY pf.id_professor ASC;

-- Alunos Arovados/Reprovados
SELECT 
  CASE WHEN nt.nota < 60 THEN 'Reprovado'
       WHEN nt.nota >= 60 THEN 'Aprovado'
  END AS "Situação",
  nt.nota AS "Nota", ps.nome as "Aluno", al.matricula AS "RA"
  FROM pessoa ps
  INNER JOIN alunos al ON al.id_pessoa = ps.id_pessoa
  INNER JOIN notas nt ON nt.id_Aluno = al.id_aluno
  ORDER BY "Situação" ASC, nt.nota DESC;