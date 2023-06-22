-- INSERTs do trabalho de Banco de Dados do 2º Bimestre.
-- Alunos:
-- 		VICTOR FAGUNDES RAMOS       RA: 00239823
-- 		LUCAS PESSOLI               RA: 00229058
-- 		NICOLAS LEANDRO             RA: 00238714
-- 		ADRIAN LUCAS                RA: 00230994
-- 		RENAN AUGUSTO MENDES CARLOS RA: 00234708
-- 		ERICK DANIEL TEIXEIRA VIER  RA: 00235908
-- 		ALAN HENRIQUE RIBEIRO       RA: 00233005

INSERT INTO Pessoa (id_pessoa, nome)
  VALUES
	(1,  'Roberto'), 
	(2,  'Erick'), 
	(3,  'Maycon'), 
	(4,  'Nicolas'),
	(5,  'Alice'), 
	(6,  'Adrian'),
	(7,  'Sérgio'), 
	(8,  'Márcia'),
	(9,  'Alan'),
	(10, 'Vitor'),
	(11, 'Renan'),
	(12, 'Lucas'),
	(13, 'Joana'),
	(14, 'Jean'),
	(15, 'Rafael'),
	(16, 'Henrique'),
	(17, 'Lionel'),
	(18, 'Fernando'),
	(19, 'Endrick'),
	(20, 'Evaristo'), 
	(21, 'Giovanna'), 
	(22, 'Douglas'); 
	
INSERT INTO Turma (id_turma, descricao)
  VALUES
	(1, '1 ano A'),
	(2, '1 ano B'),
	(3, '2 ano A'),
	(4, '2 ano B'),
	(5, '3 ano A'),
	(6, '3 ano B');
	
INSERT INTO Alunos (id_aluno, id_pessoa, id_turma, matricula)
  VALUES 
	(1,  2,  1, '00235908'),
	(2,  4,  1, '00238714'),
	(3,  6,  1, '00230994'),
	(4,  9,  2, '00233006'),
	(5,  10, 2, '00239823'),
	(6,  11, 2, '00234708'),
	(7,  12, 3, '00229058'),
	(8,  15, 3, '00274290'),
	(9,  16, 4, '00862498'),
	(10, 17, 4, '00991991'),
	(11, 18, 4, '00333300'),
	(12, 19, 5, '00012312');


INSERT INTO Professor (id_professor, id_pessoa, id_disciplina)
  VALUES
	(1,  1,  1),
	(2,  3,  4),
	(3,  7,  7),
	(4,  8,  2),
	(5,  13, 3),
	(6,  20, 6),
	(7,  21, 8),
	(8,  22, 10),
	(9,  5,  9),
	(10, 14, 11);
	
INSERT INTO Periodo (id_periodo, descricao)
  VALUES
	(1, '1º Periodo'),
	(2, '2º Periodo'),
	(3, '3º Periodo'),
	(4, '4º Periodo'),
	(5, '5º Periodo');
	
INSERT INTO Disciplina (id_disciplina, descricao, id_professor, id_periodo)
  VALUES
	(1,  'Banco de Dados', 1, 1),
	(2,  'Programação Orientada a Objetos', 4, 1),
	(3,  'Sistemas Operacionais', 5, 2),
	(4,  'Estrutura de Dados', 2, 2),
	(5,  NULL, NULL, NULL),
	(6,  'Gestão de Equipes e Projetos', 6, 3),
	(7,  'Engenharia de Software', 3, 4),
	(8,  'Algoritimos', 7, 4),
	(9,  'Legislação Aplicada a Tecnologia da Informação', 9, 5),
	(10, 'Arquitetura e Organização de Computadores', 8, 5),
	(11, 'Relações Sociais e Cidadania', 10, 5);

INSERT INTO Notas (id_nota, nota, id_disciplina, id_aluno)
  VALUES 
	(1, 78.0, 3, 1),
	(2, 100.0, 4, 2),
	(3, 40.0, 1, 3),
	(4, 10.5, 2, 5),
	(5, 60.0, 5, 4),
	(6, 50.0, 7, 7),
	(7, 30.0, 6, 6),
	(8, 90.0, 9, 10),
	(9, 40.0, 8, 8),
	(10, 80.0, 11, 9),
	(11, 32.0, 10, 11),
	(12, 60.0, 2, 12);