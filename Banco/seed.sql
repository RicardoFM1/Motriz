USE Motriz;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;
SET UNIQUE_CHECKS = 0;

START TRANSACTION;

-- =========================================================
-- 1. ENDEREÇOS
-- =========================================================

INSERT INTO endereco
(id, logradouro, numero, complemento, bairro, cidade, UF, CEP)
VALUES
(1, 'Rua das Oficinas', 100, 'Sala 01', 'Centro', 'São Paulo', 'SP', '01001000'),
(2, 'Av. dos Automóveis', 250, 'Galpão A', 'Mooca', 'São Paulo', 'SP', '03101000'),
(3, 'Rua dos Mecânicos', 75, 'Loja 02', 'Tatuapé', 'São Paulo', 'SP', '03301000'),
(4, 'Rua Augusta', 120, 'Apto 12', 'Consolação', 'São Paulo', 'SP', '01305000'),
(5, 'Av. Paulista', 1500, 'Apto 81', 'Bela Vista', 'São Paulo', 'SP', '01310000'),
(6, 'Rua Vergueiro', 800, 'Casa', 'Liberdade', 'São Paulo', 'SP', '01504000'),
(7, 'Rua Haddock Lobo', 300, 'Apto 45', 'Cerqueira César', 'São Paulo', 'SP', '01414000'),
(8, 'Rua da Consolação', 950, 'Apto 32', 'Consolação', 'São Paulo', 'SP', '01302000'),
(9, 'Rua Oscar Freire', 500, 'Apto 10', 'Pinheiros', 'São Paulo', 'SP', '05409000'),
(10, 'Rua Teodoro Sampaio', 700, 'Casa', 'Pinheiros', 'São Paulo', 'SP', '05406000'),
(11, 'Av. Faria Lima', 900, 'Sala 15', 'Itaim Bibi', 'São Paulo', 'SP', '04538000'),
(12, 'Rua dos Pinheiros', 450, 'Apto 21', 'Pinheiros', 'São Paulo', 'SP', '05422000'),
(13, 'Rua Heitor Penteado', 1100, 'Casa', 'Sumaré', 'São Paulo', 'SP', '05438000'),
(14, 'Rua Pompéia', 600, 'Apto 44', 'Pompéia', 'São Paulo', 'SP', '05022000'),
(15, 'Av. Lins de Vasconcelos', 700, 'Casa', 'Aclimação', 'São Paulo', 'SP', '01538000'),
(16, 'Rua Domingos de Morais', 1300, 'Apto 52', 'Vila Mariana', 'São Paulo', 'SP', '04010000'),
(17, 'Rua Vergueiro', 1600, 'Casa', 'Vila Mariana', 'São Paulo', 'SP', '04102000'),
(18, 'Av. Jabaquara', 900, 'Apto 23', 'Saúde', 'São Paulo', 'SP', '04046000'),
(19, 'Rua Luis Gois', 350, 'Casa', 'Mirandópolis', 'São Paulo', 'SP', '04043000'),
(20, 'Rua Afonso Celso', 500, 'Apto 71', 'Vila Mariana', 'São Paulo', 'SP', '04119000'),
(21, 'Rua Itapura', 400, 'Apto 31', 'Tatuapé', 'São Paulo', 'SP', '03310000'),
(22, 'Rua Serra de Bragança', 200, 'Casa', 'Tatuapé', 'São Paulo', 'SP', '03318000'),
(23, 'Rua Cantagalo', 500, 'Apto 62', 'Tatuapé', 'São Paulo', 'SP', '03319000');

-- =========================================================
-- 2. UNIDADES
-- Unidade 3 ficará sem gerente
-- =========================================================

INSERT INTO unidade
(id, nome, telefone, status, endereco_id)
VALUES
(1, 'Porto Alegre', '(11) 3000-1001', 'ativo', 1),
(2, 'Caxias do Sul', '(11) 3000-1002', 'ativo', 2),
(3, 'Pelotas', '(11) 3000-1003', 'ativo', 3);

-- =========================================================
-- 3. COLABORADORES
--
-- Hierarquia:
--
-- Carlos (gerente)
--   └── Fernanda (supervisor)
--        ├── João (atendente)
--        └── Rafael (mecânico)
--
-- Marcelo (gerente)
--   └── Juliana (supervisor)
--        ├── Bruno (atendente)
--        └── Diego (mecânico)
--
-- Unidade 3 não possui gerente.
-- =========================================================

INSERT INTO colaborador
(id, nome, email, cpf, senha, perfil, data_de_admissao, status, colaborador_id, unidade_id)
VALUES
(1, 'Carlos Eduardo Almeida', 'carlos@motri z.com', '11111111101', '$2y$10$seed123', 'gerente', '2024-01-10 08:00:00', 'ativo', NULL, 1),
(2, 'Fernanda Souza Lima', 'fernanda@mot riz.com', '11111111102', '$2y$10$seed123', 'supervisor', '2024-02-15 08:00:00', 'ativo', 1, 1),
(3, 'João Pedro Santos', 'joao@motri z.com', '11111111103', '$2y$10$seed123', 'atendente', '2024-03-01 08:00:00', 'ativo', 2, 1),
(4, 'Rafael Martins', 'rafael@motri z.com', '11111111104', '$2y$10$seed123', 'mecanico', '2024-03-10 08:00:00', 'ativo', 2, 1),

(5, 'Marcelo Henrique Costa', 'marcelo@motri z.com', '11111111105', '$2y$10$seed123', 'gerente', '2024-01-20 08:00:00', 'ativo', NULL, 2),
(6, 'Juliana Oliveira', 'juliana@motri z.com', '11111111106', '$2y$10$seed123', 'supervisor', '2024-02-20 08:00:00', 'ativo', 5, 2),
(7, 'Bruno Ferreira', 'bruno@motri z.com', '11111111107', '$2y$10$seed123', 'atendente', '2024-04-01 08:00:00', 'ativo', 6, 2),
(8, 'Diego Rodrigues', 'diego@motri z.com', '11111111108', '$2y$10$seed123', 'mecanico', '2024-04-10 08:00:00', 'ativo', 6, 2),

