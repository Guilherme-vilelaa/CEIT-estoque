--
-- Script adicional (NÃO faz parte do dump original ceit.sql)
-- Cria a tabela de usuários usada pela tela de login.
--
-- Este arquivo roda automaticamente junto com o ceit.sql na
-- primeira inicialização do container do banco (pasta
-- docker-entrypoint-initdb.d), sem alterar nada do schema
-- original do projeto.
--

CREATE TABLE IF NOT EXISTS public.usuario (
    id serial PRIMARY KEY,
    nome character varying(100) NOT NULL,
    login character varying(50) NOT NULL UNIQUE,
    senha_hash character varying(255) NOT NULL,
    ativo boolean DEFAULT true,
    criado_em timestamp DEFAULT now()
);


-- Usuário padrão criado automaticamente:
--   login: admin
--   senha: admin123
-- (troque a senha depois de logar pela primeira vez)
INSERT INTO public.usuario (nome, login, senha_hash)
VALUES (
    'Administrador',
    'admin',
    'scrypt:32768:8:1$UWWlDIIoibs4rWWs$4caa930a893a301e2ac0be899f6e552538195f67fbb4ec41dc81a46cc39a1875f47ec84d63da3be4961ca69bab3922dc9975a294e719c0bf1231f54bd95fe932'
)
ON CONFLICT (login) DO NOTHING;
