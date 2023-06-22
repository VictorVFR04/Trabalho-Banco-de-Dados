-- CREATEs do trabalho de Banco de Dados do 2º Bimestre.
-- Alunos:
-- 		VICTOR FAGUNDES RAMOS       RA: 00239823
-- 		LUCAS PESSOLI               RA: 00229058
-- 		NICOLAS LEANDRO             RA: 00238714
-- 		ADRIAN LUCAS                RA: 00230994
-- 		RENAN AUGUSTO MENDES CARLOS RA: 00234708
-- 		ERICK DANIEL TEIXEIRA VIER  RA: 00235908
-- 		ALAN HENRIQUE RIBEIRO       RA: 00233005

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