(9, 'Amanda Ribeiro', 'amanda@motri z.com', '11111111109', '$2y$10$seed123', 'atendente', '2024-05-01 08:00:00', 'ativo', 2, 3),
(10, 'Lucas Mendes', 'lucas@motri z.com', '11111111110', '$2y$10$seed123', 'mecanico', '2024-05-10 08:00:00', 'ativo', 2, 3),
(11, 'Patrícia Gomes', 'patricia@motri z.com', '11111111111', '$2y$10$seed123', 'atendente', '2024-06-01 08:00:00', 'ativo', 6, 3),
(12, 'Thiago Nunes', 'thiago@motri z.com', '11111111112', '$2y$10$seed123', 'mecanico', '2024-06-10 08:00:00', 'ativo', 6, 3);

-- Corrige os e-mails sem espaços acidentalmente inseridos
UPDATE colaborador
SET email = REPLACE(email, ' ', '');

-- =========================================================
-- 4. CLIENTES
-- =========================================================

INSERT INTO cliente
(id, nome, documento, email, data_de_nascimento, endereco_id, observacoes)
VALUES
(1, 'Antônio Carlos da Silva', '11111111111', 'antonio.silva@email.com', '1985-04-12', 4, 'Cliente antigo'),
(2, 'Conceição Maria Oliveira', '22222222222', 'conceicao.oliveira@email.com', '1978-09-22', 5, 'Cliente recorrente'),
(3, 'Müller Henrique Souza', '33333333333', 'muller.souza@email.com', '1990-02-15', 6, 'Prefere contato por celular'),
(4, 'Mariana Costa', '44444444444', 'mariana.costa@email.com', '1992-07-08', 7, 'Cliente pessoa física'),
(5, 'Ricardo Almeida', '55555555555', 'ricardo.almeida@email.com', '1980-11-19', 8, 'Cliente pessoa física'),
(6, 'Empresa Alpha Tecnologia Ltda', '12345678000101', 'contato@alpha.com', NULL, 9, 'Cliente pessoa jurídica'),
(7, 'Beatriz Fernandes', '66666666666', 'beatriz.fernandes@email.com', '1995-01-25', 10, 'Cliente pessoa física'),
(8, 'Carlos Mendes', '77777777777', 'carlos.mendes@email.com', '1988-03-30', 11, 'Cliente pessoa física'),
(9, 'Transportadora São Paulo Ltda', '23456789000102', 'contato@transpsp.com', NULL, 12, 'Frota corporativa'),
(10, 'Daniela Martins', '88888888888', 'daniela.martins@email.com', '1991-06-17', 13, 'Cliente pessoa física'),
(11, 'Eduardo Rocha', '99999999999', 'eduardo.rocha@email.com', '1987-12-03', 14, 'Cliente pessoa física'),
(12, 'Fábio Pereira', '10101010101', 'fabio.pereira@email.com', '1982-05-14', 15, 'Cliente pessoa física'),
(13, 'Gabriela Santos', '12121212121', 'gabriela.santos@email.com', '1996-08-21', 16, 'Cliente pessoa física'),
(14, 'Henrique Barbosa', '13131313131', 'henrique.barbosa@email.com', '1985-10-10', 17, 'Cliente pessoa física'),
(15, 'Isabela Lima', '14141414141', 'isabela.lima@email.com', '1993-04-05', 18, 'Cliente pessoa física'),
(16, 'José Augusto', '15151515151', 'jose.augusto@email.com', '1975-02-18', 19, 'Cliente pessoa física'),
(17, 'Karen Souza', '16161616161', 'karen.souza@email.com', '1998-09-09', 20, 'Cliente pessoa física'),
(18, 'Luiz Henrique', '17171717171', 'luiz.henrique@email.com', '1989-07-27', 21, 'Cliente pessoa física'),
(19, 'Márcia Regina', '18181818181', 'marcia.regina@email.com', '1981-11-11', 22, 'Cliente pessoa física'),
(20, 'Nathália Alves', '19292929292', 'nathalia.alves@email.com', '1994-03-16', 23, 'Cliente pessoa física');

-- =========================================================
-- 5. TELEFONES
--
-- 20 clientes.
-- Clientes 19 e 20 ficam sem telefone.
-- 3 clientes possuem 3 números.
-- 3 clientes possuem 2 números.
-- Demais possuem 1.
-- Total = 28 números.
-- =========================================================

INSERT INTO telefone
(id, numero_fixo, numero_celular, numero_externo, cliente_id)
VALUES
(1, '(11) 3000-0001', '(11) 99000-0001', NULL, 1),
(2, NULL, '(11) 99000-0002', '(11) 98888-0002', 2),
(3, '(11) 3000-0003', '(11) 99000-0003', '(11) 97777-0003', 3),
(4, NULL, '(11) 99000-0004', NULL, 4),
(5, '(11) 3000-0005', '(11) 99000-0005', NULL, 5),
(6, NULL, '(11) 99000-0006', NULL, 6),
(7, NULL, '(11) 99000-0007', '(11) 97777-0007', 7),
(8, '(11) 3000-0008', '(11) 99000-0008', '(11) 97777-0008', 8),
(9, NULL, '(11) 99000-0009', NULL, 9),
(10, '(11) 3000-0010', '(11) 99000-0010', NULL, 10),
(11, NULL, '(11) 99000-0011', NULL, 11),
(12, '(11) 3000-0012', '(11) 99000-0012', NULL, 12),
(13, NULL, '(11) 99000-0013', '(11) 97777-0013', 13),
(14, '(11) 3000-0014', '(11) 99000-0014', '(11) 97777-0014', 14),
(15, NULL, '(11) 99000-0015', NULL, 15),
(16, '(11) 3000-0016', '(11) 99000-0016', NULL, 16),
(17, NULL, '(11) 99000-0017', NULL, 17),
(18, '(11) 3000-0018', '(11) 99000-0018', NULL, 18);

-- =========================================================
-- 6. VEÍCULOS
--
-- Cliente 1 possui 3 veículos.
-- Clientes 19 e 20 não possuem veículo.
-- =========================================================

INSERT INTO veiculo
(id, placa, marca, modelo, ano_fabricacao, cor, tipo_de_combustivel, quilometragem, cliente_id)
VALUES
(1, 'ABC1D23', 'Toyota', 'Corolla', 2020, 'Prata', 'Flex', 65000, 1),
(2, 'ABC2D34', 'Honda', 'Civic', 2019, 'Preto', 'Flex', 72000, 1),
(3, 'ABC3D45', 'Volkswagen', 'T-Cross', 2022, 'Branco', 'Flex', 38000, 1),

