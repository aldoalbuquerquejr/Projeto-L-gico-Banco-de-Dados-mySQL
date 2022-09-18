-- My Ecommerce 

-- CRIANDO E PERSISTINDO INFORMAÇÕES NAS TABELAS

create database Ecommerce;
use Ecommerce;
show tables;

-- Tabela Cliente
create table Cliente (
	idCliente int auto_increment primary key,
    Nome varchar(10),
    Sobrenome varchar(10),
    CPF char(11) not null,
    Endereço varchar(45),
    constraint cpf_unico unique (CPF)
);

-- Persistindo informações em Clientes :)
select * from Cliente;
insert into Cliente (idCliente, Nome, Sobrenome, CPF, Endereço) 
			values (1, "João", "Silva", 356478902, "Aquela Rua, Nº 10"),
				   (2, "Maria", "Alcântara", 846726543, "Rua da Baixa Nº11"),
                   (3, "Alcides", "Da Mata", 874098765, "Rua Qualquer Nº13");

-- Tabela Produto
create table Produto (
	idProduto int auto_increment primary key,
    Produto_nome varchar(10) not null,
    Categoria enum("Infantil", "Roupas", "Alimentícios", "Papelaria", "Eletrônicos", "Cosméticos") not null,
    Descrição varchar(45),
    Dimensôes varchar(10),
    Valor float
);

-- Persistindo informações em Produto
select * from Produto;
insert into Produto (idProduto, Produto_nome, Categoria, Descrição, Dimensôes, Valor)
			values (1, "Barbeador", "Cosméticos", "Cremede de Barbear Nas Nuvens 500ml", "15x4x4", 15.50),
				   (2, "Headphones", "Eletrônicos", "Headphones Tampa Bluetooth", "8x8", 350.00),
                   (3, "Caneta", "Papelaria", "Caneta cor preta escrita 6mm", "12x4x3", 6.50);

-- Tabela Pagamento
create table Pagamento (
	idCliente int,
    idPagamento int,
    Tipo_Pagamento enum("Boleto", "Crédito", "Débito"),
    Limite_Disponível float,
    primary key (idCliente, idPagamento)
);

-- Persistindo informações em Pagamento
select * from Pagamento;
insert into Pagamento (idCliente, idPagamento, Tipo_Pagamento, Limite_Disponível)
			values (1, 1, "Boleto", 200.00),
                   (2, 2, "Crédito", 1250.00),
                   (3, 3, "Débito", 580.00);

-- Tabela Pedido
update Pedido set idPedido_Entrega = 3 where idPedido = 3;
create table Pedido (
	idPedido int auto_increment primary key,
    idPedido_Cliente int,
    idPedido_Entrega int,
    Descrição varchar(45),
    Frete float default 10,
    Pedido_Status enum("Em processamento","Confirmado","Em trânsito","Entregue") not null,
    constraint fk_pedido_cliente foreign key (idPedido_Cliente) references Cliente(idCliente),
    constraint fk_pedido_entrega foreign key (idPedido_Entrega) references Entrega(idEntrega)
);

-- Persistindo informações em Pedido
select * from Pedido;
insert into Pedido (idPedido, idPedido_Cliente, Descrição, Frete, Pedido_Status)
			values (1, 1, "Barbeador", 7.50, "Em processamento"),
                   (2, 2, "Headphones", 25.50, "Em trânsito"),
                   (3, 3, "Caneta", 0.0, "Em trânsito");

-- Tabela Estoque
create table Estoque (
	idEstoque int auto_increment primary key,
    Localização varchar(255),
    Quantidade int default 0
);

-- Persistindo informações em Estoque
select * from Estoque;
insert into Estoque (idEstoque, Localização, Quantidade)
			values (1, "Petrópolis - RJ", 450),
                   (2, "Araraquara - SP", 350),
                   (3, "São Bento - PB", 200);

-- Tabela Fornecedor
create table Fornecedor (
	idFornecedor int auto_increment primary key,
    CNPJ char(14) not null,
	Localização varchar(255),
    Contato char(14) not null,
    constraint CNPJ_Unico unique (CNPJ)
);

-- Persistindo informaões em Fornecedor
select * from Fornecedor;
insert into Fornecedor (idFornecedor, CNPJ, Localização, Contato)
			values (1, 06789543675432, "Petrópolis - RJ", 98765213456),
                   (2, 78698754632432, "Araraquara - SP", 98725698709),
                   (3, 09765871234543, "São Bento - PB", 99876234122);

-- Tabela Vendedor
create table Vendedor (
	idVendedor int auto_increment primary key,
    Nome_Social varchar(255) not null,
    CNPJ char(14),
    CPF char(11),
    Contato char(11) not null,
    Localização varchar(255),
    constraint CNPJ_Unico_Vendedor unique (CNPJ),
    constraint CPF_Unico_Vendedor unique (CPF)
);

-- Persistindo informações em Vendedor
select * from Vendedor;
insert into Vendedor (idVendedor, Nome_Social, CNPJ, CPF, Contato, Localização)
			values (1, "Papelaria Macedo", 098367865431, 97098356785, 99654872431, "Rio de Janeiro - RJ"),
                   (2, "Eletrônicos Fulano", 46789025678453, 09256789321, 99765345621, "São Paulo - SP"),
                   (3, "Cosméticos Abreu", 09854376587654, 87690876543, 99876987987, "João Pessoa - PB");

