-- Comandos criados para utilizar no Postgre

CREATE TABLE Pessoa(
	id_pessoa INT PRIMARY KEY NOT NULL,
	nome VARCHAR(50) NOT NULL
);

CREATE TABLE Periodo(
	id_periodo INT PRIMARY KEY NOT NULL,
	descricao VARCHAR(100) NOT NULL
);

CREATE TABLE Professor(	
	id_professor INT PRIMARY KEY NOT NULL,
	id_pessoa INT NOT NULL,
	id_disciplina INT NOT NULL
);

CREATE TABLE Disciplina (
	id_disciplina INT PRIMARY KEY NOT NULL,
	descricao VARCHAR(50),
	id_professor INT,
	id_periodo INT,
	CONSTRAINT fk_idprofessor FOREIGN KEY (id_professor) REFERENCES Professor (id_professor),
	CONSTRAINT fk_idperiodo FOREIGN KEY (id_periodo) REFERENCES Periodo (id_periodo)
);

CREATE TABLE Turma(
	id_turma INT PRIMARY KEY NOT NULL,
	descricao VARCHAR(50) NOT NULL
);

CREATE TABLE Alunos (
	id_aluno INT PRIMARY KEY NOT NULL,
	id_pessoa INT NOT NULL,
	id_turma INT NOT NULL,
	matricula VARCHAR(8) NOT NULL,
	CONSTRAINT fk_idpessoa FOREIGN KEY (id_pessoa) REFERENCES Pessoa (id_pessoa),
	CONSTRAINT fk_idturma FOREIGN KEY (id_turma) REFERENCES Turma (id_turma)
);

CREATE TABLE Notas(
	id_nota INT PRIMARY KEY NOT NULL,
	nota REAL,
	id_disciplina INT,
	id_aluno INT,
	CONSTRAINT fk_idaluno FOREIGN KEY(id_aluno) REFERENCES Alunos (id_aluno),
	CONSTRAINT fk_iddisciplina FOREIGN KEY(id_disciplina) REFERENCES Disciplina (id_disciplina)
);

CREATE TABLE Recuperacao(
	id_recuperacao INT PRIMARY KEY NOT NULL,
	id_aluno INT,
	id_disciplina INT,
	id_nota INT,
	data TIMESTAMP(6),
	CONSTRAINT fk_idaluno FOREIGN KEY(id_aluno) REFERENCES Alunos (id_aluno),
	CONSTRAINT fk_iddisciplina FOREIGN KEY(id_disciplina) REFERENCES Disciplina (id_disciplina),
	CONSTRAINT fk_idnota FOREIGN KEY (id_nota) REFERENCES Notas (id_nota)
);

CREATE OR REPLACE FUNCTION insere_na_recuperacao()
  RETURNS TRIGGER AS
  $$
  DECLARE 
    contador INTEGER := 0;
  BEGIN
    contador := contador + 1;
    IF (SELECT nota FROM Notas WHERE id_nota = NEW.id_nota) < 60.0 THEN

    IF (SELECT COUNT(id_recuperacao) FROM Recuperacao) >= 1 THEN
        contador := (SELECT COUNT(id_recuperacao) FROM Recuperacao) + 1;
    END IF;
    
    INSERT INTO Recuperacao (id_recuperacao, id_aluno, id_disciplina, id_nota, data)
    VALUES (contador, NEW.id_aluno, NEW.id_disciplina, NEW.id_nota, NOW());
	  
    END IF;
    RETURN NEW;
  END;
  $$
LANGUAGE plpgsql;

CREATE TRIGGER trig_insere_na_recuperacao
AFTER INSERT ON Notas
FOR EACH ROW
EXECUTE PROCEDURE insere_na_recuperacao();

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