(4, 'DEF4E56', 'Chevrolet', 'Onix', 2021, 'Prata', 'Flex', 45000, 2),
(5, 'DEF5E67', 'Fiat', 'Argo', 2020, 'Vermelho', 'Flex', 51000, 3),
(6, 'GHI6F78', 'Hyundai', 'HB20', 2022, 'Branco', 'Flex', 30000, 4),
(7, 'GHI7F89', 'Ford', 'Ka', 2018, 'Preto', 'Flex', 85000, 5),
(8, 'JKL8G90', 'Renault', 'Duster', 2021, 'Cinza', 'Flex', 49000, 6),
(9, 'JKL9H01', 'Nissan', 'Kicks', 2022, 'Azul', 'Flex', 35000, 7),
(10, 'MNO0I12', 'Jeep', 'Renegade', 2020, 'Branco', 'Flex', 61000, 8),
(11, 'MNO1I23', 'Toyota', 'Hilux', 2019, 'Prata', 'Diesel', 90000, 9),
(12, 'PQR2J34', 'Volkswagen', 'Polo', 2023, 'Cinza', 'Flex', 18000, 10),
(13, 'PQR3J45', 'Chevrolet', 'Tracker', 2021, 'Preto', 'Flex', 55000, 11),
(14, 'STU4K56', 'Honda', 'Fit', 2018, 'Prata', 'Flex', 97000, 12),
(15, 'STU5K67', 'Fiat', 'Cronos', 2022, 'Branco', 'Flex', 29000, 13),
(16, 'VWX6L78', 'Hyundai', 'Creta', 2021, 'Azul', 'Flex', 42000, 14),
(17, 'VWX7L89', 'Ford', 'Ranger', 2020, 'Preto', 'Diesel', 78000, 15),
(18, 'YZA8M90', 'Nissan', 'Versa', 2019, 'Branco', 'Flex', 68000, 16),
(19, 'YZA9N01', 'Toyota', 'Yaris', 2022, 'Vermelho', 'Flex', 27000, 17),
(20, 'BCD0N12', 'Volkswagen', 'Virtus', 2021, 'Cinza', 'Flex', 46000, 18),
(21, 'BCD1O23', 'Chevrolet', 'S10', 2018, 'Branco', 'Diesel', 105000, 9),
(22, 'EFG2P34', 'Fiat', 'Toro', 2020, 'Prata', 'Diesel', 73000, 6),
(23, 'EFG3P45', 'Honda', 'HR-V', 2023, 'Preto', 'Flex', 16000, 7),
(24, 'HIJ4Q56', 'Renault', 'Sandero', 2019, 'Vermelho', 'Flex', 80000, 8),
(25, 'HIJ5Q67', 'Toyota', 'Etios', 2017, 'Prata', 'Flex', 112000, 10);

-- =========================================================
-- 7. SUBCATEGORIAS
-- =========================================================

INSERT INTO subcategoria
(id, nome)
VALUES
(1, 'Motor'),
(2, 'Freios'),
(3, 'Suspensão'),
(4, 'Elétrica'),
(5, 'Carroceria');

-- =========================================================
-- 8. CATEGORIAS
-- =========================================================

INSERT INTO categoria
(id, nome, subcategoria_id)
VALUES
(1, 'Óleo e Lubrificação', 1),
(2, 'Motor', 1),
(3, 'Arrefecimento', 1),
(4, 'Freios', 2),
(5, 'Pastilhas', 2),
(6, 'Suspensão', 3),
(7, 'Amortecedores', 3),
(8, 'Elétrica', 4),
(9, 'Bateria', 4),
(10, 'Injeção Eletrônica', 1),
(11, 'Pneus', NULL),
(12, 'Alinhamento', NULL),
(13, 'Funilaria', 5),
(14, 'Pintura', 5),
(15, 'Diagnóstico', NULL);

-- =========================================================
-- 9. FORNECEDORES
-- =========================================================

INSERT INTO fornecedor
(id, razao_social, CNPJ, email, telefone)
VALUES
(1, 'AutoParts Brasil', '11111111000101', 'contato@autoparts.com', '(11) 3100-1001'),
(2, 'Peças Paulista Ltda', '22222222000102', 'vendas@pecaspaulista.com', '(11) 3100-1002'),
(3, 'Distribuidora MotorSul', '33333333000103', 'contato@motorsul.com', '(11) 3100-1003'),
(4, 'Freios & Cia', '44444444000104', 'vendas@freiosecia.com', '(11) 3100-1004'),
(5, 'Auto Center Distribuição', '55555555000105', 'contato@autocenter.com', '(11) 3100-1005');

-- =========================================================
-- 10. PEÇAS
--
-- Peças 1-5 possuem estoque abaixo do mínimo.
-- Peças 29 e 30 não possuem fornecedor.
-- =========================================================

INSERT INTO peca
(id, nome, codigo, preco_de_custo, preco_de_venda, estoque_minimo, fornecedor_id)
VALUES
(1, 'Filtro de óleo', 'PEC001', 2500, 4500, 10, 1),
(2, 'Filtro de ar', 'PEC002', 3000, 5500, 10, 1),
(3, 'Filtro de combustível', 'PEC003', 3500, 6500, 8, 2),
(4, 'Pastilha de freio dianteira', 'PEC004', 7000, 12000, 12, 4),
(5, 'Pastilha de freio traseira', 'PEC005', 6000, 10500, 10, 4),
(6, 'Disco de freio', 'PEC006', 12000, 20000, 6, 4),
(7, 'Amortecedor dianteiro', 'PEC007', 18000, 30000, 4, 3),
(8, 'Amortecedor traseiro', 'PEC008', 14000, 25000, 4, 3),
(9, 'Bateria 60Ah', 'PEC009', 28000, 42000, 5, 5),
(10, 'Bateria 70Ah', 'PEC010', 32000, 48000, 5, 5),
(11, 'Correia dentada', 'PEC011', 9000, 16000, 6, 3),
(12, 'Tensor da correia', 'PEC012', 7500, 13000, 5, 3),
(13, 'Velas de ignição', 'PEC013', 4500, 8000, 15, 2),
(14, 'Bobina de ignição', 'PEC014', 11000, 19000, 5, 2),
(15, 'Radiador', 'PEC015', 30000, 48000, 3, 3),
(16, 'Válvula termostática', 'PEC016', 6500, 11000, 5, 3),
(17, 'Bomba d''água', 'PEC017', 12000, 21000, 4, 3),
(18, 'Sensor de temperatura', 'PEC018', 5000, 9000, 6, 2),
(19, 'Sensor lambda', 'PEC019', 10000, 18000, 5, 2),
(20, 'Lâmpada H7', 'PEC020', 1500, 3000, 20, 5),
(21, 'Lâmpada H4', 'PEC021', 1400, 2800, 20, 5),
(22, 'Palheta dianteira', 'PEC022', 3000, 5500, 10, 1),
(23, 'Palheta traseira', 'PEC023', 2500, 5000, 8, 1),
(24, 'Coxim do motor', 'PEC024', 8000, 14000, 5, 3),
(25, 'Bieleta', 'PEC025', 3500, 6500, 8, 3),
(26, 'Bucha de suspensão', 'PEC026', 2500, 5000, 10, 3),
(27, 'Terminal de direção', 'PEC027', 4000, 7500, 8, 3),
(28, 'Rolamento de roda', 'PEC028', 9000, 16000, 5, 2),
(29, 'Fusível automotivo', 'PEC029', 500, 1200, 30, NULL),
(30, 'Relé automotivo', 'PEC030', 1500, 3000, 15, NULL);