-- Tabela Produto/Fornecedor
create table Produto_Fornecedor (
	idPF_Fornecedor int,
    idPF_Produto int,
    Quantidade int not null,
    primary key (idPF_Fornecedor, idPF_Produto),
    constraint fk_PF_Fornecedor foreign key (idPF_Fornecedor) references Fornecedor(idFornecedor),
    constraint fk_PF_Produto foreign key (idPF_Produto) references Produto(idProduto) 
);

-- Persistindo Informações em Produto/Fornecedor
select * from Produto_Fornecedor;
insert into Produto_Fornecedor (idPF_Fornecedor, idPF_Produto, Quantidade)
			values (1, 1, 1),
                   (2, 2, 1),
                   (3, 3, 1);

-- Tabela Produto/Vendedor
create table Produto_Vendedor (
	idPV_Vendedor int,
    idPV_Produto int,
    Quantidade int default 1,
    primary key (idPV_Vendedor, idPV_Produto),
    constraint fk_PV_Vendedor foreign key (idPV_Vendedor) references Vendedor(idVendedor),
    constraint fk_PV_Produto foreign key (idPV_Produto) references Produto(idProduto)
);

-- Persistinfo informações em Produto/Vendedor
select * from Produto_Vendedor;
insert into Produto_Vendedor (idPV_Vendedor, idPV_Produto, Quantidade)
			values (1, 1, 1),
                   (2, 2, 1),
                   (3, 3, 1);

-- Tabela Produto/Estoque
create table Produto_Estoque (
	idPE_Estoque int,
    idPE_Produto int,
    Quantidade int default 0,
    primary key (idPE_Estoque, idPE_Produto),
    constraint fk_PE_Estoque foreign key (idPE_Estoque) references Estoque(idEstoque),
    constraint fk_PE_Produto foreign key (idPE_Produto) references Produto(idProduto)
);

-- Persistindo informações em Produto/Estoque
select * from Produto_Estoque;
insert into Produto_Estoque (idPE_Estoque, idPE_Produto, Quantidade)
			values (1, 1, 450),
				   (2, 2, 350),
                   (3, 3, 200);

-- Tabela Produto/Pedido
create table Produto_Pedido (
	idPP_Pedido int,
    idPP_Produto int,
    Quantidade int default 1,
    PP_Status enum("Disponível em estoque", "Sem estoque") default "Disponível em estoque",
    primary key (idPP_Pedido, idPP_Produto),
    constraint fk_PP_Pedido foreign key (idPP_Pedido) references Pedido(idPedido),
    constraint fk_PP_Produto foreign key (idPP_Produto) references Produto(idProduto)
);

-- Persistindo informações em Produto/Pedido
select * from Produto_Pedido;
insert into Produto_Pedido (idPP_Pedido, idPP_Produto, Quantidade, PP_Status)
			values (1, 1, 1, "Disponível em estoque"),
                   (2, 2, 1, "Disponível em estoque"),
                   (3, 3, 1, "Disponível em estoque");

create table Entrega (
	idEntrega int auto_increment not null primary key,
    Entrega_Status enum("Em processamento", "Enviado", "Em trândito", "Entregue")
);

-- Persistindo valores em Entrega
alter table Entrega add Entrega_Status enum("Em processamento", "Confirmado", "Em trânsito", "Entregue");
drop table Entrega;
select * from Entrega;
delete from Entrega where idEntrega = 9;
insert into Entrega (idEntrega, Entrega_Status)
			values (1, "Em processamento"),
                   (2, "Em trânsito"),
                   (3, "Em trânsito");

-- ELABORANDO QUERIES!!

-- Quanto ào status dos pedidos dos respectivos clientes
select C.Nome, C.Sobrenome, P.Descrição, P.Pedido_Status
from Cliente as C, Pedido as P
where C.idCliente = idPedido;

-- Ordenar produto, descrição, valor por valor
select Produto_nome, Valor, Descrição from Produto
where Valor > 10.0
order by Valor;

-- Unindo tabelas na condição idProduto = idPedido
select * from Produto
inner join Pedido
on idProduto = idPedido;

-- Buscar nome, sobrenome, nome do produto e descrição, unindo e ordenando por valor
select c.Nome, c.Sobrenome, pr.Produto_nome, pr.Descrição
from Cliente c inner join Produto pr 
on c.idCliente = pr.idProduto
inner join pedido pe
on pr.idProduto = pe.idPedido
order by Valor;

-- Nome completo, nome do produto, status de entrega e valor ordenados na condição having
select concat(Nome, ' ' , Sobrenome) as Nome_Completo, pr.Produto_nome, pr.Valor, pe.Pedido_Status
from Cliente c, Produto pr, Pedido pe
where idCliente = idProduto and idProduto = idPedido
having Valor > 10;

-- Acrescentando R$15,00 ao frete inicial
select pr.Produto_nome, pr.Descrição, pe.Descrição, pe.Frete, pe.Frete + 15.0 as Acrescimo_Frete
from Produto pr, Pedido pe
where idProduto = idPedido;