-- =========================================================
-- 11. SERVIÇOS
--
-- 25 serviços distribuídos pelas categorias.
-- Preços variados.
-- =========================================================

INSERT INTO servico
(id, nome, descricao, preco_de_tabela, tempo_estimado, status, categoria_id, codigo, colaborador_id, quantidade)
VALUES
(1, 'Troca de óleo', 'Troca de óleo do motor', 12000, '01:00:00', 'ativo', 1, 'SRV001', 3, 1),
(2, 'Troca de filtro de óleo', 'Substituição do filtro de óleo', 6000, '00:30:00', 'ativo', 1, 'SRV002', 3, 1),
(3, 'Revisão do motor', 'Inspeção geral do motor', 25000, '03:00:00', 'ativo', 2, 'SRV003', 4, 1),
(4, 'Limpeza do sistema', 'Limpeza do sistema de arrefecimento', 18000, '02:00:00', 'ativo', 3, 'SRV004', 4, 1),
(5, 'Troca de fluido', 'Troca do fluido de arrefecimento', 15000, '01:30:00', 'ativo', 3, 'SRV005', 4, 1),
(6, 'Revisão de freios', 'Inspeção completa do sistema de freios', 22000, '02:00:00', 'ativo', 4, 'SRV006', 4, 1),
(7, 'Troca de pastilhas', 'Substituição das pastilhas', 16000, '01:30:00', 'ativo', 5, 'SRV007', 4, 1),
(8, 'Troca de discos', 'Substituição dos discos de freio', 20000, '02:00:00', 'ativo', 4, 'SRV008', 8, 1),
(9, 'Revisão da suspensão', 'Inspeção do conjunto da suspensão', 24000, '02:30:00', 'ativo', 6, 'SRV009', 8, 1),
(10, 'Troca de amortecedores', 'Substituição dos amortecedores', 30000, '03:00:00', 'ativo', 7, 'SRV010', 8, 1),
(11, 'Diagnóstico elétrico', 'Diagnóstico do sistema elétrico', 18000, '01:30:00', 'ativo', 8, 'SRV011', 10, 1),
(12, 'Troca de bateria', 'Substituição da bateria', 8000, '00:30:00', 'ativo', 9, 'SRV012', 10, 1),
(13, 'Revisão da injeção', 'Diagnóstico da injeção eletrônica', 26000, '02:30:00', 'ativo', 10, 'SRV013', 10, 1),
(14, 'Limpeza de bicos', 'Limpeza dos bicos injetores', 20000, '02:00:00', 'ativo', 10, 'SRV014', 10, 1),
(15, 'Alinhamento', 'Alinhamento da direção', 10000, '01:00:00', 'ativo', 12, 'SRV015', 4, 1),
(16, 'Balanceamento', 'Balanceamento das rodas', 9000, '01:00:00', 'ativo', 11, 'SRV016', 8, 1),
(17, 'Rodízio de pneus', 'Rodízio dos pneus', 7000, '00:45:00', 'ativo', 11, 'SRV017', 8, 1),
(18, 'Funilaria leve', 'Reparo de pequenos amassados', 35000, '04:00:00', 'ativo', 13, 'SRV018', 8, 1),
(19, 'Pintura de peça', 'Pintura de peça automotiva', 45000, '06:00:00', 'ativo', 14, 'SRV019', 8, 1),
(20, 'Polimento', 'Polimento externo completo', 28000, '03:00:00', 'ativo', 14, 'SRV020', 4, 1),
(21, 'Diagnóstico eletrônico', 'Scanner automotivo completo', 15000, '01:00:00', 'ativo', 15, 'SRV021', 10, 1),
(22, 'Revisão preventiva', 'Revisão preventiva geral', 32000, '04:00:00', 'ativo', 15, 'SRV022', 4, 1),
(23, 'Troca de correia', 'Substituição da correia dentada', 28000, '03:00:00', 'ativo', 2, 'SRV023', 4, 1),
(24, 'Troca de velas', 'Substituição das velas de ignição', 12000, '01:00:00', 'ativo', 10, 'SRV024', 10, 1),
(25, 'Revisão completa', 'Revisão completa do veículo', 50000, '05:00:00', 'ativo', 15, 'SRV025', 4, 1);

-- =========================================================
-- 12. ORDENS DE SERVIÇO
--
-- 40 OS.
-- Todos os 8 status aparecem.
-- Datas distribuídas em vários meses.
-- Algumas abertas há mais de 7 dias.
-- Algumas sem mecânico.
-- =========================================================

INSERT INTO ordem_de_servico
(id, numero, unidade_id, veiculo_id, mecanico_id, atendente_id,
 quilometragem, data_e_hora, previsao_de_entrega, status,
 observações, desconto_gerente, preco_total_os)
VALUES
(1, 1001, 1, 1, 4, 3, 65000, '2026-05-05 09:00:00', '2026-05-06', 'finalizada', 'Troca de óleo e revisão', 0, 18000),
(2, 1002, 1, 2, 4, 3, 72000, '2026-05-08 10:00:00', '2026-05-09', 'entregue', 'Revisão de freios', 1000, 30000),
(3, 1003, 1, 3, 4, 3, 38000, '2026-05-12 08:30:00', '2026-05-13', 'finalizada', 'Alinhamento', 0, 10000),
(4, 1004, 1, 4, 4, 3, 45000, '2026-05-18 11:00:00', '2026-05-19', 'entregue', 'Troca de pastilhas', 0, 16000),
(5, 1005, 1, 5, NULL, 3, 51000, '2026-05-22 09:30:00', '2026-05-24', 'aberta', 'Aguardando avaliação', 0, 12000),
(6, 1006, 1, 6, 4, 3, 30000, '2026-05-27 13:00:00', '2026-05-28', 'orçamento', 'Cliente solicitou orçamento', 0, 25000),
(7, 1007, 2, 7, 8, 7, 85000, '2026-06-02 09:00:00', '2026-06-04', 'aprovada', 'Orçamento aprovado', 2000, 28000),
(8, 1008, 2, 8, 8, 7, 49000, '2026-06-05 10:00:00', '2026-06-07', 'em_execução', 'Serviço em andamento', 0, 30000),
(9, 1009, 2, 9, 8, 7, 35000, '2026-06-10 08:00:00', '2026-06-12', 'aguardando_peca', 'Aguardando amortecedor', 0, 44000),
(10, 1010, 2, 10, 8, 7, 61000, '2026-06-14 14:00:00', '2026-06-15', 'finalizada', 'Serviço concluído', 0, 20000),
(11, 1011, 2, 11, 8, 7, 90000, '2026-06-18 09:00:00', '2026-06-19', 'entregue', 'Veículo entregue', 0, 35000),
(12, 1012, 2, 12, NULL, 7, 18000, '2026-06-22 10:00:00', '2026-06-24', 'aberta', 'Aguardando mecânico', 0, 15000),
(13, 1013, 3, 13, 10, 9, 55000, '2026-06-28 09:00:00', '2026-06-30', 'cancelado', 'Cliente cancelou o serviço', 0, 0),

(14, 1014, 1, 14, 4, 3, 97000, '2026-07-02 09:00:00', '2026-07-04', 'aberta', 'Diagnóstico pendente', 0, 18000),
(15, 1015, 1, 15, 4, 3, 29000, '2026-07-04 10:00:00', '2026-07-05', 'orçamento', 'Aguardando aprovação', 0, 32000),
(16, 1016, 1, 16, 4, 3, 42000, '2026-07-06 11:00:00', '2026-07-08', 'aprovada', 'Aprovado pelo cliente', 1000, 25000),
(17, 1017, 1, 17, 4, 3, 78000, '2026-07-08 13:00:00', '2026-07-10', 'em_execução', 'Troca de suspensão', 0, 42000),
(18, 1018, 1, 18, 4, 3, 68000, '2026-07-10 08:30:00', '2026-07-11', 'aguardando_peca', 'Peça em transporte', 0, 30000),
(19, 1019, 2, 19, 8, 7, 27000, '2026-07-12 09:00:00', '2026-07-13', 'finalizada', 'Finalizada sem pagamento', 0, 20000),
(20, 1020, 2, 20, 8, 7, 46000, '2026-07-14 10:00:00', '2026-07-15', 'entregue', 'Pagamento integral', 0, 30000),
(21, 1021, 2, 21, 8, 7, 105000, '2026-07-16 09:00:00', '2026-07-18', 'aberta', 'Diagnóstico solicitado', 0, 15000),
(22, 1022, 2, 22, NULL, 7, 73000, '2026-07-17 14:00:00', '2026-07-20', 'aberta', 'Sem mecânico definido', 0, 20000),
(23, 1023, 2, 23, 8, 7, 16000, '2026-07-18 08:00:00', '2026-07-19', 'orçamento', 'Orçamento enviado', 0, 28000),
(24, 1024, 2, 24, 8, 7, 80000, '2026-07-19 09:30:00', '2026-07-21', 'aprovada', 'Serviço autorizado', 0, 35000),
(25, 1025, 3, 25, 10, 9, 112000, '2026-07-20 10:00:00', '2026-07-22', 'em_execução', 'Revisão geral', 0, 50000),
(26, 1026, 3, 1, 10, 9, 66000, '2026-07-21 09:00:00', '2026-07-23', 'aguardando_peca', 'Aguardando filtro', 0, 18000),
(27, 1027, 3, 2, 10, 9, 73000, '2026-07-22 08:00:00', '2026-07-24', 'finalizada', 'Finalizada sem pagamento', 0, 22000),
(28, 1028, 3, 3, 10, 9, 39000, '2026-07-23 10:00:00', '2026-07-24', 'entregue', 'Pagamento em parcelas', 0, 40000),
(29, 1029, 3, 4, 10, 9, 46000, '2026-07-24 13:00:00', '2026-07-26', 'aberta', 'Cliente aguardando retorno', 0, 15000),
(30, 1030, 3, 5, NULL, 9, 52000, '2026-07-25 09:00:00', '2026-07-27', 'aberta', 'Sem mecânico definido', 0, 25000),

(31, 1031, 1, 6, 4, 3, 31000, '2026-08-01 09:00:00', '2026-08-03', 'orçamento', 'Orçamento em análise', 0, 30000),
(32, 1032, 1, 7, 4, 3, 86000, '2026-08-02 10:00:00', '2026-08-04', 'aprovada', 'Cliente aprovou', 1000, 28000),
(33, 1033, 1, 8, 4, 3, 50000, '2026-08-03 09:00:00', '2026-08-05', 'em_execução', 'Em manutenção', 0, 45000),
(34, 1034, 1, 9, 4, 3, 36000, '2026-08-04 11:00:00', '2026-08-06', 'aguardando_peca', 'Aguardando peça', 0, 30000),
(35, 1035, 2, 10, 8, 7, 62000, '2026-08-05 08:00:00', '2026-08-06', 'finalizada', 'Finalizada sem pagamento', 0, 18000),
(36, 1036, 2, 11, 8, 7, 91000, '2026-08-06 09:00:00', '2026-08-07', 'entregue', 'Pagamento integral', 0, 35000),
(37, 1037, 2, 12, 8, 7, 19000, '2026-08-07 10:00:00', '2026-08-08', 'entregue', 'Pagamento integral', 0, 22000),
(38, 1038, 3, 13, 10, 9, 56000, '2026-08-08 09:00:00', '2026-08-09', 'entregue', 'Pagamento integral', 0, 30000),
(39, 1039, 3, 14, 10, 9, 98000, '2026-08-09 11:00:00', '2026-08-11', 'aberta', 'Aberta há mais de 7 dias', 0, 25000),
(40, 1040, 3, 15, 10, 9, 30000, '2026-08-10 13:00:00', '2026-08-12', 'cancelado', 'Serviço cancelado', 0, 0);

-- =========================================================
-- 13. ITENS DE OS
--
-- Exatamente 100 itens.
-- Mistura de serviços e peças.
-- =========================================================

INSERT INTO item_os
(id, peca_id, servico_id, os_id, quantidade_peca, quantidade_servico, preco_total_peca, preco_total_servico)
VALUES

-- OS 1-10
(1, 1, NULL, 1, 1, NULL, 4500, NULL),
(2, NULL, 1, 1, NULL, 1, NULL, 12000),
(3, 4, NULL, 2, 2, NULL, 24000, NULL),
(4, NULL, 6, 2, NULL, 1, NULL, 22000),
(5, NULL, 15, 3, NULL, 1, NULL, 10000),
(6, 5, NULL, 4, 1, NULL, 10500, NULL),
(7, NULL, 7, 4, NULL, 1, NULL, 16000),
(8, NULL, 3, 5, NULL, 1, NULL, 25000),
(9, NULL, 3, 6, NULL, 1, NULL, 25000),
(10, 11, NULL, 7, 1, NULL, 16000, NULL),
(11, NULL, 23, 7, NULL, 1, NULL, 28000),
(12, 7, NULL, 8, 2, NULL, 60000, NULL),
(13, NULL, 10, 8, NULL, 1, NULL, 30000),
(14, 8, NULL, 9, 1, NULL, 25000, NULL),
(15, NULL, 9, 9, NULL, 1, NULL, 24000),
(16, NULL, 12, 10, NULL, 1, NULL, 8000),
(17, 9, NULL, 11, 1, NULL, 42000, NULL),
(18, NULL, 12, 11, NULL, 1, NULL, 8000),
(19, NULL, 21, 12, NULL, 1, NULL, 15000),
(20, NULL, 21, 13, NULL, 1, NULL, 15000),

-- OS 14-20
(21, 13, NULL, 14, 4, NULL, 32000, NULL),
(22, NULL, 24, 14, NULL, 1, NULL, 12000),
(23, 2, NULL, 15, 1, NULL, 5500, NULL),
(24, NULL, 22, 15, NULL, 1, NULL, 32000),
(25, 16, NULL, 16, 1, NULL, 11000, NULL),
(26, NULL, 6, 16, NULL, 1, NULL, 22000),
(27, 25, NULL, 17, 2, NULL, 13000, NULL),
(28, NULL, 9, 17, NULL, 1, NULL, 24000),
(29, 8, NULL, 18, 1, NULL, 25000, NULL),
(30, NULL, 10, 18, NULL, 1, NULL, 30000),
(31, NULL, 7, 19, NULL, 1, NULL, 16000),
(32, 6, NULL, 20, 1, NULL, 20000, NULL),
(33, NULL, 10, 20, NULL, 1, NULL, 30000),
(34, NULL, 21, 21, NULL, 1, NULL, 15000),
(35, 17, NULL, 22, 1, NULL, 21000, NULL),
(36, NULL, 15, 23, NULL, 1, NULL, 10000),
(37, NULL, 20, 23, NULL, 1, NULL, 28000),
(38, 10, NULL, 24, 1, NULL, 48000, NULL),
(39, NULL, 18, 24, NULL, 1, NULL, 35000),
(40, 22, NULL, 25, 2, NULL, 11000, NULL),

-- OS 25-30
(41, NULL, 25, 25, NULL, 1, NULL, 50000),
(42, 1, NULL, 26, 2, NULL, 9000, NULL),
(43, NULL, 2, 26, NULL, 1, NULL, 6000),
(44, NULL, 7, 27, NULL, 1, NULL, 16000),
(45, 28, NULL, 28, 1, NULL, 16000, NULL),
(46, NULL, 6, 28, NULL, 1, NULL, 22000),
(47, NULL, 21, 29, NULL, 1, NULL, 15000),
(48, 3, NULL, 30, 1, NULL, 6500, NULL),
(49, NULL, 13, 30, NULL, 1, NULL, 26000),
(50, 20, NULL, 31, 2, NULL, 6000, NULL),
(51, NULL, 11, 31, NULL, 1, NULL, 18000),
(52, 14, NULL, 32, 1, NULL, 19000, NULL),
(53, NULL, 13, 32, NULL, 1, NULL, 26000),
(54, 15, NULL, 33, 1, NULL, 48000, NULL),
(55, NULL, 25, 33, NULL, 1, NULL, 50000),
(56, 16, NULL, 34, 1, NULL, 11000, NULL),
(57, NULL, 4, 34, NULL, 1, NULL, 18000),
(58, 12, NULL, 35, 1, NULL, 13000, NULL),
(59, NULL, 2, 35, NULL, 1, NULL, 6000),
(60, 9, NULL, 36, 1, NULL, 42000, NULL),

-- OS 36-40
(61, NULL, 12, 36, NULL, 1, NULL, 8000),
(62, 4, NULL, 37, 1, NULL, 12000, NULL),
(63, NULL, 7, 37, NULL, 1, NULL, 16000),
(64, 7, NULL, 38, 1, NULL, 30000, NULL),
(65, NULL, 10, 38, NULL, 1, NULL, 30000),
(66, NULL, 15, 39, NULL, 1, NULL, 10000),
(67, 23, NULL, 39, 1, NULL, 5000, NULL),
(68, NULL, 1, 40, NULL, 1, NULL, 12000),

-- Itens adicionais
(69, 2, NULL, 1, 1, NULL, 5500, NULL),
(70, NULL, 22, 2, NULL, 1, NULL, 32000),
(71, 13, NULL, 3, 4, NULL, 32000, NULL),
(72, 22, NULL, 4, 1, NULL, 5500, NULL),
(73, NULL, 2, 5, NULL, 1, NULL, 6000),
(74, 1, NULL, 6, 1, NULL, 4500, NULL),
(75, NULL, 5, 7, NULL, 1, NULL, 15000),
(76, 18, NULL, 8, 1, NULL, 9000, NULL),
(77, NULL, 9, 10, NULL, 1, NULL, 24000),
(78, 13, NULL, 11, 4, NULL, 32000, NULL),
(79, NULL, 12, 12, NULL, 1, NULL, 8000),
(80, 19, NULL, 13, 1, NULL, 18000, NULL),
(81, NULL, 11, 14, NULL, 1, NULL, 18000),
(82, 24, NULL, 15, 1, NULL, 14000, NULL),
(83, NULL, 15, 16, NULL, 1, NULL, 10000),
(84, 26, NULL, 17, 2, NULL, 10000, NULL),
(85, NULL, 17, 18, NULL, 1, NULL, 7000),
(86, NULL, 25, 19, NULL, 1, NULL, 50000),
(87, 1, NULL, 20, 1, NULL, 4500, NULL),
(88, NULL, 16, 21, NULL, 1, NULL, 9000),
(89, 27, NULL, 22, 1, NULL, 7500, NULL),
(90, NULL, 14, 23, NULL, 1, NULL, 20000),
(91, 21, NULL, 24, 2, NULL, 5600, NULL),
(92, NULL, 18, 25, NULL, 1, NULL, 35000),
(93, 11, NULL, 26, 1, NULL, 16000, NULL),
(94, NULL, 1, 27, NULL, 1, NULL, 12000),
(95, 2, NULL, 28, 1, NULL, 5500, NULL),
(96, NULL, 15, 29, NULL, 1, NULL, 10000),
(97, 29, NULL, 30, 2, NULL, 2400, NULL),
(98, NULL, 22, 31, NULL, 1, NULL, 32000),
(99, 30, NULL, 32, 1, NULL, 3000, NULL),
(100, NULL, 20, 33, NULL, 1, NULL, 28000);

-- =========================================================
-- 14. PAGAMENTOS
--
-- 25 pagamentos.
-- OS entregues pagas integralmente.
-- OS 28 possui 2 parcelas.
-- Algumas OS finalizadas permanecem sem pagamento.
-- =========================================================

INSERT INTO pagamento
(id, valor, forma, numero_parcela, data_e_hora, colaborador_id, os_id)
VALUES
(1, 18000, 'PIX', NULL, '2026-05-06 16:00:00', 3, 1),

(2, 30000, 'Cartão de crédito', NULL, '2026-05-09 17:00:00', 3, 2),
(3, 16000, 'Dinheiro', NULL, '2026-05-19 17:00:00', 3, 4),
(4, 35000, 'PIX', NULL, '2026-06-19 16:00:00', 7, 11),

(5, 20000, 'PIX', NULL, '2026-07-13 16:00:00', 7, 20),

(6, 20000, 'Cartão de crédito', 1, '2026-07-24 16:00:00', 9, 28),
(7, 20000, 'Cartão de crédito', 2, '2026-08-05 16:00:00', 9, 28),

(8, 35000, 'PIX', NULL, '2026-08-06 16:00:00', 7, 36),
(9, 22000, 'PIX', NULL, '2026-08-07 16:00:00', 7, 37),
(10, 30000, 'Cartão de débito', NULL, '2026-08-09 16:00:00', 9, 38),

(11, 10000, 'PIX', NULL, '2026-07-24 10:00:00', 3, 3),
(12, 5000, 'PIX', 1, '2026-06-10 10:00:00', 7, 10),
(13, 15000, 'PIX', 2, '2026-06-20 10:00:00', 7, 10),

(14, 12000, 'Dinheiro', NULL, '2026-06-15 15:00:00', 7, 10),
(15, 8000, 'PIX', NULL, '2026-05-13 14:00:00', 3, 3),
(16, 10000, 'PIX', NULL, '2026-07-05 14:00:00', 3, 15),
(17, 11000, 'PIX', NULL, '2026-07-08 15:00:00', 3, 16),
(18, 20000, 'Cartão de crédito', NULL, '2026-07-10 15:00:00', 3, 17),
(19, 15000, 'PIX', NULL, '2026-07-19 16:00:00', 7, 23),
(20, 35000, 'PIX', NULL, '2026-07-21 16:00:00', 7, 24),
(21, 25000, 'Cartão de crédito', NULL, '2026-07-24 17:00:00', 9, 25),
(22, 18000, 'PIX', NULL, '2026-08-03 16:00:00', 3, 31),
(23, 28000, 'PIX', NULL, '2026-08-04 16:00:00', 3, 32),
(24, 30000, 'Cartão de crédito', 1, '2026-08-05 17:00:00', 3, 33),
(25, 15000, 'Cartão de crédito', 2, '2026-08-10 17:00:00', 3, 33);

-- =========================================================
-- 15. MOVIMENTAÇÕES
--
-- 40 movimentações.
-- Entradas e saídas.
-- Saídas ligadas a OS.
--
-- Peças 1-5 ficam abaixo do estoque mínimo.
-- =========================================================

INSERT INTO movimentacao
(id, estoque_atual, peca_id, fornecedor_id, quantidade, quando, motivo, colaborador_id, os_id)
VALUES
-- Entradas
(1, 5, 1, 1, 5, '2026-05-01 08:00:00', 'Entrada de estoque', 4, NULL),
(2, 6, 2, 1, 6, '2026-05-02 08:00:00', 'Entrada de estoque', 4, NULL),
(3, 4, 3, 2, 4, '2026-05-03 08:00:00', 'Entrada de estoque', 4, NULL),
(4, 5, 4, 4, 5, '2026-05-04 08:00:00', 'Entrada de estoque', 4, NULL),
(5, 4, 5, 4, 4, '2026-05-04 09:00:00', 'Entrada de estoque', 4, NULL),
(6, 8, 6, 4, 8, '2026-05-05 08:00:00', 'Entrada de estoque', 8, NULL),
(7, 5, 7, 3, 5, '2026-05-06 08:00:00', 'Entrada de estoque', 8, NULL),
(8, 5, 8, 3, 5, '2026-05-07 08:00:00', 'Entrada de estoque', 8, NULL),
(9, 8, 9, 5, 8, '2026-05-08 08:00:00', 'Entrada de estoque', 8, NULL),
(10, 8, 10, 5, 8, '2026-05-09 08:00:00', 'Entrada de estoque', 8, NULL),

-- Saídas vinculadas às OS
(11, 4, 1, 1, 1, '2026-05-05 10:00:00', 'Saída para OS', 4, 1),
(12, 4, 2, 1, 1, '2026-05-08 10:00:00', 'Saída para OS', 4, 2),
(13, 3, 4, 4, 2, '2026-05-08 11:00:00', 'Saída para OS', 4, 2),
(14, 4, 5, 4, 1, '2026-05-18 11:00:00', 'Saída para OS', 4, 4),
(15, 6, 7, 3, 2, '2026-06-05 11:00:00', 'Saída para OS', 8, 8),
(16, 4, 8, 3, 1, '2026-06-10 09:00:00', 'Saída para OS', 8, 9),
(17, 7, 9, 5, 1, '2026-06-18 10:00:00', 'Saída para OS', 8, 11),
(18, 3, 13, 2, 4, '2026-07-02 10:00:00', 'Saída para OS', 4, 14),
(19, 4, 2, 1, 1, '2026-07-04 11:00:00', 'Saída para OS', 4, 15),
(20, 3, 16, 3, 1, '2026-07-06 12:00:00', 'Saída para OS', 4, 16),
(21, 3, 25, 3, 2, '2026-07-08 14:00:00', 'Saída para OS', 4, 17),
(22, 3, 8, 3, 1, '2026-07-10 09:00:00', 'Saída para OS', 4, 18),
(23, 3, 10, 5, 1, '2026-07-14 10:00:00', 'Saída para OS', 8, 20),
(24, 7, 17, 3, 1, '2026-07-17 15:00:00', 'Saída para OS', 8, 22),
(25, 7, 28, 2, 1, '2026-07-18 09:00:00', 'Saída para OS', 8, 23),
(26, 4, 10, 5, 1, '2026-07-19 10:00:00', 'Saída para OS', 8, 24),
(27, 6, 22, 1, 2, '2026-07-20 10:00:00', 'Saída para OS', 10, 25),
(28, 4, 1, 1, 2, '2026-07-21 10:00:00', 'Saída para OS', 10, 26),
(29, 3, 4, 4, 1, '2026-07-23 10:00:00', 'Saída para OS', 10, 28),
(30, 4, 20, 5, 2, '2026-08-01 10:00:00', 'Saída para OS', 4, 31),
(31, 4, 14, 2, 1, '2026-08-02 10:00:00', 'Saída para OS', 4, 32),
(32, 2, 15, 3, 1, '2026-08-03 10:00:00', 'Saída para OS', 4, 33),
(33, 3, 16, 3, 1, '2026-08-04 10:00:00', 'Saída para OS', 4, 34),
(34, 3, 12, 3, 1, '2026-08-05 09:00:00', 'Saída para OS', 8, 35),
(35, 7, 9, 5, 1, '2026-08-06 10:00:00', 'Saída para OS', 8, 36),
(36, 4, 4, 4, 1, '2026-08-07 11:00:00', 'Saída para OS', 8, 37),
(37, 4, 7, 3, 1, '2026-08-08 10:00:00', 'Saída para OS', 10, 38),
(38, 2, 23, 1, 1, '2026-08-09 12:00:00', 'Saída para OS', 10, 39),
(39, 5, 29, 1, 2, '2026-08-10 13:00:00', 'Saída de material', 10, 40),
(40, 3, 30, 1, 1, '2026-08-10 14:00:00', 'Saída de material', 10, NULL);

-- =========================================================
-- 16. VERIFICAÇÕES
-- =========================================================

SELECT 'UNIDADES' AS tabela, COUNT(*) AS quantidade
FROM unidade;

SELECT 'COLABORADORES' AS tabela, COUNT(*) AS quantidade
FROM colaborador;

SELECT 'CLIENTES' AS tabela, COUNT(*) AS quantidade
FROM cliente;

SELECT 'TELEFONES' AS tabela,
       SUM(
         (numero_fixo IS NOT NULL) +
         (numero_celular IS NOT NULL) +
         (numero_externo IS NOT NULL)
       ) AS quantidade_numeros
FROM telefone;

SELECT 'VEICULOS' AS tabela, COUNT(*) AS quantidade
FROM veiculo;

SELECT 'CATEGORIAS' AS tabela, COUNT(*) AS quantidade
FROM categoria;

SELECT 'SERVICOS' AS tabela, COUNT(*) AS quantidade
FROM servico;

SELECT 'FORNECEDORES' AS tabela, COUNT(*) AS quantidade
FROM fornecedor;

SELECT 'PECAS' AS tabela, COUNT(*) AS quantidade
FROM peca;

SELECT 'ORDENS DE SERVICO' AS tabela, COUNT(*) AS quantidade
FROM ordem_de_servico;

SELECT 'ITENS DE OS' AS tabela, COUNT(*) AS quantidade
FROM item_os;

SELECT 'PAGAMENTOS' AS tabela, COUNT(*) AS quantidade
FROM pagamento;

SELECT 'MOVIMENTACOES' AS tabela, COUNT(*) AS quantidade
FROM movimentacao;

-- Status das OS
SELECT status, COUNT(*) AS quantidade
FROM ordem_de_servico
GROUP BY status
ORDER BY status;

-- Clientes com múltiplos veículos
SELECT cliente_id, COUNT(*) AS quantidade_veiculos
FROM veiculo
GROUP BY cliente_id
HAVING COUNT(*) >= 3;

-- Peças sem fornecedor
SELECT id, nome
FROM peca
WHERE fornecedor_id IS NULL;

-- Clientes sem telefone
SELECT c.id, c.nome
FROM cliente c
LEFT JOIN telefone t ON t.cliente_id = c.id
WHERE t.id IS NULL;

-- Clientes com 2 ou mais números
SELECT
    c.id,
    c.nome,
    (
      (t.numero_fixo IS NOT NULL) +
      (t.numero_celular IS NOT NULL) +
      (t.numero_externo IS NOT NULL)
    ) AS quantidade_numeros
FROM cliente c
JOIN telefone t ON t.cliente_id = c.id
WHERE
    (
      (t.numero_fixo IS NOT NULL) +
      (t.numero_celular IS NOT NULL) +
      (t.numero_externo IS NOT NULL)
    ) >= 2;

-- Peças cujo estoque atual está abaixo do mínimo
SELECT
    p.id,
    p.nome,
    p.estoque_minimo,
    m.estoque_atual
FROM peca p
JOIN movimentacao m ON m.id = (
    SELECT MAX(m2.id)
    FROM movimentacao m2
    WHERE m2.peca_id = p.id
)
WHERE m.estoque_atual < p.estoque_minimo;

-- OS abertas há mais de 7 dias
SELECT
    id,
    numero,
    status,
    data_e_hora
FROM ordem_de_servico
WHERE status = 'aberta'
  AND data_e_hora < DATE_SUB(NOW(), INTERVAL 7 DAY);

-- OS finalizadas sem pagamento
SELECT
    os.id,
    os.numero,
    os.status
FROM ordem_de_servico os
LEFT JOIN pagamento p ON p.os_id = os.id
WHERE os.status = 'finalizada'
GROUP BY os.id, os.numero, os.status
HAVING COUNT(p.id) = 0;

COMMIT;

SET UNIQUE_CHECKS = 1;
SET FOREIGN_KEY_CHECKS = 1;
