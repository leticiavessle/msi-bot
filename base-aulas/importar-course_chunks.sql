-- Base de aulas da MSI para a tabela course_chunks (gerado de base-aulas/chunks.jsonl).
-- Rodar no SQL Editor do Supabase DEPOIS das migrações. Pode rodar de novo: atualiza o que já existe.
-- 519 partes · versão 2026-10-04
begin;
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M04.A01-01', 'principal', 1, 4, 'V1.M04.A01 — Demandas Cash: Como e Por Que Funciona?', 'Visão geral', 'Demandas Cash: Como e Por Que Funciona?', 'Método Sócia Invisível › Módulo 04 – Anatomia das Demandas Lucrativas › Aula 01 – Demandas Cash: Como e Por Que Funciona? › Visão geral da aula

Nome oficial da aula: Demandas Cash: Como e Por Que Funciona?
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 04 – Anatomia das Demandas Lucrativas, Aula 01
Duração/formato: 2:46
Link na área de membros (abre a página do Módulo 04, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/4

Resumo:
É uma aula curta de abertura do Módulo 04 que define o que são as subdemandas e apresenta os 3 motivos pelos quais elas funcionam. A aula não traz passos práticos. É conceitual e motivacional, preparando o terreno para as próximas aulas do módulo.', 'approved', ARRAY['Demandas Cash','Anatomia das Demandas Lucrativas','alta demanda','baixa barreira de entrada','resultados ágeis','Suprema']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M04.A01-02', 'principal', 1, 4, 'V1.M04.A01 — Demandas Cash: Como e Por Que Funciona?', 'O que são subdemandas (definição da aula)', 'Demandas Cash: Como e Por Que Funciona?', 'Método Sócia Invisível › Módulo 04 – Anatomia das Demandas Lucrativas › Aula 01 – Demandas Cash: Como e Por Que Funciona? › O que são subdemandas (definição da aula)

"Ações específicas e rápidas que você pode realizar para outras pessoas e empresas. São oportunidades com demanda muito alta no mercado e que podem ser feitas por você, mesmo começando do zero."
Exemplos genéricos citados: criar algo, organizar informações ou execução direta, a maioria de forma remota.', 'approved', ARRAY['Demandas Cash','Anatomia das Demandas Lucrativas','alta demanda','baixa barreira de entrada','resultados ágeis','Suprema']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M04.A01-03', 'principal', 1, 4, 'V1.M04.A01 — Demandas Cash: Como e Por Que Funciona?', 'Por que funcionam: 3 motivos', 'Demandas Cash: Como e Por Que Funciona?', 'Método Sócia Invisível › Módulo 04 – Anatomia das Demandas Lucrativas › Aula 01 – Demandas Cash: Como e Por Que Funciona? › Por que funcionam: 3 motivos

| # | Motivo | Explicação da aula |
|---|---|---|
| 1 | Alta demanda no mercado | Empresas e pessoas precisam de ajuda para resolver problemas específicos. A procura é enorme e dá para trabalhar remotamente, de onde estiver. |
| 2 | Baixa barreira de entrada | Não exige muito tempo para começar, equipamentos caros nem conhecimentos avançados. O que importa é aprender o método e aplicar com consistência. |
| 3 | Resultados ágeis | Por serem ações específicas, dá para entregar rápido e já pegar outra. É ideal para quem está começando e precisa de retorno. |', 'approved', ARRAY['Demandas Cash','Anatomia das Demandas Lucrativas','alta demanda','baixa barreira de entrada','resultados ágeis','Suprema']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M04.A01-04', 'principal', 1, 4, 'V1.M04.A01 — Demandas Cash: Como e Por Que Funciona?', 'Para quem é (segundo a aula)', 'Demandas Cash: Como e Por Que Funciona?', 'Método Sócia Invisível › Módulo 04 – Anatomia das Demandas Lucrativas › Aula 01 – Demandas Cash: Como e Por Que Funciona? › Para quem é (segundo a aula)

- Quem se sente preso num trabalho que não valoriza.
- Quem está desempregada.
- Quem quer uma renda extra.
O benefício destacado é a liberdade: trabalhar nos próprios horários e estar mais presente com a família.', 'approved', ARRAY['Demandas Cash','Anatomia das Demandas Lucrativas','alta demanda','baixa barreira de entrada','resultados ágeis','Suprema']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M04.A01-05', 'principal', 1, 4, 'V1.M04.A01 — Demandas Cash: Como e Por Que Funciona?', 'Procedimento: o que a aluna deve fazer', 'Demandas Cash: Como e Por Que Funciona?', 'Método Sócia Invisível › Módulo 04 – Anatomia das Demandas Lucrativas › Aula 01 – Demandas Cash: Como e Por Que Funciona? › Procedimento: o que a aluna deve fazer

1. Assistir à aula para entender o conceito. Não há ação prática.
2. Seguir para a Aula 02 do Módulo 04.', 'approved', ARRAY['Demandas Cash','Anatomia das Demandas Lucrativas','alta demanda','baixa barreira de entrada','resultados ágeis','Suprema']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M04.A01-06', 'principal', 1, 4, 'V1.M04.A01 — Demandas Cash: Como e Por Que Funciona?', 'FAQ', 'Demandas Cash: Como e Por Que Funciona?', 'Método Sócia Invisível › Módulo 04 – Anatomia das Demandas Lucrativas › Aula 01 – Demandas Cash: Como e Por Que Funciona? › Pontos para o suporte

- "O que são as demandas/subdemandas?" São ações específicas e rápidas feitas remotamente para pessoas e empresas, com alta procura, que dá para fazer começando do zero.
- "Preciso de experiência, equipamento caro ou conhecimento avançado?" Não, segundo a aula. É a "baixa barreira de entrada".
- "Por que isso funciona?" Por causa da alta demanda, da baixa barreira de entrada e dos resultados rápidos.', 'approved', ARRAY['Demandas Cash','Anatomia das Demandas Lucrativas','alta demanda','baixa barreira de entrada','resultados ágeis','Suprema']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M04.A02-01', 'principal', 1, 4, 'V1.M04.A02 — As Leis das Demandas Lucrativas: O que PODE e o que NÃO PODE', 'Visão geral', 'As Leis das Demandas Lucrativas: O que PODE e o que NÃO PODE', 'Método Sócia Invisível › Módulo 04 – Anatomia das Demandas Lucrativas › Aula 02 – As Leis das Demandas Lucrativas: O que PODE e o que NÃO PODE › Visão geral da aula

Nome oficial da aula: As Leis das Demandas Lucrativas: O que PODE e o que NÃO PODE
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 04 – Anatomia das Demandas Lucrativas, Aula 02
Duração/formato: 7:08
Link na área de membros (abre a página do Módulo 04, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/4

Resumo:
É uma aula de conduta profissional para quem realiza demandas. Ela lista 5 atitudes que funcionam e 5 erros a evitar para garantir faturamento constante e uma boa reputação com quem contratou. Os temas centrais são cumprir prazos, manter a qualidade, comunicar-se bem, organizar-se, definir o escopo, negociar e cobrar o valor justo. A aula pede que a aluna anote tudo no caderno.', 'approved', ARRAY['Leis das Demandas Lucrativas','o que pode e o que não pode','regras das demandas','escopo','reputação','quem contratou','Trello','Google Agenda','Notion','caderno','blocos de tempo']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M04.A02-02', 'principal', 1, 4, 'V1.M04.A02 — As Leis das Demandas Lucrativas: O que PODE e o que NÃO PODE', '✅ O que PODE: 5 atitudes', 'As Leis das Demandas Lucrativas: O que PODE e o que NÃO PODE', 'Método Sócia Invisível › Módulo 04 – Anatomia das Demandas Lucrativas › Aula 02 – As Leis das Demandas Lucrativas: O que PODE e o que NÃO PODE › ✅ O que PODE: 5 atitudes

| # | Atitude | Como aplicar |
|---|---|---|
| 1 | Compromisso com prazo e qualidade | Revisar antes de enviar, conferir se está tudo como combinado e, se der, entregar um pouco além do esperado. |
| 2 | Comunicação clara e objetiva | Deixar claro desde o início o que você entrega, os prazos e o que está incluso. Atualizar o andamento sem esperar que perguntem. |
| 3 | Organização para várias demandas | Controlar prazos, entregas e feedbacks no Trello, Google Agenda, Notion ou num caderno. Dividir o dia em blocos de tempo. |
| 4 | Limites claros desde o início | Definir o que está incluso e o que é extra. Não aceitar tudo o que foge do escopo. |
| 5 | Flexibilidade com negociação | Ser flexível, mas explicar quando o pedido foge do escopo e negociar um valor adicional se for o caso. |', 'approved', ARRAY['Leis das Demandas Lucrativas','o que pode e o que não pode','regras das demandas','escopo','reputação','quem contratou','Trello','Google Agenda','Notion','caderno','blocos de tempo']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M04.A02-03', 'principal', 1, 4, 'V1.M04.A02 — As Leis das Demandas Lucrativas: O que PODE e o que NÃO PODE', '❌ O que NÃO PODE: 5 erros', 'As Leis das Demandas Lucrativas: O que PODE e o que NÃO PODE', 'Método Sócia Invisível › Módulo 04 – Anatomia das Demandas Lucrativas › Aula 02 – As Leis das Demandas Lucrativas: O que PODE e o que NÃO PODE › ❌ O que NÃO PODE: 5 erros

| # | Erro | Como evitar |
|---|---|---|
| 1 | Atrasar ou estourar o prazo sem avisar | Se não for dar tempo, avisar na hora e oferecer uma solução: renegociar o prazo, entregar uma parte ou dar um extra como compensação. |
| 2 | Aceitar mais demandas do que consegue entregar | Poucas demandas bem feitas valem mais do que muitas mal feitas. A reputação vale mais do que um ganho imediato. |
| 3 | Ignorar feedbacks | Receber o ajuste sem se colocar na defensiva e corrigir. Isso fideliza quem contratou. |
| 4 | Subestimar o valor do trabalho | Não cobrar muito pouco por medo. Preço baixo demais gera desconfiança sobre a qualidade. |
| 5 | Sumir durante o processo | Combinar pontos de contato, mandar atualizações e responder rápido, nem que seja: "Recebi sua mensagem, te respondo com mais detalhes em breve." |', 'approved', ARRAY['Leis das Demandas Lucrativas','o que pode e o que não pode','regras das demandas','escopo','reputação','quem contratou','Trello','Google Agenda','Notion','caderno','blocos de tempo']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M04.A02-04', 'principal', 1, 4, 'V1.M04.A02 — As Leis das Demandas Lucrativas: O que PODE e o que NÃO PODE', 'Procedimento: o que a aluna deve fazer', 'As Leis das Demandas Lucrativas: O que PODE e o que NÃO PODE', 'Método Sócia Invisível › Módulo 04 – Anatomia das Demandas Lucrativas › Aula 02 – As Leis das Demandas Lucrativas: O que PODE e o que NÃO PODE › Procedimento: o que a aluna deve fazer

1. Anotar no caderno as 5 atitudes e os 5 erros.
2. Escolher uma ferramenta de organização (Trello, Google Agenda, Notion ou caderno) para controlar prazos, entregas e feedbacks.
3. Aplicar as regras em cada demanda. Antes de aceitar: definir escopo, prazo e o que está incluso. Durante: atualizar quem contratou. Antes de entregar: revisar.
4. Seguir para a próxima aula do Módulo 04.', 'approved', ARRAY['Leis das Demandas Lucrativas','o que pode e o que não pode','regras das demandas','escopo','reputação','quem contratou','Trello','Google Agenda','Notion','caderno','blocos de tempo']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M04.A02-05', 'principal', 1, 4, 'V1.M04.A02 — As Leis das Demandas Lucrativas: O que PODE e o que NÃO PODE', 'FAQ', 'As Leis das Demandas Lucrativas: O que PODE e o que NÃO PODE', 'Método Sócia Invisível › Módulo 04 – Anatomia das Demandas Lucrativas › Aula 02 – As Leis das Demandas Lucrativas: O que PODE e o que NÃO PODE › Pontos para o suporte

- "Não vou conseguir entregar no prazo, o que faço?" Avisar na hora quem contratou e propor uma solução: novo prazo, entrega parcial ou um extra.
- "Posso pegar várias demandas ao mesmo tempo?" Só as que der para entregar com qualidade. A aula desaconselha pegar demais.
- "Pediram algo a mais do que o combinado." Explicar que está fora do escopo e, se for o caso, negociar um valor adicional.
- "Como me organizo?" Com Trello, Google Agenda, Notion ou caderno, e blocos de tempo por tarefa.', 'approved', ARRAY['Leis das Demandas Lucrativas','o que pode e o que não pode','regras das demandas','escopo','reputação','quem contratou','Trello','Google Agenda','Notion','caderno','blocos de tempo']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M04.A03-01', 'principal', 1, 4, 'V1.M04.A03 — Vantagens de Realizar as Demandas', 'Visão geral', 'Vantagens de Realizar as Demandas', 'Método Sócia Invisível › Módulo 04 – Anatomia das Demandas Lucrativas › Aula 03 – Vantagens de Realizar as Demandas › Visão geral da aula

Nome oficial da aula: Vantagens de Realizar as Demandas
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 04 – Anatomia das Demandas Lucrativas, Aula 03
Duração/formato: 5:16
Link na área de membros (abre a página do Módulo 04, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/4

Resumo:
É uma aula que apresenta 8 vantagens de trabalhar com as demandas e intercala duas dicas práticas: criar uma rotina com horários fixos e começar com preços competitivos, ajustando depois. A intenção é dar clareza e motivação. A aula não ensina a executar demandas.', 'approved', ARRAY['vantagens das demandas','benefícios','por que vale a pena','trabalho remoto','liberdade geográfica','baixo investimento inicial','autonomia e controle']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M04.A03-02', 'principal', 1, 4, 'V1.M04.A03 — Vantagens de Realizar as Demandas', 'As 8 vantagens', 'Vantagens de Realizar as Demandas', 'Método Sócia Invisível › Módulo 04 – Anatomia das Demandas Lucrativas › Aula 03 – Vantagens de Realizar as Demandas › As 8 vantagens

| # | Vantagem | O que a aula diz |
|---|---|---|
| 1 | Flexibilidade de horários | Trabalhar quando for conveniente: quando os filhos estão na escola ou dormindo, ou em algumas horas livres de quem tem outro emprego. |
| 2 | Trabalho remoto | Basta celular ou computador com internet. Dá para trabalhar de casa, de uma cafeteria ou viajando, e ainda economizar com transporte e alimentação. |
| 3 | Baixo investimento inicial | Começar com o que já tem, sem equipamentos caros. É acessível a qualquer condição financeira. |
| 4 | Mercado em crescimento / alta procura | Empresas buscam soluções rápidas e específicas, e não é preciso ser especialista. Exemplo: organizar informações, criar algo ou executar uma demanda direta, em vez de contratar um funcionário fixo. |
| 5 | Potencial de crescimento financeiro | Pode virar a renda principal. Com experiência, reputação e clientes fiéis, dá para cobrar mais. |
| 6 | Desenvolvimento de habilidades | Aprender continuamente e abrir novas portas. |
| 7 | Autonomia e controle | A aluna decide quantas demandas aceita, quanto cobra e como organiza o tempo, sem chefe. |
| 8 | Transformação financeira | Sair do sufoco, pagar dívidas e realizar sonhos. "Dá para ganhar já no primeiro dia." |', 'approved', ARRAY['vantagens das demandas','benefícios','por que vale a pena','trabalho remoto','liberdade geográfica','baixo investimento inicial','autonomia e controle']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M04.A03-03', 'principal', 1, 4, 'V1.M04.A03 — Vantagens de Realizar as Demandas', 'Procedimento: dicas práticas da aula', 'Vantagens de Realizar as Demandas', 'Método Sócia Invisível › Módulo 04 – Anatomia das Demandas Lucrativas › Aula 03 – Vantagens de Realizar as Demandas › Procedimento: dicas práticas da aula

1. Criar uma rotina: definir horários específicos para trabalhar e respeitá-los como compromissos importantes.
2. Precificar em etapas: começar com valores competitivos para atrair os primeiros clientes e ajustar os preços conforme ganhar confiança e reputação.
3. Seguir para a próxima aula do Módulo 04.', 'approved', ARRAY['vantagens das demandas','benefícios','por que vale a pena','trabalho remoto','liberdade geográfica','baixo investimento inicial','autonomia e controle']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M04.A03-04', 'principal', 1, 4, 'V1.M04.A03 — Vantagens de Realizar as Demandas', 'FAQ', 'Vantagens de Realizar as Demandas', 'Método Sócia Invisível › Módulo 04 – Anatomia das Demandas Lucrativas › Aula 03 – Vantagens de Realizar as Demandas › Pontos para o suporte

- "Preciso investir para começar?" Segundo a aula, basta celular ou computador com internet. (Lembrar que a Soffia, apresentada no M01, é paga depois dos 30 dias grátis.)
- "Consigo conciliar com o meu emprego, filhos ou estudos?" Sim. A flexibilidade de horários é a primeira vantagem citada.
- "Dá para virar renda principal?" A aula diz que pode, "dependendo do seu comprometimento e dedicação". Não prometer valores.', 'approved', ARRAY['vantagens das demandas','benefícios','por que vale a pena','trabalho remoto','liberdade geográfica','baixo investimento inicial','autonomia e controle']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M04.A04-01', 'principal', 1, 4, 'V1.M04.A04 — Ciclo de Pagamento: O que é e Como Funciona', 'Visão geral', 'Ciclo de Pagamento: O que é e Como Funciona', 'Método Sócia Invisível › Módulo 04 – Anatomia das Demandas Lucrativas › Aula 04 – Ciclo de Pagamento: O que é e Como Funciona › Visão geral da aula

Nome oficial da aula: Ciclo de Pagamento: O que é e Como Funciona
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 04 – Anatomia das Demandas Lucrativas, Aula 04
Duração/formato: 4:09
Link na área de membros (abre a página do Módulo 04, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/4

Resumo:
A aula explica o ciclo de pagamento, ou seja, o período entre realizar a demanda e o dinheiro ser liberado. Esse período varia conforme quem contratou, o canal usado e o que foi combinado. A aula ensina a alinhar o pagamento antes de começar, apresenta os tipos, prazos e meios de pagamento e dá dicas de organização financeira.', 'approved', ARRAY['ciclo de pagamento','quando eu recebo','prazo de pagamento','pagamento das demandas','pagamento antecipado','pagamento por etapas','pagamento após a entrega','reserva financeira','planejamento de caixa','fluxo de caixa']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M04.A04-02', 'principal', 1, 4, 'V1.M04.A04 — Ciclo de Pagamento: O que é e Como Funciona', 'Procedimento: passo a passo', 'Ciclo de Pagamento: O que é e Como Funciona', 'Método Sócia Invisível › Módulo 04 – Anatomia das Demandas Lucrativas › Aula 04 – Ciclo de Pagamento: O que é e Como Funciona › Procedimento: passo a passo

### 1. Alinhar o pagamento ANTES de começar a demanda
Perguntar a quem contratou:
- Qual é o valor total?
- Qual é o prazo de pagamento?
- O pagamento é antes, durante ou depois da entrega?
- Qual é o meio de pagamento: Pix, transferência etc.?
➡️ Registrar tudo por escrito, em mensagem, e-mail ou contrato.
### 2. Escolher o tipo de pagamento
| Tipo | Como funciona |
|---|---|
| Antecipado | Quem contratou paga antes de a demanda começar. |
| Por etapas ⭐ | Uma parte no início e o restante depois da entrega. É o que a Gabriela mais usa, porque protege os dois lados e passa profissionalismo. |
| Após a entrega | Paga só quando a demanda é finalizada. |
### 3. Prazo
Os prazos variam. A recomendação da Gabriela é receber logo após a entrega. Se oferecerem um prazo longo, negociar para encurtar, por exemplo com um pagamento parcial no início e o restante na entrega.
### 4. Meio de recebimento
| Meio | Observação |
|---|---|
| Pix | O mais rápido: cai em segundos. |
| Transferência bancária | É segura, mas pode demorar, dependendo do banco. |
| Pelo canal/plataforma | Se a demanda veio de um canal específico, o pagamento pode ser feito por lá. |
➡️ Ter mais de uma opção de recebimento disponível.
### 5. Organização financeira
- Reserva financeira para despesas emergenciais, já que os prazos variam.
- Planejamento de caixa: anotar cada demanda, o valor a receber e o prazo de pagamento.
- Fazer mais de uma demanda ao mesmo tempo, respeitando o próprio limite, para ter mais segurança financeira.', 'approved', ARRAY['ciclo de pagamento','quando eu recebo','prazo de pagamento','pagamento das demandas','pagamento antecipado','pagamento por etapas','pagamento após a entrega','reserva financeira','planejamento de caixa','fluxo de caixa']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M04.A04-03', 'principal', 1, 4, 'V1.M04.A04 — Ciclo de Pagamento: O que é e Como Funciona', 'FAQ', 'Ciclo de Pagamento: O que é e Como Funciona', 'Método Sócia Invisível › Módulo 04 – Anatomia das Demandas Lucrativas › Aula 04 – Ciclo de Pagamento: O que é e Como Funciona › Pontos para o suporte

- "Quando eu recebo pelas demandas?" Depende do ciclo de pagamento, ou seja, do que foi combinado e do canal usado. A aula recomenda receber logo após a entrega e, de preferência, por Pix.
- "Como eu recebo?" Por Pix, transferência ou pela própria plataforma de onde veio a demanda.
- "Como evitar calote?" Combinar valor, prazo e forma de pagamento por escrito antes de começar e preferir pagamento por etapas.', 'approved', ARRAY['ciclo de pagamento','quando eu recebo','prazo de pagamento','pagamento das demandas','pagamento antecipado','pagamento por etapas','pagamento após a entrega','reserva financeira','planejamento de caixa','fluxo de caixa']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M04.A05-01', 'principal', 1, 4, 'V1.M04.A05 — Tudo que você aprendeu', 'Visão geral', 'Tudo que você aprendeu', 'Método Sócia Invisível › Módulo 04 – Anatomia das Demandas Lucrativas › Aula 05 – Tudo que você aprendeu › Visão geral da aula

Nome oficial da aula: Tudo que você aprendeu
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 04 – Anatomia das Demandas Lucrativas, Aula 05
Duração/formato: 4:07
Link na área de membros (abre a página do Módulo 04, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/4

Resumo:
É a aula de encerramento do Módulo 04. Ela revisa as 4 aulas anteriores e traz os próximos passos para colocar o conteúdo em prática. A orientação é voltar às aulas anteriores sempre que surgir uma dúvida.', 'approved', ARRAY['Tudo que você aprendeu','revisão do módulo 4','resumo do módulo','MOD 4 AULA 5','próximos passos','colocando em prática','suporte 24x7','suporte 24/7']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M04.A05-02', 'principal', 1, 4, 'V1.M04.A05 — Tudo que você aprendeu', 'Revisão do módulo', 'Tudo que você aprendeu', 'Método Sócia Invisível › Módulo 04 – Anatomia das Demandas Lucrativas › Aula 05 – Tudo que você aprendeu › Revisão do módulo

| Aula | Tema | Principal aprendizado |
|---|---|---|
| 01 – Demandas Cash | O que são as demandas e por que funcionam | Alta procura por soluções rápidas, acessíveis a iniciantes, com resultado rápido e sem grande investimento. |
| 02 – Leis das Demandas Lucrativas | O que fazer e o que evitar | Fazer: prazos, comunicação clara, organização, qualidade. Evitar: atrasos, pegar demandas demais, ignorar feedback, cobrar pouco, misturar o pessoal com o profissional. |
| 03 – Vantagens | Benefícios do modelo | Flexibilidade, trabalho remoto, baixo custo, alta demanda, crescimento, habilidades e autonomia. |
| 04 – Ciclo de Pagamento | Como e quando se recebe | Alinhar antes, conhecer tipos, prazos e meios de pagamento, e se organizar financeiramente. |', 'approved', ARRAY['Tudo que você aprendeu','revisão do módulo 4','resumo do módulo','MOD 4 AULA 5','próximos passos','colocando em prática','suporte 24x7','suporte 24/7']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M04.A05-03', 'principal', 1, 4, 'V1.M04.A05 — Tudo que você aprendeu', 'Procedimento: próximos passos', 'Tudo que você aprendeu', 'Método Sócia Invisível › Módulo 04 – Anatomia das Demandas Lucrativas › Aula 05 – Tudo que você aprendeu › Procedimento: próximos passos

1. Definir o objetivo: por que você quer fazer demandas? Renda extra, pagar dívidas, liberdade financeira, mais tempo com a família?
2. Criar uma rotina com horários específicos de trabalho.
3. Começar pequeno: escolher uma ou duas demandas para começar e crescer aos poucos.
4. Aprender sempre: diante de uma dúvida, voltar às aulas e revisar.
5. Se a dúvida não estiver nas aulas, chamar o suporte.
6. Seguir para o Módulo 05.', 'approved', ARRAY['Tudo que você aprendeu','revisão do módulo 4','resumo do módulo','MOD 4 AULA 5','próximos passos','colocando em prática','suporte 24x7','suporte 24/7']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M04.A05-04', 'principal', 1, 4, 'V1.M04.A05 — Tudo que você aprendeu', 'FAQ', 'Tudo que você aprendeu', 'Método Sócia Invisível › Módulo 04 – Anatomia das Demandas Lucrativas › Aula 05 – Tudo que você aprendeu › Pontos para o suporte

- "Terminei o Módulo 4, e agora?" Definir o objetivo, montar uma rotina, começar com 1 ou 2 demandas e seguir para o Módulo 05.
- "Tenho uma dúvida sobre o conteúdo do módulo." Indicar a aula específica usando a tabela de revisão acima.', 'approved', ARRAY['Tudo que você aprendeu','revisão do módulo 4','resumo do módulo','MOD 4 AULA 5','próximos passos','colocando em prática','suporte 24x7','suporte 24/7']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M05.A01-01', 'principal', 1, 5, 'V1.M05.A01 — Mindset da Dupla Jornada: Como Mulheres estão Multiplicando sua Renda', 'Visão geral', 'Mindset da Dupla Jornada: Como Mulheres estão Multiplicando sua Renda', 'Método Sócia Invisível › Módulo 05 – Como Ganhar Mais Trabalhando Menos › Aula 01 – Mindset da Dupla Jornada: Como Mulheres estão Multiplicando sua Renda › Visão geral da aula

Nome oficial da aula: Mindset da Dupla Jornada: Como Mulheres estão Multiplicando sua Renda
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 05 – Como Ganhar Mais Trabalhando Menos, Aula 01
Duração/formato: 5:24
Link na área de membros (abre a página do Módulo 05, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/5

Resumo:
É a abertura do Módulo 05, voltada principalmente à mulher CLT. A aula apresenta o "mindset da dupla renda": parar de ver o salário como teto e usar as habilidades que já tem (do trabalho e de casa) para fazer subdemandas para empresas nas horas vagas. Traz uma conta de exemplo de renda extra e termina com uma missão: listar 5 habilidades.', 'approved', ARRAY['Mindset da Dupla Jornada','mindset da dupla renda','dupla renda','Como ganhar mais trabalhando menos','pequenas demandas','pequenos trabalhos','CLT','carteira assinada','5 habilidades','missão da aula']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M05.A01-02', 'principal', 1, 5, 'V1.M05.A01 — Mindset da Dupla Jornada: Como Mulheres estão Multiplicando sua Renda', 'Pontos principais', 'Mindset da Dupla Jornada: Como Mulheres estão Multiplicando sua Renda', 'Método Sócia Invisível › Módulo 05 – Como Ganhar Mais Trabalhando Menos › Aula 01 – Mindset da Dupla Jornada: Como Mulheres estão Multiplicando sua Renda › Pontos principais

- Mindset da dupla renda: pensar como "empresária da própria vida". O salário CLT não é o limite, e 2 horas livres por dia são um ativo.
- A diferença não está no tempo nem na sorte, e sim na forma de pensar e no que se faz com as horas que sobram.
- O que são subdemandas (segundo esta aula): tarefas pequenas e importantes que empresas e empreendedores não conseguem resolver sozinhos. Exemplos:
  - organizar planilhas;
  - escrever textos para redes sociais;
  - fazer pesquisas na internet;
  - criar apresentações;
  - responder mensagens e fazer ligações;
  - organizar agendas;
  - ajudar com assuntos específicos.
- Por que as mulheres se destacam: disciplina de horários, trabalho sob pressão, atenção aos detalhes, organização e capacidade de fazer várias coisas ao mesmo tempo.
- Benefícios: não depender 100% do salário (próprio ou do marido), ter segurança se algo acontecer no emprego, ganhar confiança e ser exemplo para os filhos.
### Conta de exemplo da aula
| Premissa | Valor |
|---|---|
| Demandas por semana | 3 (cerca de 2 h nos dias livres) |
| Valor por demanda | R$ 150 |
| Por semana | R$ 450 |
| Por mês (4 semanas) | R$ 1.800 |
| Por ano | R$ 21.600 |', 'approved', ARRAY['Mindset da Dupla Jornada','mindset da dupla renda','dupla renda','Como ganhar mais trabalhando menos','pequenas demandas','pequenos trabalhos','CLT','carteira assinada','5 habilidades','missão da aula']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M05.A01-03', 'principal', 1, 5, 'V1.M05.A01 — Mindset da Dupla Jornada: Como Mulheres estão Multiplicando sua Renda', 'Procedimento: missão da aula', 'Mindset da Dupla Jornada: Como Mulheres estão Multiplicando sua Renda', 'Método Sócia Invisível › Módulo 05 – Como Ganhar Mais Trabalhando Menos › Aula 01 – Mindset da Dupla Jornada: Como Mulheres estão Multiplicando sua Renda › Procedimento: missão da aula

1. Anotar 5 habilidades que você usa no trabalho CLT e no dia a dia.
2. Para cada uma, pensar: como isso poderia ajudar empresas que estão ocupadas demais para fazer sozinhas?
3. Levar a lista para as próximas aulas. Segundo a aula, elas vão ensinar:
  - como encontrar oportunidades usando essas habilidades;
  - como organizar o tempo sem atrapalhar o emprego CLT;
  - como precificar;
  - como construir uma renda extra consistente.', 'approved', ARRAY['Mindset da Dupla Jornada','mindset da dupla renda','dupla renda','Como ganhar mais trabalhando menos','pequenas demandas','pequenos trabalhos','CLT','carteira assinada','5 habilidades','missão da aula']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M05.A01-04', 'principal', 1, 5, 'V1.M05.A01 — Mindset da Dupla Jornada: Como Mulheres estão Multiplicando sua Renda', 'FAQ', 'Mindset da Dupla Jornada: Como Mulheres estão Multiplicando sua Renda', 'Método Sócia Invisível › Módulo 05 – Como Ganhar Mais Trabalhando Menos › Aula 01 – Mindset da Dupla Jornada: Como Mulheres estão Multiplicando sua Renda › Pontos para o suporte

- "Trabalho CLT, dá para fazer?" Sim. Este módulo foi feito para esse caso: horas vagas, fins de semana e horário de almoço.
- "Quais habilidades eu preciso ter?" As que você já usa no trabalho e em casa: planilhas, textos, pesquisas, apresentações, atendimento, agenda.
- "Quanto vou ganhar?" A aula dá um exemplo (R$ 150 por demanda, R$ 1.800/mês), mas o suporte não deve tratar isso como promessa.
- "O que eu faço nesta aula?" Listar 5 habilidades e pensar em como cada uma ajudaria empresas.', 'approved', ARRAY['Mindset da Dupla Jornada','mindset da dupla renda','dupla renda','Como ganhar mais trabalhando menos','pequenas demandas','pequenos trabalhos','CLT','carteira assinada','5 habilidades','missão da aula']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M05.A02-01', 'principal', 1, 5, 'V1.M05.A02 — Auditoria de Tempo: Descobrindo Suas Horas Perdidas', 'Visão geral', 'Auditoria de Tempo: Descobrindo Suas Horas Perdidas', 'Método Sócia Invisível › Módulo 05 – Como Ganhar Mais Trabalhando Menos › Aula 02 – Auditoria de Tempo: Descobrindo Suas Horas Perdidas › Visão geral da aula

Nome oficial da aula: Auditoria de Tempo: Descobrindo Suas Horas Perdidas
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 05 – Como Ganhar Mais Trabalhando Menos, Aula 02
Duração/formato: 7:09
Link na área de membros (abre a página do Módulo 05, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/5

Resumo:
É uma aula prática que ensina a fazer uma auditoria de tempo em 6 passos para encontrar as horas "escondidas" no dia e usá-las nas subdemandas. A ideia central é: "Você não precisa de mais tempo, precisa descobrir onde está perdendo o tempo que já tem." A aula adapta as orientações a 4 perfis de aluna (CLT, mãe solo, dona de casa e desempregada) e usa três casos de alunas (Carla, Ana e Júlia) como exemplo.', 'approved', ARRAY['Auditoria de tempo','auditoria das horas','horas perdidas','ladrões de tempo','janelas de oportunidade','janelas de tempo','blocos de tempo','mãe solo','mãe sola','mães solos','eliminar a culpa']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M05.A02-02', 'principal', 1, 5, 'V1.M05.A02 — Auditoria de Tempo: Descobrindo Suas Horas Perdidas', 'Procedimento: auditoria de tempo em 6 passos', 'Auditoria de Tempo: Descobrindo Suas Horas Perdidas', 'Método Sócia Invisível › Módulo 05 – Como Ganhar Mais Trabalhando Menos › Aula 02 – Auditoria de Tempo: Descobrindo Suas Horas Perdidas › Procedimento: auditoria de tempo em 6 passos (parte 1 de 2)

### Passo 1: Mapear a semana real
Durante 7 dias, anotar de hora em hora tudo o que faz, registrando a semana real e não a ideal. O que observar em cada perfil:
| Perfil | O que anotar |
|---|---|
| CLT | Hora de acordar, tempo se arrumando, transporte, almoço, hora de chegada em casa, jantar, tempo no celular e hora de dormir. |
| Mãe solo | Horário da escola das crianças, sono delas, celular e TV depois que dormem, tarefas que poderiam ser feitas de forma mais eficiente. |
| Dona de casa | Tempo real em cada tarefa doméstica, celular, TV, WhatsApp e tempo em que as crianças ficam ocupadas sozinhas. |
| Desempregada | Tempo real procurando emprego, celular sem fim produtivo, TV e tempo remoendo problemas. |
### Passo 2: Identificar os ladrões de tempo
Os mais comuns: redes sociais sem propósito, TV, conversas de WhatsApp sem objetivo, trabalho doméstico desorganizado e, o pior de todos, se preocupar com o que não pode controlar.
### Passo 3: Encontrar as janelas de oportunidade
"Toda mulher tem pelo menos 3 janelas por dia."
| Perfil | Janelas sugeridas | Estimativa da aula |
|---|---|---|
| CLT | Horário de almoço, 1 h antes de dormir, 2 h no fim de semana | ≥ 4 h/semana, "R$ 300 a R$ 400 extras por mês" |
| Mãe solo | Depois que as crianças dormem, enquanto estão na escola ou ocupadas | ≥ 6 h/semana |
| Dona de casa | Enquanto as crianças dormem, com o almoço no fogo, depois que a família dorme e com as tarefas mais organizadas | ~8 h/semana |
| Desempregada | 4 h por dia enquanto procura emprego | "Maior potencial de todas" |
### Passo 4: Trabalhar em blocos de tempo
Não é preciso ter 8 horas seguidas: blocos de 30 min a 2 h bastam. Tempos de referência citados:
| Tarefa | Tempo estimado |
|---|---|
| Responder e-mails | 30 min |
| Organizar textos para redes sociais | 45 min |
| Organizar uma planilha básica | 1 h |
| Fazer uma pesquisa na internet | 1 h |', 'approved', ARRAY['Auditoria de tempo','auditoria das horas','horas perdidas','ladrões de tempo','janelas de oportunidade','janelas de tempo','blocos de tempo','mãe solo','mãe sola','mães solos','eliminar a culpa']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M05.A02-03', 'principal', 1, 5, 'V1.M05.A02 — Auditoria de Tempo: Descobrindo Suas Horas Perdidas', 'Procedimento: auditoria de tempo em 6 passos', 'Auditoria de Tempo: Descobrindo Suas Horas Perdidas', 'Método Sócia Invisível › Módulo 05 – Como Ganhar Mais Trabalhando Menos › Aula 02 – Auditoria de Tempo: Descobrindo Suas Horas Perdidas › Procedimento: auditoria de tempo em 6 passos (parte 2 de 2)

### Passo 4: Trabalhar em blocos de tempo (continuação)
| Tarefa | Tempo estimado |
|---|---|
| Criar uma apresentação básica | 2 h |
### Passo 5: Eliminar a culpa
Querer ganhar dinheiro não é egoísmo nem negligência com a família. É responsabilidade e exemplo para os filhos. A dona de casa tem direito ao próprio dinheiro, e para quem está desempregada essa pode ser uma porta de entrada.
### Passo 6: Testar por uma semana
Usar 2 horas por dia nas janelas encontradas para aprender sobre as subdemandas e se organizar para fazer a primeira demanda.', 'approved', ARRAY['Auditoria de tempo','auditoria das horas','horas perdidas','ladrões de tempo','janelas de oportunidade','janelas de tempo','blocos de tempo','mãe solo','mãe sola','mães solos','eliminar a culpa']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M05.A02-04', 'principal', 1, 5, 'V1.M05.A02 — Auditoria de Tempo: Descobrindo Suas Horas Perdidas', 'Missão até a próxima aula', 'Auditoria de Tempo: Descobrindo Suas Horas Perdidas', 'Método Sócia Invisível › Módulo 05 – Como Ganhar Mais Trabalhando Menos › Aula 02 – Auditoria de Tempo: Descobrindo Suas Horas Perdidas › Missão até a próxima aula

1. Fazer a auditoria de tempo por 3 dias, anotando de hora em hora.
2. Identificar pelo menos 2 janelas de tempo para trabalhar com as subdemandas.
3. Parar de dizer "não tenho tempo".', 'approved', ARRAY['Auditoria de tempo','auditoria das horas','horas perdidas','ladrões de tempo','janelas de oportunidade','janelas de tempo','blocos de tempo','mãe solo','mãe sola','mães solos','eliminar a culpa']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M05.A02-05', 'principal', 1, 5, 'V1.M05.A02 — Auditoria de Tempo: Descobrindo Suas Horas Perdidas', 'Casos citados na aula', 'Auditoria de Tempo: Descobrindo Suas Horas Perdidas', 'Método Sócia Invisível › Módulo 05 – Como Ganhar Mais Trabalhando Menos › Aula 02 – Auditoria de Tempo: Descobrindo Suas Horas Perdidas › Casos citados na aula

| Aluna | Perfil | Descoberta na auditoria | Resultado relatado |
|---|---|---|---|
| Carla | Mãe solo de 2, recepcionista | 2 h/dia no Instagram depois que os filhos dormiam | R$ 2.000/mês com 2 h/dia |
| Ana | Dona de casa, 3 filhos pequenos | Tarefas domésticas desorganizadas, levando o dobro do tempo | R$ 5.000/mês no horário escolar |
| Júlia | Desempregada havia 6 meses | 4 h/dia de TV e lamentação | R$ 7.500/mês, "nem precisou mais procurar emprego" |', 'approved', ARRAY['Auditoria de tempo','auditoria das horas','horas perdidas','ladrões de tempo','janelas de oportunidade','janelas de tempo','blocos de tempo','mãe solo','mãe sola','mães solos','eliminar a culpa']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M05.A02-06', 'principal', 1, 5, 'V1.M05.A02 — Auditoria de Tempo: Descobrindo Suas Horas Perdidas', 'FAQ', 'Auditoria de Tempo: Descobrindo Suas Horas Perdidas', 'Método Sócia Invisível › Módulo 05 – Como Ganhar Mais Trabalhando Menos › Aula 02 – Auditoria de Tempo: Descobrindo Suas Horas Perdidas › Pontos para o suporte

- "Não tenho tempo." Indicar esta aula e sugerir a auditoria por 3 dias para achar pelo menos 2 janelas. Blocos de 30 minutos já servem.
- "Sou mãe solo, dona de casa ou estou desempregada. Serve para mim?" Sim. A aula traz orientações específicas para cada perfil (tabelas acima).
- "Quanto tempo leva cada demanda?" A aula estima de 30 min a 2 h, dependendo do tipo (ver a tabela do Passo 4).
- Resultados das alunas citadas: não repetir como promessa de ganho.', 'approved', ARRAY['Auditoria de tempo','auditoria das horas','horas perdidas','ladrões de tempo','janelas de oportunidade','janelas de tempo','blocos de tempo','mãe solo','mãe sola','mães solos','eliminar a culpa']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M05.A03-01', 'principal', 1, 5, 'V1.M05.A03 — A Arte de Fazer Mais Trabalhando Menos', 'Visão geral', 'A Arte de Fazer Mais Trabalhando Menos', 'Método Sócia Invisível › Módulo 05 – Como Ganhar Mais Trabalhando Menos › Aula 03 – A Arte de Fazer Mais Trabalhando Menos › Visão geral da aula

Nome oficial da aula: A Arte de Fazer Mais Trabalhando Menos
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 05 – Como Ganhar Mais Trabalhando Menos, Aula 03
Duração/formato: 7:21
Link na área de membros (abre a página do Módulo 05, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/5

Resumo:
A aula ensina produtividade estratégica para a "mulher real", aquela que tem mil responsabilidades e precisa gerar renda nas horas que sobram. São 5 pilares: 80/20, blocos de energia, regra dos três, automação da rotina e o "não estratégico". A aula dá aplicações por perfil (CLT, mãe solo, dona de casa e desempregada) e um exercício para fazer uma tarefa na metade do tempo. O caso usado de exemplo é o da Fernanda.
A frase-chave é: "Mulher próspera não é mulher ocupada. Mulher próspera é mulher estratégica."', 'approved', ARRAY['produtividade estratégica','fazer mais trabalhando menos','80/20','80 e 20','princípio de Pareto','blocos de energia','picos de energia','mapa de energia','regra dos três','3 prioridades','automação da rotina','rotina automática','não estratégico','dizer não']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M05.A03-02', 'principal', 1, 5, 'V1.M05.A03 — A Arte de Fazer Mais Trabalhando Menos', 'Os 5 pilares', 'A Arte de Fazer Mais Trabalhando Menos', 'Método Sócia Invisível › Módulo 05 – Como Ganhar Mais Trabalhando Menos › Aula 03 – A Arte de Fazer Mais Trabalhando Menos › Os 5 pilares

| # | Pilar | Como aplicar |
|---|---|---|
| 1 | Princípio 80/20 | 80% dos resultados vêm de 20% das ações. Identificar as poucas tarefas do trabalho e da casa que realmente fazem diferença e cortar o perfeccionismo e o que "ninguém nota". |
| 2 | Blocos de energia | Durante 1 semana, anotar de hora em hora o nível de energia e foco (escala de 1 a 10) para achar pelo menos 2 picos por dia. Usar os picos para as subdemandas ou o trabalho importante, e os vales para tarefas automáticas e burocracia. |
| 3 | Regra dos três | Escolher só 3 prioridades por dia: 1 do trabalho principal, 1 da família e 1 da renda extra (uma subdemanda). |
| 4 | Automação da rotina | Reduzir decisões: cardápio semanal fixo e compras 1 vez por semana, roupa separada na noite anterior, horários fixos para tarefas domésticas, mensagens em horários específicos. |
| 5 | Não estratégico | Dizer não ao que não aproxima dos objetivos: conversa longa no portão, desabafo diário no WhatsApp, problemas de parentes, reunião desnecessária, perfeição doméstica. Usar a frase "Não posso agora, estou trabalhando." e tratar as horas de subdemanda como trabalho de verdade. |', 'approved', ARRAY['produtividade estratégica','fazer mais trabalhando menos','80/20','80 e 20','princípio de Pareto','blocos de energia','picos de energia','mapa de energia','regra dos três','3 prioridades','automação da rotina','rotina automática','não estratégico','dizer não']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M05.A03-03', 'principal', 1, 5, 'V1.M05.A03 — A Arte de Fazer Mais Trabalhando Menos', 'Aplicação por perfil', 'A Arte de Fazer Mais Trabalhando Menos', 'Método Sócia Invisível › Módulo 05 – Como Ganhar Mais Trabalhando Menos › Aula 03 – A Arte de Fazer Mais Trabalhando Menos › Aplicação por perfil

| Perfil | Como organizar |
|---|---|
| CLT | Pico da manhã para planejar e fazer as tarefas importantes do emprego. Almoço para uma subdemanda rápida. 1 h antes de dormir para demandas maiores. Automatizar a rotina doméstica. |
| Mãe solo | Crianças dormindo: subdemandas que exigem concentração. Crianças na escola: tarefas que aceitam interrupção. Automatizar refeições, pôr as crianças para ajudar e recusar compromissos sociais que não agregam. |
| Dona de casa | Pico de energia para as subdemandas e tarefas domésticas no "automático". Casa organizada para se manter sozinha, família mais independente e horas de trabalho tratadas como sagradas. |
| Desempregada | 4 h/dia de subdemandas (2 de manhã e 2 à tarde) e 1 h para procurar emprego. Ter rotina de trabalho formal. |', 'approved', ARRAY['produtividade estratégica','fazer mais trabalhando menos','80/20','80 e 20','princípio de Pareto','blocos de energia','picos de energia','mapa de energia','regra dos três','3 prioridades','automação da rotina','rotina automática','não estratégico','dizer não']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M05.A03-04', 'principal', 1, 5, 'V1.M05.A03 — A Arte de Fazer Mais Trabalhando Menos', 'Exercício prático: tarefa na metade do tempo', 'A Arte de Fazer Mais Trabalhando Menos', 'Método Sócia Invisível › Módulo 05 – Como Ganhar Mais Trabalhando Menos › Aula 03 – A Arte de Fazer Mais Trabalhando Menos › Exercício prático: tarefa na metade do tempo

1. Escolher uma tarefa diária que leva mais tempo do que deveria, como arrumar a casa, cozinhar ou responder mensagens.
2. Pensar em como fazê-la na metade do tempo. Exemplos da aula:
  - separar os ingredientes antes de cozinhar;
  - arrumar a casa por blocos, não cômodo por cômodo;
  - responder mensagens em horários fixos.
3. Usar o tempo liberado para fazer subdemandas. A conta da aula: 1 h por dia são 30 h por mês.', 'approved', ARRAY['produtividade estratégica','fazer mais trabalhando menos','80/20','80 e 20','princípio de Pareto','blocos de energia','picos de energia','mapa de energia','regra dos três','3 prioridades','automação da rotina','rotina automática','não estratégico','dizer não']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M05.A03-05', 'principal', 1, 5, 'V1.M05.A03 — A Arte de Fazer Mais Trabalhando Menos', 'Missão até a próxima aula', 'A Arte de Fazer Mais Trabalhando Menos', 'Método Sócia Invisível › Módulo 05 – Como Ganhar Mais Trabalhando Menos › Aula 03 – A Arte de Fazer Mais Trabalhando Menos › Missão até a próxima aula

1. Identificar os 2 picos de energia do dia.
2. Hoje à noite, escolher as 3 prioridades de amanhã (trabalho, família e renda extra).
3. Automatizar uma tarefa repetitiva.
4. Começar a dizer não ao que não aproxima dos objetivos.', 'approved', ARRAY['produtividade estratégica','fazer mais trabalhando menos','80/20','80 e 20','princípio de Pareto','blocos de energia','picos de energia','mapa de energia','regra dos três','3 prioridades','automação da rotina','rotina automática','não estratégico','dizer não']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M05.A03-06', 'principal', 1, 5, 'V1.M05.A03 — A Arte de Fazer Mais Trabalhando Menos', 'Caso citado: Fernanda', 'A Arte de Fazer Mais Trabalhando Menos', 'Método Sócia Invisível › Módulo 05 – Como Ganhar Mais Trabalhando Menos › Aula 03 – A Arte de Fazer Mais Trabalhando Menos › Caso citado: Fernanda

Auxiliar administrativa (8 h/dia) com 2 filhos pequenos. Descobriu que só 2 das 8 tarefas do trabalho e 3 das 10 tarefas domésticas faziam diferença. Os picos de energia dela eram das 6h às 8h e das 21h às 23h. A aula diz que hoje ela ganha R$ 3.200/mês com 6 horas por semana e que a rotina automatizada liberou 2 h/dia, que "viraram mais R$ 1.800/mês".', 'approved', ARRAY['produtividade estratégica','fazer mais trabalhando menos','80/20','80 e 20','princípio de Pareto','blocos de energia','picos de energia','mapa de energia','regra dos três','3 prioridades','automação da rotina','rotina automática','não estratégico','dizer não']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M05.A03-07', 'principal', 1, 5, 'V1.M05.A03 — A Arte de Fazer Mais Trabalhando Menos', 'FAQ', 'A Arte de Fazer Mais Trabalhando Menos', 'Método Sócia Invisível › Módulo 05 – Como Ganhar Mais Trabalhando Menos › Aula 03 – A Arte de Fazer Mais Trabalhando Menos › Pontos para o suporte

- "Não consigo conciliar tudo." Indicar a regra dos três (1 prioridade de trabalho, 1 de família e 1 de renda extra) e a automação da rotina.
- "Qual o melhor horário para fazer as demandas?" O do seu pico de energia. A aula sugere mapear a energia por uma semana, de 1 a 10.
- "Estou desempregada, quanto tempo devo dedicar?" A aula sugere 4 h/dia de subdemandas e 1 h/dia para procurar emprego.
- Valores da Fernanda: não repetir como promessa.', 'approved', ARRAY['produtividade estratégica','fazer mais trabalhando menos','80/20','80 e 20','princípio de Pareto','blocos de energia','picos de energia','mapa de energia','regra dos três','3 prioridades','automação da rotina','rotina automática','não estratégico','dizer não']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M05.A04-01', 'principal', 1, 5, 'V1.M05.A04 — SOS Sobrecarga: Como Identificar e Resolver', 'Visão geral', 'SOS Sobrecarga: Como Identificar e Resolver', 'Método Sócia Invisível › Módulo 05 – Como Ganhar Mais Trabalhando Menos › Aula 04 – SOS Sobrecarga: Como Identificar e Resolver › Visão geral da aula

Nome oficial da aula: SOS Sobrecarga: Como Identificar e Resolver
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 05 – Como Ganhar Mais Trabalhando Menos, Aula 04
Duração/formato: 5:58
Link na área de membros (abre a página do Módulo 05, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/5

Resumo:
É uma aula sobre prevenir a sobrecarga e o burnout ao conciliar as subdemandas com trabalho, casa e família. Ela ensina a reconhecer 5 sinais de alerta e a aplicar 5 estratégias:
- limite de horas;
- semáforo emocional;
- dia de descanso;
- "nãos" prontos;
- família como alerta.
Também traz adaptações por perfil de aluna. O caso usado de exemplo é o da Patrícia, que se sobrecarregou e abandonou tudo. A mensagem central: "Renda sustentável não é trabalhar até se matar. É uma maratona, não uma corrida de 100 metros."', 'approved', ARRAY['SOS sobrecarga','sobrecarga','burnout','burnou','esgotamento','cansaço','semáforo emocional','verde amarelo vermelho','limite não negociável','limite semanal de horas','dia sagrado do descanso','dia de descanso','nãos automáticos','regra dos não automáticos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M05.A04-02', 'principal', 1, 5, 'V1.M05.A04 — SOS Sobrecarga: Como Identificar e Resolver', 'Os 5 sinais de sobrecarga', 'SOS Sobrecarga: Como Identificar e Resolver', 'Método Sócia Invisível › Módulo 05 – Como Ganhar Mais Trabalhando Menos › Aula 04 – SOS Sobrecarga: Como Identificar e Resolver › Os 5 sinais de sobrecarga

| # | Sinal | Como aparece |
|---|---|---|
| 1 | Cansaço constante, mesmo dormindo | Acordar já exausta, com o cérebro que não desliga. |
| 2 | Irritação com o que antes não incomodava | Explodir com filhos, marido ou colegas. Tolerância zero. |
| 3 | Falta de concentração | Pensar na roupa enquanto faz a demanda, e na demanda enquanto lava a roupa. |
| 4 | Negligenciar o que é importante | Parar de se exercitar, comer mal, se afastar da família, largar o que gosta. |
| 5 | Culpa o tempo todo | Culpa ao descansar, culpa ao trabalhar, sensação de que nunca é o suficiente. |', 'approved', ARRAY['SOS sobrecarga','sobrecarga','burnout','burnou','esgotamento','cansaço','semáforo emocional','verde amarelo vermelho','limite não negociável','limite semanal de horas','dia sagrado do descanso','dia de descanso','nãos automáticos','regra dos não automáticos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M05.A04-03', 'principal', 1, 5, 'V1.M05.A04 — SOS Sobrecarga: Como Identificar e Resolver', 'Procedimento: 5 estratégias de prevenção', 'SOS Sobrecarga: Como Identificar e Resolver', 'Método Sócia Invisível › Módulo 05 – Como Ganhar Mais Trabalhando Menos › Aula 04 – SOS Sobrecarga: Como Identificar e Resolver › Procedimento: 5 estratégias de prevenção

1. Limite não negociável: definir quantas horas por semana vai dedicar às subdemandas e nunca ultrapassar, mesmo que apareça uma demanda que pague bem.
2. Semáforo emocional, antes de começar o trabalho do dia:
  - 🟢 Verde (bem, com energia): trabalhar normalmente.
  - 🟡 Amarelo (cansada, mas funcional): só demandas simples e rápidas.
  - 🔴 Vermelho (exausta): não fazer subdemandas. Descansar ou fazer só o essencial.
3. Dia sagrado do descanso: 1 dia por semana sem nenhuma subdemanda, para descansar, ficar com a família ou não fazer nada.
4. Nãos automáticos: ter uma lista pronta do que recusar quando estiver sobrecarregada, sem culpa e sem precisar explicar. Exemplos: demandas extras, favores, compromissos sociais desnecessários, perfeccionismo.
5. Sinais de alerta da família: pedir a filhos, marido e mãe que avisem quando você estiver estressada, cansada ou irritada demais.', 'approved', ARRAY['SOS sobrecarga','sobrecarga','burnout','burnou','esgotamento','cansaço','semáforo emocional','verde amarelo vermelho','limite não negociável','limite semanal de horas','dia sagrado do descanso','dia de descanso','nãos automáticos','regra dos não automáticos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M05.A04-04', 'principal', 1, 5, 'V1.M05.A04 — SOS Sobrecarga: Como Identificar e Resolver', 'Riscos por perfil', 'SOS Sobrecarga: Como Identificar e Resolver', 'Método Sócia Invisível › Módulo 05 – Como Ganhar Mais Trabalhando Menos › Aula 04 – SOS Sobrecarga: Como Identificar e Resolver › Riscos por perfil

| Perfil | Maior risco | Orientação |
|---|---|---|
| CLT | Fazer subdemandas depois de um dia pesado | Reconhecer quando está cansada demais para trabalhar com qualidade. |
| Mãe solo | Culpa por trabalhar em vez de estar com os filhos | Os filhos também precisam de uma mãe saudável e presente. |
| Dona de casa | Achar que pode trabalhar a qualquer hora | Separar horários para as subdemandas e para a família. |
| Desempregada | Trabalhar demais, parar de procurar emprego ou se cobrar para ganhar rápido | Ter paciência e construir aos poucos. |', 'approved', ARRAY['SOS sobrecarga','sobrecarga','burnout','burnou','esgotamento','cansaço','semáforo emocional','verde amarelo vermelho','limite não negociável','limite semanal de horas','dia sagrado do descanso','dia de descanso','nãos automáticos','regra dos não automáticos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M05.A04-05', 'principal', 1, 5, 'V1.M05.A04 — SOS Sobrecarga: Como Identificar e Resolver', 'Missão até a próxima aula', 'SOS Sobrecarga: Como Identificar e Resolver', 'Método Sócia Invisível › Módulo 05 – Como Ganhar Mais Trabalhando Menos › Aula 04 – SOS Sobrecarga: Como Identificar e Resolver › Missão até a próxima aula

1. Escrever no papel o seu limite semanal de horas para subdemandas.
2. Escolher o seu dia sagrado de descanso.
3. Fazer uma lista de 5 coisas a que vai dizer não automaticamente quando estiver sobrecarregada.
4. Conversar com a família sobre os seus sinais de sobrecarga.', 'approved', ARRAY['SOS sobrecarga','sobrecarga','burnout','burnou','esgotamento','cansaço','semáforo emocional','verde amarelo vermelho','limite não negociável','limite semanal de horas','dia sagrado do descanso','dia de descanso','nãos automáticos','regra dos não automáticos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M05.A04-06', 'principal', 1, 5, 'V1.M05.A04 — SOS Sobrecarga: Como Identificar e Resolver', 'Caso citado: Patrícia', 'SOS Sobrecarga: Como Identificar e Resolver', 'Método Sócia Invisível › Módulo 05 – Como Ganhar Mais Trabalhando Menos › Aula 04 – SOS Sobrecarga: Como Identificar e Resolver › Caso citado: Patrícia

Auxiliar de enfermagem, mãe de 3. Em 2 semanas, já trabalhava 12 h/dia (8 no hospital e 4 com demandas). Em 1 mês, ganhava R$ 2.800 extras. Em 2 meses, teve uma crise de ansiedade e abandonou tudo: burnout e depressão, com 6 meses de recuperação. Hoje trabalha 8 h/semana com subdemandas, "feliz e saudável".', 'approved', ARRAY['SOS sobrecarga','sobrecarga','burnout','burnou','esgotamento','cansaço','semáforo emocional','verde amarelo vermelho','limite não negociável','limite semanal de horas','dia sagrado do descanso','dia de descanso','nãos automáticos','regra dos não automáticos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M05.A04-07', 'principal', 1, 5, 'V1.M05.A04 — SOS Sobrecarga: Como Identificar e Resolver', 'FAQ', 'SOS Sobrecarga: Como Identificar e Resolver', 'Método Sócia Invisível › Módulo 05 – Como Ganhar Mais Trabalhando Menos › Aula 04 – SOS Sobrecarga: Como Identificar e Resolver › Pontos para o suporte

- "Estou cansada, sobrecarregada." Indicar esta aula, o semáforo emocional (no amarelo, só demandas simples; no vermelho, descansar) e o limite semanal de horas.
- "Posso trabalhar todos os dias?" A aula recomenda 1 dia por semana sem subdemandas.
- ⚠️ Aluna relatando sofrimento real (ansiedade, depressão, exaustão intensa): acolher e sugerir que procure ajuda profissional (médico ou psicólogo). No Brasil, o CVV atende pelo 188, 24 horas. O suporte não deve tratar o caso só com as dicas da aula.', 'approved', ARRAY['SOS sobrecarga','sobrecarga','burnout','burnou','esgotamento','cansaço','semáforo emocional','verde amarelo vermelho','limite não negociável','limite semanal de horas','dia sagrado do descanso','dia de descanso','nãos automáticos','regra dos não automáticos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M05.A05-01', 'principal', 1, 5, 'V1.M05.A05 — Liberdade Planejada: Construindo Sua Saída do CLT', 'Visão geral', 'Liberdade Planejada: Construindo Sua Saída do CLT', 'Método Sócia Invisível › Módulo 05 – Como Ganhar Mais Trabalhando Menos › Aula 05 – Liberdade Planejada: Construindo Sua Saída do CLT › Visão geral da aula

Nome oficial da aula: Liberdade Planejada: Construindo Sua Saída do CLT
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 05 – Como Ganhar Mais Trabalhando Menos, Aula 05
Duração/formato: 4:42
Link na área de membros (abre a página do Módulo 05, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/5

Resumo:
A aula ensina a planejar a saída do emprego CLT com segurança, sem decisões por impulso. A regra central é: não sair do CLT enquanto a renda extra for instável. Ela apresenta um plano de transição em 5 fases, cada uma com critérios objetivos para avançar, traz cuidados por perfil e propõe um teste de prontidão. A mensagem é: "Melhor demorar 2 anos para sair com segurança do que sair em 2 meses e ter que voltar em 6."', 'approved', ARRAY['Liberdade planejada','saída do CLT','sair do CLT','pedir demissão','largar o emprego','plano de transição','5 fases','construção da base','escalada controlada','preparação para o salto','transição gradual','liberdade total','reserva de emergência']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M05.A05-02', 'principal', 1, 5, 'V1.M05.A05 — Liberdade Planejada: Construindo Sua Saída do CLT', 'Procedimento: plano de transição em 5 fases', 'Liberdade Planejada: Construindo Sua Saída do CLT', 'Método Sócia Invisível › Módulo 05 – Como Ganhar Mais Trabalhando Menos › Aula 05 – Liberdade Planejada: Construindo Sua Saída do CLT › Procedimento: plano de transição em 5 fases

| Fase | Situação | Critérios para avançar |
|---|---|---|
| 1. Construção da base | Ainda no CLT, começando nas subdemandas. O foco é aprender, criar reputação e entender o mercado, não ganhar muito. | • ≥ 10 demandas concluídas com sucesso<br>• ≥ 5 pessoas satisfeitas que recomendem você<br>• ≥ R$ 500/mês de forma consistente por mais de 3 meses |
| 2. Escalada controlada | Ainda no CLT, com a renda extra crescendo e clientes fixos. | • ≥ 50% do salário CLT com subdemandas por 3 meses seguidos<br>• ≥ 3 pessoas fixas com trabalho regular<br>• Reserva = 3 meses do salário CLT (obrigatória) |
| 3. Preparação para o salto | Ainda no CLT, preparando ativamente a saída. | • ≥ 100% do salário CLT com subdemandas por 3 meses seguidos<br>• ≥ 5 pessoas fixas<br>• Reserva = 6 meses de gastos pessoais |
| 4. Transição gradual | Negociar com o empregador: meio período, redução de carga horária ou trabalho remoto. | • ≥ 100% do antigo salário CLT com subdemandas por 3 meses seguidos<br>• ≥ 8 pessoas ativas contratando |
| 5. Liberdade total | Pedir demissão e viver só da renda própria, ainda com cuidado, planejamento e humildade. | — |
Por que a reserva é obrigatória: fora do CLT, a renda oscila, há atrasos de pagamento e imprevistos.', 'approved', ARRAY['Liberdade planejada','saída do CLT','sair do CLT','pedir demissão','largar o emprego','plano de transição','5 fases','construção da base','escalada controlada','preparação para o salto','transição gradual','liberdade total','reserva de emergência']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M05.A05-03', 'principal', 1, 5, 'V1.M05.A05 — Liberdade Planejada: Construindo Sua Saída do CLT', 'Cuidados por perfil', 'Liberdade Planejada: Construindo Sua Saída do CLT', 'Método Sócia Invisível › Módulo 05 – Como Ganhar Mais Trabalhando Menos › Aula 05 – Liberdade Planejada: Construindo Sua Saída do CLT › Cuidados por perfil

| Perfil | Orientação |
|---|---|
| Mãe solo | Transição ainda mais cuidadosa. Considerar manter um trabalho de meio período até ter certeza de que a renda própria está estável. |
| Casada / com família | Alinhar o plano com o marido, que precisa concordar e estar preparado para oscilações. Se ele também trabalha, a transição fica mais segura. |
| Mais velha | Pode ser mais difícil voltar ao mercado se der errado. Ser ainda mais conservadora nos critérios. |
| Mais nova | Tem mais margem para errar e recomeçar, mas deve usar isso para construir uma base sólida, não para agir com imprudência. |', 'approved', ARRAY['Liberdade planejada','saída do CLT','sair do CLT','pedir demissão','largar o emprego','plano de transição','5 fases','construção da base','escalada controlada','preparação para o salto','transição gradual','liberdade total','reserva de emergência']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M05.A05-04', 'principal', 1, 5, 'V1.M05.A05 — Liberdade Planejada: Construindo Sua Saída do CLT', 'Teste de prontidão', 'Liberdade Planejada: Construindo Sua Saída do CLT', 'Método Sócia Invisível › Módulo 05 – Como Ganhar Mais Trabalhando Menos › Aula 05 – Liberdade Planejada: Construindo Sua Saída do CLT › Teste de prontidão

Você consegue ficar 3 meses sem fazer subdemandas e ainda pagar todas as contas com a reserva? Se a resposta for não, você não está pronta para sair do CLT.', 'approved', ARRAY['Liberdade planejada','saída do CLT','sair do CLT','pedir demissão','largar o emprego','plano de transição','5 fases','construção da base','escalada controlada','preparação para o salto','transição gradual','liberdade total','reserva de emergência']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M05.A05-05', 'principal', 1, 5, 'V1.M05.A05 — Liberdade Planejada: Construindo Sua Saída do CLT', 'Missão até a próxima aula', 'Liberdade Planejada: Construindo Sua Saída do CLT', 'Método Sócia Invisível › Módulo 05 – Como Ganhar Mais Trabalhando Menos › Aula 05 – Liberdade Planejada: Construindo Sua Saída do CLT › Missão até a próxima aula

1. Identificar em que fase você está, com honestidade. Quem ainda não começou está na Fase 1.
2. Fazer uma planilha com todos os gastos mensais (casa, comida, transporte, saúde, educação, lazer) e somar. Esse é o valor mínimo que você precisa ganhar para viver sem CLT.
3. Ter paciência.', 'approved', ARRAY['Liberdade planejada','saída do CLT','sair do CLT','pedir demissão','largar o emprego','plano de transição','5 fases','construção da base','escalada controlada','preparação para o salto','transição gradual','liberdade total','reserva de emergência']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M05.A05-06', 'principal', 1, 5, 'V1.M05.A05 — Liberdade Planejada: Construindo Sua Saída do CLT', 'FAQ', 'Liberdade Planejada: Construindo Sua Saída do CLT', 'Método Sócia Invisível › Módulo 05 – Como Ganhar Mais Trabalhando Menos › Aula 05 – Liberdade Planejada: Construindo Sua Saída do CLT › Pontos para o suporte

- "Quero largar meu emprego para fazer só demandas." Indicar esta aula. Orientar a não sair antes de cumprir os critérios das fases, fazer o teste dos 3 meses de reserva e montar a planilha de gastos.
- "Quando posso sair do CLT?" Quando a renda com subdemandas igualar o salário por 3 meses seguidos, com clientes fixos e uma reserva de 6 meses (Fases 3 e 4).
- Postura do suporte: esta aula é conservadora e responsável. Usá-la como referência para evitar que alunas tomem decisões arriscadas por empolgação.', 'approved', ARRAY['Liberdade planejada','saída do CLT','sair do CLT','pedir demissão','largar o emprego','plano de transição','5 fases','construção da base','escalada controlada','preparação para o salto','transição gradual','liberdade total','reserva de emergência']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M08.A01-01', 'principal', 1, 8, 'V1.M08.A01 — O Código das Demandas no Workana', 'Visão geral', 'O Código das Demandas no Workana', 'Método Sócia Invisível › Módulo 08 – Faturando com Demandas na Prática › Aula 01 – O Código das Demandas no Workana › Visão geral da aula

Nome oficial da aula: O Código das Demandas no Workana
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 08 – Faturando com Demandas na Prática, Aula 01
Duração/formato: 3:57
Link na área de membros (abre a página do Módulo 08, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/8

Resumo:
É a abertura do Módulo 08, que apresenta uma segunda plataforma: o Workana. A diferença em relação ao 99Freelas, segundo a aula: no 99Freelas há demandas rápidas e pontuais, e no Workana há trabalhos mais estruturados, que podem durar semanas ou meses e virar parcerias de longo prazo. Por exemplo, avaliar os produtos de uma marca durante 3 meses ou cuidar de todos os dados de uma pequena empresa. A aula é motivacional e não traz passos práticos. O cadastro e o perfil ficam para as próximas aulas.', 'approved', ARRAY['Workana','Work Ana','Uorkana','Faturando com demandas na prática','99Freelas','99 filas','projetos de longo prazo','parcerias','trabalhos estruturados']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M08.A01-02', 'principal', 1, 8, 'V1.M08.A01 — O Código das Demandas no Workana', 'O que a aula diz sobre o Workana', 'O Código das Demandas no Workana', 'Método Sócia Invisível › Módulo 08 – Faturando com Demandas na Prática › Aula 01 – O Código das Demandas no Workana › O que a aula diz sobre o Workana

- O que é: um espaço que conecta a aluna a empresários, empreendedores e negócios que precisam de ajuda constante.
- Tipos de oportunidade citados:
  - criação de conteúdo para redes sociais;
  - organização de dados e informações;
  - pesquisas de mercado e análise de concorrência;
  - suporte administrativo;
  - revisão e criação de textos;
  - gerenciamento de e-mails;
  - atendimento básico por chat.
- Iniciantes têm espaço: "muitas empresas preferem quem está começando", por serem mais dedicadas e dispostas a crescer junto. A aluna não vai "competir" com experientes, vai se posicionar.
- Custo: a aula diz que é "completamente gratuita" para se cadastrar, se candidatar e montar o perfil.
- Flexibilidade: 100% remoto, no horário que a aluna quiser, conciliável com a família e o emprego CLT.', 'approved', ARRAY['Workana','Work Ana','Uorkana','Faturando com demandas na prática','99Freelas','99 filas','projetos de longo prazo','parcerias','trabalhos estruturados']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M08.A01-03', 'principal', 1, 8, 'V1.M08.A01 — O Código das Demandas no Workana', '99Freelas × Workana (segundo a aula)', 'O Código das Demandas no Workana', 'Método Sócia Invisível › Módulo 08 – Faturando com Demandas na Prática › Aula 01 – O Código das Demandas no Workana › 99Freelas × Workana (segundo a aula)

|  | 99Freelas (M07) | Workana (M08) |
|---|---|---|
| Tipo de demanda | Rápida e pontual | Mais estruturada, de semanas a meses |
| Relação com o cliente | Projeto a projeto | Pode virar parceria de longo prazo |', 'approved', ARRAY['Workana','Work Ana','Uorkana','Faturando com demandas na prática','99Freelas','99 filas','projetos de longo prazo','parcerias','trabalhos estruturados']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M08.A01-04', 'principal', 1, 8, 'V1.M08.A01 — O Código das Demandas no Workana', 'O que as próximas aulas prometem', 'O Código das Demandas no Workana', 'Método Sócia Invisível › Módulo 08 – Faturando com Demandas na Prática › Aula 01 – O Código das Demandas no Workana › O que as próximas aulas prometem

1. Criar um perfil que chama atenção.
2. Se candidatar às melhores oportunidades.
3. Precificar o trabalho.
4. Comunicar-se profissionalmente.
5. Entregar resultados que fidelizam o contratante.', 'approved', ARRAY['Workana','Work Ana','Uorkana','Faturando com demandas na prática','99Freelas','99 filas','projetos de longo prazo','parcerias','trabalhos estruturados']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M08.A01-05', 'principal', 1, 8, 'V1.M08.A01 — O Código das Demandas no Workana', 'Procedimento: o que a aluna deve fazer', 'O Código das Demandas no Workana', 'Método Sócia Invisível › Módulo 08 – Faturando com Demandas na Prática › Aula 01 – O Código das Demandas no Workana › Procedimento: o que a aluna deve fazer

1. Assistir à aula para conhecer o Workana. Não há ação prática.
2. Seguir para a Aula 02 do Módulo 08, onde começa a criação do perfil.', 'approved', ARRAY['Workana','Work Ana','Uorkana','Faturando com demandas na prática','99Freelas','99 filas','projetos de longo prazo','parcerias','trabalhos estruturados']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M08.A01-06', 'principal', 1, 8, 'V1.M08.A01 — O Código das Demandas no Workana', 'FAQ', 'O Código das Demandas no Workana', 'Método Sócia Invisível › Módulo 08 – Faturando com Demandas na Prática › Aula 01 – O Código das Demandas no Workana › Pontos para o suporte

- "Qual a diferença entre o 99Freelas e o Workana?" O 99Freelas tem demandas mais rápidas e pontuais. O Workana tem projetos mais longos, que podem virar parcerias. A aluna pode usar os dois.
- "Preciso de experiência para o Workana?" Segundo a aula, não. Muitas empresas aceitam iniciantes.
- "O Workana é pago?" O cadastro é gratuito, mas a plataforma cobra comissão sobre os projetos e tem planos pagos opcionais. Não dizer que é "completamente gratuita".
- "O Workana é do método?" Não. É uma plataforma independente. Problemas de conta ou pagamento devem ser resolvidos com o suporte do Workana.', 'approved', ARRAY['Workana','Work Ana','Uorkana','Faturando com demandas na prática','99Freelas','99 filas','projetos de longo prazo','parcerias','trabalhos estruturados']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M08.A02-01', 'principal', 1, 8, 'V1.M08.A02 — Construindo Sua Vitrine Digital no Workana', 'Visão geral', 'Construindo Sua Vitrine Digital no Workana', 'Método Sócia Invisível › Módulo 08 – Faturando com Demandas na Prática › Aula 02 – Construindo Sua Vitrine Digital no Workana › Visão geral da aula

Nome oficial da aula: Construindo Sua Vitrine Digital no Workana
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 08 – Faturando com Demandas na Prática, Aula 02
Duração/formato: 1:55
Link na área de membros (abre a página do Módulo 08, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/8

Resumo:
É uma aula prática e curta, com gravação de tela, que ensina a criar a conta de freelancer no Workana e preencher o perfil, incluindo a seção Projetos em destaque, que funciona como portfólio. A aula descreve o Workana como uma plataforma "mais gourmetizada", com projetos mais elaborados que os do 99Freelas. A busca por projetos fica para a Aula 03.', 'approved', ARRAY['Workana','Workana Brasil','vitrine digital','editar perfil','meu perfil','criar conta','eu quero trabalhar como freelancer','continuar com o Google','preço por hora','aparecer como','atividade freelancer','habilidades principais','perfil público','projetos em destaque','portfólio','não compartilhe dados de contato','bloqueio','minha executiva']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M08.A02-02', 'principal', 1, 8, 'V1.M08.A02 — Construindo Sua Vitrine Digital no Workana', 'Procedimento: passo a passo', 'Construindo Sua Vitrine Digital no Workana', 'Método Sócia Invisível › Módulo 08 – Faturando com Demandas na Prática › Aula 02 – Construindo Sua Vitrine Digital no Workana › Procedimento: passo a passo

### Parte 1: Criar a conta
1. Pesquisar "Workana Brasil" no Google e abrir o site.
2. Entre "Eu quero contratar" e "Eu quero trabalhar", rolar a página e escolher "Eu quero trabalhar como freelancer".
3. Preencher nome completo e e-mail, ou continuar com o Google.
### Parte 2: Editar o perfil
Ir em Meu perfil › Editar e preencher:
| Campo | Orientação da aula |
|---|---|
| Nome | Nome completo. |
| O que você deseja trabalhar | Logo abaixo do nome: o serviço que você oferece. É o título profissional. |
| Preço por hora | Valor da sua hora de trabalho. |
| Aparecer como | Como o seu nome é exibido. |
| Atividade freelancer | Área de atuação. Exemplo da aula: Marketing e vendas. |
| Visibilidade | Deixar o perfil público. |
| Habilidades principais | Selecionar até 3 habilidades principais. |
| Foto | Adicionar foto de perfil. |
Clicar em Salvar.
⚠️ Aviso do próprio Workana no perfil: "Cuidado, não compartilhe dados de contato. Você poderá ser bloqueado."
### Parte 3: Projetos em destaque (portfólio)
Na seção Projetos em destaque, incluir trabalhos já feitos ou uma apresentação do que você oferece:
- título e apresentação sucinta;
- imagem ou imagem de galeria;
- data de execução (opcional);
- arquivos em PDF (opcional).
Sem experiência? Fazer só uma breve apresentação do que você quer oferecer na plataforma.', 'approved', ARRAY['Workana','Workana Brasil','vitrine digital','editar perfil','meu perfil','criar conta','eu quero trabalhar como freelancer','continuar com o Google','preço por hora','aparecer como','atividade freelancer','habilidades principais','perfil público','projetos em destaque','portfólio','não compartilhe dados de contato','bloqueio','minha executiva']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M08.A02-03', 'principal', 1, 8, 'V1.M08.A02 — Construindo Sua Vitrine Digital no Workana', 'Dicas para usar com as aulas anteriores', 'Construindo Sua Vitrine Digital no Workana', 'Método Sócia Invisível › Módulo 08 – Faturando com Demandas na Prática › Aula 02 – Construindo Sua Vitrine Digital no Workana › Dicas para usar com as aulas anteriores

- O que você deseja trabalhar: usar a fórmula de linguagem profissional (M06 A02).
- Projetos em destaque: usar os cases e o portfólio montados no M06 A04, identificando trabalhos fictícios como projetos de estudo.
- Foto: seguir o Hack 1 do Bônus 02 (M07 A06): luz natural, fundo neutro, sem selfie.
- Preço por hora: a aula não orienta o valor. A precificação aparece nos Bônus 01 e 02 do M07.', 'approved', ARRAY['Workana','Workana Brasil','vitrine digital','editar perfil','meu perfil','criar conta','eu quero trabalhar como freelancer','continuar com o Google','preço por hora','aparecer como','atividade freelancer','habilidades principais','perfil público','projetos em destaque','portfólio','não compartilhe dados de contato','bloqueio','minha executiva']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M08.A02-04', 'principal', 1, 8, 'V1.M08.A02 — Construindo Sua Vitrine Digital no Workana', 'FAQ', 'Construindo Sua Vitrine Digital no Workana', 'Método Sócia Invisível › Módulo 08 – Faturando com Demandas na Prática › Aula 02 – Construindo Sua Vitrine Digital no Workana › Pontos para o suporte

- "Como me cadastro no Workana?" Google › "Workana Brasil" › "Eu quero trabalhar como freelancer" › nome e e-mail (ou login com Google).
- "Onde edito meu perfil?" Em Meu perfil › Editar.
- "Não tenho portfólio, o que coloco em Projetos em destaque?" Uma breve apresentação do que você oferece, ou os cases do M06 A04.
- "Posso colocar meu WhatsApp ou e-mail no perfil?" Não. O próprio Workana avisa que compartilhar dados de contato pode bloquear a conta.
- "Como cadastro minha conta para receber?" Esta aula não mostra.', 'approved', ARRAY['Workana','Workana Brasil','vitrine digital','editar perfil','meu perfil','criar conta','eu quero trabalhar como freelancer','continuar com o Google','preço por hora','aparecer como','atividade freelancer','habilidades principais','perfil público','projetos em destaque','portfólio','não compartilhe dados de contato','bloqueio','minha executiva']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M08.A03-01', 'principal', 1, 8, 'V1.M08.A03 — O Ciclo da Realização: Como Receber', 'Visão geral', 'O Ciclo da Realização: Como Receber', 'Método Sócia Invisível › Módulo 08 – Faturando com Demandas na Prática › Aula 03 – O Ciclo da Realização: Como Receber › Visão geral da aula

Nome oficial da aula: O Ciclo da Realização: Como Receber
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 08 – Faturando com Demandas na Prática, Aula 03
Duração/formato: 1:51
Link na área de membros (abre a página do Módulo 08, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/8

Resumo:
É uma aula prática e curta, com gravação de tela, que ensina a configurar o recebimento no Workana: escolher o meio de saque (o recomendado é o Mercado Pago), definir o saldo mínimo e a frequência de pagamento. No Workana não é preciso informar agência e conta. O dinheiro vai para a conta do Mercado Pago ligada ao e-mail cadastrado.', 'approved', ARRAY['Workana','como receber','receber pagamento','saque','sacar dinheiro','dados bancários','Minhas Finanças','Opções de Saque','Mercado Pago','PayPal','saldo mínimo','pague-me em qualquer quantidade','frequência de pagamento','início do mês','meio do mês','semanal','executiva']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M08.A03-02', 'principal', 1, 8, 'V1.M08.A03 — O Ciclo da Realização: Como Receber', 'Procedimento: passo a passo', 'O Ciclo da Realização: Como Receber', 'Método Sócia Invisível › Módulo 08 – Faturando com Demandas na Prática › Aula 03 – O Ciclo da Realização: Como Receber › Procedimento: passo a passo

1. No Workana, ir em Minhas Finanças › Opções de Saque.
2. Escolher o meio de recebimento. Há 3 opções. A aula recomenda o Mercado Pago:
| Opção | Custo (segundo a aula) | Prazo (segundo a aula) | Recomendação |
|---|---|---|---|
| Mercado Pago | Sem custo | 24 horas | ⭐ Recomendado |
| PayPal | 2% por transferência | — | Alternativa |
| 3ª opção | — | — | Não detalhada na aula |
3. Informar o e-mail da sua conta do Mercado Pago. Quem não tem conta precisa criar uma antes.
4. Definir o saldo mínimo para saque:
  - "Pague-me em qualquer quantidade" (recomendado na aula): qualquer saldo é transferido.
  - Ou um valor mínimo, como R$ 600 ou R$ 1.500. Nesse caso, o Workana espera juntar esse valor antes de transferir.
5. Escolher quando receber: início do mês, meio do mês ou semanal. ⚠️ É obrigatório escolher. Sem isso, o Workana não consegue enviar o pagamento.
6. Salvar as alterações.', 'approved', ARRAY['Workana','como receber','receber pagamento','saque','sacar dinheiro','dados bancários','Minhas Finanças','Opções de Saque','Mercado Pago','PayPal','saldo mínimo','pague-me em qualquer quantidade','frequência de pagamento','início do mês','meio do mês','semanal','executiva']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M08.A03-03', 'principal', 1, 8, 'V1.M08.A03 — O Ciclo da Realização: Como Receber', 'FAQ', 'O Ciclo da Realização: Como Receber', 'Método Sócia Invisível › Módulo 08 – Faturando com Demandas na Prática › Aula 03 – O Ciclo da Realização: Como Receber › Pontos para o suporte

- "Como cadastro meus dados para receber no Workana?" Minhas Finanças › Opções de Saque, selecionar Mercado Pago, informar o e-mail da conta, escolher "pague-me em qualquer quantidade", escolher a frequência e salvar.
- "Precisa de agência e conta?" Não, se usar o Mercado Pago. Basta o e-mail da conta.
- "Não tenho Mercado Pago." Criar uma conta no Mercado Pago, ou usar o PayPal (que cobra cerca de 2% por transferência, segundo a aula).
- "Meu pagamento não caiu." Verificar:
  1. se a frequência de pagamento foi escolhida (sem ela, o Workana não envia);
  2. se há um saldo mínimo acima do saldo atual;
 3. se o cliente já aprovou a entrega e o valor saiu da custódia;
  4. se o e-mail do Mercado Pago está correto.
- "Quando eu recebo?" Depende da frequência escolhida (semanal, início ou meio do mês) e da aprovação do cliente. Não prometer "hoje mesmo".', 'approved', ARRAY['Workana','como receber','receber pagamento','saque','sacar dinheiro','dados bancários','Minhas Finanças','Opções de Saque','Mercado Pago','PayPal','saldo mínimo','pague-me em qualquer quantidade','frequência de pagamento','início do mês','meio do mês','semanal','executiva']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M08.A04-01', 'principal', 1, 8, 'V1.M08.A04 — Mapeamento Inteligente: Identificando Demandas Lucrativas', 'Visão geral', 'Mapeamento Inteligente: Identificando Demandas Lucrativas', 'Método Sócia Invisível › Módulo 08 – Faturando com Demandas na Prática › Aula 04 – Mapeamento Inteligente: Identificando Demandas Lucrativas › Visão geral da aula

Nome oficial da aula: Mapeamento Inteligente: Identificando Demandas Lucrativas
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 08 – Faturando com Demandas na Prática, Aula 04
Duração/formato: 2:41
Link na área de membros (abre a página do Módulo 08, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/8

Resumo:
É uma aula prática, com gravação de tela, que ensina a encontrar projetos no Workana e, pela primeira vez no curso, mostra na tela como enviar uma proposta: destacar habilidades e portfólio, montar o orçamento (vendo a taxa da plataforma descontada), escrever a proposta e definir o prazo. Depois do envio, a conversa com o cliente segue pela área de Mensagens.', 'approved', ARRAY['Workana','encontre um trabalho','encontre projetos','buscar projetos','procurar vagas','categorias','Tradução e Conteúdo','filtros','salvar busca','fazer uma proposta','enviar proposta','orçamento','custo do serviço','taxa da plataforma','destacar habilidade','destacar projeto','portfólio','prazo de entrega','mensagens','notificação','Minha Executiva']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M08.A04-02', 'principal', 1, 8, 'V1.M08.A04 — Mapeamento Inteligente: Identificando Demandas Lucrativas', 'Procedimento: passo a passo', 'Mapeamento Inteligente: Identificando Demandas Lucrativas', 'Método Sócia Invisível › Módulo 08 – Faturando com Demandas na Prática › Aula 04 – Mapeamento Inteligente: Identificando Demandas Lucrativas › Procedimento: passo a passo

### Parte 1: Encontrar projetos
1. Ir em Encontre um trabalho › Encontre projetos.
2. No canto da tela, escolher uma categoria. Exemplo da aula: Tradução e Conteúdo.
3. Refinar com os filtros: habilidades, data de publicação, modalidade de trabalho e idioma.
4. Salvar a busca para reencontrar essas vagas filtradas depois.
### Parte 2: Analisar o projeto
Abrir o projeto (exemplo: "tradução de notificação extrajudicial, português › inglês"), ampliar os detalhes e conferir:
| Item | Exemplo da aula |
|---|---|
| Descrição do projeto | Texto do cliente |
| Orçamento | R$ 280 a R$ 600 |
| Propostas já enviadas | 3 |
| Freelancers interessados | 3 |
| Publicação | Há 3 horas |
| Prazo de entrega | Não estabelecido |
### Parte 3: Enviar a proposta
1. Clicar para fazer a proposta.
2. Destacar uma habilidade e um projeto do portfólio cadastrado no perfil (Aula 02).
3. Orçamento: estimar pelas horas necessárias ou informar o valor total. A tela mostra a taxa do Workana e quanto você vai receber:
| Valor cobrado do cliente | Custo do serviço (taxa Workana) | Você recebe |
|---|---|---|
| R$ 500 | R$ 100 (20%) | R$ 400 |
4. Detalhes da proposta: colar um texto-base de proposta (guardado nas notas do celular, por exemplo) e adaptar ao projeto. Se o texto era de atendente, reescrever para tradução. Usar a estrutura de 8 partes do Bônus 01 (M07 A05).
5. Anexar o portfólio.
6. Informar o prazo em dias para concluir. Exemplo da aula: 1 dia.
7. Enviar. A plataforma leva direto para Mensagens, e você é notificada quando o cliente responder.', 'approved', ARRAY['Workana','encontre um trabalho','encontre projetos','buscar projetos','procurar vagas','categorias','Tradução e Conteúdo','filtros','salvar busca','fazer uma proposta','enviar proposta','orçamento','custo do serviço','taxa da plataforma','destacar habilidade','destacar projeto','portfólio','prazo de entrega','mensagens','notificação','Minha Executiva']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M08.A04-03', 'principal', 1, 8, 'V1.M08.A04 — Mapeamento Inteligente: Identificando Demandas Lucrativas', 'FAQ', 'Mapeamento Inteligente: Identificando Demandas Lucrativas', 'Método Sócia Invisível › Módulo 08 – Faturando com Demandas na Prática › Aula 04 – Mapeamento Inteligente: Identificando Demandas Lucrativas › Pontos para o suporte

- "Como procuro projetos no Workana?" Encontre um trabalho › Encontre projetos › escolher a categoria no canto da tela › filtros (habilidades, data, modalidade, idioma) › salvar a busca.
- "Como envio a proposta?" Abrir o projeto › fazer proposta › destacar habilidade e portfólio › orçamento › texto da proposta › anexo › prazo › enviar.
- "Por que vou receber menos do que cobrei?" O Workana desconta o custo do serviço. No exemplo da aula, R$ 100 de R$ 500 (20%). O valor líquido aparece na tela antes de enviar.
- "Mandei a proposta, e agora?" Aguardar a resposta em Mensagens. A plataforma notifica.
- "Posso usar a mesma proposta para todos?" Pode usar um texto-base, mas sempre adaptar a cada projeto. O Bônus 02 alerta que o cliente percebe o copia e cola.', 'approved', ARRAY['Workana','encontre um trabalho','encontre projetos','buscar projetos','procurar vagas','categorias','Tradução e Conteúdo','filtros','salvar busca','fazer uma proposta','enviar proposta','orçamento','custo do serviço','taxa da plataforma','destacar habilidade','destacar projeto','portfólio','prazo de entrega','mensagens','notificação','Minha Executiva']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M08.A05-01', 'principal', 1, 8, 'V1.M08.A05 — Bônus 1: Precificação Inteligente para Ganhar Mais', 'Visão geral', 'Bônus 1: Precificação Inteligente para Ganhar Mais', 'Método Sócia Invisível › Módulo 08 – Faturando com Demandas na Prática › Aula 05 – Bônus 1: Precificação Inteligente para Ganhar Mais › Visão geral da aula

Nome oficial da aula: Bônus 1: Precificação Inteligente para Ganhar Mais
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 08 – Faturando com Demandas na Prática, Aula 05
Duração/formato: 8:05
Link na área de membros (abre a página do Módulo 08, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/8

Resumo:
A aula ensina a precificar pelo valor que o cliente percebe, e não pelas horas trabalhadas. A tese: "quem contrata não compra as suas horas, compra o resultado". Ela apresenta:
- os 3 pilares do valor;
- perguntas para calcular o valor real de um trabalho;
- 4 estratégias: preço por valor, pacotes, três opções e justificativa;
- um plano de aumento gradual de preço;
- respostas para objeções e sinais de que a aluna cobra pouco;
- uma missão prática.
Fórmula da aula: ❌ tempo × valor da hora = preço → ✅ valor percebido pelo cliente = preço.', 'approved', ARRAY['precificação inteligente','precificar','quanto cobrar','preço','orçamento','valor percebido','valor entregue','transformação','custo da não solução','pacotes','três opções de preço','básico, completo e premium','justificativa de valor','ancoragem','objeções','está muito caro','vou pensar','fulana cobra mais barato','aumentar preço 20%','mulher suprema']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M08.A05-02', 'principal', 1, 8, 'V1.M08.A05 — Bônus 1: Precificação Inteligente para Ganhar Mais', 'Os 3 pilares da precificação', 'Bônus 1: Precificação Inteligente para Ganhar Mais', 'Método Sócia Invisível › Módulo 08 – Faturando com Demandas na Prática › Aula 05 – Bônus 1: Precificação Inteligente para Ganhar Mais › Os 3 pilares da precificação

| Pilar | Pergunta-guia | Exemplo da aula |
|---|---|---|
| 1. Valor entregue | O que você resolve, e não o que você faz? | "Você não organiza a casa, você devolve tempo e tranquilidade." / "Não faz atendimento, transforma irritados em fiéis." / "Não cria conteúdo, aumenta vendas e engajamento." |
| 2. Transformação gerada | Como é a vida do cliente antes e depois? | Antes: bagunça, estresse, vergonha de receber visitas. Depois: tranquilidade, orgulho, tempo para a família. |
| 3. Custo da não solução | O que acontece se ele não contratar? | Continua perdendo tempo, estressado, com impacto até nos relacionamentos. |', 'approved', ARRAY['precificação inteligente','precificar','quanto cobrar','preço','orçamento','valor percebido','valor entregue','transformação','custo da não solução','pacotes','três opções de preço','básico, completo e premium','justificativa de valor','ancoragem','objeções','está muito caro','vou pensar','fulana cobra mais barato','aumentar preço 20%','mulher suprema']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M08.A05-03', 'principal', 1, 8, 'V1.M08.A05 — Bônus 1: Precificação Inteligente para Ganhar Mais', 'Procedimento: como calcular o valor real', 'Bônus 1: Precificação Inteligente para Ganhar Mais', 'Método Sócia Invisível › Módulo 08 – Faturando com Demandas na Prática › Aula 05 – Bônus 1: Precificação Inteligente para Ganhar Mais › Procedimento: como calcular o valor real

Para cada serviço, responder:
1. Quanto tempo o cliente economiza?
2. Quanto dinheiro ele ganha ou economiza?
3. Qual problema emocional eu resolvo?
4. Qual é o custo de não resolver?
5. Quanto ele gastaria para resolver de outra forma?
Exemplo da aula (organização de closet): 6 h de trabalho a R$ 20/h = R$ 120. O cliente economiza 30 min/dia, cerca de 180 h/ano, que "a R$ 50/h valem R$ 9.000". Conclusão da aula: cobrar R$ 600, não R$ 120.', 'approved', ARRAY['precificação inteligente','precificar','quanto cobrar','preço','orçamento','valor percebido','valor entregue','transformação','custo da não solução','pacotes','três opções de preço','básico, completo e premium','justificativa de valor','ancoragem','objeções','está muito caro','vou pensar','fulana cobra mais barato','aumentar preço 20%','mulher suprema']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M08.A05-04', 'principal', 1, 8, 'V1.M08.A05 — Bônus 1: Precificação Inteligente para Ganhar Mais', '4 estratégias de preço', 'Bônus 1: Precificação Inteligente para Ganhar Mais', 'Método Sócia Invisível › Módulo 08 – Faturando com Demandas na Prática › Aula 05 – Bônus 1: Precificação Inteligente para Ganhar Mais › 4 estratégias de preço

| # | Estratégia | Como aplicar | Exemplo |
|---|---|---|---|
| 1 | Preço por valor, não por hora | Apresentar o preço ligado ao resultado. | "Investimento de R$ 500 para ter uma casa organizada que economiza 2 horas do seu dia", em vez de "R$ 50/hora". |
| 2 | Pacotes, não avulsos | Juntar serviços e extras. | Em vez de "quarto R$ 200": quarto + closet + banheiro + manual + 30 dias de acompanhamento = R$ 800. |
| 3 | Três opções de preço | Básico, Completo e Premium. "A maioria escolhe o do meio." | Básico R$ 500 · Completo R$ 800 · Premium R$ 1.200. |
| 4 | Justificativa de valor | Listar o valor de cada item e mostrar a "economia". | Itens que somam R$ 1.050 → "seu investimento: R$ 800". |', 'approved', ARRAY['precificação inteligente','precificar','quanto cobrar','preço','orçamento','valor percebido','valor entregue','transformação','custo da não solução','pacotes','três opções de preço','básico, completo e premium','justificativa de valor','ancoragem','objeções','está muito caro','vou pensar','fulana cobra mais barato','aumentar preço 20%','mulher suprema']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M08.A05-05', 'principal', 1, 8, 'V1.M08.A05 — Bônus 1: Precificação Inteligente para Ganhar Mais', 'Plano de aumento gradual', 'Bônus 1: Precificação Inteligente para Ganhar Mais', 'Método Sócia Invisível › Módulo 08 – Faturando com Demandas na Prática › Aula 05 – Bônus 1: Precificação Inteligente para Ganhar Mais › Plano de aumento gradual

| Mês | Ação |
|---|---|
| 1 | Cobrar o preço atual para construir portfólio |
| 2 | +20% |
| 3 | +20% |
| 4 | +20% |
"Perder alguns clientes é normal. Você vai trabalhar menos e ganhar mais."', 'approved', ARRAY['precificação inteligente','precificar','quanto cobrar','preço','orçamento','valor percebido','valor entregue','transformação','custo da não solução','pacotes','três opções de preço','básico, completo e premium','justificativa de valor','ancoragem','objeções','está muito caro','vou pensar','fulana cobra mais barato','aumentar preço 20%','mulher suprema']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M08.A05-06', 'principal', 1, 8, 'V1.M08.A05 — Bônus 1: Precificação Inteligente para Ganhar Mais', 'Respostas a objeções (modelos da aula)', 'Bônus 1: Precificação Inteligente para Ganhar Mais', 'Método Sócia Invisível › Módulo 08 – Faturando com Demandas na Prática › Aula 05 – Bônus 1: Precificação Inteligente para Ganhar Mais › Respostas a objeções (modelos da aula)

| Objeção | Resposta sugerida |
|---|---|
| "Está muito caro." | "Entendo. Quanto você perde por mês com o estresse e o tempo procurando coisas? Meu trabalho devolve esse tempo e essa tranquilidade." |
| "Vou pensar." | "Claro! Enquanto isso, posso te mandar algumas dicas gratuitas para você já conhecer meu método?" |
| "Fulana cobra mais barato." | "Existem profissionais com preços diferentes. A diferença é que eu crio sistemas que se mantêm. Meu foco é resultado duradouro." |', 'approved', ARRAY['precificação inteligente','precificar','quanto cobrar','preço','orçamento','valor percebido','valor entregue','transformação','custo da não solução','pacotes','três opções de preço','básico, completo e premium','justificativa de valor','ancoragem','objeções','está muito caro','vou pensar','fulana cobra mais barato','aumentar preço 20%','mulher suprema']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M08.A05-07', 'principal', 1, 8, 'V1.M08.A05 — Bônus 1: Precificação Inteligente para Ganhar Mais', 'Sinais de preço', 'Bônus 1: Precificação Inteligente para Ganhar Mais', 'Método Sócia Invisível › Módulo 08 – Faturando com Demandas na Prática › Aula 05 – Bônus 1: Precificação Inteligente para Ganhar Mais › Sinais de preço

| Você está cobrando pouco se… | Você está cobrando certo se… |
|---|---|
| Todos aceitam na hora | Alguns negociam, mas a maioria aceita |
| Tem mais demanda do que dá conta | Consegue escolher os melhores trabalhos |
| Trabalha muito e ganha pouco | Trabalha menos e ganha mais |
| Outros profissionais cobram mais | Os clientes valorizam o seu trabalho |', 'approved', ARRAY['precificação inteligente','precificar','quanto cobrar','preço','orçamento','valor percebido','valor entregue','transformação','custo da não solução','pacotes','três opções de preço','básico, completo e premium','justificativa de valor','ancoragem','objeções','está muito caro','vou pensar','fulana cobra mais barato','aumentar preço 20%','mulher suprema']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M08.A05-08', 'principal', 1, 8, 'V1.M08.A05 — Bônus 1: Precificação Inteligente para Ganhar Mais', '❌ Erros fatais de precificação', 'Bônus 1: Precificação Inteligente para Ganhar Mais', 'Método Sócia Invisível › Módulo 08 – Faturando com Demandas na Prática › Aula 05 – Bônus 1: Precificação Inteligente para Ganhar Mais › ❌ Erros fatais de precificação

Competir por preço, cobrar por hora, não justificar o valor, ter medo de perder o contrato, se comparar com concorrentes amadores, não aumentar os preços com a experiência e aceitar qualquer trabalho só pelo dinheiro.', 'approved', ARRAY['precificação inteligente','precificar','quanto cobrar','preço','orçamento','valor percebido','valor entregue','transformação','custo da não solução','pacotes','três opções de preço','básico, completo e premium','justificativa de valor','ancoragem','objeções','está muito caro','vou pensar','fulana cobra mais barato','aumentar preço 20%','mulher suprema']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M08.A05-09', 'principal', 1, 8, 'V1.M08.A05 — Bônus 1: Precificação Inteligente para Ganhar Mais', 'Missão prática', 'Bônus 1: Precificação Inteligente para Ganhar Mais', 'Método Sócia Invisível › Módulo 08 – Faturando com Demandas na Prática › Aula 05 – Bônus 1: Precificação Inteligente para Ganhar Mais › Missão prática

1. Calcular o valor real de cada serviço com as 5 perguntas.
2. Criar 3 pacotes (Básico, Completo e Premium) para cada serviço.
3. Preparar justificativas de valor para cada preço.
4. Aumentar os preços em 20% a partir da próxima proposta.', 'approved', ARRAY['precificação inteligente','precificar','quanto cobrar','preço','orçamento','valor percebido','valor entregue','transformação','custo da não solução','pacotes','três opções de preço','básico, completo e premium','justificativa de valor','ancoragem','objeções','está muito caro','vou pensar','fulana cobra mais barato','aumentar preço 20%','mulher suprema']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M08.A05-10', 'principal', 1, 8, 'V1.M08.A05 — Bônus 1: Precificação Inteligente para Ganhar Mais', 'FAQ', 'Bônus 1: Precificação Inteligente para Ganhar Mais', 'Método Sócia Invisível › Módulo 08 – Faturando com Demandas na Prática › Aula 05 – Bônus 1: Precificação Inteligente para Ganhar Mais › Pontos para o suporte

- "Quanto eu cobro?" Indicar esta aula: pensar no valor que o cliente recebe, montar 3 pacotes e justificar o preço. Para iniciantes, lembrar o Mês 1 do plano (preço atual para montar portfólio) e o Hack 13 do Bônus 02 (M07): começar com demandas menores para ganhar avaliações.
- "O cliente disse que está caro." Usar os modelos de resposta a objeções da tabela acima.
- "Todo mundo aceita meu preço na hora." Segundo a aula, é sinal de que está cobrando pouco.
- Lembrar a taxa da plataforma: no Workana, cerca de 20% do valor fica com a plataforma (ver a Aula 04 deste módulo). O preço precisa considerar isso.', 'approved', ARRAY['precificação inteligente','precificar','quanto cobrar','preço','orçamento','valor percebido','valor entregue','transformação','custo da não solução','pacotes','três opções de preço','básico, completo e premium','justificativa de valor','ancoragem','objeções','está muito caro','vou pensar','fulana cobra mais barato','aumentar preço 20%','mulher suprema']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M08.A06-01', 'principal', 1, 8, 'V1.M08.A06 — Bônus 2: Hacks Avançados para o Workana', 'Visão geral', 'Bônus 2: Hacks Avançados para o Workana', 'Método Sócia Invisível › Módulo 08 – Faturando com Demandas na Prática › Aula 06 – Bônus 2: Hacks Avançados para o Workana › Visão geral da aula

Nome oficial da aula: Bônus 2: Hacks Avançados para o Workana
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 08 – Faturando com Demandas na Prática, Aula 06
Duração/formato: 7:27
Link na área de membros (abre a página do Módulo 08, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/8

Resumo:
A aula traz 14 hacks para usar o Workana como porta de entrada para o mercado latino-americano. Segundo a aula, no 99Freelas a concorrência é local e no Workana é global, com projetos de toda a América Latina, muitos em dólar e de longo prazo (renda recorrente). A tese central é que a nacionalidade brasileira é um diferencial: criatividade, cordialidade e dedicação. A aula termina com uma lista de erros, um plano de crescimento em 4 meses e uma missão prática.', 'approved', ARRAY['hacks avançados Workana','99 Freelance','mercado internacional','América Latina','latinos','trabalhos em dólar','espanhol','México','Colômbia','Argentina','Chile','Uruguai','Paraguai','perfil em espanhol','Google Tradutor','ChatGPT','fuso horário','horário de aplicar','proposta cultural','jeitinho brasileiro','brasilidade','trabalhos recorrentes','pacotes mensais','soberana brasileira']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M08.A06-02', 'principal', 1, 8, 'V1.M08.A06 — Bônus 2: Hacks Avançados para o Workana', 'Os 14 hacks', 'Bônus 2: Hacks Avançados para o Workana', 'Método Sócia Invisível › Módulo 08 – Faturando com Demandas na Prática › Aula 06 – Bônus 2: Hacks Avançados para o Workana › Os 14 hacks (parte 1 de 2)

### Perfil e posicionamento
| # | Hack | Como aplicar |
|---|---|---|
| 1 | Perfil internacional | Escrever o perfil em português e espanhol, mesmo com espanhol básico (usar o Google Tradutor e pedir revisão). Destacar a nacionalidade brasileira. Usar foto profissional, sem selfie. |
| 5 | Portfólio adaptado | Apresentar os trabalhos com um toque cultural. Exemplo: "atendimento com cordialidade brasileira e eficiência internacional". |
| 10 | Valor agregado cultural | Oferecer o que "só uma brasileira oferece": jeitinho brasileiro, soluções criativas com materiais acessíveis, atendimento humanizado, flexibilidade. |
| 13 | Disponibilidade estratégica | Destacar que o horário comercial brasileiro permite atender clientes de vários países latinos, inclusive por videochamada. |
| 14 | Proposta educativa | Explicar ao cliente por que contratar uma brasileira: fama de criatividade, cordialidade e soluções inovadoras. |
### Quando e como enviar
| # | Hack | Como aplicar |
|---|---|---|
| 2 | Fusos horários | Sugestão da aula: 8h–12h para México e Colômbia; 14h–18h para Argentina e Chile; 19h–22h para Uruguai e Paraguai. |
| 3 | Proposta cultural | Adaptar o tom ao país: México mais formal e respeitoso; Argentina direto e confiante; Colômbia caloroso e próximo; Chile técnico e detalhista. |
| 6 | Comunicação brasileira | Em vez de "posso fazer o seu trabalho?", algo como: "Eu adoraria ajudar você a transformar o seu espaço com o cuidado e a dedicação que caracterizam o trabalho brasileiro". Sempre em espanhol, com ajuda do Google Tradutor ou do ChatGPT. |
| 8 | Palavras-chave em espanhol | Usar os termos que o cliente usa, em espanhol. Exemplos citados: organização doméstica, espaços funcionais, atendimento personalizado, experiência do usuário, consultoria personalizada. |
| 11 | Follow-up em duas etapas | 48 h depois: "Espero que tenha tido tempo de analisar minha proposta. Há algum aspecto que gostaria que eu detalhasse?" 1 semana depois: "Tenho pensado no seu trabalho e tenho algumas ideias adicionais." |', 'approved', ARRAY['hacks avançados Workana','99 Freelance','mercado internacional','América Latina','latinos','trabalhos em dólar','espanhol','México','Colômbia','Argentina','Chile','Uruguai','Paraguai','perfil em espanhol','Google Tradutor','ChatGPT','fuso horário','horário de aplicar','proposta cultural','jeitinho brasileiro','brasilidade','trabalhos recorrentes','pacotes mensais','soberana brasileira']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M08.A06-03', 'principal', 1, 8, 'V1.M08.A06 — Bônus 2: Hacks Avançados para o Workana', 'Os 14 hacks', 'Bônus 2: Hacks Avançados para o Workana', 'Método Sócia Invisível › Módulo 08 – Faturando com Demandas na Prática › Aula 06 – Bônus 2: Hacks Avançados para o Workana › Os 14 hacks (parte 2 de 2)

### Preço e tipo de trabalho
| # | Hack | Como aplicar |
|---|---|---|
| 4 | Preços em dólar | Muitos projetos pagam em dólar ("US$ 200 ≈ R$ 1.000, dependendo da cotação"). Não converter o preço em reais: pesquisar quanto cobram os profissionais locais e ficar cerca de 20% abaixo. Exemplo: se uma mexicana cobra US$ 300, cobrar US$ 240. |
| 7 | Trabalhos recorrentes | Buscar relações de longo prazo e oferecer pacotes mensais. Exemplos: consultoria mensal (US$ 150), acompanhamento semanal por WhatsApp (US$ 80), revisão trimestral presencial (US$ 200). |
| 9 | Prova social internacional | Adaptar depoimentos ao público latino. Exemplo da aula: "Graças a [nome], nossa casa foi completamente transformada… – Maria, México." |
| 12 | Trabalhos premium | Identificar clientes que pagam bem: orçamento acima de US$ 500, histórico de contratar profissionais caros, empresas (e não pessoas físicas), anúncios que pedem "alta qualidade" ou "profissional experiente". Para esses, posicionar-se como premium desde o início. |', 'approved', ARRAY['hacks avançados Workana','99 Freelance','mercado internacional','América Latina','latinos','trabalhos em dólar','espanhol','México','Colômbia','Argentina','Chile','Uruguai','Paraguai','perfil em espanhol','Google Tradutor','ChatGPT','fuso horário','horário de aplicar','proposta cultural','jeitinho brasileiro','brasilidade','trabalhos recorrentes','pacotes mensais','soberana brasileira']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M08.A06-04', 'principal', 1, 8, 'V1.M08.A06 — Bônus 2: Hacks Avançados para o Workana', '❌ Erros que matam a performance', 'Bônus 2: Hacks Avançados para o Workana', 'Método Sócia Invisível › Módulo 08 – Faturando com Demandas na Prática › Aula 06 – Bônus 2: Hacks Avançados para o Workana › ❌ Erros que matam a performance

1. Traduzir literalmente do português para o espanhol.
2. Não adaptar os preços ao mercado internacional.
3. Ignorar as diferenças culturais entre países.
4. Competir apenas por preço.
5. Não destacar a nacionalidade brasileira.
6. Enviar propostas nos horários errados.
7. Não oferecer trabalhos de longo prazo.', 'approved', ARRAY['hacks avançados Workana','99 Freelance','mercado internacional','América Latina','latinos','trabalhos em dólar','espanhol','México','Colômbia','Argentina','Chile','Uruguai','Paraguai','perfil em espanhol','Google Tradutor','ChatGPT','fuso horário','horário de aplicar','proposta cultural','jeitinho brasileiro','brasilidade','trabalhos recorrentes','pacotes mensais','soberana brasileira']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M08.A06-05', 'principal', 1, 8, 'V1.M08.A06 — Bônus 2: Hacks Avançados para o Workana', 'Plano de crescimento', 'Bônus 2: Hacks Avançados para o Workana', 'Método Sócia Invisível › Módulo 08 – Faturando com Demandas na Prática › Aula 06 – Bônus 2: Hacks Avançados para o Workana › Plano de crescimento

| Mês | Foco |
|---|---|
| 1 | Construir reputação com trabalhos pequenos de vários países |
| 2 | Identificar quais países respondem melhor ao seu perfil |
| 3 | Especializar-se nesses países e aumentar o preço |
| 4 | Focar em trabalhos recorrentes e de maior valor |', 'approved', ARRAY['hacks avançados Workana','99 Freelance','mercado internacional','América Latina','latinos','trabalhos em dólar','espanhol','México','Colômbia','Argentina','Chile','Uruguai','Paraguai','perfil em espanhol','Google Tradutor','ChatGPT','fuso horário','horário de aplicar','proposta cultural','jeitinho brasileiro','brasilidade','trabalhos recorrentes','pacotes mensais','soberana brasileira']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M08.A06-06', 'principal', 1, 8, 'V1.M08.A06 — Bônus 2: Hacks Avançados para o Workana', 'Missão prática', 'Bônus 2: Hacks Avançados para o Workana', 'Método Sócia Invisível › Módulo 08 – Faturando com Demandas na Prática › Aula 06 – Bônus 2: Hacks Avançados para o Workana › Missão prática

1. Reescrever o perfil em português e espanhol, destacando a brasilidade.
2. Pesquisar os preços nos países que quer atender.
3. Adaptar o portfólio para o público latino.
4. Enviar 5 propostas usando a estratégia de horário e de comunicação cultural.', 'approved', ARRAY['hacks avançados Workana','99 Freelance','mercado internacional','América Latina','latinos','trabalhos em dólar','espanhol','México','Colômbia','Argentina','Chile','Uruguai','Paraguai','perfil em espanhol','Google Tradutor','ChatGPT','fuso horário','horário de aplicar','proposta cultural','jeitinho brasileiro','brasilidade','trabalhos recorrentes','pacotes mensais','soberana brasileira']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M08.A06-07', 'principal', 1, 8, 'V1.M08.A06 — Bônus 2: Hacks Avançados para o Workana', 'FAQ', 'Bônus 2: Hacks Avançados para o Workana', 'Método Sócia Invisível › Módulo 08 – Faturando com Demandas na Prática › Aula 06 – Bônus 2: Hacks Avançados para o Workana › Pontos para o suporte

- "Preciso saber espanhol?" Não precisa ser fluente. A aula orienta usar o Google Tradutor ou o ChatGPT e pedir revisão. A aluna deve ter segurança para se comunicar com o cliente durante o projeto.
- "Posso receber em dólar?" Segundo a aula, muitos projetos no Workana são pagos em dólar. O recebimento segue a configuração de saque da Aula 03 deste módulo. Confirmar as regras de conversão e taxas na própria plataforma.
- "Quanto cobro de clientes de fora?" Pesquisar o preço local do país e ficar cerca de 20% abaixo (Hack 4).
- "O cliente não respondeu." Follow-up em 48 h e depois em 1 semana (Hack 11).
- Horários por país: não repassar a tabela do Hack 2.', 'approved', ARRAY['hacks avançados Workana','99 Freelance','mercado internacional','América Latina','latinos','trabalhos em dólar','espanhol','México','Colômbia','Argentina','Chile','Uruguai','Paraguai','perfil em espanhol','Google Tradutor','ChatGPT','fuso horário','horário de aplicar','proposta cultural','jeitinho brasileiro','brasilidade','trabalhos recorrentes','pacotes mensais','soberana brasileira']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A01-01', 'principal', 1, 9, 'V1.M09.A01 — Como Lucrar com Pesquisas Reais', 'Visão geral', 'Como Lucrar com Pesquisas Reais', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 01 – Como Lucrar com Pesquisas Reais › Visão geral da aula

Nome oficial da aula: Como Lucrar com Pesquisas Reais
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 09 – Transformando Opinião em Lucro, Aula 01
Duração/formato: 4:31
Link na área de membros (abre a página do Módulo 09, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/9

Resumo:
É a aula de abertura do Módulo 09, sobre ganhar dinheiro com pesquisas e opinião. A aula afirma que algumas oportunidades pagam em dólar. É introdutória e motivacional: não cita plataformas nem traz passos práticos. Ela apresenta o que o módulo vai ensinar e 3 regras para aproveitar o conteúdo. O tom é mais realista que o de outras aulas: "não tem mágica, não tem promessa vazia… o sucesso depende de você".', 'approved', ARRAY['Transformando opinião em lucro','pesquisas reais','pesquisas pagas','pesquisas remuneradas','responder pesquisas','dar opinião','pagamento em dólar','receber em dólar','convites','perfil perfeito']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A01-02', 'principal', 1, 9, 'V1.M09.A01 — Como Lucrar com Pesquisas Reais', 'O que o módulo promete ensinar', 'Como Lucrar com Pesquisas Reais', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 01 – Como Lucrar com Pesquisas Reais › O que o módulo promete ensinar

1. Identificar as oportunidades que pagam melhor.
2. Otimizar o perfil para receber mais convites e ser escolhida.
3. Executar as demandas com qualidade profissional.
4. Os erros que fazem "90% das pessoas" serem rejeitadas e como evitá-los.
5. Estratégias para aumentar os ganhos mensais com consistência.
6. Como receber em dólar com segurança.
7. Técnicas para se destacar e virar referência, e como negociar pagamentos melhores.', 'approved', ARRAY['Transformando opinião em lucro','pesquisas reais','pesquisas pagas','pesquisas remuneradas','responder pesquisas','dar opinião','pagamento em dólar','receber em dólar','convites','perfil perfeito']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A01-03', 'principal', 1, 9, 'V1.M09.A01 — Como Lucrar com Pesquisas Reais', 'Procedimento: as 3 regras para aproveitar o módulo', 'Como Lucrar com Pesquisas Reais', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 01 – Como Lucrar com Pesquisas Reais › Procedimento: as 3 regras para aproveitar o módulo

1. Seguir o passo a passo na ordem. Pular etapas "pode atrasar os resultados e dificultar a aceitação nas oportunidades".
2. Colocar em prática imediatamente: cadastrar-se, testar e explorar as estratégias assim que aprender.
3. Usar o material como guia: voltar às aulas sempre que surgir dúvida.
Rotina sugerida: usar as horas livres (quando as crianças estão na escola ou à noite) para pegar pequenas demandas pelo celular ou computador, com consistência diária ("como regar uma semente").
Em seguida, seguir para a Aula 02 do Módulo 09.', 'approved', ARRAY['Transformando opinião em lucro','pesquisas reais','pesquisas pagas','pesquisas remuneradas','responder pesquisas','dar opinião','pagamento em dólar','receber em dólar','convites','perfil perfeito']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A01-04', 'principal', 1, 9, 'V1.M09.A01 — Como Lucrar com Pesquisas Reais', 'FAQ', 'Como Lucrar com Pesquisas Reais', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 01 – Como Lucrar com Pesquisas Reais › Pontos para o suporte

- "O que é o Módulo 9?" É o módulo sobre ganhar dinheiro respondendo pesquisas e dando opinião, com algumas oportunidades pagas em dólar.
- "Em quais sites eu respondo pesquisas?" Esta aula ainda não cita plataformas. Elas devem aparecer nas próximas aulas do módulo.
- "Posso fazer pelo celular?" Sim, segundo a aula.
- "Quanto dá para ganhar?" A aula não dá valores. Não prometer ganhos.', 'approved', ARRAY['Transformando opinião em lucro','pesquisas reais','pesquisas pagas','pesquisas remuneradas','responder pesquisas','dar opinião','pagamento em dólar','receber em dólar','convites','perfil perfeito']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A02-01', 'principal', 1, 9, 'V1.M09.A02 — O Poder da Sua Opinião', 'Visão geral', 'O Poder da Sua Opinião', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 02 – O Poder da Sua Opinião › Visão geral da aula

Nome oficial da aula: O Poder da Sua Opinião
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 09 – Transformando Opinião em Lucro, Aula 02
Duração/formato: 5:52
Link na área de membros (abre a página do Módulo 09, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/9

Resumo:
A aula explica como funciona o mercado de pesquisas remuneradas: empresas pagam para entender como o consumidor pensa, compra e avalia produtos. Ela apresenta:
- os pilares de sucesso;
- os 3 tipos de pesquisa (online, presencial e VIP por vídeo), com exemplos de plataformas;
- regras de organização e de segurança;
- dicas para montar um perfil que recebe mais convites.
A missão final é criar um e-mail exclusivo, completar os cadastros e acompanhar os convites.', 'approved', ARRAY['pesquisas remuneradas','pesquisas pagas','responder pesquisas','cliente oculto','teste de produtos','entrevistas','grupos focais','pesquisas VIP','GrabPoints','Grab Points','Atapow','AttaPoll','Atta Poll','Falaí','Fala Aí','ProductTube','Product Tube','Respondente','Respondent','e-mail exclusivo','caixa de spam','planilha de controle','dados reais','dados estratégicos','perfil de consumo']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A02-02', 'principal', 1, 9, 'V1.M09.A02 — O Poder da Sua Opinião', 'Pilares (segundo a aula)', 'O Poder da Sua Opinião', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 02 – O Poder da Sua Opinião › Pilares (segundo a aula)

| Pilar | O que a aula diz |
|---|---|
| Segurança / autenticidade | Ser sincera e não tentar adivinhar o que a empresa quer ouvir. Manter as informações consistentes: se disser que tem carro numa pesquisa e que não tem em outra, o sistema percebe e pode bloquear a conta. |
| (2º pilar) | Não citado na gravação: a aula pula do 1º para o "terceiro". |
| Disponibilidade | Quanto mais participa, mais o algoritmo favorece e mais convites chegam. |
| Perfil estratégico | Cadastro completo, coerente e atrativo aumenta as chances de seleção. |', 'approved', ARRAY['pesquisas remuneradas','pesquisas pagas','responder pesquisas','cliente oculto','teste de produtos','entrevistas','grupos focais','pesquisas VIP','GrabPoints','Grab Points','Atapow','AttaPoll','Atta Poll','Falaí','Fala Aí','ProductTube','Product Tube','Respondente','Respondent','e-mail exclusivo','caixa de spam','planilha de controle','dados reais','dados estratégicos','perfil de consumo']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A02-03', 'principal', 1, 9, 'V1.M09.A02 — O Poder da Sua Opinião', 'Tipos de pesquisa', 'O Poder da Sua Opinião', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 02 – O Poder da Sua Opinião › Tipos de pesquisa

| Tipo | Como funciona | Pagamento | Plataformas citadas* |
|---|---|---|---|
| Online | Questionários pelo celular ou computador, em apps ou sites | Pix, PayPal, vouchers ou pontos convertidos em dinheiro | GrabPoints, "Atapow" (AttaPoll?), "Falaí", "Missense" |
| Presencial | Cliente oculto, teste de produtos, auditorias, visitas a estabelecimentos | Dinheiro, reembolso de compras ou produtos grátis | "ProductTube", "Vid", convites exclusivos |
| VIP (videoconferência) | Entrevistas em grupo ou individuais por Zoom, Meet ou Skype. Pagam mais e exigem cadastro mais completo | Pix ou PayPal | "Respondente" (Respondent?), "Vento", oportunidades exclusivas |
* Os nomes seguem a transcrição e vários parecem ter erro de grafia.', 'approved', ARRAY['pesquisas remuneradas','pesquisas pagas','responder pesquisas','cliente oculto','teste de produtos','entrevistas','grupos focais','pesquisas VIP','GrabPoints','Grab Points','Atapow','AttaPoll','Atta Poll','Falaí','Fala Aí','ProductTube','Product Tube','Respondente','Respondent','e-mail exclusivo','caixa de spam','planilha de controle','dados reais','dados estratégicos','perfil de consumo']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A02-04', 'principal', 1, 9, 'V1.M09.A02 — O Poder da Sua Opinião', 'Procedimento: passo a passo', 'O Poder da Sua Opinião', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 02 – O Poder da Sua Opinião › Procedimento: passo a passo

### 1. Organizar-se antes de se cadastrar
- Criar um e-mail exclusivo só para pesquisas e convites.
- Verificar sempre a caixa de spam, porque muitos convites caem lá.
- Ter um caderno ou planilha com: plataformas em que se cadastrou, pagamentos recebidos e datas de participação.
### 2. Cadastrar-se com segurança
- Nunca pagar para participar. Plataformas legítimas não cobram.
- Desconfiar de promessas irreais, como "ganhe R$ 800 em 12 minutos".
- Fornecer só os dados básicos necessários: nome, CPF e chave Pix.
- Nunca compartilhar senhas ou dados de cartão de crédito.
- Na dúvida, perguntar ao suporte antes de decidir.
### 3. Montar o perfil
- Completar 100% dos cadastros. Perfis completos recebem mais convites.
- Marcar interesses amplos: bebidas, tecnologia, higiene, eletrônicos etc.
- Ser coerente entre as plataformas, com as mesmas informações em todos os cadastros.
- Mostrar-se como uma consumidora ativa.
### 4. Participar com constância
Responder com regularidade e acompanhar os convites. "Quanto mais você participa, mais oportunidades aparecem."', 'approved', ARRAY['pesquisas remuneradas','pesquisas pagas','responder pesquisas','cliente oculto','teste de produtos','entrevistas','grupos focais','pesquisas VIP','GrabPoints','Grab Points','Atapow','AttaPoll','Atta Poll','Falaí','Fala Aí','ProductTube','Product Tube','Respondente','Respondent','e-mail exclusivo','caixa de spam','planilha de controle','dados reais','dados estratégicos','perfil de consumo']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A02-05', 'principal', 1, 9, 'V1.M09.A02 — O Poder da Sua Opinião', 'Missão da aula', 'O Poder da Sua Opinião', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 02 – O Poder da Sua Opinião › Missão da aula

1. Criar o e-mail exclusivo.
2. Completar os cadastros nas plataformas.
3. Acompanhar os convites, inclusive no spam.', 'approved', ARRAY['pesquisas remuneradas','pesquisas pagas','responder pesquisas','cliente oculto','teste de produtos','entrevistas','grupos focais','pesquisas VIP','GrabPoints','Grab Points','Atapow','AttaPoll','Atta Poll','Falaí','Fala Aí','ProductTube','Product Tube','Respondente','Respondent','e-mail exclusivo','caixa de spam','planilha de controle','dados reais','dados estratégicos','perfil de consumo']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A02-06', 'principal', 1, 9, 'V1.M09.A02 — O Poder da Sua Opinião', 'FAQ', 'O Poder da Sua Opinião', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 02 – O Poder da Sua Opinião › Pontos para o suporte

- "Em quais sites respondo pesquisas?" A aula cita exemplos por tipo (tabela acima). Confirmar a lista oficial e a grafia correta antes de indicar.
- "Preciso pagar para me cadastrar?" Não. Plataformas legítimas não cobram. Se pedirem pagamento, desconfiar.
- "Que dados posso informar?" Nome, CPF e chave Pix para validar a identidade e receber. Nunca senhas nem dados de cartão.
- "Não recebo convites." Verificar se os cadastros estão 100% completos, se os interesses estão amplos e se os convites não estão no spam.
- "Minha conta foi bloqueada." Uma causa comum é informação inconsistente entre pesquisas ou cadastros. Orientar a aluna a contatar o suporte da plataforma.', 'approved', ARRAY['pesquisas remuneradas','pesquisas pagas','responder pesquisas','cliente oculto','teste de produtos','entrevistas','grupos focais','pesquisas VIP','GrabPoints','Grab Points','Atapow','AttaPoll','Atta Poll','Falaí','Fala Aí','ProductTube','Product Tube','Respondente','Respondent','e-mail exclusivo','caixa de spam','planilha de controle','dados reais','dados estratégicos','perfil de consumo']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A03-01', 'principal', 1, 9, 'V1.M09.A03 — O Jogo do Algoritmo: Domine as Regras e Multiplique Suas Oportunidades', 'Visão geral', 'O Jogo do Algoritmo: Domine as Regras e Multiplique Suas Oportunidades', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 03 – O Jogo do Algoritmo: Domine as Regras e Multiplique Suas Oportunidades › Visão geral da aula

Nome oficial da aula: O Jogo do Algoritmo: Domine as Regras e Multiplique Suas Oportunidades
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 09 – Transformando Opinião em Lucro, Aula 03
Duração/formato: 4:17
Link na área de membros (abre a página do Módulo 09, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/9

Resumo:
A aula explica que as plataformas de pesquisa não distribuem convites ao acaso. Elas usam algoritmos que avaliam o histórico, o engajamento e a consistência das respostas de cada participante. A frase-chave é: "Não é sorte, é algoritmo. Quem entende as regras joga melhor." A aula dá práticas para receber mais pesquisas, lista os erros que causam eliminação e explica que os critérios demográficos (idade, sexo, região, filhos) limitam quais pesquisas aparecem para cada pessoa, e que isso é normal.', 'approved', ARRAY['jogo do algoritmo','algoritmo das pesquisas','como receber mais pesquisas','mais convites','desclassificação','eliminada','screen out','estorno de pontos','suspensão de conta','perguntas de atenção','pegadinhas','controle de qualidade','comportamento de bot','critérios demográficos','região','idade','sexo','filhos','cota disponível']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A03-02', 'principal', 1, 9, 'V1.M09.A03 — O Jogo do Algoritmo: Domine as Regras e Multiplique Suas Oportunidades', 'Procedimento: como se destacar', 'O Jogo do Algoritmo: Domine as Regras e Multiplique Suas Oportunidades', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 03 – O Jogo do Algoritmo: Domine as Regras e Multiplique Suas Oportunidades › Procedimento: como se destacar

| # | Prática | Por quê |
|---|---|---|
| 1 | Preencher o perfil por completo em todas as plataformas | Muita gente não faz e perde oportunidades. |
| 2 | Manter coerência nas respostas | Contradições levam a desclassificação, estorno de pontos ou suspensão da conta. |
| 3 | Cadastrar-se em várias plataformas | Mais chances de achar pesquisas que se encaixam no seu perfil. |
| 4 | Usar um e-mail dedicado | Centraliza e organiza os convites (ver a Aula 02). |
| 5 | Acessar as plataformas pelo menos 1 vez por dia | As pesquisas expiram em poucas horas, conforme a cota. |
| 6 | Manter o perfil atualizado | Se mudar de cidade, número de filhos ou hábitos, atualizar. |
| 7 | Não recusar pesquisas com frequência | Mesmo as de valor pequeno constroem histórico de participante ativa. |
| 8 | Variar os dispositivos (celular, tablet, computador) | Segundo a aula, "mostra atividade legítima". |
| 9 | Abrir as pesquisas mesmo sem concluir | Segundo a aula, "demonstra interesse". |', 'approved', ARRAY['jogo do algoritmo','algoritmo das pesquisas','como receber mais pesquisas','mais convites','desclassificação','eliminada','screen out','estorno de pontos','suspensão de conta','perguntas de atenção','pegadinhas','controle de qualidade','comportamento de bot','critérios demográficos','região','idade','sexo','filhos','cota disponível']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A03-03', 'principal', 1, 9, 'V1.M09.A03 — O Jogo do Algoritmo: Domine as Regras e Multiplique Suas Oportunidades', '❌ Erros que eliminam nas pesquisas', 'O Jogo do Algoritmo: Domine as Regras e Multiplique Suas Oportunidades', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 03 – O Jogo do Algoritmo: Domine as Regras e Multiplique Suas Oportunidades › ❌ Erros que eliminam nas pesquisas

1. Responder rápido demais: parece comportamento de robô (bot).
2. Contradições entre pesquisas: por exemplo, dizer que tem filhos numa e negar em outra.
3. Errar as perguntas de atenção: as empresas incluem "pegadinhas" para verificar se a pessoa está lendo. Ler com calma e responder com atenção.', 'approved', ARRAY['jogo do algoritmo','algoritmo das pesquisas','como receber mais pesquisas','mais convites','desclassificação','eliminada','screen out','estorno de pontos','suspensão de conta','perguntas de atenção','pegadinhas','controle de qualidade','comportamento de bot','critérios demográficos','região','idade','sexo','filhos','cota disponível']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A03-04', 'principal', 1, 9, 'V1.M09.A03 — O Jogo do Algoritmo: Domine as Regras e Multiplique Suas Oportunidades', 'Critérios demográficos: "parâmetros, não limites"', 'O Jogo do Algoritmo: Domine as Regras e Multiplique Suas Oportunidades', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 03 – O Jogo do Algoritmo: Domine as Regras e Multiplique Suas Oportunidades › Critérios demográficos: "parâmetros, não limites"

Cada pesquisa busca um público específico (região, idade, sexo, filhos, hábitos). Nem toda pesquisa estará disponível para você, e tudo bem. Exemplos da aula:
- quem tem perfil masculino não recebe pesquisas só para mulheres;
- quem tem 35 anos não é chamada para pesquisas de 18 a 24 anos;
- quem mora na capital não vê pesquisas para moradores do interior.
Algumas informações do perfil são fixas, então preencher com atenção desde o início.', 'approved', ARRAY['jogo do algoritmo','algoritmo das pesquisas','como receber mais pesquisas','mais convites','desclassificação','eliminada','screen out','estorno de pontos','suspensão de conta','perguntas de atenção','pegadinhas','controle de qualidade','comportamento de bot','critérios demográficos','região','idade','sexo','filhos','cota disponível']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A03-05', 'principal', 1, 9, 'V1.M09.A03 — O Jogo do Algoritmo: Domine as Regras e Multiplique Suas Oportunidades', 'Resumo prático', 'O Jogo do Algoritmo: Domine as Regras e Multiplique Suas Oportunidades', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 03 – O Jogo do Algoritmo: Domine as Regras e Multiplique Suas Oportunidades › Resumo prático

Perfil completo · coerência · várias plataformas · organização · acesso diário · paciência e constância.', 'approved', ARRAY['jogo do algoritmo','algoritmo das pesquisas','como receber mais pesquisas','mais convites','desclassificação','eliminada','screen out','estorno de pontos','suspensão de conta','perguntas de atenção','pegadinhas','controle de qualidade','comportamento de bot','critérios demográficos','região','idade','sexo','filhos','cota disponível']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A03-06', 'principal', 1, 9, 'V1.M09.A03 — O Jogo do Algoritmo: Domine as Regras e Multiplique Suas Oportunidades', 'FAQ', 'O Jogo do Algoritmo: Domine as Regras e Multiplique Suas Oportunidades', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 03 – O Jogo do Algoritmo: Domine as Regras e Multiplique Suas Oportunidades › Pontos para o suporte

- "Sempre sou eliminada no começo das pesquisas." É normal acontecer por critério demográfico (a pesquisa busca outro público). Também pode ser por responder rápido demais, contradições ou errar perguntas de atenção. Orientar a ler com calma e manter o perfil coerente.
- "Recebo poucas pesquisas." Completar o perfil, cadastrar-se em mais plataformas, acessar todo dia e não recusar pesquisas com frequência.
- "Perdi meus pontos / minha conta foi suspensa." Uma das causas citadas é resposta contraditória. Orientar a aluna a contatar o suporte da plataforma.
- "Por que não aparecem pesquisas para mim?" Os critérios demográficos filtram quem recebe cada pesquisa. Isso não depende da aluna.', 'approved', ARRAY['jogo do algoritmo','algoritmo das pesquisas','como receber mais pesquisas','mais convites','desclassificação','eliminada','screen out','estorno de pontos','suspensão de conta','perguntas de atenção','pegadinhas','controle de qualidade','comportamento de bot','critérios demográficos','região','idade','sexo','filhos','cota disponível']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A04-01', 'principal', 1, 9, 'V1.M09.A04 — Ganhos Reais com Pesquisas: A Estratégia Oculta', 'Visão geral', 'Ganhos Reais com Pesquisas: A Estratégia Oculta', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 04 – Ganhos Reais com Pesquisas: A Estratégia Oculta › Visão geral da aula

Nome oficial da aula: Ganhos Reais com Pesquisas: A Estratégia Oculta
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 09 – Transformando Opinião em Lucro, Aula 04
Duração/formato: 6:54
Link na área de membros (abre a página do Módulo 09, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/9

Resumo:
A aula apresenta a "estratégia" da Gabriela para ter renda com pesquisas remuneradas. A primeira parte trata de segurança (golpes, dados pessoais, reputação das plataformas) e é bem útil. A segunda parte afirma que "as pesquisas não premiam respostas, premiam perfis interessantes para o mercado" e orienta a aluna a "ajustar" dados de perfil (renda, profissão, CEP, hábitos) para ser mais escolhida. Esse ponto é crítico:
Relato de ganho: no começo, a Gabriela diz que somava R$ 200 a R$ 300 por mês, às vezes numa semana.', 'approved', ARRAY['estratégia oculta','ganhos reais com pesquisas','quanto dá para ganhar com pesquisas','golpes','segurança','reputação da plataforma','Reclame Aqui','pesquisas presenciais','pesquisas online','perfil interessante','dados reais','dados estratégicos','perfil de consumo','CEP','renda','profissão','responsável pelas compras','desclassificada','comportamento de bot','pegadinha de atenção']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A04-02', 'principal', 1, 9, 'V1.M09.A04 — Ganhos Reais com Pesquisas: A Estratégia Oculta', 'Parte 1: Segurança (procedimento)', 'Ganhos Reais com Pesquisas: A Estratégia Oculta', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 04 – Ganhos Reais com Pesquisas: A Estratégia Oculta › Parte 1: Segurança (procedimento)

### Pesquisas presenciais
1. Calcular se o tempo e o deslocamento valem a recompensa.
2. Fornecer só os dados essenciais. Endereço completo e dados financeiros só para empresas sólidas e reconhecidas.
3. A participação é voluntária. Se sentir desconforto, pode parar.
### Pesquisas online
1. Cuidado com golpes: desconfiar de promessas irreais e de plataformas que pedem dados financeiros ou pagamento para se inscrever. Pesquisas legítimas não pedem cartão de crédito nem senha bancária.
2. Avaliar tempo × valor antes de começar. Algumas são longas demais para pagar pouco.
3. Proteger a caixa de entrada: usar um e-mail exclusivo para pesquisas.
4. Checar a reputação da plataforma antes de se cadastrar: pesquisar o nome no Google e em fóruns especializados.
### Regras de ouro
- Nunca fornecer senhas, cartões ou documentos pessoais em pesquisas.
- Confiar na intuição: se parecer estranho, recusar.', 'approved', ARRAY['estratégia oculta','ganhos reais com pesquisas','quanto dá para ganhar com pesquisas','golpes','segurança','reputação da plataforma','Reclame Aqui','pesquisas presenciais','pesquisas online','perfil interessante','dados reais','dados estratégicos','perfil de consumo','CEP','renda','profissão','responsável pelas compras','desclassificada','comportamento de bot','pegadinha de atenção']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A04-03', 'principal', 1, 9, 'V1.M09.A04 — Ganhos Reais com Pesquisas: A Estratégia Oculta', 'Parte 2: Expectativas realistas', 'Ganhos Reais com Pesquisas: A Estratégia Oculta', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 04 – Ganhos Reais com Pesquisas: A Estratégia Oculta › Parte 2: Expectativas realistas

- Não existe passar em todas as pesquisas. Perfis novos demoram a ser aceitos com frequência. Mesmo quem domina o assunto pode ser desclassificada, porque cada pesquisa busca um público específico. Não desanimar.
- Quem mais participa: mães em casa, autônomos nos intervalos do trabalho, estudantes, aposentados, quem quer "pagar o iFood do mês".', 'approved', ARRAY['estratégia oculta','ganhos reais com pesquisas','quanto dá para ganhar com pesquisas','golpes','segurança','reputação da plataforma','Reclame Aqui','pesquisas presenciais','pesquisas online','perfil interessante','dados reais','dados estratégicos','perfil de consumo','CEP','renda','profissão','responsável pelas compras','desclassificada','comportamento de bot','pegadinha de atenção']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A04-04', 'principal', 1, 9, 'V1.M09.A04 — Ganhos Reais com Pesquisas: A Estratégia Oculta', 'Parte 3: Dicas para não ser desclassificada', 'Ganhos Reais com Pesquisas: A Estratégia Oculta', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 04 – Ganhos Reais com Pesquisas: A Estratégia Oculta › Parte 3: Dicas para não ser desclassificada

1. Ler as perguntas com calma. Não clicar no automático.
2. Não responder rápido demais, porque parece comportamento de robô.
3. Não atualizar a página durante a pesquisa.
4. Atenção às perguntas de atenção. Exemplo: "Que dia vem depois de terça-feira?"
5. "Sempre marque que você é responsável pelas compras da casa."', 'approved', ARRAY['estratégia oculta','ganhos reais com pesquisas','quanto dá para ganhar com pesquisas','golpes','segurança','reputação da plataforma','Reclame Aqui','pesquisas presenciais','pesquisas online','perfil interessante','dados reais','dados estratégicos','perfil de consumo','CEP','renda','profissão','responsável pelas compras','desclassificada','comportamento de bot','pegadinha de atenção']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A04-05', 'principal', 1, 9, 'V1.M09.A04 — Ganhos Reais com Pesquisas: A Estratégia Oculta', 'Parte 4: "Dados reais × dados estratégicos" (segundo a aula)', 'Ganhos Reais com Pesquisas: A Estratégia Oculta', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 04 – Ganhos Reais com Pesquisas: A Estratégia Oculta › Parte 4: "Dados reais × dados estratégicos" (segundo a aula)

| Dados reais: "nunca mudam" | Dados "estratégicos": "ajustáveis" |
|---|---|
| Nome, CPF, data de nascimento, chave Pix, e-mail, telefone, conta bancária | Profissão, renda, hábitos de consumo, estilo de vida |
Perfis que a aula diz serem "mais aceitos": CEP de área nobre, cargo de gestão com renda de R$ 5 mil a R$ 10 mil, compras online, delivery, streaming, viagens ocasionais e uso de redes sociais e e-commerce.', 'approved', ARRAY['estratégia oculta','ganhos reais com pesquisas','quanto dá para ganhar com pesquisas','golpes','segurança','reputação da plataforma','Reclame Aqui','pesquisas presenciais','pesquisas online','perfil interessante','dados reais','dados estratégicos','perfil de consumo','CEP','renda','profissão','responsável pelas compras','desclassificada','comportamento de bot','pegadinha de atenção']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A04-06', 'principal', 1, 9, 'V1.M09.A04 — Ganhos Reais com Pesquisas: A Estratégia Oculta', 'FAQ', 'Ganhos Reais com Pesquisas: A Estratégia Oculta', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 04 – Ganhos Reais com Pesquisas: A Estratégia Oculta › Pontos para o suporte

- "Como sei se uma plataforma de pesquisa é confiável?" Pesquisar o nome no Google e em fóruns. Desconfiar de quem pede pagamento, cartão ou senha. Plataformas legítimas não cobram para participar.
- "Uma pesquisa pediu meu cartão / senha." Não fornecer. É sinal de golpe.
- "Sou sempre desclassificada." É normal no começo. Cada pesquisa busca um público específico. Ler com calma, não responder rápido demais, não atualizar a página e prestar atenção às perguntas-teste.
- "Quanto dá para ganhar?" A própria aula cita R$ 200 a R$ 300 por mês no começo. Não prometer valores.
- "Posso mudar minha renda, profissão ou CEP no cadastro?" Orientar a NÃO declarar informações falsas.', 'approved', ARRAY['estratégia oculta','ganhos reais com pesquisas','quanto dá para ganhar com pesquisas','golpes','segurança','reputação da plataforma','Reclame Aqui','pesquisas presenciais','pesquisas online','perfil interessante','dados reais','dados estratégicos','perfil de consumo','CEP','renda','profissão','responsável pelas compras','desclassificada','comportamento de bot','pegadinha de atenção']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A05-01', 'principal', 1, 9, 'V1.M09.A05 — Como Transformar Suas Opiniões em Renda Consistente', 'Visão geral', 'Como Transformar Suas Opiniões em Renda Consistente', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 05 – Como Transformar Suas Opiniões em Renda Consistente › Visão geral da aula

Nome oficial da aula: Como Transformar Suas Opiniões em Renda Consistente
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 09 – Transformando Opinião em Lucro, Aula 05
Duração/formato: 3:03
Link na área de membros (abre a página do Módulo 09, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/9

Resumo:
É uma aula curta que funciona como ponte para as aulas das plataformas. Ela explica como as plataformas de pesquisa funcionam, como "pontes" entre consumidores e empresas, apresenta os 5 tipos de oportunidade e dá 5 passos para se cadastrar e usar bem as plataformas. A Gabriela anuncia que vai apresentar os seus "verdadeiros aliados", as plataformas responsáveis pela maior parte dos ganhos dela, e avisa que os links já estão disponíveis. Mas pede que a aluna assista às aulas antes de se cadastrar.', 'approved', ARRAY['plataformas de pesquisa','sites de pesquisa','apps de pesquisa','aliados','pesquisas tradicionais','entrevistas em vídeo','Zoom','Google Meet','teste de produtos','protótipos','avaliar aplicativos e sites','cliente oculto','missões','links das plataformas','links abaixo da aula','grupos e comunidades','filtros']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A05-02', 'principal', 1, 9, 'V1.M09.A05 — Como Transformar Suas Opiniões em Renda Consistente', 'Tipos de oportunidade', 'Como Transformar Suas Opiniões em Renda Consistente', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 05 – Como Transformar Suas Opiniões em Renda Consistente › Tipos de oportunidade

| Tipo | Como funciona |
|---|---|
| Pesquisas tradicionais | Questionários online pelo celular ou computador |
| Entrevistas em vídeo | Discussões em grupo por Zoom ou Google Meet |
| Testes de produtos e protótipos | Empresas enviam itens para casa, ou a aluna avalia apps e sites |
| Cliente oculto | Visitas presenciais para avaliar o atendimento em lojas e restaurantes |
| Oportunidades e missões | Pequenas atividades com pagamento extra |
Em troca, a aluna recebe pagamentos, benefícios ou acesso antecipado a novidades.', 'approved', ARRAY['plataformas de pesquisa','sites de pesquisa','apps de pesquisa','aliados','pesquisas tradicionais','entrevistas em vídeo','Zoom','Google Meet','teste de produtos','protótipos','avaliar aplicativos e sites','cliente oculto','missões','links das plataformas','links abaixo da aula','grupos e comunidades','filtros']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A05-03', 'principal', 1, 9, 'V1.M09.A05 — Como Transformar Suas Opiniões em Renda Consistente', 'Procedimento: 5 passos para se cadastrar e usar as plataformas', 'Como Transformar Suas Opiniões em Renda Consistente', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 05 – Como Transformar Suas Opiniões em Renda Consistente › Procedimento: 5 passos para se cadastrar e usar as plataformas

1. Criar um e-mail exclusivo para pesquisas.
2. Preencher o perfil de forma correta e consistente. Perfis completos e ativos recebem mais convites.
3. Ler com atenção o que cada cadastro pede, para evitar erros que desclassificam.
4. Monitorar os pagamentos. Algumas plataformas pagam na hora, outras têm prazo.
5. Acompanhar os grupos e comunidades, onde administradores e membros compartilham oportunidades.
⚠️ Antes de clicar nos links: assistir às próximas aulas, que mostram como funciona cada plataforma e o que observar no cadastro. "Um cadastro inteligente separa alguns trocados de uma renda consistente."', 'approved', ARRAY['plataformas de pesquisa','sites de pesquisa','apps de pesquisa','aliados','pesquisas tradicionais','entrevistas em vídeo','Zoom','Google Meet','teste de produtos','protótipos','avaliar aplicativos e sites','cliente oculto','missões','links das plataformas','links abaixo da aula','grupos e comunidades','filtros']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A05-04', 'principal', 1, 9, 'V1.M09.A05 — Como Transformar Suas Opiniões em Renda Consistente', 'FAQ', 'Como Transformar Suas Opiniões em Renda Consistente', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 05 – Como Transformar Suas Opiniões em Renda Consistente › Pontos para o suporte

- "Onde estão os links das plataformas de pesquisa?" Segundo a aula, os links já estão prontos na área de membros. Confirmar onde ficam (abaixo desta aula ou nas próximas).
- "Por onde começo?" Criar o e-mail exclusivo e assistir às aulas de cada plataforma antes de se cadastrar.
- "Quando recebo das pesquisas?" Depende da plataforma: algumas pagam na hora, outras têm prazo. Orientar a aluna a monitorar e anotar os pagamentos (ver a planilha da Aula 02).
- "As empresas mandam produto para casa?" Sim, nos testes de produtos, segundo a aula.', 'approved', ARRAY['plataformas de pesquisa','sites de pesquisa','apps de pesquisa','aliados','pesquisas tradicionais','entrevistas em vídeo','Zoom','Google Meet','teste de produtos','protótipos','avaliar aplicativos e sites','cliente oculto','missões','links das plataformas','links abaixo da aula','grupos e comunidades','filtros']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A06-01', 'principal', 1, 9, 'V1.M09.A06 — Transforme Cliques em Dinheiro com GrabPoints', 'Visão geral', 'Transforme Cliques em Dinheiro com GrabPoints', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 06 – Transforme Cliques em Dinheiro com GrabPoints › Visão geral da aula

Nome oficial da aula: Transforme Cliques em Dinheiro com GrabPoints
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 09 – Transformando Opinião em Lucro, Aula 06
Duração/formato: 2:39
Link na área de membros (abre a página do Módulo 09, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/9

Resumo:
É a primeira aula do módulo sobre uma plataforma específica: o GrabPoints, uma plataforma de recompensas online em que a aluna acumula pontos com ações digitais e depois os troca por dinheiro (PayPal) ou vales-presente. A aula explica as formas de ganhar, o passo a passo de uso, os pontos fortes e os pontos de atenção. A Gabriela diz que já usou a plataforma e teve "ganhos reais", sem citar valores.', 'approved', ARRAY['GrabPoints','Grab Points','Grabpoint','Grab Point','plataforma de recompensas','pontos','trocar pontos','PayPal','vale-presente Amazon','Google Play','recarga de celular','saque mínimo','3 dólares','US$ 3','link de indicação','convidar amigos','baixar aplicativos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A06-02', 'principal', 1, 9, 'V1.M09.A06 — Transforme Cliques em Dinheiro com GrabPoints', 'Formas de ganhar pontos', 'Transforme Cliques em Dinheiro com GrabPoints', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 06 – Transforme Cliques em Dinheiro com GrabPoints › Formas de ganhar pontos

| Ação | Como funciona |
|---|---|
| Responder pesquisas | A principal função. Temas variados, com recompensa que varia conforme a dificuldade |
| Baixar aplicativos | Testar apps e ganhar pontos extras |
| Concluir ofertas | Fazer cadastros, jogar ou fazer compras online |
| Convidar amigos | Ganhar pontos quando alguém entra pelo seu link de indicação |', 'approved', ARRAY['GrabPoints','Grab Points','Grabpoint','Grab Point','plataforma de recompensas','pontos','trocar pontos','PayPal','vale-presente Amazon','Google Play','recarga de celular','saque mínimo','3 dólares','US$ 3','link de indicação','convidar amigos','baixar aplicativos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A06-03', 'principal', 1, 9, 'V1.M09.A06 — Transforme Cliques em Dinheiro com GrabPoints', 'Procedimento: passo a passo', 'Transforme Cliques em Dinheiro com GrabPoints', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 06 – Transforme Cliques em Dinheiro com GrabPoints › Procedimento: passo a passo

1. Criar a conta no GrabPoints com os dados básicos, de preferência com o e-mail exclusivo de pesquisas (Aula 02).
2. Completar o perfil com atenção. A plataforma usa essas informações para enviar pesquisas compatíveis com os seus interesses.
3. Acumular pontos com as opções disponíveis (pesquisas, apps, ofertas, indicações).
4. Trocar os pontos quando atingir o mínimo:
  - dinheiro via PayPal;
  - vales-presente: Amazon, Google Play;
  - recarga de celular.', 'approved', ARRAY['GrabPoints','Grab Points','Grabpoint','Grab Point','plataforma de recompensas','pontos','trocar pontos','PayPal','vale-presente Amazon','Google Play','recarga de celular','saque mínimo','3 dólares','US$ 3','link de indicação','convidar amigos','baixar aplicativos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A06-04', 'principal', 1, 9, 'V1.M09.A06 — Transforme Cliques em Dinheiro com GrabPoints', 'Pontos fortes × pontos de atenção (segundo a aula)', 'Transforme Cliques em Dinheiro com GrabPoints', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 06 – Transforme Cliques em Dinheiro com GrabPoints › Pontos fortes × pontos de atenção (segundo a aula)

| ✅ Pontos fortes | ⚠️ Pontos de atenção |
|---|---|
| Várias formas de ganhar além das pesquisas | Pagamento em dólar: acompanhar a cotação |
| Saque a partir de US$ 3, bom para iniciantes | Poucas pesquisas disponíveis no Brasil: exige paciência |
| Site leve e fácil de usar | Suporte pode ser lento |', 'approved', ARRAY['GrabPoints','Grab Points','Grabpoint','Grab Point','plataforma de recompensas','pontos','trocar pontos','PayPal','vale-presente Amazon','Google Play','recarga de celular','saque mínimo','3 dólares','US$ 3','link de indicação','convidar amigos','baixar aplicativos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A06-05', 'principal', 1, 9, 'V1.M09.A06 — Transforme Cliques em Dinheiro com GrabPoints', 'FAQ', 'Transforme Cliques em Dinheiro com GrabPoints', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 06 – Transforme Cliques em Dinheiro com GrabPoints › Pontos para o suporte

- "O que é o GrabPoints?" É uma plataforma de recompensas: você acumula pontos respondendo pesquisas, baixando apps, concluindo ofertas e indicando amigos, e troca por dinheiro no PayPal ou por vales-presente.
- "Qual o valor mínimo para sacar?" Segundo a aula, US$ 3. Confirmar no site, porque o valor pode mudar.
- "Como recebo?" Por PayPal (em dólar, convertido para reais pelo PayPal) ou por vales-presente e recarga. A aluna precisa de uma conta PayPal para receber em dinheiro.
- "Quase não aparecem pesquisas para mim." A própria aula avisa que as pesquisas para o Brasil podem ser limitadas. Completar o perfil e acessar com frequência.
- "Tive um problema com a conta ou o pagamento." Contatar o suporte do GrabPoints. A aula avisa que ele pode ser lento. O método não tem acesso às contas das alunas.', 'approved', ARRAY['GrabPoints','Grab Points','Grabpoint','Grab Point','plataforma de recompensas','pontos','trocar pontos','PayPal','vale-presente Amazon','Google Play','recarga de celular','saque mínimo','3 dólares','US$ 3','link de indicação','convidar amigos','baixar aplicativos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A07-01', 'principal', 1, 9, 'V1.M09.A07 — AttaPoll na Prática: Como Lucrar com Pesquisas no Celular', 'Visão geral', 'AttaPoll na Prática: Como Lucrar com Pesquisas no Celular', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 07 – AttaPoll na Prática: Como Lucrar com Pesquisas no Celular › Visão geral da aula

Nome oficial da aula: AttaPoll na Prática: Como Lucrar com Pesquisas no Celular
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 09 – Transformando Opinião em Lucro, Aula 07
Duração/formato: 2:47
Link na área de membros (abre a página do Módulo 09, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/9

Resumo:
A aula apresenta o AttaPoll, um aplicativo de pesquisas remuneradas para celular (Android e iOS) que conecta a aluna a empresas que querem a opinião dela, em troca de dinheiro via PayPal. A aula explica o funcionamento, as vantagens, os pontos de atenção e dá dicas de uso. Assim como na aula do GrabPoints, a Gabriela diz ter tido "ganhos reais", sem citar valores.
Na transcrição, o nome aparece como "Atapal". Na Aula 02 do módulo, como "Atapow". O nome correto é AttaPoll.', 'approved', ARRAY['AttaPoll','Atta Poll','Atapal','Atapoll','Atapow','Ata Pol','aplicativo de pesquisas','app de pesquisa no celular','Android','iOS','iPhone','saque mínimo','3 dólares','US$ 3','PayPal','convidar amigos','indicação','porcentagem dos ganhos','notificações','pesquisas em inglês']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A07-02', 'principal', 1, 9, 'V1.M09.A07 — AttaPoll na Prática: Como Lucrar com Pesquisas no Celular', 'Procedimento: passo a passo', 'AttaPoll na Prática: Como Lucrar com Pesquisas no Celular', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 07 – AttaPoll na Prática: Como Lucrar com Pesquisas no Celular › Procedimento: passo a passo

1. Baixar o app AttaPoll na loja do celular (Google Play ou App Store).
2. Fazer o cadastro. É rápido, leva poucos minutos. Usar de preferência o e-mail exclusivo de pesquisas (Aula 02).
3. Completar o perfil com detalhes. Quanto mais completo, mais pesquisas a aluna recebe.
4. Ativar as notificações para ser avisada de novas pesquisas em tempo real.
5. Responder às pesquisas com atenção e consistência.
6. Sacar pelo PayPal a partir de US$ 3.
7. (Opcional) Convidar amigos e ganhar uma porcentagem dos ganhos deles.', 'approved', ARRAY['AttaPoll','Atta Poll','Atapal','Atapoll','Atapow','Ata Pol','aplicativo de pesquisas','app de pesquisa no celular','Android','iOS','iPhone','saque mínimo','3 dólares','US$ 3','PayPal','convidar amigos','indicação','porcentagem dos ganhos','notificações','pesquisas em inglês']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A07-03', 'principal', 1, 9, 'V1.M09.A07 — AttaPoll na Prática: Como Lucrar com Pesquisas no Celular', 'Vantagens × pontos de atenção (segundo a aula)', 'AttaPoll na Prática: Como Lucrar com Pesquisas no Celular', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 07 – AttaPoll na Prática: Como Lucrar com Pesquisas no Celular › Vantagens × pontos de atenção (segundo a aula)

| ✅ Vantagens | ⚠️ Pontos de atenção |
|---|---|
| Flexibilidade: responder no seu tempo, de qualquer lugar | Algumas pesquisas pagam pouco |
| Interface intuitiva, fácil mesmo para iniciantes | O número de pesquisas varia com o perfil e a localização |
| Pagamentos confiáveis e pontuais | Algumas pesquisas aparecem em inglês, mesmo com o app em português |
| Suporte ativo, com respostas rápidas | — |', 'approved', ARRAY['AttaPoll','Atta Poll','Atapal','Atapoll','Atapow','Ata Pol','aplicativo de pesquisas','app de pesquisa no celular','Android','iOS','iPhone','saque mínimo','3 dólares','US$ 3','PayPal','convidar amigos','indicação','porcentagem dos ganhos','notificações','pesquisas em inglês']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A07-04', 'principal', 1, 9, 'V1.M09.A07 — AttaPoll na Prática: Como Lucrar com Pesquisas no Celular', 'Dicas de uso', 'AttaPoll na Prática: Como Lucrar com Pesquisas no Celular', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 07 – AttaPoll na Prática: Como Lucrar com Pesquisas no Celular › Dicas de uso

1. Manter o perfil sempre atualizado para receber mais convites.
2. Responder com atenção e consistência, evitando desclassificações e melhorando o histórico.
3. Testar horários diferentes. Algumas pesquisas aparecem em janelas curtas.', 'approved', ARRAY['AttaPoll','Atta Poll','Atapal','Atapoll','Atapow','Ata Pol','aplicativo de pesquisas','app de pesquisa no celular','Android','iOS','iPhone','saque mínimo','3 dólares','US$ 3','PayPal','convidar amigos','indicação','porcentagem dos ganhos','notificações','pesquisas em inglês']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A07-05', 'principal', 1, 9, 'V1.M09.A07 — AttaPoll na Prática: Como Lucrar com Pesquisas no Celular', 'FAQ', 'AttaPoll na Prática: Como Lucrar com Pesquisas no Celular', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 07 – AttaPoll na Prática: Como Lucrar com Pesquisas no Celular › Pontos para o suporte

- "O que é o AttaPoll?" Um app de pesquisas pagas para Android e iOS. A aluna responde pesquisas e saca por PayPal a partir de US$ 3.
- "Não acho o app ''Atapal''." O nome correto é AttaPoll.
- "Qual o saque mínimo?" Segundo a aula, US$ 3, via PayPal. A aluna precisa de conta PayPal. Confirmar o valor atual no app.
- "Apareceu pesquisa em inglês." A própria aula avisa que isso pode acontecer. A aluna só deve responder se entender as perguntas, para não cair em contradições nem errar as perguntas de atenção.
- "Recebo poucas pesquisas." Depende do perfil e da localização. Manter o perfil atualizado, ativar as notificações e abrir o app em horários variados.
- Problema com a conta ou o pagamento: contatar o suporte do AttaPoll.', 'approved', ARRAY['AttaPoll','Atta Poll','Atapal','Atapoll','Atapow','Ata Pol','aplicativo de pesquisas','app de pesquisa no celular','Android','iOS','iPhone','saque mínimo','3 dólares','US$ 3','PayPal','convidar amigos','indicação','porcentagem dos ganhos','notificações','pesquisas em inglês']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A08-01', 'principal', 1, 9, 'V1.M09.A08 — Ganhos Diretos via PIX: Descubra o Falaí', 'Visão geral', 'Ganhos Diretos via PIX: Descubra o Falaí', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 08 – Ganhos Diretos via PIX: Descubra o Falaí › Visão geral da aula

Nome oficial da aula: Ganhos Diretos via PIX: Descubra o Falaí
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 09 – Transformando Opinião em Lucro, Aula 08
Duração/formato: 2:54
Link na área de membros (abre a página do Módulo 09, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/9

Resumo:
A aula apresenta o Falaí (grafado "Fala.i" na transcrição), uma plataforma 100% brasileira de pesquisas remuneradas. O grande diferencial: pagamento em reais, via Pix, instantâneo, sem conversão de moeda nem taxa internacional. A aula explica o funcionamento, as vantagens, os pontos de atenção e dá dicas de uso. A Gabriela relata ter recebido mais de R$ 200 num único dia.', 'approved', ARRAY['Falaí','Fala.i','Fala Aí','Fala i','plataforma brasileira de pesquisas','pesquisas pagas em reais','pagamento instantâneo','convidar amigos','indicação','bônus por cadastro','notificações personalizadas']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A08-02', 'principal', 1, 9, 'V1.M09.A08 — Ganhos Diretos via PIX: Descubra o Falaí', 'Procedimento: passo a passo', 'Ganhos Diretos via PIX: Descubra o Falaí', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 08 – Ganhos Diretos via PIX: Descubra o Falaí › Procedimento: passo a passo

1. Fazer o cadastro no Falaí. É rápido. Usar de preferência o e-mail exclusivo de pesquisas (Aula 02).
2. Completar o perfil com o máximo de informações. A plataforma usa esses dados para enviar pesquisas compatíveis.
3. Ativar as notificações no celular para ser avisada de novas pesquisas.
4. Responder às pesquisas com consistência e coerência. Os temas vão de produtos do dia a dia a assuntos sociais e de mercado.
5. Receber via Pix, com pagamento instantâneo direto na conta.
6. (Opcional) Convidar amigos e ganhar bônus por cada novo cadastro.', 'approved', ARRAY['Falaí','Fala.i','Fala Aí','Fala i','plataforma brasileira de pesquisas','pesquisas pagas em reais','pagamento instantâneo','convidar amigos','indicação','bônus por cadastro','notificações personalizadas']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A08-03', 'principal', 1, 9, 'V1.M09.A08 — Ganhos Diretos via PIX: Descubra o Falaí', 'Vantagens × pontos de atenção (segundo a aula)', 'Ganhos Diretos via PIX: Descubra o Falaí', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 08 – Ganhos Diretos via PIX: Descubra o Falaí › Vantagens × pontos de atenção (segundo a aula)

| ✅ Vantagens | ⚠️ Pontos de atenção |
|---|---|
| Brasileira: pagamento, suporte e plataforma em português | Nem sempre há pesquisas disponíveis: depende do perfil e da demanda |
| Pagamento em reais via Pix, sem conversão nem taxa internacional | Alguns valores são baixos: exige constância |
| Suporte acessível e direto | Plataforma em expansão: pode ter instabilidades ocasionais |
| Comunidade ativa de usuários trocando dicas | — |', 'approved', ARRAY['Falaí','Fala.i','Fala Aí','Fala i','plataforma brasileira de pesquisas','pesquisas pagas em reais','pagamento instantâneo','convidar amigos','indicação','bônus por cadastro','notificações personalizadas']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A08-04', 'principal', 1, 9, 'V1.M09.A08 — Ganhos Diretos via PIX: Descubra o Falaí', 'Dicas de uso', 'Ganhos Diretos via PIX: Descubra o Falaí', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 08 – Ganhos Diretos via PIX: Descubra o Falaí › Dicas de uso

1. Ser consistente e coerente nas respostas, para manter um bom histórico.
2. Ativar as notificações do celular.
3. Aproveitar o programa de indicações.', 'approved', ARRAY['Falaí','Fala.i','Fala Aí','Fala i','plataforma brasileira de pesquisas','pesquisas pagas em reais','pagamento instantâneo','convidar amigos','indicação','bônus por cadastro','notificações personalizadas']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A08-05', 'principal', 1, 9, 'V1.M09.A08 — Ganhos Diretos via PIX: Descubra o Falaí', 'FAQ', 'Ganhos Diretos via PIX: Descubra o Falaí', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 08 – Ganhos Diretos via PIX: Descubra o Falaí › Pontos para o suporte

- "Tem alguma plataforma que paga em reais / por Pix?" Sim, o Falaí, apresentado nesta aula. Pagamento em reais, via Pix.
- "Como recebo no Falaí?" Via Pix, direto na conta, segundo a aula de forma instantânea. Confirmar as regras de saque (valor mínimo, prazo) na plataforma.
- "Não aparecem pesquisas." A própria aula avisa que a frequência depende do perfil e da demanda. Completar o perfil e ativar as notificações.
- "O site está com erro / instável." A aula avisa que a plataforma pode ter instabilidades. Tentar mais tarde e, se persistir, contatar o suporte do Falaí.
- "Quanto dá para ganhar?" Os valores variam e muitos são baixos. Não repetir os "R$ 200 em um dia" como expectativa.', 'approved', ARRAY['Falaí','Fala.i','Fala Aí','Fala i','plataforma brasileira de pesquisas','pesquisas pagas em reais','pagamento instantâneo','convidar amigos','indicação','bônus por cadastro','notificações personalizadas']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A09-01', 'principal', 1, 9, 'V1.M09.A09 — Ganhe em Dólares com o Voissy', 'Visão geral', 'Ganhe em Dólares com o Voissy', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 09 – Ganhe em Dólares com o Voissy › Visão geral da aula

Nome oficial da aula: Ganhe em Dólares com o Voissy
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 09 – Transformando Opinião em Lucro, Aula 09
Duração/formato: 1:50
Link na área de membros (abre a página do Módulo 09, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/9

Resumo:
É uma aula curta que apresenta o Voissy (falado "Voice" na gravação), um aplicativo de pesquisas remuneradas para Android e iOS. Ele conecta consumidores de todo o Brasil a empresas e paga em dólar, via PayPal, com saque a partir de US$ 4. A aula traz o passo a passo e 3 dicas de uso. Não cita valores de ganho.', 'approved', ARRAY['Voissy','Voice','Voici','Voisy','Vento','aplicativo de pesquisas em dólar','app de pesquisa','Android','iOS','saque mínimo','4 dólares','US$ 4','PayPal','CEP no cadastro','pesquisa sumiu','limite de vagas','cota']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A09-02', 'principal', 1, 9, 'V1.M09.A09 — Ganhe em Dólares com o Voissy', 'Procedimento: passo a passo', 'Ganhe em Dólares com o Voissy', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 09 – Ganhe em Dólares com o Voissy › Procedimento: passo a passo

1. Baixar o app Voissy na loja do celular (Google Play ou App Store).
2. Criar a conta. Dica da aula: "use o CEP no cadastro". Usar de preferência o e-mail exclusivo de pesquisas (Aula 02).
3. Completar o perfil inicial. Quanto mais completo, mais convites.
4. Ativar as notificações do celular.
5. Responder às pesquisas com atenção e acumular pontos.
6. Trocar os pontos por dinheiro via PayPal ao atingir o mínimo de US$ 4.', 'approved', ARRAY['Voissy','Voice','Voici','Voisy','Vento','aplicativo de pesquisas em dólar','app de pesquisa','Android','iOS','saque mínimo','4 dólares','US$ 4','PayPal','CEP no cadastro','pesquisa sumiu','limite de vagas','cota']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A09-03', 'principal', 1, 9, 'V1.M09.A09 — Ganhe em Dólares com o Voissy', 'Dicas de ouro', 'Ganhe em Dólares com o Voissy', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 09 – Ganhe em Dólares com o Voissy › Dicas de ouro

1. Preencher 100% do perfil para aumentar a frequência de convites.
2. Responder assim que a notificação chegar, porque as pesquisas expiram rápido. Se uma pesquisa sumir, é porque o limite de vagas foi atingido. Não é erro.
3. Responder com calma e consistência para evitar desclassificações e manter um bom histórico.', 'approved', ARRAY['Voissy','Voice','Voici','Voisy','Vento','aplicativo de pesquisas em dólar','app de pesquisa','Android','iOS','saque mínimo','4 dólares','US$ 4','PayPal','CEP no cadastro','pesquisa sumiu','limite de vagas','cota']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A09-04', 'principal', 1, 9, 'V1.M09.A09 — Ganhe em Dólares com o Voissy', 'FAQ', 'Ganhe em Dólares com o Voissy', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 09 – Ganhe em Dólares com o Voissy › Pontos para o suporte

- "O que é o Voissy?" Um app de pesquisas pagas em dólar (Android e iOS). Saque via PayPal a partir de US$ 4, segundo a aula.
- "Não acho o app ''Voice''." O nome correto é Voissy.
- "A pesquisa sumiu antes de eu responder." Normal: o limite de vagas daquela pesquisa foi atingido. Responder assim que chegar a notificação.
- "Preciso de PayPal?" Sim, para sacar em dinheiro, segundo a aula.
- Problema com a conta ou o pagamento: contatar o suporte do Voissy.', 'approved', ARRAY['Voissy','Voice','Voici','Voisy','Vento','aplicativo de pesquisas em dólar','app de pesquisa','Android','iOS','saque mínimo','4 dólares','US$ 4','PayPal','CEP no cadastro','pesquisa sumiu','limite de vagas','cota']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A10-01', 'principal', 1, 9, 'V1.M09.A10 — Como Lucrar com Pesquisas e Missões Criativas na MeSeems', 'Visão geral', 'Como Lucrar com Pesquisas e Missões Criativas na MeSeems', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 10 – Como Lucrar com Pesquisas e Missões Criativas na MeSeems › Visão geral da aula

Nome oficial da aula: Como Lucrar com Pesquisas e Missões Criativas na MeSeems
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 09 – Transformando Opinião em Lucro, Aula 10
Duração/formato: 3:01
Link na área de membros (abre a página do Módulo 09, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/9

Resumo:
A aula apresenta a MeSeems (falada "Missense" na gravação), uma plataforma de pesquisas que funciona como uma rede social: tem feed com enquetes e debates, missões extras, sistema de níveis e uma loja de recompensas (Pix, recarga de celular, descontos em livros e outros). Disponível em app e site. A aula dá o passo a passo, 3 dicas (incluindo sacar às 17h) e lista vantagens e pontos de atenção. Não cita valores de ganho.
Na Aula 02 deste módulo, a plataforma aparece como "Missense". O nome correto é MeSeems.', 'approved', ARRAY['MeSeems','Me Seems','Missense','Misseems','missões','missões rápidas','enquetes','debates','feed','sistema de níveis','nível','subir de nível','loja de recompensas','vouchers','recarga de celular','desconto em livros','saque às 17h','horário de saque']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A10-02', 'principal', 1, 9, 'V1.M09.A10 — Como Lucrar com Pesquisas e Missões Criativas na MeSeems', 'Procedimento: passo a passo', 'Como Lucrar com Pesquisas e Missões Criativas na MeSeems', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 10 – Como Lucrar com Pesquisas e Missões Criativas na MeSeems › Procedimento: passo a passo

1. Fazer o cadastro (app ou site). É rápido. Usar de preferência o e-mail exclusivo de pesquisas (Aula 02).
2. Completar 100% do perfil para receber pesquisas mais alinhadas.
3. Participar de:
  - pesquisas tradicionais;
  - missões rápidas (perguntas curtas, convidar amigos);
  - enquetes e debates do feed.
4. Subir de nível com engajamento constante para desbloquear recompensas melhores.
5. Trocar os pontos na loja: Pix, recarga de celular, descontos em livros, vouchers e outros.', 'approved', ARRAY['MeSeems','Me Seems','Missense','Misseems','missões','missões rápidas','enquetes','debates','feed','sistema de níveis','nível','subir de nível','loja de recompensas','vouchers','recarga de celular','desconto em livros','saque às 17h','horário de saque']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A10-03', 'principal', 1, 9, 'V1.M09.A10 — Como Lucrar com Pesquisas e Missões Criativas na MeSeems', 'Dicas de ouro', 'Como Lucrar com Pesquisas e Missões Criativas na MeSeems', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 10 – Como Lucrar com Pesquisas e Missões Criativas na MeSeems › Dicas de ouro

1. Completar 100% do perfil.
2. Não subestimar as missões rápidas. Parecem pequenas, mas aceleram os ganhos.
3. Fazer saques e trocas de vouchers às 17h em ponto, "horário em que a plataforma libera as operações com mais facilidade".', 'approved', ARRAY['MeSeems','Me Seems','Missense','Misseems','missões','missões rápidas','enquetes','debates','feed','sistema de níveis','nível','subir de nível','loja de recompensas','vouchers','recarga de celular','desconto em livros','saque às 17h','horário de saque']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A10-04', 'principal', 1, 9, 'V1.M09.A10 — Como Lucrar com Pesquisas e Missões Criativas na MeSeems', 'Vantagens × pontos de atenção (segundo a aula)', 'Como Lucrar com Pesquisas e Missões Criativas na MeSeems', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 10 – Como Lucrar com Pesquisas e Missões Criativas na MeSeems › Vantagens × pontos de atenção (segundo a aula)

| ✅ Vantagens | ⚠️ Pontos de atenção |
|---|---|
| Plataforma completa: pesquisas, comunidade e várias formas de ganhar pontos | Algumas pesquisas pagam pouco |
| Loja variada: Pix, recarga, livros e mais | Saques via Pix têm restrição de horário |
| Interface amigável no app e no site | O sistema de níveis exige tempo e constância |
| Suporte rápido | — |', 'approved', ARRAY['MeSeems','Me Seems','Missense','Misseems','missões','missões rápidas','enquetes','debates','feed','sistema de níveis','nível','subir de nível','loja de recompensas','vouchers','recarga de celular','desconto em livros','saque às 17h','horário de saque']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A10-05', 'principal', 1, 9, 'V1.M09.A10 — Como Lucrar com Pesquisas e Missões Criativas na MeSeems', 'FAQ', 'Como Lucrar com Pesquisas e Missões Criativas na MeSeems', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 10 – Como Lucrar com Pesquisas e Missões Criativas na MeSeems › Pontos para o suporte

- "O que é a MeSeems?" Uma plataforma de pesquisas com jeito de rede social: tem missões, níveis e uma loja para trocar pontos por Pix, recarga ou vouchers.
- "Não acho a ''Missense''." O nome correto é MeSeems.
- "Não consigo sacar / trocar meus pontos." A aula diz que os saques têm restrição de horário e recomenda tentar às 17h. Confirmar a regra atual na plataforma.
- "Como ganho mais pontos?" Completar o perfil, fazer as missões rápidas e participar com constância para subir de nível.
- Problema com a conta ou o pagamento: contatar o suporte da MeSeems.', 'approved', ARRAY['MeSeems','Me Seems','Missense','Misseems','missões','missões rápidas','enquetes','debates','feed','sistema de níveis','nível','subir de nível','loja de recompensas','vouchers','recarga de celular','desconto em livros','saque às 17h','horário de saque']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A11-01', 'principal', 1, 9, 'V1.M09.A11 — Como Ser um Agente Secreto do Consumo na Modatta', 'Visão geral', 'Como Ser um Agente Secreto do Consumo na Modatta', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 11 – Como Ser um Agente Secreto do Consumo na Modatta › Visão geral da aula

Nome oficial da aula: Como Ser um Agente Secreto do Consumo na Modatta
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 09 – Transformando Opinião em Lucro, Aula 11
Duração/formato: 2:49
Link na área de membros (abre a página do Módulo 09, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/9

Resumo:
A aula apresenta a Modatta (falada "Modata" na gravação), um app brasileiro (Android e iOS) com uma proposta diferente das plataformas anteriores: a aluna ganha pontos por compartilhar os seus dados de uso, conectando contas como Facebook, Instagram, Spotify e apps de compras, e por missões personalizadas de marcas parceiras. O pagamento é via Pix. A aula traz o passo a passo, vantagens, pontos de atenção e uma dica importante sobre validação da conta. Não cita valores de ganho.', 'approved', ARRAY['Modatta','Modata','Mo Datta','agente secreto do consumo','compartilhar dados','monetizar dados','ganhar com seus dados','conectar contas','Facebook','Instagram','Spotify','aplicativos de compras','pontos de boas-vindas','missões personalizadas','marcas parceiras','status pendente','validar conta','validação','ícone de headset']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A11-02', 'principal', 1, 9, 'V1.M09.A11 — Como Ser um Agente Secreto do Consumo na Modatta', 'Procedimento: passo a passo', 'Como Ser um Agente Secreto do Consumo na Modatta', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 11 – Como Ser um Agente Secreto do Consumo na Modatta › Procedimento: passo a passo

1. Baixar o app Modatta (Google Play ou App Store) e fazer o cadastro. Ao se inscrever, a aluna ganha pontos de boas-vindas.
2. Validar a conta assim que sair do status "pendente". ⚠️ Essa é a "dica de ouro" da aula.
  - Se o prazo de validação expirar: abrir o suporte (ícone de headset) no app e solicitar a validação. Segundo a aula, o retorno costuma ser rápido.
3. Conectar as contas do dia a dia que quiser compartilhar: Facebook, Instagram, Spotify, apps de compras. É isso que permite à plataforma entender os hábitos de consumo e recompensar a aluna.
4. Participar das missões personalizadas criadas pelas marcas parceiras.
5. Receber os ganhos via Pix.', 'approved', ARRAY['Modatta','Modata','Mo Datta','agente secreto do consumo','compartilhar dados','monetizar dados','ganhar com seus dados','conectar contas','Facebook','Instagram','Spotify','aplicativos de compras','pontos de boas-vindas','missões personalizadas','marcas parceiras','status pendente','validar conta','validação','ícone de headset']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A11-03', 'principal', 1, 9, 'V1.M09.A11 — Como Ser um Agente Secreto do Consumo na Modatta', 'Vantagens × pontos de atenção (segundo a aula)', 'Como Ser um Agente Secreto do Consumo na Modatta', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 11 – Como Ser um Agente Secreto do Consumo na Modatta › Vantagens × pontos de atenção (segundo a aula)

| ✅ Vantagens | ⚠️ Pontos de atenção |
|---|---|
| "Ganhar sendo você mesma": recompensa por hábitos que já existem | Algumas recompensas são baixas: exige constância |
| Privacidade: dados criptografados e anonimizados, com controle do que compartilhar | É preciso se sentir confortável em compartilhar os dados de uso |
| Missões criativas, diferentes das pesquisas tradicionais | — |
| Pix rápido, plataforma transparente, suporte acessível | — |', 'approved', ARRAY['Modatta','Modata','Mo Datta','agente secreto do consumo','compartilhar dados','monetizar dados','ganhar com seus dados','conectar contas','Facebook','Instagram','Spotify','aplicativos de compras','pontos de boas-vindas','missões personalizadas','marcas parceiras','status pendente','validar conta','validação','ícone de headset']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A11-04', 'principal', 1, 9, 'V1.M09.A11 — Como Ser um Agente Secreto do Consumo na Modatta', 'FAQ', 'Como Ser um Agente Secreto do Consumo na Modatta', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 11 – Como Ser um Agente Secreto do Consumo na Modatta › Pontos para o suporte

- "O que é a Modatta?" Um app brasileiro em que a aluna ganha pontos por compartilhar dados de uso (conectando redes sociais, Spotify e apps de compras) e por missões de marcas, com pagamento via Pix.
- "Minha conta ficou pendente / o prazo de validação expirou." Abrir o suporte no app (ícone de headset) e pedir a validação. Orientar a validar assim que o status "pendente" sair.
- "É seguro compartilhar meus dados?" Segundo a aula, os dados são criptografados e anonimizados e a aluna escolhe o que compartilhar. Recomendar que ela leia os termos e a política de privacidade e conecte só o que se sentir confortável.
- "Não acho a ''Modata''." O nome correto é Modatta.
- Problema com a conta ou o pagamento: contatar o suporte da Modatta pelo app.', 'approved', ARRAY['Modatta','Modata','Mo Datta','agente secreto do consumo','compartilhar dados','monetizar dados','ganhar com seus dados','conectar contas','Facebook','Instagram','Spotify','aplicativos de compras','pontos de boas-vindas','missões personalizadas','marcas parceiras','status pendente','validar conta','validação','ícone de headset']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A12-01', 'principal', 1, 9, 'V1.M09.A12 — Ysense: O Clássico das Pesquisas Remuneradas', 'Visão geral', 'Ysense: O Clássico das Pesquisas Remuneradas', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 12 – Ysense: O Clássico das Pesquisas Remuneradas › Visão geral da aula

Nome oficial da aula: Ysense: O Clássico das Pesquisas Remuneradas
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 09 – Transformando Opinião em Lucro, Aula 12
Duração/formato: 3:21
Link na área de membros (abre a página do Módulo 09, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/9

Resumo:
A aula apresenta o ySense (falado "iSense" na gravação), descrito como referência em pesquisas remuneradas. Além de pesquisas, ele oferece tarefas simples, ofertas pagas, bônus diários e um programa de indicação com comissão sobre os ganhos dos indicados. A aula diz que o pagamento é em euros, com saque mínimo de € 10, mas isso precisa ser conferido. A aula dá dicas de uso e fecha o bloco de plataformas incentivando a aluna a diversificar. Não cita valores de ganho.', 'approved', ARRAY['ySense','iSense','Y Sense','pesquisas remuneradas','tarefas simples','ofertas pagas','bônus diários','indicação','comissão sobre ganhos dos indicados','euros','dólares','saque mínimo','10 euros','PayPal','gift cards','cartões pré-pagos','desclassificação']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A12-02', 'principal', 1, 9, 'V1.M09.A12 — Ysense: O Clássico das Pesquisas Remuneradas', 'Formas de ganhar', 'Ysense: O Clássico das Pesquisas Remuneradas', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 12 – Ysense: O Clássico das Pesquisas Remuneradas › Formas de ganhar

| Forma | Descrição |
|---|---|
| Pesquisas | Grande volume disponível, com critérios mais rigorosos |
| Tarefas simples ("oportunidades simples") | Pequenas atividades |
| Ofertas pagas | "Muitas vezes rendem mais do que as pesquisas" |
| Bônus diários | Recompensas por atividade diária |
| Indicação | Comissão sobre os ganhos das pessoas convidadas |', 'approved', ARRAY['ySense','iSense','Y Sense','pesquisas remuneradas','tarefas simples','ofertas pagas','bônus diários','indicação','comissão sobre ganhos dos indicados','euros','dólares','saque mínimo','10 euros','PayPal','gift cards','cartões pré-pagos','desclassificação']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A12-03', 'principal', 1, 9, 'V1.M09.A12 — Ysense: O Clássico das Pesquisas Remuneradas', 'Procedimento: passo a passo', 'Ysense: O Clássico das Pesquisas Remuneradas', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 12 – Ysense: O Clássico das Pesquisas Remuneradas › Procedimento: passo a passo

1. Fazer o cadastro no ySense (site ou app). Usar de preferência o e-mail exclusivo de pesquisas (Aula 02).
2. Preencher o perfil com atenção e consistência para receber pesquisas alinhadas.
3. Acessar todos os dias. A presença constante aumenta os convites.
4. Usar o site e o app para ampliar as oportunidades.
5. Acompanhar as ofertas pagas e os bônus diários.
6. Sacar ao atingir o mínimo, via PayPal, gift cards ou cartões pré-pagos.', 'approved', ARRAY['ySense','iSense','Y Sense','pesquisas remuneradas','tarefas simples','ofertas pagas','bônus diários','indicação','comissão sobre ganhos dos indicados','euros','dólares','saque mínimo','10 euros','PayPal','gift cards','cartões pré-pagos','desclassificação']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A12-04', 'principal', 1, 9, 'V1.M09.A12 — Ysense: O Clássico das Pesquisas Remuneradas', 'Vantagens × pontos de atenção (segundo a aula)', 'Ysense: O Clássico das Pesquisas Remuneradas', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 12 – Ysense: O Clássico das Pesquisas Remuneradas › Vantagens × pontos de atenção (segundo a aula)

| ✅ Vantagens | ⚠️ Pontos de atenção |
|---|---|
| Grande volume de pesquisas | Desclassificações frequentes: concorrência alta e critérios rigorosos |
| Pagamentos seguros e várias opções de saque | Prazos de pagamento mais longos |
| Versátil: pesquisas, tarefas, ofertas e bônus | — |
| Indicação vantajosa, com comissão sobre os ganhos dos indicados | — |', 'approved', ARRAY['ySense','iSense','Y Sense','pesquisas remuneradas','tarefas simples','ofertas pagas','bônus diários','indicação','comissão sobre ganhos dos indicados','euros','dólares','saque mínimo','10 euros','PayPal','gift cards','cartões pré-pagos','desclassificação']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A12-05', 'principal', 1, 9, 'V1.M09.A12 — Ysense: O Clássico das Pesquisas Remuneradas', 'Mensagem de fechamento do bloco', 'Ysense: O Clássico das Pesquisas Remuneradas', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 12 – Ysense: O Clássico das Pesquisas Remuneradas › Mensagem de fechamento do bloco

"O segredo é diversificar." Há outras plataformas com diferentes formas de pagamento (Pix, PayPal, vouchers). Usar várias aumenta as chances de ganho e a autonomia.', 'approved', ARRAY['ySense','iSense','Y Sense','pesquisas remuneradas','tarefas simples','ofertas pagas','bônus diários','indicação','comissão sobre ganhos dos indicados','euros','dólares','saque mínimo','10 euros','PayPal','gift cards','cartões pré-pagos','desclassificação']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M09.A12-06', 'principal', 1, 9, 'V1.M09.A12 — Ysense: O Clássico das Pesquisas Remuneradas', 'FAQ', 'Ysense: O Clássico das Pesquisas Remuneradas', 'Método Sócia Invisível › Módulo 09 – Transformando Opinião em Lucro › Aula 12 – Ysense: O Clássico das Pesquisas Remuneradas › Pontos para o suporte

- "O que é o ySense?" Uma plataforma de pesquisas e tarefas pagas, com ofertas, bônus diários e indicação. Saque por PayPal, gift cards ou cartões pré-pagos.
- "Não acho o ''iSense''." O nome correto é ySense.
- "Qual o saque mínimo? Em que moeda paga?" Não repetir "€ 10 em euros" sem conferir. Orientar a aluna a consultar a página de saques da própria plataforma.
- "Sou muito desclassificada no ySense." A própria aula avisa que é comum ali, porque os critérios são mais rigorosos. Paciência e perfil coerente.
- Problema com a conta ou o pagamento: contatar o suporte do ySense.', 'approved', ARRAY['ySense','iSense','Y Sense','pesquisas remuneradas','tarefas simples','ofertas pagas','bônus diários','indicação','comissão sobre ganhos dos indicados','euros','dólares','saque mínimo','10 euros','PayPal','gift cards','cartões pré-pagos','desclassificação']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M01.A01-01', 'principal', 1, 1, 'V1.M01.A01 — Aula de Boas-Vindas', 'Visão geral', 'Aula de Boas-Vindas', 'Método Sócia Invisível › Módulo 01 – Primeiro acesso? Clique aqui / Sua primeira vitória › Aula 01 – Aula de Boas-Vindas › Visão geral da aula

Nome oficial da aula: Aula de Boas-Vindas
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 01 – Primeiro acesso? Clique aqui / Sua primeira vitória, Aula 01
Duração/formato: 11:24
Link na área de membros (abre a página do Módulo 01, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/1

Resumo:
Aula de abertura do método. Não traz conteúdo técnico: funciona como um mapa de primeiros passos. A aluna é orientada a (1) entrar no grupo de alunas no WhatsApp, (2) conhecer a área de membros no computador e no celular, incluindo onde fica o Suporte, (3) seguir os módulos na ordem, sem pular, e (4) resgatar hoje os 30 dias gratuitos da Soffia, a inteligência artificial que busca demandas. No fim, a aula apresenta os planos pagos da Soffia (trimestral e anual) com desconto exclusivo e deixa claro que eles são opcionais.', 'approved', ARRAY['Método Sócio Invisível','Método Sócio é Invisível','Sofia','a Sofia','assofiar','pics','piques','aula de boas-vindas','aula de boas vindas','primeira aula','primeiro acesso','grupo de alunas','grupo de avisos','grupo do WhatsApp','Plano Premium','plano trimestral','plano anual']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M01.A01-02', 'principal', 1, 1, 'V1.M01.A01 — Aula de Boas-Vindas', 'Procedimento: o que a aluna deve fazer', 'Aula de Boas-Vindas', 'Método Sócia Invisível › Módulo 01 – Primeiro acesso? Clique aqui / Sua primeira vitória › Aula 01 – Aula de Boas-Vindas › Procedimento: o que a aluna deve fazer

1. Entrar no grupo de alunas (WhatsApp). Clicar no botão logo abaixo do vídeo da aula. É gratuito e leva menos de 10 segundos. Pelo grupo chegam os avisos de aulas ao vivo, os conteúdos exclusivos e as atualizações de novos conteúdos na área de membros.
2. Localizar o botão Suporte. No computador, ele fica no topo, ao lado do nome "Método Sócia Invisível". Leva direto ao WhatsApp da equipe, que responde todos os dias.
3. Entender a organização da área de membros.
  - 1ª fileira: o Método Sócia Invisível completo, com os módulos em ordem (Módulo 1 = esta aula; depois Módulo 2, 3…).
  - Fileiras abaixo: tudo o que foi adquirido na compra (acessos extras e bônus), cada item na sua fileira e também em ordem.
4. Usar a área de membros pelo celular. O menu inferior tem:
  - Início: volta para a tela principal.
  - Lupa: busca aulas.
  - Suporte: sempre visível.
  - Perfil: permite trocar a senha. Ali também aparecem o e-mail e o WhatsApp do suporte.
5. Seguir os módulos na ordem, sem pular. Cada aula prepara a próxima. Quando a aula pedir uma ação, a aluna deve fazer na hora.
6. Resgatar os 30 dias gratuitos da Soffia (fazer hoje).
 - Clicar no banner da Soffia dentro da área de membros ou no link na descrição da aula.
  - Informar os dados do cartão e seguir o passo a passo.
  - Os 30 dias começam a contar a partir da ativação.
7. (Opcional) Garantir um plano da Soffia com desconto, pelo link do Plano Premium abaixo da aula.
8. Ir para o Módulo 2.', 'approved', ARRAY['Método Sócio Invisível','Método Sócio é Invisível','Sofia','a Sofia','assofiar','pics','piques','aula de boas-vindas','aula de boas vindas','primeira aula','primeiro acesso','grupo de alunas','grupo de avisos','grupo do WhatsApp','Plano Premium','plano trimestral','plano anual']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M01.A01-03', 'principal', 1, 1, 'V1.M01.A01 — Aula de Boas-Vindas', 'Soffia: o que é', 'Aula de Boas-Vindas', 'Método Sócia Invisível › Módulo 01 – Primeiro acesso? Clique aqui / Sua primeira vitória › Aula 01 – Aula de Boas-Vindas › Soffia: o que é

É uma inteligência artificial que faz a parte "burocrática" das demandas:
- encontra as demandas que pagam mais, das maiores empresas, assim que elas são liberadas;
- monta a fila do dia;
- preenche os cadastros.
Para a aluna, sobra só dar a opinião de consumidora real.', 'approved', ARRAY['Método Sócio Invisível','Método Sócio é Invisível','Sofia','a Sofia','assofiar','pics','piques','aula de boas-vindas','aula de boas vindas','primeira aula','primeiro acesso','grupo de alunas','grupo de avisos','grupo do WhatsApp','Plano Premium','plano trimestral','plano anual']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M01.A01-04', 'principal', 1, 1, 'V1.M01.A01 — Aula de Boas-Vindas', 'Soffia: preços e condições citados na aula', 'Aula de Boas-Vindas', 'Método Sócia Invisível › Módulo 01 – Primeiro acesso? Clique aqui / Sua primeira vitória › Aula 01 – Aula de Boas-Vindas › Soffia: preços e condições citados na aula

| Opção | Valor | Observação |
|---|---|---|
| Teste gratuito | R$ 0 por 30 dias | Pede cartão. Conta a partir da ativação. |
| Mensal (após os 30 dias) | R$ 97,00/mês | ~R$ 1.164 em 12 meses ("passa de R$ 1.100") |
| Plano trimestral (3 meses) | R$ 197,00 à vista ou 12x de R$ 19,00* | ~R$ 100 de desconto sobre ~R$ 300 no mensal |
| Plano anual (12 meses) | R$ 697,00 à vista ou 12x de R$ 69,00 | Economia de mais de R$ 400. Menos de R$ 2/dia. Recomendado na aula. |
* Valor da parcela conforme transcrição. Conferir no checkout.
- Os planos com desconto são apresentados como condição exclusiva desta aula.
- A aula afirma que nenhum plano é obrigatório: o método completo e os 30 dias grátis já estão liberados e bastam para ter resultado.', 'approved', ARRAY['Método Sócio Invisível','Método Sócio é Invisível','Sofia','a Sofia','assofiar','pics','piques','aula de boas-vindas','aula de boas vindas','primeira aula','primeiro acesso','grupo de alunas','grupo de avisos','grupo do WhatsApp','Plano Premium','plano trimestral','plano anual']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M01.A01-05', 'principal', 1, 1, 'V1.M01.A01 — Aula de Boas-Vindas', 'FAQ', 'Aula de Boas-Vindas', 'Método Sócia Invisível › Módulo 01 – Primeiro acesso? Clique aqui / Sua primeira vitória › Aula 01 – Aula de Boas-Vindas › Pontos para o suporte

- "Onde fica o suporte?" No topo da área de membros (computador) ou no menu inferior (celular). E-mail e WhatsApp também aparecem no Perfil.
- "Como troco minha senha?" Pelo celular: menu inferior › Perfil.
- "Onde ativo a Soffia?" Pelo banner da Soffia na área de membros ou pelo link na descrição desta aula.
- "A Soffia é paga?" Os primeiros 30 dias são grátis, contados a partir da ativação, com cartão cadastrado. Depois custa R$ 97/mês, ou a aluna pode escolher o plano trimestral ou o anual.
- "Preciso comprar um plano para ter resultado?" Não, segundo a própria aula.
- "Onde está o grupo?" No botão abaixo do vídeo da Aula 01 do Módulo 01.
- "Onde estão meus bônus?" Nas fileiras abaixo do método principal, na área de membros.', 'approved', ARRAY['Método Sócio Invisível','Método Sócio é Invisível','Sofia','a Sofia','assofiar','pics','piques','aula de boas-vindas','aula de boas vindas','primeira aula','primeiro acesso','grupo de alunas','grupo de avisos','grupo do WhatsApp','Plano Premium','plano trimestral','plano anual']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M10.A01-01', 'principal', 1, 10, 'V1.M10.A01 — O Código das Demandas no Vinte Pila', 'Visão geral', 'O Código das Demandas no Vinte Pila', 'Método Sócia Invisível › Módulo 10 – O Universo das Demandas Digitais › Aula 01 – O Código das Demandas no Vinte Pila › Visão geral da aula

Nome oficial da aula: O Código das Demandas no Vinte Pila
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 10 – O Universo das Demandas Digitais, Aula 01
Duração/formato: 4:01
Link na área de membros (abre a página do Módulo 10, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/10

Resumo:
É a abertura do Módulo 10, que apresenta uma terceira plataforma de freela: o Vinte Pila. É uma plataforma nacional em que a própria aluna publica os seus serviços (chamados de gigs) numa vitrine, e os clientes a contratam diretamente pelo site. O nome vem do valor inicial sugerido, R$ 20, mas é possível criar ofertas com valores maiores. A aula é introdutória. O cadastro e a publicação do primeiro serviço ficam para a Aula 02.', 'approved', ARRAY['Vinte Pila','VintePila','Vintipila','20 Pila','20pila','O universo das demandas digitais','gigs','microprojetos','micro projetos','mentoria projetos remunerados','executiva','executiva digital','gestora de microprojetos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M10.A01-02', 'principal', 1, 10, 'V1.M10.A01 — O Código das Demandas no Vinte Pila', 'O que a aula diz sobre o Vinte Pila', 'O Código das Demandas no Vinte Pila', 'Método Sócia Invisível › Módulo 10 – O Universo das Demandas Digitais › Aula 01 – O Código das Demandas no Vinte Pila › O que a aula diz sobre o Vinte Pila

- O que é: plataforma nacional que conecta profissionais a clientes que precisam de tarefas simples, rápidas e pontuais.
- Exemplos de serviços:
  - legendas para redes sociais;
  - digitação de documentos;
  - pesquisa na internet;
  - organização de planilhas;
  - respostas automáticas no WhatsApp.
- Preço: a partir de R$ 20, com possibilidade de ofertas personalizadas mais caras.
### Como funciona
1. A aluna cria um perfil.
2. Publica os seus serviços (gigs).
3. Os clientes navegam e contratam direto pelo site.
4. A aluna entrega o microprojeto e recebe pela própria plataforma.
### Por que é uma boa porta de entrada (segundo a aula)
- Começar com microprojetos simples.
- Ter uma vitrine pública dos serviços.
- Trabalhar por demanda, com flexibilidade.
- Faturar mesmo sem experiência.
- Posicionar-se como "executiva digital" com uma proposta de valor clara.', 'approved', ARRAY['Vinte Pila','VintePila','Vintipila','20 Pila','20pila','O universo das demandas digitais','gigs','microprojetos','micro projetos','mentoria projetos remunerados','executiva','executiva digital','gestora de microprojetos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M10.A01-03', 'principal', 1, 10, 'V1.M10.A01 — O Código das Demandas no Vinte Pila', 'Diferença em relação às plataformas anteriores', 'O Código das Demandas no Vinte Pila', 'Método Sócia Invisível › Módulo 10 – O Universo das Demandas Digitais › Aula 01 – O Código das Demandas no Vinte Pila › Diferença em relação às plataformas anteriores

|  | 99Freelas / Workana (M07, M08) | Vinte Pila (M10) |
|---|---|---|
| Quem toma a iniciativa | A aluna busca projetos e envia propostas | A aluna publica serviços prontos e o cliente contrata |
| Preço | Negociado por proposta | Definido na oferta, a partir de R$ 20 |', 'approved', ARRAY['Vinte Pila','VintePila','Vintipila','20 Pila','20pila','O universo das demandas digitais','gigs','microprojetos','micro projetos','mentoria projetos remunerados','executiva','executiva digital','gestora de microprojetos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M10.A01-04', 'principal', 1, 10, 'V1.M10.A01 — O Código das Demandas no Vinte Pila', 'O que a próxima aula promete', 'O Código das Demandas no Vinte Pila', 'Método Sócia Invisível › Módulo 10 – O Universo das Demandas Digitais › Aula 01 – O Código das Demandas no Vinte Pila › O que a próxima aula promete

Passo a passo na tela (computador e celular) para:
1. se cadastrar corretamente;
2. montar uma bio que chame atenção;
3. criar uma oferta de serviço estratégica;
4. entregar com qualidade para fidelizar.', 'approved', ARRAY['Vinte Pila','VintePila','Vintipila','20 Pila','20pila','O universo das demandas digitais','gigs','microprojetos','micro projetos','mentoria projetos remunerados','executiva','executiva digital','gestora de microprojetos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M10.A01-05', 'principal', 1, 10, 'V1.M10.A01 — O Código das Demandas no Vinte Pila', 'Procedimento: o que a aluna deve fazer', 'O Código das Demandas no Vinte Pila', 'Método Sócia Invisível › Módulo 10 – O Universo das Demandas Digitais › Aula 01 – O Código das Demandas no Vinte Pila › Procedimento: o que a aluna deve fazer

1. Assistir à aula para conhecer o Vinte Pila. Não há ação prática.
2. Seguir para a Aula 02 do Módulo 10.', 'approved', ARRAY['Vinte Pila','VintePila','Vintipila','20 Pila','20pila','O universo das demandas digitais','gigs','microprojetos','micro projetos','mentoria projetos remunerados','executiva','executiva digital','gestora de microprojetos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M10.A01-06', 'principal', 1, 10, 'V1.M10.A01 — O Código das Demandas no Vinte Pila', 'FAQ', 'O Código das Demandas no Vinte Pila', 'Método Sócia Invisível › Módulo 10 – O Universo das Demandas Digitais › Aula 01 – O Código das Demandas no Vinte Pila › Pontos para o suporte

- "O que é o Vinte Pila?" Uma plataforma brasileira em que você publica os seus serviços (a partir de R$ 20) e os clientes contratam e pagam pelo próprio site.
- "Qual a diferença para o 99Freelas e o Workana?" Lá você procura projetos e manda propostas. No Vinte Pila você anuncia os seus serviços e espera o cliente contratar.
- "Só posso cobrar R$ 20?" Não. R$ 20 é o valor inicial sugerido, e dá para criar ofertas com valores maiores.
- "O Vinte Pila é do método?" Não. É uma plataforma independente. Problemas de conta ou pagamento devem ser resolvidos com o suporte dela.', 'approved', ARRAY['Vinte Pila','VintePila','Vintipila','20 Pila','20pila','O universo das demandas digitais','gigs','microprojetos','micro projetos','mentoria projetos remunerados','executiva','executiva digital','gestora de microprojetos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M10.A02-01', 'principal', 1, 10, 'V1.M10.A02 — Construindo Sua Vitrine Digital no Vinte Pila', 'Visão geral', 'Construindo Sua Vitrine Digital no Vinte Pila', 'Método Sócia Invisível › Módulo 10 – O Universo das Demandas Digitais › Aula 02 – Construindo Sua Vitrine Digital no Vinte Pila › Visão geral da aula

Nome oficial da aula: Construindo Sua Vitrine Digital no Vinte Pila
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 10 – O Universo das Demandas Digitais, Aula 02
Duração/formato: 2:35
Link na área de membros (abre a página do Módulo 10, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/10

Resumo:
É uma aula prática, com gravação de tela, que ensina a criar a conta na Vinte Pila, editar o perfil e cadastrar os dados bancários. Diferente de outras plataformas, os dados bancários ficam na mesma tela do perfil. A aula descreve a Vinte Pila como uma "vitrine de serviços criativos e práticos" (organização de dados, atendimento, edições simples, assistente virtual), que dá para usar pelo celular, e como uma das "parceiras de oportunidade" da mentoria.', 'approved', ARRAY['Vinte Pila','20pila','20 Pila','VintePila','criar conta','botão verde','pessoa física','pessoa jurídica','editar perfil','descrição do perfil','300 caracteres','foto de perfil','dados bancários','banco','agência','tipo de conta','número da conta','menus: serviços','criar serviços','meus serviços','vendas','minhas vendas','compras','Mentoria Projetos Remunerados','parceira de oportunidade']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M10.A02-02', 'principal', 1, 10, 'V1.M10.A02 — Construindo Sua Vitrine Digital no Vinte Pila', 'Procedimento: passo a passo', 'Construindo Sua Vitrine Digital no Vinte Pila', 'Método Sócia Invisível › Módulo 10 – O Universo das Demandas Digitais › Aula 02 – Construindo Sua Vitrine Digital no Vinte Pila › Procedimento: passo a passo

### Parte 1: Criar a conta (gratuita)
1. Pesquisar "20pila" no Google e abrir o primeiro resultado.
2. Clicar no botão verde para criar a conta.
3. Escolher pessoa física ou pessoa jurídica.
4. Preencher: nome completo, celular, e-mail, CPF, senha e endereço.
5. Aceitar os termos e finalizar o cadastro.
### Parte 2: Editar o perfil
1. Já logada, localizar os menus: Serviços (Criar serviços, Meus serviços), Vendas (Minhas vendas), Compras.
2. Ir em Editar perfil e preencher:
| Campo | Orientação da aula |
|---|---|
| Descrição do perfil | Ser sucinta: o limite é de 300 caracteres. Apresentar você. |
| E-mail e senha | Conferir ou alterar. |
| Foto de perfil | Foto boa e profissional, mesmo que tirada com o celular. |
### Parte 3: Dados bancários (na mesma tela)
Preencher nome do titular, banco, agência, tipo de conta e número da conta, e clicar em Salvar alterações.', 'approved', ARRAY['Vinte Pila','20pila','20 Pila','VintePila','criar conta','botão verde','pessoa física','pessoa jurídica','editar perfil','descrição do perfil','300 caracteres','foto de perfil','dados bancários','banco','agência','tipo de conta','número da conta','menus: serviços','criar serviços','meus serviços','vendas','minhas vendas','compras','Mentoria Projetos Remunerados','parceira de oportunidade']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M10.A02-03', 'principal', 1, 10, 'V1.M10.A02 — Construindo Sua Vitrine Digital no Vinte Pila', 'Dicas para usar com as aulas anteriores', 'Construindo Sua Vitrine Digital no Vinte Pila', 'Método Sócia Invisível › Módulo 10 – O Universo das Demandas Digitais › Aula 02 – Construindo Sua Vitrine Digital no Vinte Pila › Dicas para usar com as aulas anteriores

- Descrição de 300 caracteres: adaptar o elevator pitch (M06 A02) para um texto curto.
- Foto: seguir o Hack 1 do Bônus 02 (M07 A06): luz natural, fundo neutro, sem selfie.
- Serviços a oferecer: usar o mapeamento de habilidades (M06 A01).', 'approved', ARRAY['Vinte Pila','20pila','20 Pila','VintePila','criar conta','botão verde','pessoa física','pessoa jurídica','editar perfil','descrição do perfil','300 caracteres','foto de perfil','dados bancários','banco','agência','tipo de conta','número da conta','menus: serviços','criar serviços','meus serviços','vendas','minhas vendas','compras','Mentoria Projetos Remunerados','parceira de oportunidade']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M10.A02-04', 'principal', 1, 10, 'V1.M10.A02 — Construindo Sua Vitrine Digital no Vinte Pila', 'FAQ', 'Construindo Sua Vitrine Digital no Vinte Pila', 'Método Sócia Invisível › Módulo 10 – O Universo das Demandas Digitais › Aula 02 – Construindo Sua Vitrine Digital no Vinte Pila › Pontos para o suporte

- "Como me cadastro na Vinte Pila?" Google › "20pila" › botão verde › pessoa física › nome, celular, e-mail, CPF, senha e endereço › aceitar os termos.
- "Onde coloco meus dados bancários?" Em Editar perfil, logo abaixo da foto: nome, banco, agência, tipo e número da conta.
- "O que escrevo na descrição?" Uma apresentação curta, de até 300 caracteres, com o que você oferece.
- "Como publico meu serviço?" Ver a Aula 04 deste módulo: Serviços › Criar serviço.
- "A Vinte Pila é do método?" Não. É uma plataforma independente, descrita na aula como "parceira de oportunidade". Problemas de conta ou pagamento devem ir para o suporte da Vinte Pila.', 'approved', ARRAY['Vinte Pila','20pila','20 Pila','VintePila','criar conta','botão verde','pessoa física','pessoa jurídica','editar perfil','descrição do perfil','300 caracteres','foto de perfil','dados bancários','banco','agência','tipo de conta','número da conta','menus: serviços','criar serviços','meus serviços','vendas','minhas vendas','compras','Mentoria Projetos Remunerados','parceira de oportunidade']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M10.A03-01', 'principal', 1, 10, 'V1.M10.A03 — O Ciclo da Realização: Como Receber', 'Visão geral', 'O Ciclo da Realização: Como Receber', 'Método Sócia Invisível › Módulo 10 – O Universo das Demandas Digitais › Aula 03 – O Ciclo da Realização: Como Receber › Visão geral da aula

Nome oficial da aula: O Ciclo da Realização: Como Receber
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 10 – O Universo das Demandas Digitais, Aula 03
Duração/formato: 0:53
Link na área de membros (abre a página do Módulo 10, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/10

Resumo:
É uma aula curtíssima (53 s), com gravação de tela, que mostra onde cadastrar os dados bancários na Vinte Pila para receber pelos microprojetos. O conteúdo repete a Parte 3 da Aula 02, com um alerta importante: se errar os dados, não tem como corrigir depois.', 'approved', ARRAY['Vinte Pila','20pila','20 Pila','como receber','dados bancários','informações para pagamento','conta bancária','nome do titular','banco','agência','tipo de conta','número da conta','não tem como consertar','dados errados','corrigir conta bancária']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M10.A03-02', 'principal', 1, 10, 'V1.M10.A03 — O Ciclo da Realização: Como Receber', 'Procedimento: passo a passo', 'O Ciclo da Realização: Como Receber', 'Método Sócia Invisível › Módulo 10 – O Universo das Demandas Digitais › Aula 03 – O Ciclo da Realização: Como Receber › Procedimento: passo a passo

1. Com a conta aberta, ir em Editar perfil.
2. Rolar até o final da página, na seção "Informações para pagamento".
3. Preencher:
  - nome do titular;
  - banco;
  - agência;
  - tipo de conta;
  - número da conta.
4. ⚠️ Conferir tudo com muita atenção antes de salvar. Segundo a aula, se errar, não tem como consertar depois.
5. Salvar. A conta passa a receber os pagamentos dos microprojetos feitos na plataforma.', 'approved', ARRAY['Vinte Pila','20pila','20 Pila','como receber','dados bancários','informações para pagamento','conta bancária','nome do titular','banco','agência','tipo de conta','número da conta','não tem como consertar','dados errados','corrigir conta bancária']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M10.A03-03', 'principal', 1, 10, 'V1.M10.A03 — O Ciclo da Realização: Como Receber', 'FAQ', 'O Ciclo da Realização: Como Receber', 'Método Sócia Invisível › Módulo 10 – O Universo das Demandas Digitais › Aula 03 – O Ciclo da Realização: Como Receber › Pontos para o suporte

- "Onde cadastro meu banco na Vinte Pila?" Editar perfil › final da página › "Informações para pagamento".
- "Cadastrei a conta errada, como corrijo?" Segundo a aula, não dá para corrigir sozinha depois de salvar. Orientar a aluna a contatar o suporte da Vinte Pila. Confirmar o procedimento real com a plataforma.
- "Quando recebo?" Ver a Aula 05 deste módulo: saque mínimo de R$ 80, processado às quartas-feiras para pedidos feitos até terça.', 'approved', ARRAY['Vinte Pila','20pila','20 Pila','como receber','dados bancários','informações para pagamento','conta bancária','nome do titular','banco','agência','tipo de conta','número da conta','não tem como consertar','dados errados','corrigir conta bancária']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M10.A04-01', 'principal', 1, 10, 'V1.M10.A04 — Cadastro Inteligente de Demandas', 'Visão geral', 'Cadastro Inteligente de Demandas', 'Método Sócia Invisível › Módulo 10 – O Universo das Demandas Digitais › Aula 04 – Cadastro Inteligente de Demandas › Visão geral da aula

Nome oficial da aula: Cadastro Inteligente de Demandas
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 10 – O Universo das Demandas Digitais, Aula 04
Duração/formato: 2:07
Link na área de membros (abre a página do Módulo 10, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/10

Resumo:
É uma aula prática, com gravação de tela, que mostra as duas formas de conseguir microprojetos na Vinte Pila:
1. Criar um serviço (gig), que fica na vitrine para qualquer contratante comprar.
2. Candidatar-se a "Oportunidades de trabalho" publicadas por contratantes, como no 99Freelas e no Workana.
Um detalhe próprio da plataforma: cada oportunidade aceita um número limitado de propostas. Quando as vagas se esgotam, não dá mais para enviar.', 'approved', ARRAY['Vinte Pila','Vintipila','20pila','criar serviço','publicar serviço','gig','oferta de serviço','título do serviço','categoria','descrição','instruções ao comprador','prazo','imagens','áudios','serviço extra','extras de R$ 10 a R$ 40','oportunidades de trabalho','candidatar','proposta','vagas preenchidas','em progresso','minha executiva']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M10.A04-02', 'principal', 1, 10, 'V1.M10.A04 — Cadastro Inteligente de Demandas', 'Procedimento', 'Cadastro Inteligente de Demandas', 'Método Sócia Invisível › Módulo 10 – O Universo das Demandas Digitais › Aula 04 – Cadastro Inteligente de Demandas › Procedimento

### Opção 1: Criar um serviço (vitrine)
1. Ir em Serviços › Criar serviço.
2. Preencher:
| Campo | Orientação da aula |
|---|---|
| Título do serviço | O que você quer oferecer. É possível criar vários serviços. |
| Valor | Começa em R$ 20. |
| Categoria | Escolher entre as categorias disponíveis. |
| Descrição | Espaço livre: o que você faz, quanto cobra por cada coisa, como trabalha. |
| Instruções ao comprador | O que o cliente precisa enviar ou informar para você executar o serviço. |
| Prazo | De 1 a quantos dias você definir. |
| Imagens e áudios | Anexar para ilustrar o serviço. |
| Serviços extras | Adicionais de R$ 10 a R$ 40, cada um com a sua descrição. |
1. Salvar. O serviço aparece na tela principal para os contratantes.
### Opção 2: Candidatar-se a oportunidades
1. Ir em Oportunidades de trabalho.
2. Clicar em Detalhes e ler a descrição do projeto.
3. Fazer uma proposta, como nas outras plataformas. Usar a estrutura do Bônus 01 do M07.
4. ⚠️ Atenção: cada oportunidade tem um limite de propostas. Se as vagas já foram preenchidas, ou se o projeto está "em progresso" (alguém já foi escolhido), não é possível enviar.', 'approved', ARRAY['Vinte Pila','Vintipila','20pila','criar serviço','publicar serviço','gig','oferta de serviço','título do serviço','categoria','descrição','instruções ao comprador','prazo','imagens','áudios','serviço extra','extras de R$ 10 a R$ 40','oportunidades de trabalho','candidatar','proposta','vagas preenchidas','em progresso','minha executiva']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M10.A04-03', 'principal', 1, 10, 'V1.M10.A04 — Cadastro Inteligente de Demandas', 'Dicas para usar com as aulas anteriores', 'Cadastro Inteligente de Demandas', 'Método Sócia Invisível › Módulo 10 – O Universo das Demandas Digitais › Aula 04 – Cadastro Inteligente de Demandas › Dicas para usar com as aulas anteriores

- Título e descrição do serviço: usar a linguagem profissional e a fórmula "Especialista em…" (M06 A02).
- Preço e extras: aplicar a lógica de pacotes e 3 opções do Bônus 1 do M08 (Precificação). Os "serviços extras" funcionam como upgrades.
- Imagens: usar os cases do portfólio (M06 A04).', 'approved', ARRAY['Vinte Pila','Vintipila','20pila','criar serviço','publicar serviço','gig','oferta de serviço','título do serviço','categoria','descrição','instruções ao comprador','prazo','imagens','áudios','serviço extra','extras de R$ 10 a R$ 40','oportunidades de trabalho','candidatar','proposta','vagas preenchidas','em progresso','minha executiva']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M10.A04-04', 'principal', 1, 10, 'V1.M10.A04 — Cadastro Inteligente de Demandas', 'FAQ', 'Cadastro Inteligente de Demandas', 'Método Sócia Invisível › Módulo 10 – O Universo das Demandas Digitais › Aula 04 – Cadastro Inteligente de Demandas › Pontos para o suporte

- "Como publico meu serviço na Vinte Pila?" Serviços › Criar serviço › título, categoria, descrição, instruções ao comprador, prazo, imagens e extras › salvar.
- "Qual o preço mínimo?" R$ 20 por serviço. Os extras vão de R$ 10 a R$ 40.
- "Não consigo enviar proposta para uma oportunidade." Provavelmente as vagas de proposta já se esgotaram ou o projeto está em progresso. Buscar oportunidades mais recentes.
- "Posso ter mais de um serviço?" Sim, a aluna pode criar vários.', 'approved', ARRAY['Vinte Pila','Vintipila','20pila','criar serviço','publicar serviço','gig','oferta de serviço','título do serviço','categoria','descrição','instruções ao comprador','prazo','imagens','áudios','serviço extra','extras de R$ 10 a R$ 40','oportunidades de trabalho','candidatar','proposta','vagas preenchidas','em progresso','minha executiva']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M10.A05-01', 'principal', 1, 10, 'V1.M10.A05 — Mapeamento Inteligente: Identificando Demandas Lucrativas', 'Visão geral', 'Mapeamento Inteligente: Identificando Demandas Lucrativas', 'Método Sócia Invisível › Módulo 10 – O Universo das Demandas Digitais › Aula 05 – Mapeamento Inteligente: Identificando Demandas Lucrativas › Visão geral da aula

Nome oficial da aula: Mapeamento Inteligente: Identificando Demandas Lucrativas
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 10 – O Universo das Demandas Digitais, Aula 05
Duração/formato: 2:13
Link na área de membros (abre a página do Módulo 10, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/10

Resumo:
É uma aula prática, com gravação de tela, que fecha o ciclo na Vinte Pila:
1. Enviar uma proposta a uma oportunidade (valor e prazo).
2. Conversar com o contratante pela área de Mensagens.
3. Acompanhar os rendimentos e sacar o dinheiro.
Regras de saque importantes: mínimo de R$ 80 e processamento às quartas-feiras para pedidos feitos até terça-feira.', 'approved', ARRAY['Vinte Pila','20pila','Vintipila','fazer uma proposta','enviar proposta','valor mínimo R$ 20','prazo de entrega','mensagens','caixa de entrada','bate-papo','oferta personalizada','enviar arquivo','rendimentos','saldo','retiradas pendentes','pagamentos pendentes','extrato de transações','descontos da plataforma','retirar dinheiro','sacar','saque mínimo R$ 80','saque às quartas-feiras','minha executiva']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M10.A05-02', 'principal', 1, 10, 'V1.M10.A05 — Mapeamento Inteligente: Identificando Demandas Lucrativas', 'Procedimento: passo a passo', 'Mapeamento Inteligente: Identificando Demandas Lucrativas', 'Método Sócia Invisível › Módulo 10 – O Universo das Demandas Digitais › Aula 05 – Mapeamento Inteligente: Identificando Demandas Lucrativas › Procedimento: passo a passo

### Parte 1: Enviar a proposta
1. Abrir a oportunidade de trabalho e clicar em "Fazer uma proposta".
2. Informar o valor (mínimo de R$ 20) e o prazo de entrega (exemplo da aula: 24 horas).
3. Clicar em Enviar. Segundo a aula, aqui não é obrigatório escrever uma descrição: basta valor e prazo.
### Parte 2: Conversar com o contratante
1. Na página principal, clicar em Mensagens (caixa de entrada).
2. Abrir a conversa com o contratante para combinar os detalhes do projeto.
3. Dentro da conversa é possível:
  - enviar uma oferta personalizada;
  - enviar arquivos.
### Parte 3: Ver os rendimentos e sacar
1. Na página principal, clicar nos três pontinhos › Rendimentos.
2. Nessa tela aparecem:
  - saldo disponível;
  - retiradas pendentes e pagamentos pendentes;
  - extrato de transações, com tudo o que foi recebido e os descontos da plataforma.
3. Clicar em Retirar dinheiro, informar o valor e confirmar em Retirar.
| Regra de saque (segundo a aula) | Valor |
|---|---|
| Saldo mínimo para sacar | R$ 80 |
| Processamento | Toda quarta-feira |
| Prazo para pedir | Até terça-feira para entrar no processamento da quarta |', 'approved', ARRAY['Vinte Pila','20pila','Vintipila','fazer uma proposta','enviar proposta','valor mínimo R$ 20','prazo de entrega','mensagens','caixa de entrada','bate-papo','oferta personalizada','enviar arquivo','rendimentos','saldo','retiradas pendentes','pagamentos pendentes','extrato de transações','descontos da plataforma','retirar dinheiro','sacar','saque mínimo R$ 80','saque às quartas-feiras','minha executiva']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M10.A05-03', 'principal', 1, 10, 'V1.M10.A05 — Mapeamento Inteligente: Identificando Demandas Lucrativas', 'FAQ', 'Mapeamento Inteligente: Identificando Demandas Lucrativas', 'Método Sócia Invisível › Módulo 10 – O Universo das Demandas Digitais › Aula 05 – Mapeamento Inteligente: Identificando Demandas Lucrativas › Pontos para o suporte

- "Como envio proposta na Vinte Pila?" Abrir a oportunidade › "Fazer uma proposta" › valor (mínimo R$ 20) e prazo › Enviar.
- "Onde converso com o cliente?" Em Mensagens, na página principal. Ali dá para mandar oferta personalizada e arquivos.
- "Onde vejo meu saldo?" Três pontinhos › Rendimentos.
- "Não consigo sacar." Verificar se o saldo é de pelo menos R$ 80.
- "Pedi o saque e não caiu." Os saques são processados às quartas-feiras, para pedidos feitos até terça. Um pedido feito na quarta só entra na quarta seguinte. Conferir se os dados bancários estão corretos (ver o alerta da Aula 03).
- "Quanto a plataforma desconta?" O desconto aparece no extrato de transações. A aula não diz o percentual.', 'approved', ARRAY['Vinte Pila','20pila','Vintipila','fazer uma proposta','enviar proposta','valor mínimo R$ 20','prazo de entrega','mensagens','caixa de entrada','bate-papo','oferta personalizada','enviar arquivo','rendimentos','saldo','retiradas pendentes','pagamentos pendentes','extrato de transações','descontos da plataforma','retirar dinheiro','sacar','saque mínimo R$ 80','saque às quartas-feiras','minha executiva']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M10.A06-01', 'principal', 1, 10, 'V1.M10.A06 — Bônus: O Poder do Follow-up: Como Transformar Silêncio em Contratos', 'Visão geral', 'Bônus: O Poder do Follow-up: Como Transformar Silêncio em Contratos', 'Método Sócia Invisível › Módulo 10 – O Universo das Demandas Digitais › Aula 06 – Bônus: O Poder do Follow-up: Como Transformar Silêncio em Contratos › Visão geral da aula

Nome oficial da aula: Bônus: O Poder do Follow-up: Como Transformar Silêncio em Contratos
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 10 – O Universo das Demandas Digitais, Aula 06
Duração/formato: 5:08
Link na área de membros (abre a página do Módulo 10, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/10

Resumo:
A aula ensina 10 "hacks" para gerar as primeiras vendas com microsserviços, usando a lógica da Vinte Pila: começar pequeno (R$ 20) para ganhar confiança, experiência e reputação, e depois crescer com pacotes. A mensagem central: "Não é sobre o valor em si, é sobre a mentalidade: aprender a gerar renda de forma consistente e replicar em escala." Termina com um exercício prático.', 'approved', ARRAY['follow-up','follow up','transformar silêncio em contratos','Vinte Pila','20 pila','hacks do Vinte Pila','oferta irresistível','oferta específica','preço inicial','pacotes','redes sociais como vitrine','boca a boca','indicação','automatizar','modelos prontos','Google Docs','Supremo','Suprema']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M10.A06-02', 'principal', 1, 10, 'V1.M10.A06 — Bônus: O Poder do Follow-up: Como Transformar Silêncio em Contratos', 'Os 10 hacks', 'Bônus: O Poder do Follow-up: Como Transformar Silêncio em Contratos', 'Método Sócia Invisível › Módulo 10 – O Universo das Demandas Digitais › Aula 06 – Bônus: O Poder do Follow-up: Como Transformar Silêncio em Contratos › Os 10 hacks

| # | Hack | Como aplicar |
|---|---|---|
| 1 | Escolher uma habilidade simples | Algo que já sabe fazer: escrever, organizar, revisar textos, criar imagens simples, digitar rápido, planilha básica, resolver problemas no celular. "O simples funciona." |
| 2 | Criar uma oferta específica | Resolver um problema claro, com prazo. ❌ "Faço trabalhos gerais" → ✅ "Organizo sua lista de contatos em uma planilha em menos de 24 h" ou "Reviso seu texto e entrego pronto para publicação". |
| 3 | Redes sociais como vitrine | Post simples e direto. Exemplo: "Precisa de ajuda para organizar suas ideias? Eu faço isso de forma rápida e prática. Me chama no privado." Sempre com prazo curto. |
| 4 | Preço inicial acessível | O objetivo no início é confiança e reputação. Exemplo: "Faço por R$ 20 e entrego em até 24 h." |
| 5 | Boca a boca | Depois de entregar, pedir: "Se gostou, pode me indicar para alguém que precise? Isso me ajuda muito." |
| 6 | Pacotes simples | Depois de alguns trabalhos. Exemplos: 3 revisões de texto por R$ 50, até 5 planilhas por R$ 100. |
| 7 | Automatizar | Usar modelos prontos de planilha e a correção automática do Google Docs para economizar tempo. |
| 8 | Responder rápido | Estar presente, ser educada e mostrar compromisso. |
| 9 | Criar uma rotina | Separar um horário do dia para divulgar, responder e entregar. |
| 10 | Não ter medo de errar | Errar no preço ou no prazo no começo é normal. Aprender e ajustar. |', 'approved', ARRAY['follow-up','follow up','transformar silêncio em contratos','Vinte Pila','20 pila','hacks do Vinte Pila','oferta irresistível','oferta específica','preço inicial','pacotes','redes sociais como vitrine','boca a boca','indicação','automatizar','modelos prontos','Google Docs','Supremo','Suprema']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M10.A06-03', 'principal', 1, 10, 'V1.M10.A06 — Bônus: O Poder do Follow-up: Como Transformar Silêncio em Contratos', 'Procedimento: exercício prático', 'Bônus: O Poder do Follow-up: Como Transformar Silêncio em Contratos', 'Método Sócia Invisível › Módulo 10 – O Universo das Demandas Digitais › Aula 06 – Bônus: O Poder do Follow-up: Como Transformar Silêncio em Contratos › Procedimento: exercício prático

1. Escrever 3 coisas que você sabe fazer bem e que podem ajudar outras pessoas.
2. Escolher uma e criar uma oferta simples: "Faço [tal subdemanda] por R$ 20 e entrego em até 24 horas."
3. Publicar a oferta na Vinte Pila (Serviços › Criar serviço, ver a Aula 04 deste módulo).
4. Quando alguém procurar: responder rápido, combinar os detalhes e entregar no prazo.
5. Depois de entregar, pedir feedback e indicação.', 'approved', ARRAY['follow-up','follow up','transformar silêncio em contratos','Vinte Pila','20 pila','hacks do Vinte Pila','oferta irresistível','oferta específica','preço inicial','pacotes','redes sociais como vitrine','boca a boca','indicação','automatizar','modelos prontos','Google Docs','Supremo','Suprema']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M10.A06-04', 'principal', 1, 10, 'V1.M10.A06 — Bônus: O Poder do Follow-up: Como Transformar Silêncio em Contratos', 'FAQ', 'Bônus: O Poder do Follow-up: Como Transformar Silêncio em Contratos', 'Método Sócia Invisível › Módulo 10 – O Universo das Demandas Digitais › Aula 06 – Bônus: O Poder do Follow-up: Como Transformar Silêncio em Contratos › Pontos para o suporte

- "Que serviço eu ofereço na Vinte Pila?" Algo simples que você já sabe fazer, com problema e prazo claros. Exemplo: "Organizo sua lista de contatos em planilha em 24 h por R$ 20."
- "Ninguém compra meu serviço." Revisar se a oferta é específica (não "faço de tudo"), se tem prazo curto e se a aluna está respondendo rápido. Divulgar com constância.
- "Quando posso cobrar mais?" Depois dos primeiros trabalhos e avaliações, criar pacotes (Hack 6) e aplicar a precificação do Bônus 1 do M08.', 'approved', ARRAY['follow-up','follow up','transformar silêncio em contratos','Vinte Pila','20 pila','hacks do Vinte Pila','oferta irresistível','oferta específica','preço inicial','pacotes','redes sociais como vitrine','boca a boca','indicação','automatizar','modelos prontos','Google Docs','Supremo','Suprema']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M10.A07-01', 'principal', 1, 10, 'V1.M10.A07 — Bônus: Hacks Avançados para o Vinte Pila', 'Visão geral', 'Bônus: Hacks Avançados para o Vinte Pila', 'Método Sócia Invisível › Módulo 10 – O Universo das Demandas Digitais › Aula 07 – Bônus: Hacks Avançados para o Vinte Pila › Visão geral da aula

Nome oficial da aula: Bônus: Hacks Avançados para o Vinte Pila
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 10 – O Universo das Demandas Digitais, Aula 07
Duração/formato: 5:34
Link na área de membros (abre a página do Módulo 10, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/10

Resumo:
A aula ensina a fazer follow-up, ou seja, voltar a falar com quem não respondeu a uma mensagem ou proposta. A tese é: "o silêncio não é o fim da conversa". As pessoas estão ocupadas e esquecem, e não é algo pessoal. A aula dá os princípios de um follow-up que funciona sem parecer chato, modelos de mensagem, o momento de parar e um exercício prático.', 'approved', ARRAY['follow-up','follow up','acompanhamento','cobrar resposta','cliente não respondeu','silêncio','sem resposta','vácuo','senso de urgência','agenda','80% das vendas depois do quinto contato','hacks avançados Vinte Pila']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M10.A07-02', 'principal', 1, 10, 'V1.M10.A07 — Bônus: Hacks Avançados para o Vinte Pila', 'Procedimento: como fazer follow-up', 'Bônus: Hacks Avançados para o Vinte Pila', 'Método Sócia Invisível › Módulo 10 – O Universo das Demandas Digitais › Aula 07 – Bônus: Hacks Avançados para o Vinte Pila › Procedimento: como fazer follow-up

| # | Princípio | Como aplicar |
|---|---|---|
| 1 | Saber o objetivo | Antes de escrever, definir: fechar o contrato? Tirar uma dúvida? Oferecer mais informação? |
| 2 | Timing | Intervalo de 2 a 3 dias entre cada contato. Nada de mensagens seguidas. |
| 3 | Personalizar | Citar algo específico da conversa ou da necessidade da pessoa. Nada de mensagem copiada e colada. |
| 4 | Variar o canal | Sem resposta num canal, tentar outro. |
| 5 | Ser breve | Relembrar o que foi conversado, dizer o que precisa e pedir uma resposta. |
| 6 | Mostrar empatia | Perguntar como a pessoa está e se há algo em que possa ajudar. |
| 7 | Criar senso de urgência (quando a pessoa enrola) | Mencionar a própria agenda. |
| 8 | Saber a hora de parar | Depois de 4 ou 5 follow-ups sem resposta, focar em outras oportunidades, mas deixar a porta aberta. |
Para transformar follow-up em contrato: focar em ajudar, e não só em vender, e usar cada contato para reforçar autoridade e confiança.
### Modelos de mensagem da aula
- Follow-up simples: "Oi, tudo bem? Eu mandei aquela proposta sobre o trabalho X e queria saber se você teve a chance de dar uma olhada. Se precisar de mais informações, é só me avisar."
- Com urgência: "Oi, só queria te avisar que estou organizando minha agenda para os próximos dias e queria saber se você ainda tem interesse no trabalho. Assim eu consigo reservar um tempo para te atender da melhor forma."', 'approved', ARRAY['follow-up','follow up','acompanhamento','cobrar resposta','cliente não respondeu','silêncio','sem resposta','vácuo','senso de urgência','agenda','80% das vendas depois do quinto contato','hacks avançados Vinte Pila']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M10.A07-03', 'principal', 1, 10, 'V1.M10.A07 — Bônus: Hacks Avançados para o Vinte Pila', 'Exercício prático', 'Bônus: Hacks Avançados para o Vinte Pila', 'Método Sócia Invisível › Módulo 10 – O Universo das Demandas Digitais › Aula 07 – Bônus: Hacks Avançados para o Vinte Pila › Exercício prático

1. Escolher uma pessoa ou um trabalho para o qual já mandou mensagem ou proposta e não teve resposta.
2. Escrever uma mensagem de follow-up (papel ou bloco de notas) breve, objetiva e mostrando valor.
3. Enviar e anotar a data.
4. Sem resposta em 2 a 3 dias, fazer novo follow-up.', 'approved', ARRAY['follow-up','follow up','acompanhamento','cobrar resposta','cliente não respondeu','silêncio','sem resposta','vácuo','senso de urgência','agenda','80% das vendas depois do quinto contato','hacks avançados Vinte Pila']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M10.A07-04', 'principal', 1, 10, 'V1.M10.A07 — Bônus: Hacks Avançados para o Vinte Pila', 'FAQ', 'Bônus: Hacks Avançados para o Vinte Pila', 'Método Sócia Invisível › Módulo 10 – O Universo das Demandas Digitais › Aula 07 – Bônus: Hacks Avançados para o Vinte Pila › Pontos para o suporte

- "Mandei proposta e o cliente não respondeu." Esperar 2 a 3 dias e mandar um follow-up curto e personalizado. Usar os modelos acima. Parar depois de 4 ou 5 tentativas.
- "Tenho medo de parecer chata." A aula recomenda intervalo entre contatos, mensagens curtas e foco em ajudar.
- Outros materiais de follow-up: Hack 10 do Bônus 02 do M07 (follow-up com valor em 48 h) e Hack 11 do Bônus 2 do M08 (48 h e depois 1 semana).', 'approved', ARRAY['follow-up','follow up','acompanhamento','cobrar resposta','cliente não respondeu','silêncio','sem resposta','vácuo','senso de urgência','agenda','80% das vendas depois do quinto contato','hacks avançados Vinte Pila']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M11.A01-01', 'principal', 1, 11, 'V1.M11.A01 — O Código das Demandas no GETNINJAS', 'Visão geral', 'O Código das Demandas no GETNINJAS', 'Método Sócia Invisível › Módulo 11 – Liberdade Financeira com as Demandas › Aula 01 – O Código das Demandas no GETNINJAS › Visão geral da aula

Nome oficial da aula: O Código das Demandas no GETNINJAS
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 11 – Liberdade Financeira com as Demandas, Aula 01
Duração/formato: 4:03
Link na área de membros (abre a página do Módulo 11, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/11

Resumo:
É a abertura do Módulo 11, que apresenta uma quarta plataforma: o GetNinjas (transcrito como "Netlinx" e "agatininhas"). É uma plataforma que conecta clientes a prestadores de serviço de todo o Brasil. Os clientes publicam pedidos, a prestadora acessa os pedidos e entra em contato para oferecer o serviço, e o pagamento é feito direto pelo cliente. A aula é introdutória. Cadastro e perfil ficam para a Aula 02.', 'approved', ARRAY['GetNinjas','Get Ninjas','Liberdade financeira com as demandas','moedas','créditos','desbloquear contato','liberar pedido','pedidos','projetos dos clientes','prestadora de serviços','Mentoria Projetos Remunerados','gestora de microprojetos','executiva']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M11.A01-02', 'principal', 1, 11, 'V1.M11.A01 — O Código das Demandas no GETNINJAS', 'O que a aula diz sobre o GetNinjas', 'O Código das Demandas no GETNINJAS', 'Método Sócia Invisível › Módulo 11 – Liberdade Financeira com as Demandas › Aula 01 – O Código das Demandas no GETNINJAS › O que a aula diz sobre o GetNinjas

- Áreas citadas: suporte administrativo, atendimento ao cliente, produção de conteúdo, serviços digitais "e muito mais".
- Não é preciso ser expert: usar as habilidades atuais e aprender o resto no método.
- Por que usar (segundo a aula):
  - trabalhar de casa, atendendo clientes do Brasil todo;
  - estrutura simples: celular e internet;
  - serviços sob demanda, no seu tempo;
  - escolher com quem trabalhar e quanto cobrar.
- Posicionamento: entrar como "gestora de microprojetos", e não "mais uma prestadora de serviços".
### Como funciona na prática (segundo a aula)
1. O cliente publica um pedido.
2. A prestadora vê os pedidos e entra em contato com o cliente para oferecer o serviço.
3. As duas partes fecham o combinado.
4. A prestadora executa e recebe direto do cliente.', 'approved', ARRAY['GetNinjas','Get Ninjas','Liberdade financeira com as demandas','moedas','créditos','desbloquear contato','liberar pedido','pedidos','projetos dos clientes','prestadora de serviços','Mentoria Projetos Remunerados','gestora de microprojetos','executiva']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M11.A01-03', 'principal', 1, 11, 'V1.M11.A01 — O Código das Demandas no GETNINJAS', 'Comparação com as plataformas anteriores', 'O Código das Demandas no GETNINJAS', 'Método Sócia Invisível › Módulo 11 – Liberdade Financeira com as Demandas › Aula 01 – O Código das Demandas no GETNINJAS › Comparação com as plataformas anteriores

|  | 99Freelas / Workana (M07, M08) | Vinte Pila (M10) | GetNinjas (M11) |
|---|---|---|---|
| Quem toma a iniciativa | A aluna envia propostas | O cliente compra o serviço publicado | A aluna contata o cliente que publicou o pedido |
| Pagamento | Pela plataforma (com taxa) | Pela plataforma | Direto do cliente |
| Custo para a prestadora | Taxa sobre o projeto e planos | Taxa (ver M10) | Compra de moedas para liberar contatos |', 'approved', ARRAY['GetNinjas','Get Ninjas','Liberdade financeira com as demandas','moedas','créditos','desbloquear contato','liberar pedido','pedidos','projetos dos clientes','prestadora de serviços','Mentoria Projetos Remunerados','gestora de microprojetos','executiva']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M11.A01-04', 'principal', 1, 11, 'V1.M11.A01 — O Código das Demandas no GETNINJAS', 'Procedimento: o que a aluna deve fazer', 'O Código das Demandas no GETNINJAS', 'Método Sócia Invisível › Módulo 11 – Liberdade Financeira com as Demandas › Aula 01 – O Código das Demandas no GETNINJAS › Procedimento: o que a aluna deve fazer

1. Assistir à aula para conhecer o GetNinjas. Não há ação prática.
2. Organizar-se: separar um tempo e preparar o ambiente para a próxima aula.
3. Seguir para a Aula 02 do Módulo 11, que mostra na tela o cadastro e a configuração do perfil.', 'approved', ARRAY['GetNinjas','Get Ninjas','Liberdade financeira com as demandas','moedas','créditos','desbloquear contato','liberar pedido','pedidos','projetos dos clientes','prestadora de serviços','Mentoria Projetos Remunerados','gestora de microprojetos','executiva']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M11.A01-05', 'principal', 1, 11, 'V1.M11.A01 — O Código das Demandas no GETNINJAS', 'FAQ', 'O Código das Demandas no GETNINJAS', 'Método Sócia Invisível › Módulo 11 – Liberdade Financeira com as Demandas › Aula 01 – O Código das Demandas no GETNINJAS › Pontos para o suporte

- "O que é o GetNinjas?" Uma plataforma em que clientes publicam pedidos de serviço e a prestadora entra em contato para oferecer o trabalho. O pagamento é combinado e feito direto entre as duas partes.
- "O GetNinjas é pago?" O cadastro é gratuito, mas, segundo o próprio GetNinjas, é preciso comprar moedas para liberar o contato dos clientes.
- "Como recebo no GetNinjas?" Direto do cliente, no valor e na forma combinados. A plataforma não intermedeia o pagamento.
- "Não acho a ''Netlinx''." O nome correto é GetNinjas.
- "O GetNinjas é do método?" Não. É uma plataforma independente.', 'approved', ARRAY['GetNinjas','Get Ninjas','Liberdade financeira com as demandas','moedas','créditos','desbloquear contato','liberar pedido','pedidos','projetos dos clientes','prestadora de serviços','Mentoria Projetos Remunerados','gestora de microprojetos','executiva']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M11.A02-01', 'principal', 1, 11, 'V1.M11.A02 — Construindo Sua Vitrine Digital no GETNINJAS', 'Visão geral', 'Construindo Sua Vitrine Digital no GETNINJAS', 'Método Sócia Invisível › Módulo 11 – Liberdade Financeira com as Demandas › Aula 02 – Construindo Sua Vitrine Digital no GETNINJAS › Visão geral da aula

Nome oficial da aula: Construindo Sua Vitrine Digital no GETNINJAS
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 11 – Liberdade Financeira com as Demandas, Aula 02
Duração/formato: 1:57
Link na área de membros (abre a página do Módulo 11, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/11

Resumo:
É uma aula prática e curta, com gravação de tela, que ensina a fazer o cadastro de prestadora de serviço no GetNinjas: escolher a categoria (o exemplo é Design e Tecnologia), informar os dados pessoais e confirmar pelo celular. A aula não mostra a edição do perfil nem a descrição dos serviços, apesar do título "Construindo Sua Vitrine". A busca por projetos fica para a Aula 03.', 'approved', ARRAY['GetNinjas','Get Ninjas','seja um profissional','sou prestador de serviço','quero me cadastrar','SMS','código no celular','categorias','Design e Tecnologia','reforma','serviços domésticos','assistência','eventos','moda e beleza','aulas','consultoria','automóveis','CPF','CNPJ','CEP','data de nascimento','gênero','Mentoria Projetos Remunerados','parceira de oportunidades']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M11.A02-02', 'principal', 1, 11, 'V1.M11.A02 — Construindo Sua Vitrine Digital no GETNINJAS', 'Procedimento: passo a passo', 'Construindo Sua Vitrine Digital no GETNINJAS', 'Método Sócia Invisível › Módulo 11 – Liberdade Financeira com as Demandas › Aula 02 – Construindo Sua Vitrine Digital no GETNINJAS › Procedimento: passo a passo

1. Pesquisar "GetNinjas" no Google e abrir o site.
2. Clicar em "Seja um profissional" e escolher "Sou prestador de serviço".
3. Informar e-mail e número de celular e clicar em "Quero me cadastrar".
4. O GetNinjas envia um SMS. Escolher concluir o cadastro agora, ou continuar pelo aplicativo.
5. Escolher a categoria de serviços. Opções mostradas: reforma, serviços domésticos, assistência, eventos, moda e beleza, design e tecnologia, aulas, consultoria, automóveis e outras.
  - Exemplo da aula: Design e Tecnologia, com subcategorias como gráfica e audiovisual.
6. Preencher nome completo e CEP. O celular já vem preenchido. Clicar em Continuar.
7. Digitar o código recebido no celular.
8. Informar CPF (ou CNPJ), data de nascimento e gênero.
9. Finalizar o cadastro. Depois, é possível baixar o aplicativo ou voltar para a conta pelo site.', 'approved', ARRAY['GetNinjas','Get Ninjas','seja um profissional','sou prestador de serviço','quero me cadastrar','SMS','código no celular','categorias','Design e Tecnologia','reforma','serviços domésticos','assistência','eventos','moda e beleza','aulas','consultoria','automóveis','CPF','CNPJ','CEP','data de nascimento','gênero','Mentoria Projetos Remunerados','parceira de oportunidades']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M11.A02-03', 'principal', 1, 11, 'V1.M11.A02 — Construindo Sua Vitrine Digital no GETNINJAS', 'Dicas para usar com as aulas anteriores', 'Construindo Sua Vitrine Digital no GETNINJAS', 'Método Sócia Invisível › Módulo 11 – Liberdade Financeira com as Demandas › Aula 02 – Construindo Sua Vitrine Digital no GETNINJAS › Dicas para usar com as aulas anteriores

- Categoria: escolher a que corresponde às habilidades mapeadas no M06 A01 (5 círculos). Para quem trabalha de casa, dar preferência a categorias de serviços digitais, como Design e Tecnologia ou Consultoria.
- Descrição e foto do perfil: esta aula não mostra, mas vale aplicar o elevator pitch (M06 A02) e o Hack 1 do Bônus 02 (M07 A06) quando a plataforma pedir.', 'approved', ARRAY['GetNinjas','Get Ninjas','seja um profissional','sou prestador de serviço','quero me cadastrar','SMS','código no celular','categorias','Design e Tecnologia','reforma','serviços domésticos','assistência','eventos','moda e beleza','aulas','consultoria','automóveis','CPF','CNPJ','CEP','data de nascimento','gênero','Mentoria Projetos Remunerados','parceira de oportunidades']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M11.A02-04', 'principal', 1, 11, 'V1.M11.A02 — Construindo Sua Vitrine Digital no GETNINJAS', 'FAQ', 'Construindo Sua Vitrine Digital no GETNINJAS', 'Método Sócia Invisível › Módulo 11 – Liberdade Financeira com as Demandas › Aula 02 – Construindo Sua Vitrine Digital no GETNINJAS › Pontos para o suporte

- "Como me cadastro no GetNinjas?" Google › GetNinjas › "Seja um profissional" › "Sou prestador de serviço" › e-mail e celular › código por SMS › categoria › nome e CEP › CPF, data de nascimento e gênero › finalizar.
- "Não recebi o SMS." Conferir o número informado e pedir o reenvio. Se persistir, contatar o suporte do GetNinjas.
- "Qual categoria escolho?" A que tem a ver com o serviço que você vai oferecer. Para trabalhar de casa, as categorias digitais (Design e Tecnologia, Consultoria) fazem mais sentido.
- "Paga alguma coisa para se cadastrar?" O cadastro é gratuito. Para liberar o contato de clientes, o GetNinjas cobra em moedas (ver a Aula 01 deste módulo).', 'approved', ARRAY['GetNinjas','Get Ninjas','seja um profissional','sou prestador de serviço','quero me cadastrar','SMS','código no celular','categorias','Design e Tecnologia','reforma','serviços domésticos','assistência','eventos','moda e beleza','aulas','consultoria','automóveis','CPF','CNPJ','CEP','data de nascimento','gênero','Mentoria Projetos Remunerados','parceira de oportunidades']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M11.A03-01', 'principal', 1, 11, 'V1.M11.A03 — Fazendo Demandas Mobile: App GETNINJAS', 'Visão geral', 'Fazendo Demandas Mobile: App GETNINJAS', 'Método Sócia Invisível › Módulo 11 – Liberdade Financeira com as Demandas › Aula 03 – Fazendo Demandas Mobile: App GETNINJAS › Visão geral da aula

Nome oficial da aula: Fazendo Demandas Mobile: App GETNINJAS
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 11 – Liberdade Financeira com as Demandas, Aula 03
Duração/formato: 2:42
Link na área de membros (abre a página do Módulo 11, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/11

Resumo:
É uma aula prática, com gravação da tela do celular, que ensina a baixar e entrar no app do GetNinjas, ver os pedidos disponíveis, liberar um pedido (o que custa moedas) para ter o contato do cliente, e comprar moedas. É a primeira aula que mostra que, no GetNinjas, o acesso ao cliente é pago.', 'approved', ARRAY['GetNinjas','Get Ninjas','app GetNinjas','aplicativo amarelinho','Play Store','Google Play','Apple Store','App Store','baixar o aplicativo','pedidos disponíveis','detalhes do pedido','liberar pedido','moedas','comprar moedas','custo em moedas','exclusividade','pedido exclusivo','pedidos aceitos','realizados','não realizados','Mentoria MPR']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M11.A03-02', 'principal', 1, 11, 'V1.M11.A03 — Fazendo Demandas Mobile: App GETNINJAS', 'Procedimento: passo a passo', 'Fazendo Demandas Mobile: App GETNINJAS', 'Método Sócia Invisível › Módulo 11 – Liberdade Financeira com as Demandas › Aula 03 – Fazendo Demandas Mobile: App GETNINJAS › Procedimento: passo a passo

### 1. Baixar e entrar no app
1. Abrir a Play Store (Android) ou a App Store (iPhone).
2. Pesquisar "GetNinjas". É o app amarelo. Tocar em Instalar/Obter.
3. Abrir o app e informar o número de celular usado no cadastro (Aula 02).
4. Digitar o código recebido por SMS. Pronto, a conta está conectada.
### 2. Ver os pedidos disponíveis
- Na tela inicial ficam os pedidos disponíveis. Exemplo da aula: edição de fotos (remoção e alteração de fundo, até 10 fotos, urgente).
- Abrir um pedido: as informações principais ficam no topo. Rolar para baixo para ver mais detalhes.
### 3. Liberar o pedido (custa moedas)
- Tocar em "Liberar pedido". Com isso, a aluna recebe o contato do cliente e pode negociar direto, ao custo de algumas moedas.
- Pode haver a opção de exclusividade no pedido (a aula mostra "quero / não quero exclusividade").
- Depois de liberar, falar com o cliente e combinar o projeto.
### 4. Moedas
- Na seção Moedas, a aluna vê o saldo, as moedas já usadas e pode comprar mais.
### 5. Acompanhar os pedidos
- Ver os pedidos aceitos, realizados e não realizados.', 'approved', ARRAY['GetNinjas','Get Ninjas','app GetNinjas','aplicativo amarelinho','Play Store','Google Play','Apple Store','App Store','baixar o aplicativo','pedidos disponíveis','detalhes do pedido','liberar pedido','moedas','comprar moedas','custo em moedas','exclusividade','pedido exclusivo','pedidos aceitos','realizados','não realizados','Mentoria MPR']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M11.A03-03', 'principal', 1, 11, 'V1.M11.A03 — Fazendo Demandas Mobile: App GETNINJAS', 'FAQ', 'Fazendo Demandas Mobile: App GETNINJAS', 'Método Sócia Invisível › Módulo 11 – Liberdade Financeira com as Demandas › Aula 03 – Fazendo Demandas Mobile: App GETNINJAS › Pontos para o suporte

- "Como baixo o app do GetNinjas?" Play Store ou App Store › "GetNinjas" (app amarelo) › entrar com o celular do cadastro › código por SMS.
- "Como pego um pedido?" Abrir o pedido › "Liberar pedido", que custa moedas › recebe o contato do cliente › negociar direto.
- "Preciso pagar?" Para liberar o contato do cliente, sim: é preciso ter moedas, compradas no próprio app. O cadastro é gratuito.
- "Gastei moedas e o cliente não respondeu / não fechou." Isso pode acontecer. Orientar a aluna a escolher bem os pedidos antes de liberar e a entrar em contato rápido. Para reembolso de moedas, só o suporte do GetNinjas pode ajudar.
- "O que é exclusividade?" A aula não explica. Consultar a regra no próprio app ou no suporte do GetNinjas.', 'approved', ARRAY['GetNinjas','Get Ninjas','app GetNinjas','aplicativo amarelinho','Play Store','Google Play','Apple Store','App Store','baixar o aplicativo','pedidos disponíveis','detalhes do pedido','liberar pedido','moedas','comprar moedas','custo em moedas','exclusividade','pedido exclusivo','pedidos aceitos','realizados','não realizados','Mentoria MPR']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M11.A04-01', 'principal', 1, 11, 'V1.M11.A04 — O Ciclo da Realização: Como Receber', 'Visão geral', 'O Ciclo da Realização: Como Receber', 'Método Sócia Invisível › Módulo 11 – Liberdade Financeira com as Demandas › Aula 04 – O Ciclo da Realização: Como Receber › Visão geral da aula

Nome oficial da aula: O Ciclo da Realização: Como Receber
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 11 – Liberdade Financeira com as Demandas, Aula 04
Duração/formato: 1:29
Link na área de membros (abre a página do Módulo 11, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/11

Resumo:
É uma aula curta que explica como se recebe no GetNinjas. Diferente das outras plataformas do curso, o GetNinjas não intermedeia o pagamento e não cobra taxa sobre o serviço. Depois de liberar o pedido com moedas, a aluna tem o contato do cliente (WhatsApp, e-mail), combina tudo diretamente e recebe direto na conta dela, às vezes no mesmo dia. A recomendação da aula é cobrar 50% antes e 50% na entrega.', 'approved', ARRAY['GetNinjas','Get Ninjas','como receber','receber direto do cliente','sem taxa','sem intermediação','50% antes','50% na entrega','sinal','pagamento adiantado','moedas','moedinhas','liberar pedido','WhatsApp','contato do cliente']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M11.A04-02', 'principal', 1, 11, 'V1.M11.A04 — O Ciclo da Realização: Como Receber', 'Procedimento: passo a passo', 'O Ciclo da Realização: Como Receber', 'Método Sócia Invisível › Módulo 11 – Liberdade Financeira com as Demandas › Aula 04 – O Ciclo da Realização: Como Receber › Procedimento: passo a passo

1. Liberar o pedido com moedas para receber o contato do cliente (ver a Aula 03).
2. Combinar direto com o cliente, por WhatsApp ou e-mail: serviço, valor, prazo e forma de pagamento.
3. Cobrar 50% antes de começar e 50% na entrega. É a recomendação da aula.
4. Receber direto na sua conta, na forma combinada, como Pix ou transferência. O valor fica 100% com a aluna, sem taxa da plataforma.', 'approved', ARRAY['GetNinjas','Get Ninjas','como receber','receber direto do cliente','sem taxa','sem intermediação','50% antes','50% na entrega','sinal','pagamento adiantado','moedas','moedinhas','liberar pedido','WhatsApp','contato do cliente']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M11.A04-03', 'principal', 1, 11, 'V1.M11.A04 — O Ciclo da Realização: Como Receber', 'GetNinjas × outras plataformas: recebimento', 'O Ciclo da Realização: Como Receber', 'Método Sócia Invisível › Módulo 11 – Liberdade Financeira com as Demandas › Aula 04 – O Ciclo da Realização: Como Receber › GetNinjas × outras plataformas: recebimento

| Plataforma | Quem intermedeia o pagamento | Taxa sobre o serviço | Custo para a aluna |
|---|---|---|---|
| 99Freelas (M07) | A plataforma | Sim (~20% no plano grátis) | Planos opcionais |
| Workana (M08) | A plataforma (com custódia) | Sim (20%, mostrado na Aula 04 do M08) | Planos opcionais |
| Vinte Pila (M10) | A plataforma | Ver M10 | — |
| GetNinjas (M11) | Ninguém: é direto com o cliente | Não | Moedas para liberar cada pedido |', 'approved', ARRAY['GetNinjas','Get Ninjas','como receber','receber direto do cliente','sem taxa','sem intermediação','50% antes','50% na entrega','sinal','pagamento adiantado','moedas','moedinhas','liberar pedido','WhatsApp','contato do cliente']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M11.A04-04', 'principal', 1, 11, 'V1.M11.A04 — O Ciclo da Realização: Como Receber', 'FAQ', 'O Ciclo da Realização: Como Receber', 'Método Sócia Invisível › Módulo 11 – Liberdade Financeira com as Demandas › Aula 04 – O Ciclo da Realização: Como Receber › Pontos para o suporte

- "Como recebo no GetNinjas?" Direto do cliente, no valor e na forma combinados (Pix, transferência). O GetNinjas não cobra taxa sobre o serviço.
- "Quando recebo?" Quando for combinado com o cliente. A aula recomenda 50% antes de começar e 50% na entrega.
- "O cliente não pagou." Como o pagamento não passa pela plataforma, não há garantia do GetNinjas. Orientar: sempre pedir o sinal de 50% antes, combinar por escrito e só entregar o arquivo final depois do pagamento restante. Se houver problema, a aluna pode reportar o cliente ao suporte do GetNinjas.
- "Vale a pena comprar moedas?" A aula diz que "compensa bastante". Orientar com cautela: começar com poucas moedas e escolher bem os pedidos (ver a Aula 03).', 'approved', ARRAY['GetNinjas','Get Ninjas','como receber','receber direto do cliente','sem taxa','sem intermediação','50% antes','50% na entrega','sinal','pagamento adiantado','moedas','moedinhas','liberar pedido','WhatsApp','contato do cliente']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M11.A07-01', 'principal', 1, 11, 'V1.M11.A07 — Bônus: Hacks Avançados para o GETNINJAS', 'Visão geral', 'Bônus: Hacks Avançados para o GETNINJAS', 'Método Sócia Invisível › Módulo 11 – Liberdade Financeira com as Demandas › Aula 07 – Bônus: Hacks Avançados para o GETNINJAS › Visão geral da aula

Nome oficial da aula: Bônus: Hacks Avançados para o GETNINJAS
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 11 – Liberdade Financeira com as Demandas, Aula 07
Duração/formato: 7:36
Link na área de membros (abre a página do Módulo 11, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/11

Resumo:
A aula reúne 12 hacks para usar o GetNinjas de forma estratégica: escolher bem os pedidos antes de gastar moedas, escrever mensagens que vendem, usar templates, reativar clientes antigos, oferecer pacotes, observar horários e tendências, e caprichar no pós-atendimento. Termina com um exercício prático de 4 passos. O Hack 1 responde ao principal risco apontado nas aulas anteriores do módulo, o gasto de moedas sem retorno.', 'approved', ARRAY['GetNinjas','Get Ninjas','hacks avançados','estratégias','segredinhos','créditos','moedas','escolher pedidos','pitch','mensagem de proposta','templates de resposta','campo de perguntas','reativar contatos','clientes antigos','escassez','urgência','vagas limitadas','pacotes','ticket médio','horários de maior movimento','tendências na região','pós-atendimento']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M11.A07-02', 'principal', 1, 11, 'V1.M11.A07 — Bônus: Hacks Avançados para o GETNINJAS', 'Os 12 hacks', 'Bônus: Hacks Avançados para o GETNINJAS', 'Método Sócia Invisível › Módulo 11 – Liberdade Financeira com as Demandas › Aula 07 – Bônus: Hacks Avançados para o GETNINJAS › Os 12 hacks

### Antes de gastar moedas
| # | Hack | Como aplicar |
|---|---|---|
| 1 | Escolher bem os pedidos | Não responder a tudo, porque cada resposta gasta moedas. Perguntar-se: a pessoa sabe o que quer? É algo que eu faço bem? O valor compensa o meu tempo? Só liberar se as 3 respostas forem sim. |
| 10 | Horários de maior movimento | Segundo a aula, início da manhã e fim da tarde. Estar disponível para responder rápido. |
| 11 | Tendências da região | Observar quais serviços são mais pedidos na região e destacar esses no perfil e nas mensagens. |
### Como abordar o cliente
| # | Hack | Como aplicar |
|---|---|---|
| 2 | Mensagem como pitch | Nada de "Oi, faço esse trabalho, vamos conversar?". Mostrar que entendeu o problema, que tem experiência e que está pronta para ajudar. |
| 3 | Campo de perguntas | Perguntar antes da proposta: "Você já tem ideia do prazo? Qual o objetivo principal?" |
| 4 | Clientes indecisos | Diante de um pedido vago: "Se quiser, posso te ajudar a entender melhor o que você precisa e criar uma solução personalizada." |
| 5 | Templates personalizáveis | Ter modelos prontos (um para "algo rápido" e outro para "algo sob medida") e ajustar a cada pedido. |
| 7 | Escassez e urgência | "Tenho espaço na agenda para começar hoje, mas as vagas são limitadas." |
| 8 | Avaliações como prova social | Quem já tem avaliações: "Você pode conferir as avaliações no meu perfil." |
### Aumentar o faturamento e fidelizar
| # | Hack | Como aplicar |
|---|---|---|
| 6 | Reativar contatos | Voltar a falar com quem já contratou: "Vi que já trabalhamos juntos. Precisa de algo mais agora?", oferecendo algo novo ou uma promoção. |
| 9 | Pacotes | Exemplos: até 5 planilhas por R$ 200; até 3 textos revisados por R$ 100. Aumenta o valor médio por cliente. |
| 12 | Pós-atendimento impecável | Depois de entregar: "Obrigada pela oportunidade. Se precisar de algo mais, estou à disposição." |', 'approved', ARRAY['GetNinjas','Get Ninjas','hacks avançados','estratégias','segredinhos','créditos','moedas','escolher pedidos','pitch','mensagem de proposta','templates de resposta','campo de perguntas','reativar contatos','clientes antigos','escassez','urgência','vagas limitadas','pacotes','ticket médio','horários de maior movimento','tendências na região','pós-atendimento']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M11.A07-03', 'principal', 1, 11, 'V1.M11.A07 — Bônus: Hacks Avançados para o GETNINJAS', 'Exercício prático', 'Bônus: Hacks Avançados para o GETNINJAS', 'Método Sócia Invisível › Módulo 11 – Liberdade Financeira com as Demandas › Aula 07 – Bônus: Hacks Avançados para o GETNINJAS › Exercício prático

1. Revisar os pedidos abertos e escolher os 3 com mais potencial (usando o Hack 1).
2. Escrever mensagens personalizadas para eles com as dicas da aula.
3. Enviar uma mensagem de reativação para alguém com quem já trabalhou, oferecendo algo novo ou um pacote.
4. Organizar-se para os horários de maior movimento.', 'approved', ARRAY['GetNinjas','Get Ninjas','hacks avançados','estratégias','segredinhos','créditos','moedas','escolher pedidos','pitch','mensagem de proposta','templates de resposta','campo de perguntas','reativar contatos','clientes antigos','escassez','urgência','vagas limitadas','pacotes','ticket médio','horários de maior movimento','tendências na região','pós-atendimento']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M11.A07-04', 'principal', 1, 11, 'V1.M11.A07 — Bônus: Hacks Avançados para o GETNINJAS', 'FAQ', 'Bônus: Hacks Avançados para o GETNINJAS', 'Método Sócia Invisível › Módulo 11 – Liberdade Financeira com as Demandas › Aula 07 – Bônus: Hacks Avançados para o GETNINJAS › Pontos para o suporte

- "Estou gastando moedas e não fecho nada." Indicar o Hack 1: só liberar pedidos que a aluna faz bem, com cliente que sabe o que quer e valor que compense. Também revisar se a mensagem segue o Hack 2 (pitch) e não é genérica.
- "O que escrevo para o cliente?" Usar os modelos dos Hacks 2, 4 e 5, adaptando a cada pedido.
- "Como consigo mais clientes sem gastar moedas?" Reativar quem já contratou (Hack 6) e caprichar no pós-atendimento (Hack 12).
- "Qual o melhor horário?" Segundo a aula, início da manhã e fim da tarde.', 'approved', ARRAY['GetNinjas','Get Ninjas','hacks avançados','estratégias','segredinhos','créditos','moedas','escolher pedidos','pitch','mensagem de proposta','templates de resposta','campo de perguntas','reativar contatos','clientes antigos','escassez','urgência','vagas limitadas','pacotes','ticket médio','horários de maior movimento','tendências na região','pós-atendimento']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M12.A01-01', 'principal', 1, 12, 'V1.M12.A01 — O Código das Demandas no VINTE CONTO', 'Visão geral', 'O Código das Demandas no VINTE CONTO', 'Método Sócia Invisível › Módulo 12 – Desbravando as Demandas › Aula 01 – O Código das Demandas no VINTE CONTO › Visão geral da aula

Nome oficial da aula: O Código das Demandas no VINTE CONTO
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 12 – Desbravando as Demandas, Aula 01
Duração/formato: 3:45
Link na área de membros (abre a página do Módulo 12, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/12

Resumo:
É a abertura do Módulo 12, que apresenta uma quinta plataforma: o Vinte Conto, chamado na aula de "plataforma secreta 2". Segundo a aula, é uma plataforma brasileira que conecta empresas e empreendedores a profissionais de microprojetos online, com valor fixo, pagamento pela própria plataforma e foco em iniciantes. A aula é introdutória e cita que "muitas executivas conseguiram os primeiros lucros em menos de uma semana". O cadastro fica para a Aula 02.', 'approved', ARRAY['Vinte Conto','VinteConto','20 conto','Desbravando as demandas','plataforma secreta 2','plataforma secreta','O código das sub demandas no Vinte Conto','Mentoria Projetos Remunerados','Projetos Imunerados']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M12.A01-02', 'principal', 1, 12, 'V1.M12.A01 — O Código das Demandas no VINTE CONTO', 'O que a aula diz sobre o Vinte Conto', 'O Código das Demandas no VINTE CONTO', 'Método Sócia Invisível › Módulo 12 – Desbravando as Demandas › Aula 01 – O Código das Demandas no VINTE CONTO › O que a aula diz sobre o Vinte Conto

- Como funciona (segundo a aula): as empresas publicam projetos, a aluna se candidata, entrega e recebe pela plataforma.
- Exemplos de projetos:
  - posts para redes sociais;
  - digitação de textos;
  - pesquisa de informações online;
  - artes simples no Canva;
  - revisão de conteúdos;
  - organização de arquivos e documentos.
- Por que é boa para iniciantes:
  - plataforma nacional, com comunicação simples;
  - valor fixo: a aluna já sabe quanto vai receber;
  - boa para testar habilidades e montar portfólio;
  - ambiente leve e colaborativo;
  - dá para começar com pouco tempo por dia.
- Expectativa (dita na aula): "Talvez você não fature milhares na primeira semana, mas o Vinte Conto é excelente para construir ritmo, prática e reputação."', 'approved', ARRAY['Vinte Conto','VinteConto','20 conto','Desbravando as demandas','plataforma secreta 2','plataforma secreta','O código das sub demandas no Vinte Conto','Mentoria Projetos Remunerados','Projetos Imunerados']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M12.A01-03', 'principal', 1, 12, 'V1.M12.A01 — O Código das Demandas no VINTE CONTO', 'O que a próxima aula promete', 'O Código das Demandas no VINTE CONTO', 'Método Sócia Invisível › Módulo 12 – Desbravando as Demandas › Aula 01 – O Código das Demandas no VINTE CONTO › O que a próxima aula promete

Passo a passo na tela do computador para:
1. se cadastrar;
2. criar um perfil estratégico;
3. encontrar e se candidatar aos melhores microprojetos;
4. entregar o serviço e receber.', 'approved', ARRAY['Vinte Conto','VinteConto','20 conto','Desbravando as demandas','plataforma secreta 2','plataforma secreta','O código das sub demandas no Vinte Conto','Mentoria Projetos Remunerados','Projetos Imunerados']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M12.A01-04', 'principal', 1, 12, 'V1.M12.A01 — O Código das Demandas no VINTE CONTO', 'Procedimento: o que a aluna deve fazer', 'O Código das Demandas no VINTE CONTO', 'Método Sócia Invisível › Módulo 12 – Desbravando as Demandas › Aula 01 – O Código das Demandas no VINTE CONTO › Procedimento: o que a aluna deve fazer

1. Assistir à aula para conhecer o Vinte Conto. Não há ação prática.
2. Seguir para a Aula 02 do Módulo 12.', 'approved', ARRAY['Vinte Conto','VinteConto','20 conto','Desbravando as demandas','plataforma secreta 2','plataforma secreta','O código das sub demandas no Vinte Conto','Mentoria Projetos Remunerados','Projetos Imunerados']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M12.A01-05', 'principal', 1, 12, 'V1.M12.A01 — O Código das Demandas no VINTE CONTO', 'FAQ', 'O Código das Demandas no VINTE CONTO', 'Método Sócia Invisível › Módulo 12 – Desbravando as Demandas › Aula 01 – O Código das Demandas no VINTE CONTO › Pontos para o suporte

- "O que é o Vinte Conto?" Uma plataforma brasileira de microprojetos online com valores fixos, voltada a iniciantes (segundo a aula). Pagamento pela plataforma.
- "O Vinte Conto é do método?" Não. É uma plataforma independente.
- "Quanto a plataforma cobra? Quando recebo?" A aula não informa.
- "Não recebi meu saque do Vinte Conto." Orientar a aluna a contatar o suporte da plataforma.', 'approved', ARRAY['Vinte Conto','VinteConto','20 conto','Desbravando as demandas','plataforma secreta 2','plataforma secreta','O código das sub demandas no Vinte Conto','Mentoria Projetos Remunerados','Projetos Imunerados']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M12.A02-01', 'principal', 1, 12, 'V1.M12.A02 — Construindo Sua Vitrine Digital no VINTE CONTO', 'Visão geral', 'Construindo Sua Vitrine Digital no VINTE CONTO', 'Método Sócia Invisível › Módulo 12 – Desbravando as Demandas › Aula 02 – Construindo Sua Vitrine Digital no VINTE CONTO › Visão geral da aula

Nome oficial da aula: Construindo Sua Vitrine Digital no VINTE CONTO
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 12 – Desbravando as Demandas, Aula 02
Duração/formato: 1:09
Link na área de membros (abre a página do Módulo 12, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/12

Resumo:
É uma aula curtíssima, com gravação de tela, que ensina a criar a conta no Vinte Conto (nome, e-mail e senha) e explica a diferença da plataforma: o cliente vem até você. Em vez de procurar projetos e enviar propostas, a aluna cadastra os serviços que oferece, como numa vitrine ou portfólio, e o cliente a encontra e contrata. O cadastro dos serviços fica para a Aula 03.', 'approved', ARRAY['Vinte Conto','VinteConto','20 conto','registrar','criar conta','o cliente vem até você','cadastrar microprojetos','portfólio','Mentoria Projetos Remunerados']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M12.A02-02', 'principal', 1, 12, 'V1.M12.A02 — Construindo Sua Vitrine Digital no VINTE CONTO', 'Procedimento: passo a passo', 'Construindo Sua Vitrine Digital no VINTE CONTO', 'Método Sócia Invisível › Módulo 12 – Desbravando as Demandas › Aula 02 – Construindo Sua Vitrine Digital no VINTE CONTO › Procedimento: passo a passo

1. Pesquisar "Vinte Conto" no Google e abrir o primeiro resultado.
2. Clicar em "Registrar", no topo da página.
3. Preencher nome, e-mail e senha.
4. Pronto, a conta está criada. O próximo passo é cadastrar os serviços (Aula 03).', 'approved', ARRAY['Vinte Conto','VinteConto','20 conto','registrar','criar conta','o cliente vem até você','cadastrar microprojetos','portfólio','Mentoria Projetos Remunerados']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M12.A02-03', 'principal', 1, 12, 'V1.M12.A02 — Construindo Sua Vitrine Digital no VINTE CONTO', 'Como a plataforma funciona (segundo esta aula)', 'Construindo Sua Vitrine Digital no VINTE CONTO', 'Método Sócia Invisível › Módulo 12 – Desbravando as Demandas › Aula 02 – Construindo Sua Vitrine Digital no VINTE CONTO › Como a plataforma funciona (segundo esta aula)

| Outras plataformas (99Freelas, Workana, GetNinjas) | Vinte Conto |
|---|---|
| A aluna procura projetos e envia propostas ou libera pedidos | A aluna cadastra os seus serviços e o cliente vem até ela |
O modelo é parecido com o do Vinte Pila (M10).', 'approved', ARRAY['Vinte Conto','VinteConto','20 conto','registrar','criar conta','o cliente vem até você','cadastrar microprojetos','portfólio','Mentoria Projetos Remunerados']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M12.A02-04', 'principal', 1, 12, 'V1.M12.A02 — Construindo Sua Vitrine Digital no VINTE CONTO', 'FAQ', 'Construindo Sua Vitrine Digital no VINTE CONTO', 'Método Sócia Invisível › Módulo 12 – Desbravando as Demandas › Aula 02 – Construindo Sua Vitrine Digital no VINTE CONTO › Pontos para o suporte

- "Como me cadastro no Vinte Conto?" Google › "Vinte Conto" › Registrar › nome, e-mail e senha.
- "Onde procuro projetos no Vinte Conto?" Não é preciso procurar: a aluna publica os serviços que oferece e os clientes a encontram. O cadastro dos serviços está na Aula 03 deste módulo.
- "Qual a diferença entre Vinte Conto e Vinte Pila?" São plataformas diferentes, com funcionamento parecido: nas duas a aluna publica os serviços.', 'approved', ARRAY['Vinte Conto','VinteConto','20 conto','registrar','criar conta','o cliente vem até você','cadastrar microprojetos','portfólio','Mentoria Projetos Remunerados']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M12.A03-01', 'principal', 1, 12, 'V1.M12.A03 — O Ciclo da Realização: Como Receber', 'Visão geral', 'O Ciclo da Realização: Como Receber', 'Método Sócia Invisível › Módulo 12 – Desbravando as Demandas › Aula 03 – O Ciclo da Realização: Como Receber › Visão geral da aula

Nome oficial da aula: O Ciclo da Realização: Como Receber
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 12 – Desbravando as Demandas, Aula 03
Duração/formato: 1:09
Link na área de membros (abre a página do Módulo 12, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/12

Resumo:
É uma aula curtíssima, com gravação de tela, que ensina a cadastrar a chave Pix no Vinte Conto para receber pelos microprojetos. A aula menciona que a plataforma pode cobrar uma "taxinha" sobre os serviços, mas não confirma o valor.', 'approved', ARRAY['Vinte Conto','Vinte e Conto','VinteConto','como receber','dados de pagamento','chave Pix','taxa','taxinha','salvar preferências']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M12.A03-02', 'principal', 1, 12, 'V1.M12.A03 — O Ciclo da Realização: Como Receber', 'Procedimento: passo a passo', 'O Ciclo da Realização: Como Receber', 'Método Sócia Invisível › Módulo 12 – Desbravando as Demandas › Aula 03 – O Ciclo da Realização: Como Receber › Procedimento: passo a passo

1. Clicar no seu nome, no topo da página.
2. Ir em "Pagamentos".
3. Cadastrar a chave Pix.
4. Clicar em Salvar preferências. Aparece a confirmação de que os detalhes de pagamento foram atualizados.
5. A partir daí, cada microprojeto feito é pago dentro da plataforma, via Pix.', 'approved', ARRAY['Vinte Conto','Vinte e Conto','VinteConto','como receber','dados de pagamento','chave Pix','taxa','taxinha','salvar preferências']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M12.A03-03', 'principal', 1, 12, 'V1.M12.A03 — O Ciclo da Realização: Como Receber', 'FAQ', 'O Ciclo da Realização: Como Receber', 'Método Sócia Invisível › Módulo 12 – Desbravando as Demandas › Aula 03 – O Ciclo da Realização: Como Receber › Pontos para o suporte

- "Como cadastro meu Pix no Vinte Conto?" Clicar no seu nome › Pagamentos › chave Pix › Salvar preferências.
- "O Vinte Conto cobra taxa?" A aula diz que pode cobrar uma taxa sobre os serviços. Confirmar no site.
- "Quando recebo?" A aula não informa. Confirmar no site.
- "Não recebi meu pagamento." Conferir se a chave Pix foi salva corretamente e orientar a aluna a contatar o suporte do Vinte Conto.', 'approved', ARRAY['Vinte Conto','Vinte e Conto','VinteConto','como receber','dados de pagamento','chave Pix','taxa','taxinha','salvar preferências']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M12.A04-01', 'principal', 1, 12, 'V1.M12.A04 — Cadastro Inteligente de Demandas', 'Visão geral', 'Cadastro Inteligente de Demandas', 'Método Sócia Invisível › Módulo 12 – Desbravando as Demandas › Aula 04 – Cadastro Inteligente de Demandas › Visão geral da aula

Nome oficial da aula: Cadastro Inteligente de Demandas
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 12 – Desbravando as Demandas, Aula 04
Duração/formato: 4:24
Link na área de membros (abre a página do Módulo 12, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/12

Resumo:
É uma aula prática, com gravação de tela, que ensina a publicar o primeiro serviço (microprojeto) no Vinte Conto e a editar o perfil. É o conteúdo que a Aula 02 prometia e que a Aula 03 dizia já ter sido ensinado. No Vinte Conto, o cliente pesquisa e encontra o serviço da aluna, sem que ela precise enviar propostas. Por isso, esta publicação é a vitrine.', 'approved', ARRAY['Vinte Conto','20 Conto','VinteConto','Cadastro inteligente de sub demandas','cadastrar serviço','publicar microprojeto','criar serviço','oferecer meu serviço','categoria','assistente virtual','título','descrição','crie e continue','valor','tags','palavras-chave','prazo de entrega','instruções','revisões','limitado','ilimitado','serviço adicional','extras','salvar e publicar','editar perfil','bio','mudar senha','histórico de pedidos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M12.A04-02', 'principal', 1, 12, 'V1.M12.A04 — Cadastro Inteligente de Demandas', 'Procedimento: passo a passo', 'Cadastro Inteligente de Demandas', 'Método Sócia Invisível › Módulo 12 – Desbravando as Demandas › Aula 04 – Cadastro Inteligente de Demandas › Procedimento: passo a passo

### Parte 1: Publicar o serviço
1. Com o login feito, clicar em "Oferecer meu serviço".
2. Escolher uma categoria: marketing digital, escrita, tradução etc. Exemplo da aula: Assistente virtual, "para abranger várias áreas".
3. Título. Exemplo: "Eu vou atender os seus clientes no WhatsApp".
4. Descrição do que será feito. A aula cola um texto guardado nas notas do celular. Se o serviço envolver imagem, é possível adicionar.
5. Clicar em "Crie e continue". Aparece um aviso do que pode e não pode ser oferecido.
6. Valor. O padrão da plataforma é R$ 20. A aula sugere começar com valor baixo para construir o perfil e depois cobrar mais conforme a complexidade.
7. Tags (palavras-chave) que o cliente usaria na busca. Exemplo: atendimento, suporte, WhatsApp.
8. Prazo de entrega: 1, 2, 5 dias etc.
9. Instruções e exemplo do trabalho: anexar um modelo, template ou arte que represente o que você entrega.
10. Revisões: definir quantas o cliente pode pedir (limitadas ou ilimitadas).
11. Serviços adicionais (extras). Exemplo: além do WhatsApp, atender também no Instagram.
12. Salvar e publicar.
Outros exemplos de serviço citados: "criar um currículo atrativo", "corrigir e revisar o seu texto com qualidade e rapidez". A aluna pode publicar vários serviços, começando pelos mais simples e evoluindo para pacotes.
### Parte 2: Editar o perfil
1. Clicar no seu nome › editar perfil.
2. Escrever uma bio. Exemplo: "Sou assistente virtual, desenvolvo funções administrativas."
3. Salvar o perfil. Toda alteração precisa ser salva.
4. No menu lateral: mudar a senha, histórico de pedidos, favoritos, lista dos seus microprojetos e pagamentos.
### Depois de publicar
O cliente pesquisa, encontra o serviço e entra em contato pela plataforma. Segundo a aula, "o segredo está na divulgação constante e no capricho das entregas".', 'approved', ARRAY['Vinte Conto','20 Conto','VinteConto','Cadastro inteligente de sub demandas','cadastrar serviço','publicar microprojeto','criar serviço','oferecer meu serviço','categoria','assistente virtual','título','descrição','crie e continue','valor','tags','palavras-chave','prazo de entrega','instruções','revisões','limitado','ilimitado','serviço adicional','extras','salvar e publicar','editar perfil','bio','mudar senha','histórico de pedidos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M12.A04-03', 'principal', 1, 12, 'V1.M12.A04 — Cadastro Inteligente de Demandas', 'Dicas para usar com as aulas anteriores', 'Cadastro Inteligente de Demandas', 'Método Sócia Invisível › Módulo 12 – Desbravando as Demandas › Aula 04 – Cadastro Inteligente de Demandas › Dicas para usar com as aulas anteriores

- Título e descrição: usar a linguagem profissional (M06 A02) e a lógica de resultado do Bônus 01 (M07 A05).
- Exemplo de trabalho: usar os cases e o portfólio do M06 A04, identificando os projetos de estudo como tal.
- Tags: usar as palavras exatas que o cliente usaria (Hack 9 do Bônus 02, M07 A06).', 'approved', ARRAY['Vinte Conto','20 Conto','VinteConto','Cadastro inteligente de sub demandas','cadastrar serviço','publicar microprojeto','criar serviço','oferecer meu serviço','categoria','assistente virtual','título','descrição','crie e continue','valor','tags','palavras-chave','prazo de entrega','instruções','revisões','limitado','ilimitado','serviço adicional','extras','salvar e publicar','editar perfil','bio','mudar senha','histórico de pedidos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M12.A04-04', 'principal', 1, 12, 'V1.M12.A04 — Cadastro Inteligente de Demandas', 'FAQ', 'Cadastro Inteligente de Demandas', 'Método Sócia Invisível › Módulo 12 – Desbravando as Demandas › Aula 04 – Cadastro Inteligente de Demandas › Pontos para o suporte

- "Como publico meu serviço no Vinte Conto?" Oferecer meu serviço › categoria › título › descrição › "Crie e continue" › valor › tags › prazo › exemplo › revisões › extras › Salvar e publicar.
- "Quanto cobro?" O padrão é R$ 20. A aula sugere começar baixo para construir o perfil e aumentar depois.
- "Ninguém me contratou ainda." Conferir se o serviço está publicado, se as tags têm as palavras que o cliente buscaria e se o título deixa o resultado claro. Publicar mais de um serviço também ajuda.
- "Onde edito a bio ou mudo a senha?" Clicar no seu nome › editar perfil. Salvar sempre depois de alterar.', 'approved', ARRAY['Vinte Conto','20 Conto','VinteConto','Cadastro inteligente de sub demandas','cadastrar serviço','publicar microprojeto','criar serviço','oferecer meu serviço','categoria','assistente virtual','título','descrição','crie e continue','valor','tags','palavras-chave','prazo de entrega','instruções','revisões','limitado','ilimitado','serviço adicional','extras','salvar e publicar','editar perfil','bio','mudar senha','histórico de pedidos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M13.A02-01', 'principal', 1, 13, 'V1.M13.A02 — Construindo Sua Vitrine Digital no FREELANCER', 'Visão geral', 'Construindo Sua Vitrine Digital no FREELANCER', 'Método Sócia Invisível › Módulo 13 – O Radar Digital das Demandas Lucrativas › Aula 02 – Construindo Sua Vitrine Digital no FREELANCER › Visão geral da aula

Nome oficial da aula: Construindo Sua Vitrine Digital no FREELANCER
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 13 – O Radar Digital das Demandas Lucrativas, Aula 02
Duração/formato: 2:41
Link na área de membros (abre a página do Módulo 13, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/13

Resumo:
É uma aula prática, com gravação de tela, que ensina a criar a conta de freelancer no Freelancer.com e montar o perfil inicial: nome de usuário, tipo de conta, categoria, até 20 habilidades, foto, descrição, idiomas e data de nascimento. Termina com a verificação do e-mail. A busca por projetos fica para a Aula 04.', 'approved', ARRAY['Freelancer','Freelancer.com','www.freelancer.com','passarinho azul','inscrever-se','nome de usuário','username','eu quero trabalhar','eu quero contratar','tipo de conta','categoria','subcategorias','até 20 habilidades','entrada de dados','Excel','suporte ao cliente','Microsoft Office','vincular Facebook','LinkedIn','pular','foto de perfil','descrição','bloco de notas','idiomas','data de nascimento','verificar e-mail','ativar conta','traduzir para português','três pontinhos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M13.A02-02', 'principal', 1, 13, 'V1.M13.A02 — Construindo Sua Vitrine Digital no FREELANCER', 'Procedimento: passo a passo', 'Construindo Sua Vitrine Digital no FREELANCER', 'Método Sócia Invisível › Módulo 13 – O Radar Digital das Demandas Lucrativas › Aula 02 – Construindo Sua Vitrine Digital no FREELANCER › Procedimento: passo a passo

1. No Google, digitar www.freelancer.com e abrir o site (ícone de passarinho azul).
2. O site é em inglês. Para traduzir, clicar nos três pontinhos do navegador › Traduzir para português.
3. Clicar em Inscrever-se e preencher nome, sobrenome, e-mail e senha, ou entrar com o Google. Clicar em Eu concordo.
4. Escolher o nome de usuário. Algo simples, sem muitos números. Exemplo da aula: "Gabriela30".
5. Tipo de conta: escolher "Eu quero trabalhar".
6. Categoria: escolher conforme as habilidades (design, negócios, computação, comércio etc.). Exemplo da aula: Entrada de dados.
7. Habilidades (subcategorias): selecionar até 20. Exemplos: Excel, entrada de dados, suporte ao cliente, atendimento ao cliente, Microsoft Office. Clicar em Prosseguir.
8. Vincular Facebook ou LinkedIn (opcional). Dá para pular.
9. Foto de perfil: rosto bem visível, sorrindo, com boa iluminação. Confirmar o nome.
10. Descrição: colar um texto pronto sobre você, guardado no bloco de notas.
11. Idiomas: português e outros que fale, como inglês.
12. Data de nascimento no formato americano: mês / dia / ano.
13. Verificar o e-mail: abrir o e-mail do Freelancer.com e clicar para ativar a conta.', 'approved', ARRAY['Freelancer','Freelancer.com','www.freelancer.com','passarinho azul','inscrever-se','nome de usuário','username','eu quero trabalhar','eu quero contratar','tipo de conta','categoria','subcategorias','até 20 habilidades','entrada de dados','Excel','suporte ao cliente','Microsoft Office','vincular Facebook','LinkedIn','pular','foto de perfil','descrição','bloco de notas','idiomas','data de nascimento','verificar e-mail','ativar conta','traduzir para português','três pontinhos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M13.A02-03', 'principal', 1, 13, 'V1.M13.A02 — Construindo Sua Vitrine Digital no FREELANCER', 'Dicas para usar com as aulas anteriores', 'Construindo Sua Vitrine Digital no FREELANCER', 'Método Sócia Invisível › Módulo 13 – O Radar Digital das Demandas Lucrativas › Aula 02 – Construindo Sua Vitrine Digital no FREELANCER › Dicas para usar com as aulas anteriores

- Descrição: adaptar o elevator pitch (M06 A02).
- Habilidades: usar o mapeamento dos 5 círculos (M06 A01).
- Foto: seguir o Hack 1 do Bônus 02 (M07 A06): luz natural, fundo neutro, sem selfie.', 'approved', ARRAY['Freelancer','Freelancer.com','www.freelancer.com','passarinho azul','inscrever-se','nome de usuário','username','eu quero trabalhar','eu quero contratar','tipo de conta','categoria','subcategorias','até 20 habilidades','entrada de dados','Excel','suporte ao cliente','Microsoft Office','vincular Facebook','LinkedIn','pular','foto de perfil','descrição','bloco de notas','idiomas','data de nascimento','verificar e-mail','ativar conta','traduzir para português','três pontinhos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M13.A02-04', 'principal', 1, 13, 'V1.M13.A02 — Construindo Sua Vitrine Digital no FREELANCER', 'FAQ', 'Construindo Sua Vitrine Digital no FREELANCER', 'Método Sócia Invisível › Módulo 13 – O Radar Digital das Demandas Lucrativas › Aula 02 – Construindo Sua Vitrine Digital no FREELANCER › Pontos para o suporte

- "Como me cadastro no Freelancer.com?" freelancer.com › Inscrever-se (ou entrar com o Google) › nome de usuário › "Eu quero trabalhar" › categoria › até 20 habilidades › foto › descrição › idiomas › data de nascimento › verificar o e-mail.
- "O site está em inglês." Traduzir pelo navegador (três pontinhos › Traduzir) ou mudar o idioma da conta (Aula 03 deste módulo).
- "Errei a data de nascimento." No Freelancer.com, o formato é mês/dia/ano. Corrigir no perfil.
- "Não consigo usar a conta / mandar proposta." Conferir se o e-mail foi verificado.
- "Preciso vincular Facebook ou LinkedIn?" Não, é opcional.', 'approved', ARRAY['Freelancer','Freelancer.com','www.freelancer.com','passarinho azul','inscrever-se','nome de usuário','username','eu quero trabalhar','eu quero contratar','tipo de conta','categoria','subcategorias','até 20 habilidades','entrada de dados','Excel','suporte ao cliente','Microsoft Office','vincular Facebook','LinkedIn','pular','foto de perfil','descrição','bloco de notas','idiomas','data de nascimento','verificar e-mail','ativar conta','traduzir para português','três pontinhos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M13.A03-01', 'principal', 1, 13, 'V1.M13.A03 — O Ciclo da Realização: Como Receber', 'Visão geral', 'O Ciclo da Realização: Como Receber', 'Método Sócia Invisível › Módulo 13 – O Radar Digital das Demandas Lucrativas › Aula 03 – O Ciclo da Realização: Como Receber › Visão geral da aula

Nome oficial da aula: O Ciclo da Realização: Como Receber
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 13 – O Radar Digital das Demandas Lucrativas, Aula 03
Duração/formato: 1:58
Link na área de membros (abre a página do Módulo 13, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/13

Resumo:
É uma aula curta, com gravação de tela, que mostra que no Freelancer.com não é possível sacar o dinheiro sem antes completar os dados da conta. A aluna aprende a preencher endereço, empresa, fuso horário e localização e a configurar o site em português. O cadastro do meio de saque em si fica para a próxima aula.', 'approved', ARRAY['Freelancer','Freelancer.com','como receber','sacar','retirar fundos','Finanças','Withdraw Funds','detalhes da conta','endereço','CEP','empresa','fuso horário','América/São Paulo','idioma','português','navegar em português','salvar configurações']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M13.A03-02', 'principal', 1, 13, 'V1.M13.A03 — O Ciclo da Realização: Como Receber', 'Procedimento: passo a passo', 'O Ciclo da Realização: Como Receber', 'Método Sócia Invisível › Módulo 13 – O Radar Digital das Demandas Lucrativas › Aula 03 – O Ciclo da Realização: Como Receber › Procedimento: passo a passo

1. Ir em Finanças › Retirar fundos. A plataforma avisa que é preciso completar o perfil antes de sacar.
2. Abrir Atualizar detalhes da conta e preencher:
| Campo | O que colocar |
|---|---|
| Nome | Seu nome completo |
| Endereço, cidade, CEP | Seu endereço real |
| País | Brasil |
| Nome da empresa | Pode ser o seu próprio nome |
| Fuso horário | América/São Paulo |
| Localização | Sua localização |
| Idioma do site | Português, para entender tudo |
3. Salvar as configurações. É obrigatório. Depois disso, a opção de saque fica liberada.
4. O cadastro do meio de recebimento é ensinado na próxima aula.', 'approved', ARRAY['Freelancer','Freelancer.com','como receber','sacar','retirar fundos','Finanças','Withdraw Funds','detalhes da conta','endereço','CEP','empresa','fuso horário','América/São Paulo','idioma','português','navegar em português','salvar configurações']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M13.A03-03', 'principal', 1, 13, 'V1.M13.A03 — O Ciclo da Realização: Como Receber', 'FAQ', 'O Ciclo da Realização: Como Receber', 'Método Sócia Invisível › Módulo 13 – O Radar Digital das Demandas Lucrativas › Aula 03 – O Ciclo da Realização: Como Receber › Pontos para o suporte

- "Não consigo sacar no Freelancer.com." Verificar se os detalhes da conta estão completos (endereço, CEP, país, empresa, fuso horário) e salvos. Sem isso, o saque fica bloqueado.
- "O que coloco em ''nome da empresa''?" O seu próprio nome.
- "O site está em inglês." Dá para mudar o idioma para português nas configurações da conta.
- "Como cadastro o PayPal ou o banco?" Ver a próxima aula deste módulo.', 'approved', ARRAY['Freelancer','Freelancer.com','como receber','sacar','retirar fundos','Finanças','Withdraw Funds','detalhes da conta','endereço','CEP','empresa','fuso horário','América/São Paulo','idioma','português','navegar em português','salvar configurações']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M13.A04-01', 'principal', 1, 13, 'V1.M13.A04 — Mapeando as Melhores Demandas para o Seu Perfil', 'Visão geral', 'Mapeando as Melhores Demandas para o Seu Perfil', 'Método Sócia Invisível › Módulo 13 – O Radar Digital das Demandas Lucrativas › Aula 04 – Mapeando as Melhores Demandas para o Seu Perfil › Visão geral da aula

Nome oficial da aula: Mapeando as Melhores Demandas para o Seu Perfil
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 13 – O Radar Digital das Demandas Lucrativas, Aula 04
Duração/formato: 6:21
Link na área de membros (abre a página do Módulo 13, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/13

Resumo:
É uma aula prática, com gravação de tela, que ensina a encontrar projetos no Freelancer.com, usando filtros e a tradução da página pelo navegador. Também mostra como completar o perfil, porque sem isso não dá para enviar proposta, e como fazer uma oferta (lance): valor, prazo, texto da proposta e opções extras como proposta em vídeo, pedido de pré-pagamento e patrocinar a oferta.', 'approved', ARRAY['Freelancer','Freelancer.com','navegar','Browse Projects','filtros','país do cliente','idiomas','traduzir a página','Google Tradutor','oferta','lance','bid','proposta','valor da oferta','prazo','taxa por hora','título profissional','resumo','verificar e-mail','proposta em vídeo','oferta em vídeo','34% mais chance','pré-pagamento','patrocinar oferta','sponsored bid','melhorias','Mentoria Projetos Remunerados']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M13.A04-02', 'principal', 1, 13, 'V1.M13.A04 — Mapeando as Melhores Demandas para o Seu Perfil', 'Procedimento: passo a passo', 'Mapeando as Melhores Demandas para o Seu Perfil', 'Método Sócia Invisível › Módulo 13 – O Radar Digital das Demandas Lucrativas › Aula 04 – Mapeando as Melhores Demandas para o Seu Perfil › Procedimento: passo a passo

### 1. Buscar projetos
1. No Freelancer.com, ir em Navegar › Projetos.
2. Traduzir a página para o português pelo navegador (Google Tradutor). Repetir sempre que algo não estiver traduzido.
3. Usar os filtros da lateral: habilidades, localização do projeto, país do cliente, idiomas.
4. Abrir o projeto e ler valor e moeda (exemplo: € 27) e os requisitos.
  - Exemplo da aula: "Assistente remoto para reuniões com clientes", que exige bom inglês falado e capacidade de fazer anotações.
### 2. Completar o perfil (necessário para enviar proposta)
- Verificar o e-mail.
- Foto de perfil.
- Título profissional. Exemplo da aula: "suporte ao cliente".
- Resumo do que você faz.
- Taxa por hora (quanto quer receber por hora).
- Endereço.
- Salvar. "Quanto mais completo, mais fácil a pessoa te contratar."
### 3. Fazer a oferta
1. No projeto, clicar em fazer oferta.
2. Informar o valor da oferta e o prazo em dias. A aula recomenda "sempre o menor possível".
3. Escrever a proposta. Usar o PDF de propostas disponível na aula, o ChatGPT e as dicas do próprio Freelancer ("como escrever uma oferta vencedora"). Ver também o Bônus 01 do M07 (estrutura de 8 partes).
4. Opções extras:
  - Proposta em vídeo: gravar um vídeo para o cliente. Segundo a plataforma, quem faz isso tem 34% mais chance de ser contratado.
  - Solicitar pré-pagamento: pedir um adiantamento para ter garantia de receber.
 - Patrocinar a oferta: destaque pago.
5. Enviar. Depois é possível editar ou retirar a oferta.', 'approved', ARRAY['Freelancer','Freelancer.com','navegar','Browse Projects','filtros','país do cliente','idiomas','traduzir a página','Google Tradutor','oferta','lance','bid','proposta','valor da oferta','prazo','taxa por hora','título profissional','resumo','verificar e-mail','proposta em vídeo','oferta em vídeo','34% mais chance','pré-pagamento','patrocinar oferta','sponsored bid','melhorias','Mentoria Projetos Remunerados']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M13.A04-03', 'principal', 1, 13, 'V1.M13.A04 — Mapeando as Melhores Demandas para o Seu Perfil', 'FAQ', 'Mapeando as Melhores Demandas para o Seu Perfil', 'Método Sócia Invisível › Módulo 13 – O Radar Digital das Demandas Lucrativas › Aula 04 – Mapeando as Melhores Demandas para o Seu Perfil › Pontos para o suporte

- "Como acho projetos no Freelancer.com?" Navegar › Projetos › traduzir a página › filtros (habilidades, país do cliente, idiomas).
- "Não consigo enviar proposta." Completar o perfil: verificar o e-mail, foto, título, resumo, taxa por hora, endereço. E salvar.
- "O site está em inglês." Traduzir a página pelo navegador ou mudar o idioma da conta para português (Aula 03 deste módulo).
- "Como escrevo a proposta?" Usar o PDF de propostas da aula, o Bônus 01 do M07 e, se quiser, o ChatGPT, revisando o texto antes de enviar.
- "Tenho medo de não receber." Usar a opção de pedir pré-pagamento ao cliente.', 'approved', ARRAY['Freelancer','Freelancer.com','navegar','Browse Projects','filtros','país do cliente','idiomas','traduzir a página','Google Tradutor','oferta','lance','bid','proposta','valor da oferta','prazo','taxa por hora','título profissional','resumo','verificar e-mail','proposta em vídeo','oferta em vídeo','34% mais chance','pré-pagamento','patrocinar oferta','sponsored bid','melhorias','Mentoria Projetos Remunerados']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M13.A05-01', 'principal', 1, 13, 'V1.M13.A05 — Venda PRO: Estratégias Avançadas para Lucrar Mais com Demandas', 'Visão geral', 'Venda PRO: Estratégias Avançadas para Lucrar Mais com Demandas', 'Método Sócia Invisível › Módulo 13 – O Radar Digital das Demandas Lucrativas › Aula 05 – Venda PRO: Estratégias Avançadas para Lucrar Mais com Demandas › Visão geral da aula

Nome oficial da aula: Venda PRO: Estratégias Avançadas para Lucrar Mais com Demandas
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 13 – O Radar Digital das Demandas Lucrativas, Aula 05
Duração/formato: 7:24
Link na área de membros (abre a página do Módulo 13, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/13

Resumo:
A aula traz 8 estratégias para aumentar o faturamento com as demandas, sem trabalhar mais. A ideia é deixar de ver cada entrega como algo isolado e passar a vender soluções, pacotes e serviços recorrentes, além de surpreender e fidelizar. É uma aula geral: vale para qualquer plataforma, não só o Freelancer.com.
"Lucrar mais não é sobre trabalhar mais. É sobre trabalhar de forma mais inteligente."', 'approved', ARRAY['Venda PRO','estratégias avançadas','lucrar mais','solução completa','pacotes','recorrência','renda fixa','mensalidade','algo a mais','surpreender','upgrade','ticket médio','storytelling','histórias','promoções','bônus','resultados concretos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M13.A05-02', 'principal', 1, 13, 'V1.M13.A05 — Venda PRO: Estratégias Avançadas para Lucrar Mais com Demandas', 'Procedimento: as 8 estratégias', 'Venda PRO: Estratégias Avançadas para Lucrar Mais com Demandas', 'Método Sócia Invisível › Módulo 13 – O Radar Digital das Demandas Lucrativas › Aula 05 – Venda PRO: Estratégias Avançadas para Lucrar Mais com Demandas › Procedimento: as 8 estratégias (parte 1 de 2)

### 1. Transformar algo simples em solução completa
Descrever o problema que resolve, não só a tarefa:
| Em vez de… | Ofereça… |
|---|---|
| "Digito textos" | "Transformo áudios ou anotações em documentos organizados e revisados, prontos para impressão ou envio" |
| "Faço slides" | "Crio apresentações visuais e profissionais, com design que impressiona e deixa sua mensagem clara" |
| "Crio artes" | "Crio posts personalizados para suas redes, com visual profissional que chama atenção" |
| "Conserto roupas" | "Faço ajustes e ainda dou dicas para renovar o guarda-roupa sem gastar" |
### 2. Criar pacotes
| Pacote (exemplo da aula) | Preço |
|---|---|
| 5 posts com design profissional, entrega em 3 dias | R$ 150 |
| Transcrição de até 5 áudios ou vídeos curtos, revisada e formatada | R$ 150 |
| Apresentação em PowerPoint com até 15 slides | R$ 200 |
| Kit de identidade visual (logo, cartão de visita, capa para redes) | R$ 300 |
| Revisão e formatação de até 3 trabalhos escolares ou acadêmicos | R$ 120 |
### 3. Recorrência (renda fixa mensal)
| Serviço mensal (exemplo da aula) | Preço/mês |
|---|---|
| Manutenção mensal de roupas (ajustes e consertos) | R$ 150 |
| Organização semanal de documentos e contas da casa | R$ 150 |
| 10 posts mensais com design e textos prontos | R$ 400 |
| Revisão e otimização mensal de textos ou materiais visuais | R$ 250 |
| Apresentações mensais em PowerPoint, até 20 slides | R$ 300 |
### 4. Surpreender com algo a mais
Um extra simples e inesperado. Exemplos:
- lista de dicas para manter documentos organizados;
- slide extra com resumo ou gráfico;
- versão extra de uma arte em outra cor, ou mockup mostrando a arte aplicada;
- sugestão de título mais chamativo num texto revisado.
### 5. Oferecer upgrades
Vender uma continuação do que já foi feito:
- documentos organizados → digitalização;
- apresentação → versão em PDF interativo ou vídeo narrado;
- arte → adaptação para stories, banners, cartões;
- texto revisado → formatação para blog ou redes sociais.
Aumenta o ticket médio.', 'approved', ARRAY['Venda PRO','estratégias avançadas','lucrar mais','solução completa','pacotes','recorrência','renda fixa','mensalidade','algo a mais','surpreender','upgrade','ticket médio','storytelling','histórias','promoções','bônus','resultados concretos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M13.A05-03', 'principal', 1, 13, 'V1.M13.A05 — Venda PRO: Estratégias Avançadas para Lucrar Mais com Demandas', 'Procedimento: as 8 estratégias', 'Venda PRO: Estratégias Avançadas para Lucrar Mais com Demandas', 'Método Sócia Invisível › Módulo 13 – O Radar Digital das Demandas Lucrativas › Aula 05 – Venda PRO: Estratégias Avançadas para Lucrar Mais com Demandas › Procedimento: as 8 estratégias (parte 2 de 2)

### 6. Usar storytelling
Contar histórias reais de resultados de clientes para mostrar o valor do trabalho.
### 7. Promoções estratégicas
"Na compra de X, ganhe Y". Exemplos:
- 5 posts + capa de destaque de bônus;
- logotipo + cartão de visita digital grátis;
- apresentação + slide-resumo extra;
- 20% de desconto na próxima solicitação.
### 8. Mostrar resultados concretos
Mostrar ao cliente o impacto do trabalho: mais engajamento, mensagem mais clara, marca mais profissional. Isso incentiva novas contratações.', 'approved', ARRAY['Venda PRO','estratégias avançadas','lucrar mais','solução completa','pacotes','recorrência','renda fixa','mensalidade','algo a mais','surpreender','upgrade','ticket médio','storytelling','histórias','promoções','bônus','resultados concretos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M13.A05-04', 'principal', 1, 13, 'V1.M13.A05 — Venda PRO: Estratégias Avançadas para Lucrar Mais com Demandas', 'FAQ', 'Venda PRO: Estratégias Avançadas para Lucrar Mais com Demandas', 'Método Sócia Invisível › Módulo 13 – O Radar Digital das Demandas Lucrativas › Aula 05 – Venda PRO: Estratégias Avançadas para Lucrar Mais com Demandas › Pontos para o suporte

- "Como ganho mais sem trabalhar mais?" Indicar esta aula: pacotes, serviços mensais, upgrades e promoções.
- "Que pacotes posso oferecer?" Ver as tabelas de pacotes e de recorrência acima. São exemplos, e os preços devem ser ajustados à realidade da aluna e da plataforma, considerando as taxas (ver as aulas de cada plataforma).
- "Como fidelizo clientes?" Entregar algo a mais, oferecer upgrades e mostrar o resultado.', 'approved', ARRAY['Venda PRO','estratégias avançadas','lucrar mais','solução completa','pacotes','recorrência','renda fixa','mensalidade','algo a mais','surpreender','upgrade','ticket médio','storytelling','histórias','promoções','bônus','resultados concretos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M14.A01-01', 'principal', 1, 14, 'V1.M14.A01 — O Chamado Rosa: Conheça o Mundo Wepink', 'Visão geral', 'O Chamado Rosa: Conheça o Mundo Wepink', 'Método Sócia Invisível › Módulo 14 – Lucrando com a WePink › Aula 01 – O Chamado Rosa: Conheça o Mundo Wepink › Visão geral da aula

Nome oficial da aula: O Chamado Rosa: Conheça o Mundo Wepink
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 14 – Lucrando com a WePink, Aula 01
Duração/formato: 1:22
Link na área de membros (abre a página do Módulo 14, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/14

Resumo:
É uma aula curta e motivacional, de abertura do Módulo 14, que apresenta a WePink, marca de beleza criada por Virginia Fonseca, como uma "oportunidade" de renda para mulheres. A aula não explica como a aluna vai ganhar dinheiro com a marca (revenda, afiliação ou outro modelo). Isso fica para as próximas aulas. A mensagem central: "Você pode mais" e "decida que você vai até o fim".', 'approved', ARRAY['WePink','We Pink','Lucrando com a WePink','O chamado rosa','mundo WePink','Virginia Fonseca','Virgínia','revendedora','afiliada','revender WePink']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M14.A01-02', 'principal', 1, 14, 'V1.M14.A01 — O Chamado Rosa: Conheça o Mundo Wepink', 'Pontos principais', 'O Chamado Rosa: Conheça o Mundo Wepink', 'Método Sócia Invisível › Módulo 14 – Lucrando com a WePink › Aula 01 – O Chamado Rosa: Conheça o Mundo Wepink › Pontos principais

- A WePink é apresentada como uma marca que "não é sobre produtos de beleza, é sobre oportunidade".
- Virginia Fonseca "não começou no topo" e construiu tudo com trabalho, visão e coragem. A marca "abre portas para mulheres como você".
- As próximas aulas prometem o passo a passo para gerar renda com a WePink.', 'approved', ARRAY['WePink','We Pink','Lucrando com a WePink','O chamado rosa','mundo WePink','Virginia Fonseca','Virgínia','revendedora','afiliada','revender WePink']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M14.A01-03', 'principal', 1, 14, 'V1.M14.A01 — O Chamado Rosa: Conheça o Mundo Wepink', 'Procedimento: o que a aluna deve fazer', 'O Chamado Rosa: Conheça o Mundo Wepink', 'Método Sócia Invisível › Módulo 14 – Lucrando com a WePink › Aula 01 – O Chamado Rosa: Conheça o Mundo Wepink › Procedimento: o que a aluna deve fazer

1. Assistir à aula. Não há ação prática.
2. Decidir ir até o fim do módulo.
3. Seguir para a Aula 02 do Módulo 14.', 'approved', ARRAY['WePink','We Pink','Lucrando com a WePink','O chamado rosa','mundo WePink','Virginia Fonseca','Virgínia','revendedora','afiliada','revender WePink']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M14.A01-04', 'principal', 1, 14, 'V1.M14.A01 — O Chamado Rosa: Conheça o Mundo Wepink', 'FAQ', 'O Chamado Rosa: Conheça o Mundo Wepink', 'Método Sócia Invisível › Módulo 14 – Lucrando com a WePink › Aula 01 – O Chamado Rosa: Conheça o Mundo Wepink › Pontos para o suporte

- "Como ganho dinheiro com a WePink?" Esta aula ainda não explica. Ver as próximas aulas do módulo.
- "O método tem parceria com a WePink / com a Virginia?" Não afirmar que existe parceria sem confirmação oficial.
- "Alguém me cobrou taxa para ser revendedora WePink." Orientar a não pagar e a conferir sempre o site oficial (wepink.com.br). Há golpes que usam o nome da marca.', 'approved', ARRAY['WePink','We Pink','Lucrando com a WePink','O chamado rosa','mundo WePink','Virginia Fonseca','Virgínia','revendedora','afiliada','revender WePink']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M14.A02-01', 'principal', 1, 14, 'V1.M14.A02 — Por Dentro da Máquina Rosa: Como Funciona a Wepink', 'Visão geral', 'Por Dentro da Máquina Rosa: Como Funciona a Wepink', 'Método Sócia Invisível › Módulo 14 – Lucrando com a WePink › Aula 02 – Por Dentro da Máquina Rosa: Como Funciona a Wepink › Visão geral da aula

Nome oficial da aula: Por Dentro da Máquina Rosa: Como Funciona a Wepink
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 14 – Lucrando com a WePink, Aula 02
Duração/formato: 2:14
Link na área de membros (abre a página do Módulo 14, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/14

Resumo:
A aula apresenta a WePink (marca de beleza, skincare e autocuidado de Virginia Fonseca) como uma "parceira fixa" que ofereceria microprojetos recorrentes a iniciantes, sem exigir seguidores nem experiência, com pagamento garantido e campanhas anônimas, sem precisar aparecer nem vender. A aula não diz que tipo de microprojeto é esse, nem onde ou como ele é oferecido. O cadastro e a candidatura ficam para a Aula 03.', 'approved', ARRAY['WePink','We Pink','Máquina Rosa','como funciona a WePink','microprojetos WePink','campanhas','campanhas anônimas','parceiro fixo','recorrência','Virginia Fonseca','Estratégia MPI']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M14.A02-02', 'principal', 1, 14, 'V1.M14.A02 — Por Dentro da Máquina Rosa: Como Funciona a Wepink', 'O que a aula afirma sobre a WePink', 'Por Dentro da Máquina Rosa: Como Funciona a Wepink', 'Método Sócia Invisível › Módulo 14 – Lucrando com a WePink › Aula 02 – Por Dentro da Máquina Rosa: Como Funciona a Wepink › O que a aula afirma sobre a WePink

| Afirmação da aula | Situação |
|---|---|
| Oferece oportunidade de trabalho para iniciantes, sem experiência e sem muitos seguidores | ⚠️ Não verificado |
| Pagamento garantido, "certinho e dentro do prazo" | ⚠️ Não verificado |
| Atividades simples, a maioria pelo celular | ⚠️ Não verificado |
| Campanhas anônimas: sem mostrar o rosto e sem vender | ⚠️ Não verificado |
| Vários projetos e recorrência: "parceiro fixo" | ⚠️ Não verificado |
| "Minhas alunas já fizeram vários microprojetos com a WePink" | ⚠️ Sem comprovação |', 'approved', ARRAY['WePink','We Pink','Máquina Rosa','como funciona a WePink','microprojetos WePink','campanhas','campanhas anônimas','parceiro fixo','recorrência','Virginia Fonseca','Estratégia MPI']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M14.A02-03', 'principal', 1, 14, 'V1.M14.A02 — Por Dentro da Máquina Rosa: Como Funciona a Wepink', 'Procedimento: o que a aluna deve fazer', 'Por Dentro da Máquina Rosa: Como Funciona a Wepink', 'Método Sócia Invisível › Módulo 14 – Lucrando com a WePink › Aula 02 – Por Dentro da Máquina Rosa: Como Funciona a Wepink › Procedimento: o que a aluna deve fazer

1. Encontrar o site da WePink no Google (primeiro resultado) e conhecer a marca.
2. Seguir para a Aula 03 do Módulo 14, que promete ensinar:
  - como se cadastrar e montar o perfil;
  - como se candidatar aos microprojetos;
  - como entregar o material corretamente.', 'approved', ARRAY['WePink','We Pink','Máquina Rosa','como funciona a WePink','microprojetos WePink','campanhas','campanhas anônimas','parceiro fixo','recorrência','Virginia Fonseca','Estratégia MPI']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M14.A02-04', 'principal', 1, 14, 'V1.M14.A02 — Por Dentro da Máquina Rosa: Como Funciona a Wepink', 'FAQ', 'Por Dentro da Máquina Rosa: Como Funciona a Wepink', 'Método Sócia Invisível › Módulo 14 – Lucrando com a WePink › Aula 02 – Por Dentro da Máquina Rosa: Como Funciona a Wepink › Pontos para o suporte

- "O que eu faço com a WePink?" A aula fala em "microprojetos" e "campanhas", mas não explica o que são. Ver a Aula 03. Não prometer pagamento garantido nem recorrência em nome da marca.
- "A WePink é parceira do método?" Não afirmar parceria sem confirmação oficial.
- "Pediram dinheiro para eu entrar em campanha da WePink." Não pagar. Conferir sempre no site oficial (wepink.com.br). Há golpes que usam o nome da marca (ver a Aula 01 deste módulo).', 'approved', ARRAY['WePink','We Pink','Máquina Rosa','como funciona a WePink','microprojetos WePink','campanhas','campanhas anônimas','parceiro fixo','recorrência','Virginia Fonseca','Estratégia MPI']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M15.A01-01', 'principal', 1, 15, 'V1.M15.A01 — Magnetismo Natural', 'Visão geral', 'Magnetismo Natural', 'Método Sócia Invisível › Módulo 15 – Performance Magnética › Aula 01 – Magnetismo Natural › Visão geral da aula

Nome oficial da aula: Magnetismo Natural
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 15 – Performance Magnética, Aula 01
Duração/formato: 5:32
Link na área de membros (abre a página do Módulo 15, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/15

Resumo:
É a abertura do Módulo 15, sobre comunicação em vídeo. A aula ensina a transformar o nervosismo em energia e a falar para a câmera com verdade e conexão, útil para vídeos de redes sociais, entrevistas, apresentações e oportunidades de trabalho que envolvam gravar mensagens, opiniões ou experiências. Ela traz 3 técnicas práticas: respiração 4-4-8, memória emocional e interpretação de texto. Termina com um exercício de gravação.
"Magnetismo não é ser perfeita. É ser verdadeira e usar suas emoções para criar conexão."', 'approved', ARRAY['Performance magnética','magnetismo natural','carisma','presença','nervosismo','frio na barriga','insegurança','vergonha de gravar','respiração 4-4-8','técnica de respiração','memória emocional','interpretar texto','intenção','ênfase','tom de voz','gravar vídeo','falar para a câmera']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M15.A01-02', 'principal', 1, 15, 'V1.M15.A01 — Magnetismo Natural', 'Pontos principais', 'Magnetismo Natural', 'Método Sócia Invisível › Módulo 15 – Performance Magnética › Aula 01 – Magnetismo Natural › Pontos principais

- Magnetismo não é dom: é sobre ser verdadeira e se conectar, e dá para aprender.
- Nervosismo é energia acumulada e sinal de que você se importa. Não lutar contra ele: usá-lo como combustível.
- Preparar-se não tira a naturalidade: organizar ideias e ensaiar dá confiança. "Interpretar é colocar intenção no que você faz."', 'approved', ARRAY['Performance magnética','magnetismo natural','carisma','presença','nervosismo','frio na barriga','insegurança','vergonha de gravar','respiração 4-4-8','técnica de respiração','memória emocional','interpretar texto','intenção','ênfase','tom de voz','gravar vídeo','falar para a câmera']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M15.A01-03', 'principal', 1, 15, 'V1.M15.A01 — Magnetismo Natural', 'Procedimento: as 3 técnicas', 'Magnetismo Natural', 'Método Sócia Invisível › Módulo 15 – Performance Magnética › Aula 01 – Magnetismo Natural › Procedimento: as 3 técnicas

### 1. Respiração 4-4-8 (antes de gravar)
1. Inspirar pelo nariz contando até 4.
2. Segurar o ar por 4 segundos.
3. Soltar devagar pela boca contando até 8.
4. Repetir 3 vezes.
### 2. Memória emocional
1. Escolher a emoção a transmitir: alegria, confiança, empolgação.
2. Lembrar de um momento real em que sentiu essa emoção.
3. Fechar os olhos e reviver a cena com detalhes: onde estava, o que sentiu, o que havia ao redor.
4. Abrir os olhos e trazer essa emoção para a fala.
### 3. Interpretar o texto
1. Ler o texto inteiro para entender a mensagem.
2. Dividir em partes, cada uma com uma intenção: o que eu quero que a pessoa sinta aqui?
3. Ajustar o tom:
  - assunto importante → tom mais sério;
  - solução ou boa notícia → tom mais empolgado;
  - algo pessoal → tom íntimo, "como se falasse com uma amiga".
4. Marcar as palavras que precisam de ênfase.
5. Praticar: gravar a mesma frase de jeitos diferentes e assistir.', 'approved', ARRAY['Performance magnética','magnetismo natural','carisma','presença','nervosismo','frio na barriga','insegurança','vergonha de gravar','respiração 4-4-8','técnica de respiração','memória emocional','interpretar texto','intenção','ênfase','tom de voz','gravar vídeo','falar para a câmera']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M15.A01-04', 'principal', 1, 15, 'V1.M15.A01 — Magnetismo Natural', 'Exercício prático', 'Magnetismo Natural', 'Método Sócia Invisível › Módulo 15 – Performance Magnética › Aula 01 – Magnetismo Natural › Exercício prático

1. Escolher uma frase ou texto curto.
2. Fazer a respiração 4-4-8.
3. Usar a memória emocional para acessar a emoção desejada.
4. Gravar 3 versões, mudando o tom e a intenção.
5. Assistir e escolher a que mais conecta.', 'approved', ARRAY['Performance magnética','magnetismo natural','carisma','presença','nervosismo','frio na barriga','insegurança','vergonha de gravar','respiração 4-4-8','técnica de respiração','memória emocional','interpretar texto','intenção','ênfase','tom de voz','gravar vídeo','falar para a câmera']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M15.A01-05', 'principal', 1, 15, 'V1.M15.A01 — Magnetismo Natural', 'FAQ', 'Magnetismo Natural', 'Método Sócia Invisível › Módulo 15 – Performance Magnética › Aula 01 – Magnetismo Natural › Pontos para o suporte

- "Tenho vergonha de gravar vídeo." Indicar esta aula: respiração 4-4-8, memória emocional e o exercício de gravar 3 versões. A aula reforça que não é preciso ser perfeita.
- "Preciso aparecer em vídeo para ganhar dinheiro?" Não em todas as frentes do método (pesquisas, várias demandas digitais etc.). Este módulo é para quem quer usar vídeo.', 'approved', ARRAY['Performance magnética','magnetismo natural','carisma','presença','nervosismo','frio na barriga','insegurança','vergonha de gravar','respiração 4-4-8','técnica de respiração','memória emocional','interpretar texto','intenção','ênfase','tom de voz','gravar vídeo','falar para a câmera']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M15.A02-01', 'principal', 1, 15, 'V1.M15.A02 — Conexão Instantânea', 'Visão geral', 'Conexão Instantânea', 'Método Sócia Invisível › Módulo 15 – Performance Magnética › Aula 02 – Conexão Instantânea › Visão geral da aula

Nome oficial da aula: Conexão Instantânea
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 15 – Performance Magnética, Aula 02
Duração/formato: 5:12
Link na área de membros (abre a página do Módulo 15, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/15

Resumo:
A aula ensina a criar conexão instantânea com quem assiste a um vídeo, usando presença, linguagem corporal, voz e intenção, e não equipamento caro ou cenário perfeito. A tese: "A diferença entre um vídeo que prende e um vídeo vazio não está no que foi dito, mas em como foi dito." Termina com o exercício de gravar um vídeo de 30 segundos e analisá-lo.', 'approved', ARRAY['conexão instantânea','conexão com a audiência','intimidade','presença','postura','fio puxando a cabeça','olhar para a lente','linguagem corporal','gestos','ombros relaxados','sorriso','voz','tom','monótono','ênfase','ritmo','falar com uma pessoa só','você em vez de vocês','vídeo de 30 segundos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M15.A02-02', 'principal', 1, 15, 'V1.M15.A02 — Conexão Instantânea', 'Procedimento: técnicas por pilar', 'Conexão Instantânea', 'Método Sócia Invisível › Módulo 15 – Performance Magnética › Aula 02 – Conexão Instantânea › Procedimento: técnicas por pilar

### 1. Presença
- Postura: coluna reta sem tensão, imaginando um fio puxando o topo da cabeça para cima.
- Olhar para a lente da câmera, e não para a tela, imaginando a pessoa do outro lado.
- Intenção: antes de gravar, perguntar "o que eu quero que a pessoa sinta?"
### 2. Linguagem corporal
- Não ficar completamente parada, com movimentos leves e naturais. Evitar exageros que distraiam.
- Usar as mãos para reforçar a fala. Exemplo: abrir as mãos ao compartilhar algo valioso.
- Ombros relaxados. A tensão aparece na câmera.
- Sorriso leve e sincero, que cria empatia.
### 3. Voz
- Variar o tom, sem falar de forma monótona.
- Para enfatizar: falar mais devagar e com tom mais firme.
- Para empolgar: acelerar levemente e pôr mais energia.
- Respiração 4-4-8 antes de gravar (Aula 01).
- Falar como com uma amiga, sem formalidade excessiva.
### 4. Intimidade
- Falar com uma pessoa só, alguém específico: amiga, irmã ou você mesma num momento difícil.
- Usar "você" em vez de "vocês".
- Ser verdadeira, sem esconder as emoções.', 'approved', ARRAY['conexão instantânea','conexão com a audiência','intimidade','presença','postura','fio puxando a cabeça','olhar para a lente','linguagem corporal','gestos','ombros relaxados','sorriso','voz','tom','monótono','ênfase','ritmo','falar com uma pessoa só','você em vez de vocês','vídeo de 30 segundos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M15.A02-03', 'principal', 1, 15, 'V1.M15.A02 — Conexão Instantânea', 'Exercício prático', 'Conexão Instantânea', 'Método Sócia Invisível › Módulo 15 – Performance Magnética › Aula 02 – Conexão Instantânea › Exercício prático

1. Ajustar a postura: coluna reta, ombros relaxados, olhar na lente.
2. Pensar na pessoa para quem está falando.
3. Gravar um vídeo de 30 segundos com um conselho ou uma dica simples.
4. Assistir e analisar: pareço confiante? Minha voz transmite emoção? Meus gestos estão naturais?', 'approved', ARRAY['conexão instantânea','conexão com a audiência','intimidade','presença','postura','fio puxando a cabeça','olhar para a lente','linguagem corporal','gestos','ombros relaxados','sorriso','voz','tom','monótono','ênfase','ritmo','falar com uma pessoa só','você em vez de vocês','vídeo de 30 segundos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M15.A02-04', 'principal', 1, 15, 'V1.M15.A02 — Conexão Instantânea', 'FAQ', 'Conexão Instantânea', 'Método Sócia Invisível › Módulo 15 – Performance Magnética › Aula 02 – Conexão Instantânea › Pontos para o suporte

- "Meus vídeos ficam sem graça / travados." Indicar esta aula: olhar para a lente, variar o tom, usar as mãos, sorrir e falar com uma pessoa só.
- "Preciso de câmera ou cenário bons?" Não, segundo a aula. O que importa é presença, postura e intenção.
- "Como treino?" Com o exercício do vídeo de 30 segundos, gravando, assistindo e ajustando.', 'approved', ARRAY['conexão instantânea','conexão com a audiência','intimidade','presença','postura','fio puxando a cabeça','olhar para a lente','linguagem corporal','gestos','ombros relaxados','sorriso','voz','tom','monótono','ênfase','ritmo','falar com uma pessoa só','você em vez de vocês','vídeo de 30 segundos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M16.A01-01', 'principal', 1, 16, 'V1.M16.A01 — As Habilidades Mais Procuradas e Como Se Destacar', 'Visão geral', 'As Habilidades Mais Procuradas e Como Se Destacar', 'Método Sócia Invisível › Módulo 16 – Habilidades que Vendem › Aula 01 – As Habilidades Mais Procuradas e Como Se Destacar › Visão geral da aula

Nome oficial da aula: As Habilidades Mais Procuradas e Como Se Destacar
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 16 – Habilidades que Vendem, Aula 01
Duração/formato: 6:36
Link na área de membros (abre a página do Módulo 16, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/16

Resumo:
A aula apresenta as 9 habilidades mais procuradas em plataformas de freela (99Freelas, Workana, Vinte Pila, Vinte Conto, GetNinjas, Fiverr, Upwork e outras). Segundo ela, a maioria não exige formação nem anos de experiência e pode ser feita com ferramentas gratuitas (CapCut, InShot, Canva, ChatGPT). A aula também dá 6 dicas para se destacar e uma mensagem de persistência para os primeiros dias.', 'approved', ARRAY['Habilidades que vendem','habilidades mais procuradas','o que oferecer','que serviço fazer','edição de vídeo','CapCut','InShot','reels','stories','design','Canva','logotipo','banner','posts','transcrição','legendagem','revisão','formatação','ChatGPT','suporte administrativo','criação de textos','tradução','gestão de redes sociais','pesquisas online','99 frilas','Orkana','20 pila','20 ponto','GetNinjas','Fiver','Fiverr','Upwork']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M16.A01-02', 'principal', 1, 16, 'V1.M16.A01 — As Habilidades Mais Procuradas e Como Se Destacar', 'As 9 habilidades mais procuradas', 'As Habilidades Mais Procuradas e Como Se Destacar', 'Método Sócia Invisível › Módulo 16 – Habilidades que Vendem › Aula 01 – As Habilidades Mais Procuradas e Como Se Destacar › As 9 habilidades mais procuradas

| # | Habilidade | O que envolve | Ferramentas citadas |
|---|---|---|---|
| 1 | Edição de vídeo e conteúdo visual | Vídeos curtos, reels, stories, edições simples | CapCut, InShot, Canva, apps de celular |
| 2 | Design básico | Logotipos, banners, posts, apresentações | Canva (modelos prontos) |
| 3 | Transcrição e legendagem | Áudio ou vídeo → texto; legendas | — (atenção aos detalhes) |
| 4 | Revisão e formatação de textos | Revisão ortográfica e gramatical, formatação de documentos | ChatGPT |
| 5 | Suporte administrativo | E-mails, planilhas, agenda | — (organização) |
| 6 | Criação de textos | Artigos, descrições de produtos, legendas, roteiros | ChatGPT |
| 7 | Tradução | Traduções simples (inglês, espanhol, francês…) | — |
| 8 | Gestão de redes sociais | Posts, respostas a comentários, organização de conteúdo | Instagram, Facebook, TikTok |
| 9 | Pesquisas online | Pesquisa de mercado, busca de informações, teste de produtos | — |
Por que são acessíveis: não exigem formação acadêmica. Ferramentas gratuitas substituem softwares profissionais (CapCut/InShot no lugar de Premiere e Final Cut; Canva no lugar de Photoshop e Illustrator), e dá para aprender rápido. A aula diz que a área de membros tem módulos que ensinam várias delas.', 'approved', ARRAY['Habilidades que vendem','habilidades mais procuradas','o que oferecer','que serviço fazer','edição de vídeo','CapCut','InShot','reels','stories','design','Canva','logotipo','banner','posts','transcrição','legendagem','revisão','formatação','ChatGPT','suporte administrativo','criação de textos','tradução','gestão de redes sociais','pesquisas online','99 frilas','Orkana','20 pila','20 ponto','GetNinjas','Fiver','Fiverr','Upwork']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M16.A01-03', 'principal', 1, 16, 'V1.M16.A01 — As Habilidades Mais Procuradas e Como Se Destacar', 'Procedimento: como se destacar', 'As Habilidades Mais Procuradas e Como Se Destacar', 'Método Sócia Invisível › Módulo 16 – Habilidades que Vendem › Aula 01 – As Habilidades Mais Procuradas e Como Se Destacar › Procedimento: como se destacar

1. Perfil atraente: foto profissional e simpática. Descrição direta com as habilidades principais. Exemplo: "Especialista em edição de vídeos curtos para redes sociais".
2. Palavras-chave: as plataformas funcionam como buscadores. Exemplo para edição: reels, stories, edição rápida, vídeos curtos.
3. Começar com demandas menores: ganhar experiência e avaliações positivas. Entregar rápido e pedir feedback.
4. Provas sociais: incluir no portfólio trabalhos feitos para amigos ou familiares.
5. Comunicação ágil: responder rápido, com educação e interesse.
6. Persistir: os primeiros dias são difíceis. Cada entrega e cada avaliação é "um tijolinho na reputação". Lembrar do motivo pelo qual começou.', 'approved', ARRAY['Habilidades que vendem','habilidades mais procuradas','o que oferecer','que serviço fazer','edição de vídeo','CapCut','InShot','reels','stories','design','Canva','logotipo','banner','posts','transcrição','legendagem','revisão','formatação','ChatGPT','suporte administrativo','criação de textos','tradução','gestão de redes sociais','pesquisas online','99 frilas','Orkana','20 pila','20 ponto','GetNinjas','Fiver','Fiverr','Upwork']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M16.A01-04', 'principal', 1, 16, 'V1.M16.A01 — As Habilidades Mais Procuradas e Como Se Destacar', 'FAQ', 'As Habilidades Mais Procuradas e Como Se Destacar', 'Método Sócia Invisível › Módulo 16 – Habilidades que Vendem › Aula 01 – As Habilidades Mais Procuradas e Como Se Destacar › Pontos para o suporte

- "Que serviço eu posso oferecer?" Ver a tabela das 9 habilidades. Cruzar com o mapeamento dos 5 círculos (M06 A01).
- "Não sei usar programas de edição ou design." CapCut, InShot e Canva são gratuitos e fáceis. Segundo a aula, o básico bem feito já resolve.
- "Ninguém me contrata." Revisar perfil, palavras-chave e portfólio, começar por demandas menores e responder rápido. É normal demorar no começo.', 'approved', ARRAY['Habilidades que vendem','habilidades mais procuradas','o que oferecer','que serviço fazer','edição de vídeo','CapCut','InShot','reels','stories','design','Canva','logotipo','banner','posts','transcrição','legendagem','revisão','formatação','ChatGPT','suporte administrativo','criação de textos','tradução','gestão de redes sociais','pesquisas online','99 frilas','Orkana','20 pila','20 ponto','GetNinjas','Fiver','Fiverr','Upwork']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M02.A01-01', 'principal', 1, 2, 'V1.M02.A01 — Quem é a Gabriela e por que ela entende sua realidade', 'Visão geral', 'Quem é a Gabriela e por que ela entende sua realidade', 'Método Sócia Invisível › Módulo 02 – O Despertar › Aula 01 – Quem é a Gabriela e por que ela entende sua realidade › Visão geral da aula

Nome oficial da aula: Quem é a Gabriela e por que ela entende sua realidade
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 02 – O Despertar, Aula 01
Duração/formato: 4:56
Link na área de membros (abre a página do Módulo 02, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/2

Resumo:
É uma aula de conexão, sem nenhum passo técnico. A especialista, Gabriela ("Gabi"), conta a própria história para criar identificação com a aluna. Ela fala de um período de muita dificuldade financeira com o marido Felipe e o filho, que tinha PLV (alergia à proteína do leite de vaca). Depois conta como a vida mudou. A mensagem central é: "Eu já vivi a sua realidade. Se eu consegui superar, você também pode." O tom é emocional e de fé ("Deus vê o que você está passando").', 'approved', ARRAY['Gabriela','Gabi','Gabi Vittorino','Método GV','geladeira de Nox','geladeira de inox','PLV','alergia à proteína do leite de vaca','Quem é a Gabriela','Aula 1 – Quem é a Gabriela']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M02.A01-02', 'principal', 1, 2, 'V1.M02.A01 — Quem é a Gabriela e por que ela entende sua realidade', 'Pontos principais da história', 'Quem é a Gabriela e por que ela entende sua realidade', 'Método Sócia Invisível › Módulo 02 – O Despertar › Aula 01 – Quem é a Gabriela e por que ela entende sua realidade › Pontos principais da história

- Família: é casada com o Felipe e tem um filho pequeno.
- Dificuldade: o casal tinha cerca de R$ 400 para o mês inteiro. O leite especial do filho (PLV) custava R$ 250, e muitas vezes era preciso escolher entre o leite dele e a comida dos pais.
- Símbolos da época: uma geladeira velha e enferrujada, com o sonho de ter uma de inox. Num aniversário, não havia dinheiro nem para pedir um lanche. Uma pessoa próxima mandou o dinheiro, e o Felipe fez uma surpresa.
- Virada: foi gradual ("as portas foram se abrindo"), com trabalho e confiança.
- Hoje: o filho estuda em escola particular e ela compra o que quer comer sem olhar o preço. Comprou a geladeira de inox com os primeiros R$ 5 mil que fez na internet.
- Mensagens de fechamento: a mudança vem "no tempo certo", é preciso ter paciência e confiar no processo, e a transformação começa por dentro.', 'approved', ARRAY['Gabriela','Gabi','Gabi Vittorino','Método GV','geladeira de Nox','geladeira de inox','PLV','alergia à proteína do leite de vaca','Quem é a Gabriela','Aula 1 – Quem é a Gabriela']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M02.A01-03', 'principal', 1, 2, 'V1.M02.A01 — Quem é a Gabriela e por que ela entende sua realidade', 'Procedimento: o que a aluna deve fazer', 'Quem é a Gabriela e por que ela entende sua realidade', 'Método Sócia Invisível › Módulo 02 – O Despertar › Aula 01 – Quem é a Gabriela e por que ela entende sua realidade › Procedimento: o que a aluna deve fazer

1. Assistir à aula (4:56). Ela não pede nenhuma ação prática.
2. Seguir para a próxima aula do Módulo 02. Na gravação, ela é chamada de "a aula mais importante da Mentoria, que vai decidir quem fica e quem vai embora".', 'approved', ARRAY['Gabriela','Gabi','Gabi Vittorino','Método GV','geladeira de Nox','geladeira de inox','PLV','alergia à proteína do leite de vaca','Quem é a Gabriela','Aula 1 – Quem é a Gabriela']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M02.A01-04', 'principal', 1, 2, 'V1.M02.A01 — Quem é a Gabriela e por que ela entende sua realidade', 'FAQ', 'Quem é a Gabriela e por que ela entende sua realidade', 'Método Sócia Invisível › Módulo 02 – O Despertar › Aula 01 – Quem é a Gabriela e por que ela entende sua realidade › Pontos para o suporte

- "Quem é a Gabriela / quem está por trás do método?" É a Gabriela (Gabi), mãe e esposa do Felipe. Ela passou por dificuldade financeira e hoje vive da internet. A história completa está nesta aula.
- "Essa aula ensina alguma coisa prática?" Não. É uma aula de apresentação e motivação. A parte prática vem nos módulos seguintes.
- "O que faço depois desta aula?" Seguir para a próxima aula do Módulo 02, sem pular.', 'approved', ARRAY['Gabriela','Gabi','Gabi Vittorino','Método GV','geladeira de Nox','geladeira de inox','PLV','alergia à proteína do leite de vaca','Quem é a Gabriela','Aula 1 – Quem é a Gabriela']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M02.A02-01', 'principal', 1, 2, 'V1.M02.A02 — A tribo das Supremas', 'Visão geral', 'A tribo das Supremas', 'Método Sócia Invisível › Módulo 02 – O Despertar › Aula 02 – A tribo das Supremas › Visão geral da aula

Nome oficial da aula: A tribo das Supremas
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 02 – O Despertar, Aula 02
Duração/formato: 5:57
Link na área de membros (abre a página do Módulo 02, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/2

Resumo:
É uma aula de mentalidade e compromisso, apresentada como "divisor de águas". Ela não tem passos técnicos. A Gabi se apresenta como mentora da aluna. Ela reforça que é uma mulher comum, que aprendeu "na marra" e virou o jogo por causa do filho com APLV. Também diz que o segredo do sucesso é a constância. No fim, ela anuncia um "ritual de passagem": a aluna vai precisar aceitar uma condição proposta pela mentora para entrar oficialmente no Círculo das Supremas. Essa decisão acontece na próxima aula.', 'approved', ARRAY['Tribo das Supremas','Círculo das Supremas','círculo de supremas','supremas','Gabriela Vitorino','Gabriela Vittorino','Gabi','APLV','PLV','alergia à proteína do leite de vaca','ritual de passagem','decisão','condição']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M02.A02-02', 'principal', 1, 2, 'V1.M02.A02 — A tribo das Supremas', 'Pontos principais', 'A tribo das Supremas', 'Método Sócia Invisível › Módulo 02 – O Despertar › Aula 02 – A tribo das Supremas › Pontos principais

- Apresentação: Gabriela é mãe, esposa do Felipe, empreendedora e mentora. Não se considera "gênia dos negócios" e não tinha referências de empreendedores na família.
- Constância: "O constante vence o talentoso". Avançar um pouco todo dia vale mais do que ter picos de energia e depois parar.
- Origem: o diagnóstico de APLV do filho e o custo do leite especial foram a dor que a levou a buscar renda na internet. Ela errou muito antes de acertar.
- "Reinicie o seu cérebro": esquecer fórmulas mágicas e dinheiro fácil.
- Quem duvida: ignorar as pessoas que debocham e focar em quem apoia. O marido dela saiu do CLT e hoje trabalha com ela.
- Pedidos da mentora:
  1. Encarar o treinamento como um novo início.
  2. O passado não define a aluna. Ela não tem culpa de onde veio, mas a partir de agora é 100% responsável pelas próprias escolhas.
- Comunidade: a proposta é formar um círculo de mulheres que se apoiam, o Círculo das Supremas.', 'approved', ARRAY['Tribo das Supremas','Círculo das Supremas','círculo de supremas','supremas','Gabriela Vitorino','Gabriela Vittorino','Gabi','APLV','PLV','alergia à proteína do leite de vaca','ritual de passagem','decisão','condição']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M02.A02-03', 'principal', 1, 2, 'V1.M02.A02 — A tribo das Supremas', 'Procedimento: o que a aluna deve fazer', 'A tribo das Supremas', 'Método Sócia Invisível › Módulo 02 – O Despertar › Aula 02 – A tribo das Supremas › Procedimento: o que a aluna deve fazer

1. Assistir à aula até o fim. Nesta aula ainda não há nenhuma ação prática.
2. Refletir sobre a decisão anunciada:
 - aceitar a condição da mentora e entrar no Círculo das Supremas.
3. Seguir para a próxima aula (Módulo 02, Aula 03), onde a decisão é tomada e a condição é revelada.', 'approved', ARRAY['Tribo das Supremas','Círculo das Supremas','círculo de supremas','supremas','Gabriela Vitorino','Gabriela Vittorino','Gabi','APLV','PLV','alergia à proteína do leite de vaca','ritual de passagem','decisão','condição']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M02.A02-04', 'principal', 1, 2, 'V1.M02.A02 — A tribo das Supremas', 'FAQ', 'A tribo das Supremas', 'Método Sócia Invisível › Módulo 02 – O Despertar › Aula 02 – A tribo das Supremas › Pontos para o suporte

- "O que é o Círculo / Tribo das Supremas?" É a comunidade de alunas do método. A entrada oficial acontece depois da decisão proposta na próxima aula.
- "Tenho que decidir alguma coisa agora?" Não. A decisão acontece na Aula 03 do Módulo 02.
- "O conteúdo não está todo liberado." A aula diz que, depois da decisão, "todo o conteúdo será liberado em 24 horas". Confirmar a regra de liberação antes de responder.', 'approved', ARRAY['Tribo das Supremas','Círculo das Supremas','círculo de supremas','supremas','Gabriela Vitorino','Gabriela Vittorino','Gabi','APLV','PLV','alergia à proteína do leite de vaca','ritual de passagem','decisão','condição']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M02.A03-01', 'principal', 1, 2, 'V1.M02.A03 — A Decisão', 'Visão geral', 'A Decisão', 'Método Sócia Invisível › Módulo 02 – O Despertar › Aula 03 – A Decisão › Visão geral da aula

Nome oficial da aula: A Decisão
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 02 – O Despertar, Aula 03
Duração/formato: 11:01
Link na área de membros (abre a página do Módulo 02, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/2

Resumo:
É a aula do "ritual de passagem" anunciado na Aula 02. A Gabriela define Suprema como uma mulher com autonomia, dona do próprio destino e protagonista da própria vida. Ela conta que o ponto de virada dela foi se reconciliar com Deus e colocá-Lo como sócio majoritário do negócio. A decisão proposta é esta: nas próximas 24 horas, a aluna deve orar e apresentar o seu projeto a Deus, convidando-O para ser seu sócio. Depois da decisão, a aluna deve entrar na comunidade e comentar confirmando o compromisso.', 'approved', ARRAY['A Decisão','aula 3 a decisão','Suprema','Supremas','tornar-se Suprema','supremos','Deus como sócio','sócio majoritário','sócio que não dorme','solicitar reembolso','pedir reembolso','grupo de avisos','Deus proverá','jovem rico']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M02.A03-02', 'principal', 1, 2, 'V1.M02.A03 — A Decisão', 'Pontos principais', 'A Decisão', 'Método Sócia Invisível › Módulo 02 – O Despertar › Aula 03 – A Decisão › Pontos principais

- O que é ser Suprema: dominar o próprio destino, ter autonomia, provar o seu ponto sempre que alguém disser o contrário, e não aceitar menos do que merece.
- Fé e dinheiro: "Como falar da criação sem mencionar o Criador?" O elemento que transformou a vida dela foi reconhecer Deus como a fonte da prosperidade.
- Comparação: a aluna deve se comparar só com a versão dela de ontem. "Não se compare com o palco dos outros; os bastidores são invisíveis."
- Bastidores da Gabriela: usou um cartão para pagar outro, pediu dinheiro para a compra do mês, fez empréstimos e ficou sem dinheiro para o leite do filho.
- Obstáculo = redirecionamento: sentir, se emocionar, se reorganizar e buscar uma solução, sem ficar lamentando.
- "Recursos reduzidos, não dificuldade": quem sabe onde está a sua segurança sabe gerar renda de novo. "Tropeçar sete vezes e levantar na oitava."
- Oração: Deus não entrega "um pacote pronto". Ele coloca a pessoa em situações para desenvolver o que ela pediu. "Não orar também é uma oração", porque comunica que a pessoa acha que dá conta sozinha.
- Jovem rico: o que importa não é quanto dinheiro se tem, e sim onde está a segurança.', 'approved', ARRAY['A Decisão','aula 3 a decisão','Suprema','Supremas','tornar-se Suprema','supremos','Deus como sócio','sócio majoritário','sócio que não dorme','solicitar reembolso','pedir reembolso','grupo de avisos','Deus proverá','jovem rico']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M02.A03-03', 'principal', 1, 2, 'V1.M02.A03 — A Decisão', 'Procedimento: o que a aluna deve fazer', 'A Decisão', 'Método Sócia Invisível › Módulo 02 – O Despertar › Aula 03 – A Decisão › Procedimento: o que a aluna deve fazer

1. Tomar a decisão em até 24 horas:
 - orar e apresentar a Deus o projeto que está começando, convidando-O para ser o "sócio majoritário". A aula sugere a oração: "venha comigo, me ensine o que não sei, me dê força quando eu não tiver mais energia, me ilumine para encontrar as melhores oportunidades…"
2. Entrar na comunidade pelo link logo abaixo da aula. Por lá chegam os avisos de encontros ao vivo e as atualizações do método, das estratégias e das técnicas.
3. Deixar um comentário abaixo da aula confirmando que está comprometida e que decidiu se tornar uma Suprema.
4. Seguir para a próxima aula.', 'approved', ARRAY['A Decisão','aula 3 a decisão','Suprema','Supremas','tornar-se Suprema','supremos','Deus como sócio','sócio majoritário','sócio que não dorme','solicitar reembolso','pedir reembolso','grupo de avisos','Deus proverá','jovem rico']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M02.A03-04', 'principal', 1, 2, 'V1.M02.A03 — A Decisão', 'FAQ', 'A Decisão', 'Método Sócia Invisível › Módulo 02 – O Despertar › Aula 03 – A Decisão › Pontos para o suporte

- "O que eu preciso fazer nesta aula?" Decidir se segue no método. Para seguir: apresentar o projeto a Deus (orar), entrar na comunidade pelo link abaixo do vídeo e comentar confirmando o compromisso.
- "Onde fica o link da comunidade/grupo?" Abaixo do vídeo desta aula. O mesmo grupo também aparece na Aula de Boas-Vindas (Módulo 01).
- "Não sou religiosa / sou de outra religião. Posso continuar?" A aula não trata desse caso.
- "As próximas aulas estão bloqueadas." A aula diz "não vou liberar as próximas aulas porque você vai desistir no meio do caminho" e fala em um prazo de 24 horas. Confirmar se existe liberação gradual real.', 'approved', ARRAY['A Decisão','aula 3 a decisão','Suprema','Supremas','tornar-se Suprema','supremos','Deus como sócio','sócio majoritário','sócio que não dorme','solicitar reembolso','pedir reembolso','grupo de avisos','Deus proverá','jovem rico']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M03.A01-01', 'principal', 1, 3, 'V1.M03.A01 — Como eu saí do CLT para faturar mais de 3 Milhões em 12 meses com as Demandas', 'Visão geral', 'Como eu saí do CLT para faturar mais de 3 Milhões em 12 meses com as Demandas', 'Método Sócia Invisível › Módulo 03 – Rota da Liberdade › Aula 01 – Como eu saí do CLT para faturar mais de 3 Milhões em 12 meses com as Demandas › Visão geral da aula

Nome oficial da aula: Como eu saí do CLT para faturar mais de 3 Milhões em 12 meses com as Demandas
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 03 – Rota da Liberdade, Aula 01
Duração/formato: 5:43
Link na área de membros (abre a página do Módulo 03, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/3

Resumo:
É a aula de abertura do Módulo 03. A própria aula avisa que "não é sobre estratégia ou técnica, é sobre acreditar". A Gabriela conta como começou nas subdemandas:
- Em 2022, tinha acabado de se tornar mãe e parou de trabalhar para cuidar do filho. O salário do marido mal cobria as contas.
- Tentou várias formas de renda online, sem sucesso.
- Começou nas subdemandas durante as sonecas do filho.
- Criou a própria estratégia na tentativa e erro. Na gravação, essa estratégia se chama "método GV".
A aula também antecipa o que o módulo vai ensinar e promete que dá para faturar "não só R$ 200 por dia, mas muito mais".', 'approved', ARRAY['Rota da Liberdade','Como eu saí do CLT','saí do CLT para faturar','3 milhões em 12 meses','Método GV']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M03.A01-02', 'principal', 1, 3, 'V1.M03.A01 — Como eu saí do CLT para faturar mais de 3 Milhões em 12 meses com as Demandas', 'Pontos principais da história', 'Como eu saí do CLT para faturar mais de 3 Milhões em 12 meses com as Demandas', 'Método Sócia Invisível › Módulo 03 – Rota da Liberdade › Aula 01 – Como eu saí do CLT para faturar mais de 3 Milhões em 12 meses com as Demandas › Pontos principais da história

- 2022: recém-mãe, parou de trabalhar e se sentia presa, sem dinheiro e sem perspectiva.
- Tentativas anteriores que não deram certo: "FIFA", afiliado, vendas em marketplace e criação de sites.
- Virada: decidiu se cadastrar para fazer subdemandas, mesmo sem conhecimento, aproveitando as sonecas do filho.
- Por que subdemandas: têm um fluxo enorme todos os dias, de vários segmentos e níveis de complexidade, o que facilita a execução e a entrega. É uma boa porta de entrada para iniciantes.
- Aprendizado-chave: só se cadastrar e fazer uma ou outra de vez em quando não dá resultado consistente. É preciso estratégia.
- Resultado: ela diz ter liberdade para trabalhar de qualquer lugar, viajar e passar mais tempo com a família.', 'approved', ARRAY['Rota da Liberdade','Como eu saí do CLT','saí do CLT para faturar','3 milhões em 12 meses','Método GV']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M03.A01-03', 'principal', 1, 3, 'V1.M03.A01 — Como eu saí do CLT para faturar mais de 3 Milhões em 12 meses com as Demandas', 'O que o módulo promete ensinar (segundo a aula)', 'Como eu saí do CLT para faturar mais de 3 Milhões em 12 meses com as Demandas', 'Método Sócia Invisível › Módulo 03 – Rota da Liberdade › Aula 01 – Como eu saí do CLT para faturar mais de 3 Milhões em 12 meses com as Demandas › O que o módulo promete ensinar (segundo a aula)

1. Como encontrar subdemandas online sem experiência.
2. As estratégias que fazem das subdemandas uma boa porta de entrada para iniciantes.
3. Como aplicar o método "sem precisar fazer investimentos exorbitantes".
4. Como construir um negócio que traga resultado financeiro e liberdade.', 'approved', ARRAY['Rota da Liberdade','Como eu saí do CLT','saí do CLT para faturar','3 milhões em 12 meses','Método GV']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M03.A01-04', 'principal', 1, 3, 'V1.M03.A01 — Como eu saí do CLT para faturar mais de 3 Milhões em 12 meses com as Demandas', 'Procedimento: o que a aluna deve fazer', 'Como eu saí do CLT para faturar mais de 3 Milhões em 12 meses com as Demandas', 'Método Sócia Invisível › Módulo 03 – Rota da Liberdade › Aula 01 – Como eu saí do CLT para faturar mais de 3 Milhões em 12 meses com as Demandas › Procedimento: o que a aluna deve fazer

1. Assistir à aula. Ela não pede nenhuma ação prática.
2. Seguir para a Aula 02 do Módulo 03, onde começa o passo a passo.', 'approved', ARRAY['Rota da Liberdade','Como eu saí do CLT','saí do CLT para faturar','3 milhões em 12 meses','Método GV']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M03.A01-05', 'principal', 1, 3, 'V1.M03.A01 — Como eu saí do CLT para faturar mais de 3 Milhões em 12 meses com as Demandas', 'FAQ', 'Como eu saí do CLT para faturar mais de 3 Milhões em 12 meses com as Demandas', 'Método Sócia Invisível › Módulo 03 – Rota da Liberdade › Aula 01 – Como eu saí do CLT para faturar mais de 3 Milhões em 12 meses com as Demandas › Pontos para o suporte

- "Quando começa a parte prática?" A partir das próximas aulas do Módulo 03 (Rota da Liberdade). Esta é só a abertura.
- "Preciso de experiência ou investimento?" Segundo a aula, não é preciso experiência, e o método dispensa "investimentos exorbitantes". Ela não diz que o custo é zero. (A Soffia, citada no Módulo 01, é paga depois de 30 dias.)
- "Quanto vou ganhar?" Não repetir os valores da aula (R$ 200/dia, 3 milhões) como promessa.', 'approved', ARRAY['Rota da Liberdade','Como eu saí do CLT','saí do CLT para faturar','3 milhões em 12 meses','Método GV']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M03.A02-01', 'principal', 1, 3, 'V1.M03.A02 — A Trilha da Sua Liberdade', 'Visão geral', 'A Trilha da Sua Liberdade', 'Método Sócia Invisível › Módulo 03 – Rota da Liberdade › Aula 02 – A Trilha da Sua Liberdade › Visão geral da aula

Nome oficial da aula: A Trilha da Sua Liberdade
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 03 – Rota da Liberdade, Aula 02
Duração/formato: 3:54
Link na área de membros (abre a página do Módulo 03, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/3

Resumo:
É uma aula curta e direta sobre começar agora, com o que se tem. A Gabriela combate a espera pelo "momento perfeito" e pela "segunda-feira", e reforça que o resultado vem de aplicar, não de comprar o curso. Além da motivação, a aula traz orientações práticas úteis para o suporte:
- dá para fazer tudo só com o celular, pelo navegador e nas versões web das ferramentas;
- não é preciso saber tecnologia, Excel nem PowerPoint;
- a aluna pode seguir no próprio ritmo, uma aula por vez;
- existe suporte no WhatsApp 24/7.', 'approved', ARRAY['Trilha da Sua Liberdade','trilha da liberdade','Gabi','Gabriela','Suprema','versão web','navegador','pelo celular','só com celular','suporte 24 horas','suporte no WhatsApp','24/7']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M03.A02-02', 'principal', 1, 3, 'V1.M03.A02 — A Trilha da Sua Liberdade', 'Pontos principais', 'A Trilha da Sua Liberdade', 'Método Sócia Invisível › Módulo 03 – Rota da Liberdade › Aula 02 – A Trilha da Sua Liberdade › Pontos principais

- Não existe mágica: o que transforma não é o curso, é o que a aluna faz com ele.
- O momento perfeito não existe: começar agora, do jeito que der. "Amanhã vira nunca."
- Exemplo pessoal: a Gabriela começou sem computador, só com o celular.
- Travas comuns: medo de errar, dúvida se vai conseguir, a voz de "isso não é para mim". A orientação é calar essa voz e agir, porque pequenas vitórias dão força para continuar.
- Tempo: ninguém tem tempo sobrando. Não é preciso ver tudo de uma vez.
- Sem experiência: mesmo quem nunca ganhou nada na internet consegue, porque o método ensina o passo a passo.', 'approved', ARRAY['Trilha da Sua Liberdade','trilha da liberdade','Gabi','Gabriela','Suprema','versão web','navegador','pelo celular','só com celular','suporte 24 horas','suporte no WhatsApp','24/7']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M03.A02-03', 'principal', 1, 3, 'V1.M03.A02 — A Trilha da Sua Liberdade', 'Procedimento: orientações práticas da aula', 'A Trilha da Sua Liberdade', 'Método Sócia Invisível › Módulo 03 – Rota da Liberdade › Aula 02 – A Trilha da Sua Liberdade › Procedimento: orientações práticas da aula

1. Começar hoje, sem esperar condições ideais.
2. Ritmo sugerido: assistir uma aula hoje, aplicar amanhã e seguir assim, sem parar.
3. Se só tiver celular: usar o navegador do celular e as versões web das ferramentas para fazer o passo a passo. O computador pode vir depois dos primeiros resultados.
4. Se tiver dúvidas: perguntar na comunidade ou no suporte pelo WhatsApp.
5. Aplicar, testar e insistir. Não basta assistir.
6. Seguir para a Aula 03 do Módulo 03.', 'approved', ARRAY['Trilha da Sua Liberdade','trilha da liberdade','Gabi','Gabriela','Suprema','versão web','navegador','pelo celular','só com celular','suporte 24 horas','suporte no WhatsApp','24/7']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M03.A02-04', 'principal', 1, 3, 'V1.M03.A02 — A Trilha da Sua Liberdade', 'FAQ', 'A Trilha da Sua Liberdade', 'Método Sócia Invisível › Módulo 03 – Rota da Liberdade › Aula 02 – A Trilha da Sua Liberdade › Pontos para o suporte

- "Só tenho celular, consigo fazer?" Sim. A aula diz que a Gabriela começou só com o celular, usando o navegador e as versões web das ferramentas.
- "Preciso saber mexer em computador, Excel ou PowerPoint?" Não, segundo a aula.
- "Tenho pouco tempo." A aluna pode ir no próprio ritmo: uma aula por dia, aplicando no dia seguinte.
- "Nunca ganhei dinheiro na internet." Não precisa de experiência. O método ensina o passo a passo.
- "Qual o horário do suporte?" A aula promete 24 horas por dia, 7 dias por semana, incluindo fins de semana e feriados.', 'approved', ARRAY['Trilha da Sua Liberdade','trilha da liberdade','Gabi','Gabriela','Suprema','versão web','navegador','pelo celular','só com celular','suporte 24 horas','suporte no WhatsApp','24/7']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M03.A03-01', 'principal', 1, 3, 'V1.M03.A03 — Quanto custa NÃO começar hoje', 'Visão geral', 'Quanto custa NÃO começar hoje', 'Método Sócia Invisível › Módulo 03 – Rota da Liberdade › Aula 03 – Quanto custa NÃO começar hoje › Visão geral da aula

Nome oficial da aula: Quanto custa NÃO começar hoje
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 03 – Rota da Liberdade, Aula 03
Duração/formato: 5:28
Link na área de membros (abre a página do Módulo 03, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/3

Resumo:
É uma aula de reflexão e decisão. A mensagem central é que "a hora certa não existe" e que o prazo do resultado depende das ações da aluna. A Gabriela convida a aluna a sair da zona de conforto, usar o medo como combustível e dar o primeiro passo, mesmo pequeno, para criar um "efeito dominó". A aula tem um exercício de visualização e termina pedindo que a aluna saia com a decisão: "Vou começar agora."', 'approved', ARRAY['Quanto custa não começar hoje','quanto custa não começar','Suprema','Método GV','método do GV','suporte individual','suporte 24 horas','WhatsApp']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M03.A03-02', 'principal', 1, 3, 'V1.M03.A03 — Quanto custa NÃO começar hoje', 'Pontos principais', 'Quanto custa NÃO começar hoje', 'Método Sócia Invisível › Módulo 03 – Rota da Liberdade › Aula 03 – Quanto custa NÃO começar hoje › Pontos principais

- A transformação começa com a ação, mesmo com medo e com dúvidas, e não quando está tudo perfeito.
- "Em quanto tempo terei resultado?" A Gabriela responde com outra pergunta: quantas vezes você prometeu começar algo e não começou? O tempo do resultado depende das ações da aluna.
- Sonhos sem ação são só sonhos. Sem ação, este seria "só mais um treinamento".
- O primeiro passo não precisa ser perfeito. Pode ser assistir a uma aula, pôr uma ideia no papel ou abrir as ferramentas para explorar.
- Medo: todo mundo sente. A diferença está em deixar o medo paralisar ou usá-lo como combustível.
- Constância: pequenas ações consistentes. Tentar tudo de uma vez leva à frustração.
- Apoio: existe a comunidade e um suporte individual no WhatsApp.', 'approved', ARRAY['Quanto custa não começar hoje','quanto custa não começar','Suprema','Método GV','método do GV','suporte individual','suporte 24 horas','WhatsApp']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M03.A03-03', 'principal', 1, 3, 'V1.M03.A03 — Quanto custa NÃO começar hoje', 'Procedimento: o que a aluna deve fazer', 'Quanto custa NÃO começar hoje', 'Método Sócia Invisível › Módulo 03 – Rota da Liberdade › Aula 03 – Quanto custa NÃO começar hoje › Procedimento: o que a aluna deve fazer

1. Exercício de visualização:
  - responder: o que está em jogo para mim? O que eu quero mudar na minha vida? (conforto para a família, liberdade, controle da própria vida);
  - fechar os olhos e imaginar como seria viver essa realidade;
  - abrir os olhos e responder: o que estou disposta a fazer para tornar isso real?
2. Dar o primeiro passo hoje, qualquer um: assistir à próxima aula, escrever uma ideia ou explorar as ferramentas.
3. Ritmo: assistir uma aula por dia, aplicar, testar, ajustar e melhorar.
4. Decidir: sair da aula com a frase "Vou começar agora."
5. Seguir para a Aula 04 do Módulo 03.', 'approved', ARRAY['Quanto custa não começar hoje','quanto custa não começar','Suprema','Método GV','método do GV','suporte individual','suporte 24 horas','WhatsApp']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M03.A03-04', 'principal', 1, 3, 'V1.M03.A03 — Quanto custa NÃO começar hoje', 'FAQ', 'Quanto custa NÃO começar hoje', 'Método Sócia Invisível › Módulo 03 – Rota da Liberdade › Aula 03 – Quanto custa NÃO começar hoje › Pontos para o suporte

- "Em quanto tempo vou ter resultado?" A aula não dá prazo. Ela diz que o tempo depende das ações e da constância da aluna. O suporte deve seguir essa linha e evitar prometer prazos.
- "Estou com medo de não dar certo." A aula acolhe o medo como parte do processo. O caminho é dar passos pequenos e constantes.
- "Onde tiro dúvidas?" Na comunidade, ou no suporte individual pelo WhatsApp para questões pessoais.', 'approved', ARRAY['Quanto custa não começar hoje','quanto custa não começar','Suprema','Método GV','método do GV','suporte individual','suporte 24 horas','WhatsApp']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M03.A04-01', 'principal', 1, 3, 'V1.M03.A04 — Home Office Master & Produtividade Inteligente', 'Visão geral', 'Home Office Master & Produtividade Inteligente', 'Método Sócia Invisível › Módulo 03 – Rota da Liberdade › Aula 04 – Home Office Master & Produtividade Inteligente › Visão geral da aula

Nome oficial da aula: Home Office Master & Produtividade Inteligente
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 03 – Rota da Liberdade, Aula 04
Duração/formato: 6:20
Link na área de membros (abre a página do Módulo 03, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/3

Resumo:
É uma aula prática sobre organizar a rotina para fazer as demandas, pensada para quem concilia CLT, filhos e casa com pouco apoio. A Gabriela ensina a:
- definir e deixar à vista o seu porquê;
- eliminar ou delegar o que não é essencial;
- trabalhar em blocos de foco de 25 a 50 minutos;
- começar o dia pela responsabilidade mais importante;
- criar um espaço sagrado de trabalho;
- pedir apoio à família.
A frase-chave é: "Produtividade inteligente não é trabalhar mais, é trabalhar melhor."', 'approved', ARRAY['Home Office','Home Oficce','home office master','produtividade inteligente','rotina','organização do tempo','seu porquê','propósito','blocos de foco','pomodoro','cronômetro','a única coisa','responsabilidade mais importante do dia','espaço sagrado','cantinho de trabalho']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M03.A04-02', 'principal', 1, 3, 'V1.M03.A04 — Home Office Master & Produtividade Inteligente', 'Procedimento: passo a passo', 'Home Office Master & Produtividade Inteligente', 'Método Sócia Invisível › Módulo 03 – Rota da Liberdade › Aula 04 – Home Office Master & Produtividade Inteligente › Procedimento: passo a passo

1. Definir o seu porquê
  - Escrever num papel, de forma específica, o motivo de estar fazendo isso. Exemplo: "Quero ter liberdade financeira para passar mais tempo com os meus filhos e dar a eles uma vida melhor."
  - Colar num lugar visível (espelho do banheiro, mesa de trabalho) e reler quando bater o desânimo.
2. Escolher o essencial
  - Listar todas as responsabilidades.
  - Para cada uma, perguntar: isso realmente precisa ser feito? Isso me leva mais perto do meu objetivo?
  - Se a resposta for não, eliminar ou delegar. Não ter medo de dizer não.
3. Trabalhar em blocos de foco
  - Blocos de 25 a 50 minutos, com uma tarefa por vez. Exemplo: com 2 horas por dia, dividir em blocos.
  - Durante o bloco: desligar as notificações, fechar as redes sociais e avisar a família.
  - Usar um cronômetro para marcar cada bloco.
4. Começar pela "única coisa"
  - Todo dia, perguntar: qual é a única coisa que, feita, torna o resto mais fácil ou desnecessário?
  - Fazer isso antes de abrir WhatsApp, redes sociais ou e-mail.
  - Exemplo nas demandas: revisar o fluxo de trabalho e terminar as demandas já começadas antes de responder mensagens.
5. Criar um espaço sagrado de trabalho
  - Pode ser uma mesa na sala ou um cantinho no quarto.
  - Deixar claro para quem mora com você que ali é o momento de foco.
6. Pedir apoio à família
  - Explicar o que você está construindo, negociar e dividir as tarefas da casa.
  - Delegar tarefas domésticas quando possível.
7. Usar os horários estratégicos
  - Aproveitar quando os filhos estão dormindo ou entretidos para as tarefas mais importantes.
8. Avançar em pequenas etapas
  - Dividir objetivos grandes. Exemplo da aula: 20 propostas viram 5 por dia.
  - Comemorar cada vitória, respeitar o próprio ritmo e se comparar só com a sua versão de ontem.
### Tarefa de saída (3 ações)
1. Escrever o seu propósito e deixá-lo em um lugar visível.
2. Identificar a responsabilidade mais importante do dia e começar por ela.
3. Eliminar uma responsabilidade que não leva ao objetivo.', 'approved', ARRAY['Home Office','Home Oficce','home office master','produtividade inteligente','rotina','organização do tempo','seu porquê','propósito','blocos de foco','pomodoro','cronômetro','a única coisa','responsabilidade mais importante do dia','espaço sagrado','cantinho de trabalho']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M03.A04-03', 'principal', 1, 3, 'V1.M03.A04 — Home Office Master & Produtividade Inteligente', 'FAQ', 'Home Office Master & Produtividade Inteligente', 'Método Sócia Invisível › Módulo 03 – Rota da Liberdade › Aula 04 – Home Office Master & Produtividade Inteligente › Pontos para o suporte

- "Trabalho CLT e tenho filhos, não tenho tempo." A aula foi feita para esse caso: blocos de foco curtos (25 a 50 min), horários em que os filhos dormem e dividir tarefas com a família.
- "Como organizo meu dia?" Começar pela tarefa mais importante (por exemplo, terminar as demandas em andamento) antes de abrir WhatsApp e redes sociais, trabalhando em blocos com cronômetro.
- "Estou desanimada." Reler o "porquê" escrito no papel. Pequenas ações constantes valem mais do que fazer tudo de uma vez.', 'approved', ARRAY['Home Office','Home Oficce','home office master','produtividade inteligente','rotina','organização do tempo','seu porquê','propósito','blocos de foco','pomodoro','cronômetro','a única coisa','responsabilidade mais importante do dia','espaço sagrado','cantinho de trabalho']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M06.A01-01', 'principal', 1, 6, 'V1.M06.A01 — A Mentira que Contaram Sobre Suas Habilidades', 'Visão geral', 'A Mentira que Contaram Sobre Suas Habilidades', 'Método Sócia Invisível › Módulo 06 – Descobrindo as Habilidades que Você Já Possui › Aula 01 – A Mentira que Contaram Sobre Suas Habilidades › Visão geral da aula

Nome oficial da aula: A Mentira que Contaram Sobre Suas Habilidades
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 06 – Descobrindo as Habilidades que Você Já Possui, Aula 01
Duração/formato: PDF (21 páginas)
Título dentro do material (PDF): Aula 1: Mapeando Seus Superpoderes Cotidianos
Link na área de membros (abre a página do Módulo 06, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/6

Resumo:
É um material em PDF que mostra que a aluna já tem as habilidades para fazer subdemandas, sem precisar de curso ou faculdade. O problema, segundo o material, é a "síndrome da invisibilidade feminina": ela faz tanta coisa no automático que não vê valor nisso, e a sociedade trata essas tarefas como "coisas de mulher" ou "coisas básicas". O material ensina o método dos 5 círculos para mapear esses "superpoderes" e dá 5 passos para transformar o mapeamento em oportunidades.', 'approved', ARRAY['A mentira que contaram sobre suas habilidades','Mapeando seus superpoderes cotidianos','superpoderes','Descobrindo as habilidades que você já possui','Descobrindo habilidades que você já possui','método dos cinco círculos','5 círculos','mapeamento de habilidades','síndrome da invisibilidade feminina','gestora familiar','especialista em atendimento']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M06.A01-02', 'principal', 1, 6, 'V1.M06.A01 — A Mentira que Contaram Sobre Suas Habilidades', 'Caso citado: Angélica', 'A Mentira que Contaram Sobre Suas Habilidades', 'Método Sócia Invisível › Módulo 06 – Descobrindo as Habilidades que Você Já Possui › Aula 01 – A Mentira que Contaram Sobre Suas Habilidades › Caso citado: Angélica

Dona de casa, mãe de 3, dizia não ter nenhuma habilidade. O material diz que hoje ela ganha R$ 7.800/mês fazendo para outras pessoas o que já fazia em casa:
| O que fazia em casa | O que passou a oferecer |
|---|---|
| Organizava a agenda da família | Organização de agenda de pequenos empresários (assistente virtual) |
| Pesquisava preços antes de comprar | Pesquisa de mercado para lojas |
| Escrevia bilhetinhos para os filhos | Posts para redes sociais de negócios familiares |', 'approved', ARRAY['A mentira que contaram sobre suas habilidades','Mapeando seus superpoderes cotidianos','superpoderes','Descobrindo as habilidades que você já possui','Descobrindo habilidades que você já possui','método dos cinco círculos','5 círculos','mapeamento de habilidades','síndrome da invisibilidade feminina','gestora familiar','especialista em atendimento']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M06.A01-03', 'principal', 1, 6, 'V1.M06.A01 — A Mentira que Contaram Sobre Suas Habilidades', 'Método dos 5 círculos', 'A Mentira que Contaram Sobre Suas Habilidades', 'Método Sócia Invisível › Módulo 06 – Descobrindo as Habilidades que Você Já Possui › Aula 01 – A Mentira que Contaram Sobre Suas Habilidades › Método dos 5 círculos

| Círculo | Tipo de habilidade | Exemplos do material |
|---|---|---|
| 1 | Domésticas que viraram profissões | Organizar a casa → personal organizer (R$ 50–100/h). Cozinhar → chef particular (R$ 80–200/evento). Plantas → paisagismo (R$ 100–300/projeto). Decorar → design de interiores (R$ 200–500/consultoria). Cuidar de crianças → babá (R$ 20–40/h). Ensinar → aula particular (R$ 30–80/h). |
| 2 | Profissionais que você subestima | Recepcionista: atendimento e agenda. Vendedora: negociação e objeções. Auxiliar administrativa: documentos, planilhas e prazos. Atendente: conflitos. Operadora de caixa: contas rápidas e pressão. Faxineira: organização e eficiência. |
| 3 | Pessoais que você não valoriza | Organização. Detalhismo: revisão e controle de qualidade. Paciência: atendimento e suporte. Criatividade: conteúdo e design. Comunicação. Persistência: pesquisa e prospecção. Empatia. |
| 4 | Tecnológicas que você não percebe | Instagram: gestão de redes (R$ 500–2.000/mês). WhatsApp Business: atendimento. Computador: digitação, formatação e pesquisa. Fotos e edição no celular para pequenos negócios. |
| 5 | De relacionamento | Mediação de conflitos, motivação, ensino, aconselhamento, escuta. |', 'approved', ARRAY['A mentira que contaram sobre suas habilidades','Mapeando seus superpoderes cotidianos','superpoderes','Descobrindo as habilidades que você já possui','Descobrindo habilidades que você já possui','método dos cinco círculos','5 círculos','mapeamento de habilidades','síndrome da invisibilidade feminina','gestora familiar','especialista em atendimento']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M06.A01-04', 'principal', 1, 6, 'V1.M06.A01 — A Mentira que Contaram Sobre Suas Habilidades', 'Procedimento: do mapeamento à oportunidade', 'A Mentira que Contaram Sobre Suas Habilidades', 'Método Sócia Invisível › Módulo 06 – Descobrindo as Habilidades que Você Já Possui › Aula 01 – A Mentira que Contaram Sobre Suas Habilidades › Procedimento: do mapeamento à oportunidade

1. Fazer uma lista honesta: anotar num papel tudo o que faz durante uma semana.
2. Identificar padrões: o que você faz com mais facilidade? Que problemas resolve melhor que os outros?
3. Pesquisar o mercado: para cada habilidade, verificar se existe demanda.
4. Começar pequeno: escolher uma habilidade em que tem confiança e oferecer a alguém conhecido.
5. Documentar os resultados: fotos de antes e depois, depoimentos e resultados alcançados.', 'approved', ARRAY['A mentira que contaram sobre suas habilidades','Mapeando seus superpoderes cotidianos','superpoderes','Descobrindo as habilidades que você já possui','Descobrindo habilidades que você já possui','método dos cinco círculos','5 círculos','mapeamento de habilidades','síndrome da invisibilidade feminina','gestora familiar','especialista em atendimento']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M06.A01-05', 'principal', 1, 6, 'V1.M06.A01 — A Mentira que Contaram Sobre Suas Habilidades', 'Missão até a próxima aula', 'A Mentira que Contaram Sobre Suas Habilidades', 'Método Sócia Invisível › Módulo 06 – Descobrindo as Habilidades que Você Já Possui › Aula 01 – A Mentira que Contaram Sobre Suas Habilidades › Missão até a próxima aula

1. Fazer o mapeamento dos 5 círculos.
2. Anotar pelo menos 3 habilidades em cada círculo, 15 no total.
3. Pesquisar quanto o mercado paga por essas habilidades.
4. Parar de se diminuir. Você não é "só" dona de casa, é gestora familiar. Não é "só" recepcionista, é especialista em atendimento.', 'approved', ARRAY['A mentira que contaram sobre suas habilidades','Mapeando seus superpoderes cotidianos','superpoderes','Descobrindo as habilidades que você já possui','Descobrindo habilidades que você já possui','método dos cinco círculos','5 círculos','mapeamento de habilidades','síndrome da invisibilidade feminina','gestora familiar','especialista em atendimento']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M06.A01-06', 'principal', 1, 6, 'V1.M06.A01 — A Mentira que Contaram Sobre Suas Habilidades', 'FAQ', 'A Mentira que Contaram Sobre Suas Habilidades', 'Método Sócia Invisível › Módulo 06 – Descobrindo as Habilidades que Você Já Possui › Aula 01 – A Mentira que Contaram Sobre Suas Habilidades › Pontos para o suporte

- "Não tenho nenhuma habilidade / não sei fazer nada." Indicar este PDF e o método dos 5 círculos. O caso da Angélica mostra que tarefas de casa viram serviços.
- "Preciso fazer curso ou faculdade?" Não, segundo o material. A aluna já tem as habilidades.
- "Esta aula é em vídeo?" Não. É um material em PDF para ler e fazer o exercício.
- Valores da Angélica e as tabelas de preço: são referências do material, não promessa de ganho.', 'approved', ARRAY['A mentira que contaram sobre suas habilidades','Mapeando seus superpoderes cotidianos','superpoderes','Descobrindo as habilidades que você já possui','Descobrindo habilidades que você já possui','método dos cinco círculos','5 círculos','mapeamento de habilidades','síndrome da invisibilidade feminina','gestora familiar','especialista em atendimento']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M06.A02-01', 'principal', 1, 6, 'V1.M06.A02 — Traduzindo a Rotina para o Mercado Digital', 'Visão geral', 'Traduzindo a Rotina para o Mercado Digital', 'Método Sócia Invisível › Módulo 06 – Descobrindo as Habilidades que Você Já Possui › Aula 02 – Traduzindo a Rotina para o Mercado Digital › Visão geral da aula

Nome oficial da aula: Traduzindo a Rotina para o Mercado Digital
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 06 – Descobrindo as Habilidades que Você Já Possui, Aula 02
Duração/formato: PDF (29 páginas)
Título dentro do material (PDF): Aula 2: Transformando Habilidades em Linguagem de Mercado
Link na área de membros (abre a página do Módulo 06, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/6

Resumo:
É um material em PDF que continua a Aula 01. Depois de mapear as habilidades, a aluna aprende a descrevê-las em linguagem profissional para que o cliente perceba o valor delas. O material traz:
- as palavras a evitar e as palavras a usar;
- um dicionário de tradução por categoria;
- uma fórmula para nomear a própria especialidade;
- um passo a passo para criar o elevator pitch, a apresentação de 30 segundos.
A ideia central é: "A mágica está na linguagem. Você não está mentindo, está usando as palavras certas."', 'approved', ARRAY['Traduzindo a rotina para o mercado digital','Transformando habilidades em linguagem de mercado','linguagem de mercado','linguagem profissional','tradução profissional','dicionário de tradução profissional','fórmula mágica da linguagem','Especialista em + habilidade + e + resultado','elevator pitch','pitch','apresentação de 30 segundos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M06.A02-02', 'principal', 1, 6, 'V1.M06.A02 — Traduzindo a Rotina para o Mercado Digital', 'Regra 1: parar de diminuir o próprio trabalho', 'Traduzindo a Rotina para o Mercado Digital', 'Método Sócia Invisível › Módulo 06 – Descobrindo as Habilidades que Você Já Possui › Aula 02 – Traduzindo a Rotina para o Mercado Digital › Regra 1: parar de diminuir o próprio trabalho

| ❌ Evitar | ✅ Usar |
|---|---|
| "Só", "apenas", "simples", "básico", "qualquer um pode", "não é nada demais" | Especialista, consultora, estrategista, mentora, facilitadora, organizadora, gestora, criadora, desenvolvedora |
| "Eu só cuido de casa." | "Eu sou especialista em gestão doméstica." |
| "Eu só organizo as coisas." | "Eu sou consultora em organização." |
| "Eu só converso com as pessoas." | "Eu sou especialista em relacionamento com cliente." |', 'approved', ARRAY['Traduzindo a rotina para o mercado digital','Transformando habilidades em linguagem de mercado','linguagem de mercado','linguagem profissional','tradução profissional','dicionário de tradução profissional','fórmula mágica da linguagem','Especialista em + habilidade + e + resultado','elevator pitch','pitch','apresentação de 30 segundos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M06.A02-03', 'principal', 1, 6, 'V1.M06.A02 — Traduzindo a Rotina para o Mercado Digital', 'Dicionário de tradução profissional', 'Traduzindo a Rotina para o Mercado Digital', 'Método Sócia Invisível › Módulo 06 – Descobrindo as Habilidades que Você Já Possui › Aula 02 – Traduzindo a Rotina para o Mercado Digital › Dicionário de tradução profissional

| Área | Em vez de… | Diga… |
|---|---|---|
| Casa | "Eu arrumo casa." | Gestão doméstica e organização de ambientes |
|  | "Eu limpo tudo." | Especialista em limpeza profissional e manutenção de ambientes |
|  | "Eu organizo as coisas." | Consultora em organização e otimização de espaços |
| Atendimento | "Eu só atendo telefone." | Especialista em atendimento ao cliente e relacionamento |
|  | "Eu converso com os clientes." | Consultora em experiência do cliente |
|  | "Eu resolvo problemas." | Especialista em resolução de conflitos e suporte |
| Redes sociais | "Eu mexo no Instagram." | Gestora de mídias sociais e conteúdo digital |
|  | "Eu posto fotos." | Criadora de conteúdo visual e estratégia digital |
|  | "Eu respondo mensagens." | Especialista em atendimento digital e relacionamento online |
| Cozinha | "Eu faço comida." | Chef particular e consultora gastronômica |
|  | "Eu sei fazer doce." | Confeiteira especializada e consultora em doces artesanais |', 'approved', ARRAY['Traduzindo a rotina para o mercado digital','Transformando habilidades em linguagem de mercado','linguagem de mercado','linguagem profissional','tradução profissional','dicionário de tradução profissional','fórmula mágica da linguagem','Especialista em + habilidade + e + resultado','elevator pitch','pitch','apresentação de 30 segundos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M06.A02-04', 'principal', 1, 6, 'V1.M06.A02 — Traduzindo a Rotina para o Mercado Digital', 'Fórmula da linguagem profissional', 'Traduzindo a Rotina para o Mercado Digital', 'Método Sócia Invisível › Módulo 06 – Descobrindo as Habilidades que Você Já Possui › Aula 02 – Traduzindo a Rotina para o Mercado Digital › Fórmula da linguagem profissional

"Especialista em" + [habilidade principal] + "e" + [resultado específico que entrega]
Exemplos: "Especialista em organização doméstica e otimização de tempo". "Especialista em atendimento ao cliente e fidelização".', 'approved', ARRAY['Traduzindo a rotina para o mercado digital','Transformando habilidades em linguagem de mercado','linguagem de mercado','linguagem profissional','tradução profissional','dicionário de tradução profissional','fórmula mágica da linguagem','Especialista em + habilidade + e + resultado','elevator pitch','pitch','apresentação de 30 segundos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M06.A02-05', 'principal', 1, 6, 'V1.M06.A02 — Traduzindo a Rotina para o Mercado Digital', 'Procedimento: criar o elevator pitch', 'Traduzindo a Rotina para o Mercado Digital', 'Método Sócia Invisível › Módulo 06 – Descobrindo as Habilidades que Você Já Possui › Aula 02 – Traduzindo a Rotina para o Mercado Digital › Procedimento: criar o elevator pitch

Estrutura:
"Oi, eu sou [nome], especialista em [área de atuação]. Eu ajudo [quem você ajuda] a [resultado que entrega] através de [como você faz isso]."
Passo a passo:
1. Escolher a habilidade principal da lista feita na Aula 01.
2. Definir quem você ajuda: mulheres ocupadas, pequenos empresários, mães que trabalham fora, pessoas idosas.
3. Definir o resultado concreto: casa organizada, clientes satisfeitos, crianças bem cuidadas, tempo otimizado.
4. Definir como você faz: consultoria presencial, atendimento online, visitas domiciliares, orientação por WhatsApp.
5. Montar a frase completa.
Exemplos do material:
- "Oi, eu sou a Carla, especialista em organização de ambientes. Eu ajudo mulheres ocupadas a terem uma casa organizada e funcional através de consultoria personalizada e sistemas práticos de organização."
- "Oi, eu sou a Ana, especialista em atendimento ao cliente. Eu ajudo pequenos negócios a fidelizarem seus clientes através de atendimento humanizado e estratégias de relacionamento."', 'approved', ARRAY['Traduzindo a rotina para o mercado digital','Transformando habilidades em linguagem de mercado','linguagem de mercado','linguagem profissional','tradução profissional','dicionário de tradução profissional','fórmula mágica da linguagem','Especialista em + habilidade + e + resultado','elevator pitch','pitch','apresentação de 30 segundos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M06.A02-06', 'principal', 1, 6, 'V1.M06.A02 — Traduzindo a Rotina para o Mercado Digital', 'Missão até a próxima aula', 'Traduzindo a Rotina para o Mercado Digital', 'Método Sócia Invisível › Módulo 06 – Descobrindo as Habilidades que Você Já Possui › Aula 02 – Traduzindo a Rotina para o Mercado Digital › Missão até a próxima aula

1. Reescrever cada habilidade da lista da Aula 01 em linguagem profissional, usando o dicionário.
2. Escrever o elevator pitch completo com a fórmula e treinar no espelho pelo menos 5 vezes.
3. Começar a se apresentar com a nova linguagem, testando com a família, amigos e conhecidos.', 'approved', ARRAY['Traduzindo a rotina para o mercado digital','Transformando habilidades em linguagem de mercado','linguagem de mercado','linguagem profissional','tradução profissional','dicionário de tradução profissional','fórmula mágica da linguagem','Especialista em + habilidade + e + resultado','elevator pitch','pitch','apresentação de 30 segundos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M06.A02-07', 'principal', 1, 6, 'V1.M06.A02 — Traduzindo a Rotina para o Mercado Digital', 'Casos citados', 'Traduzindo a Rotina para o Mercado Digital', 'Método Sócia Invisível › Módulo 06 – Descobrindo as Habilidades que Você Já Possui › Aula 02 – Traduzindo a Rotina para o Mercado Digital › Casos citados

- Carla: "eu só arrumo casa" virou "consultora em organização", e ela passou a cobrar mais. O material diz que a primeira frase "vale zero reais" e a segunda "vale R$ 150 por hora".
- Mariana: "só cuidava de redes sociais", virou "gestora de mídias sociais" e hoje ganha R$ 10.500/mês.
- Exemplo do guarda-roupa: "consultora em organização de vestuário" cobra R$ 250 por consultoria.', 'approved', ARRAY['Traduzindo a rotina para o mercado digital','Transformando habilidades em linguagem de mercado','linguagem de mercado','linguagem profissional','tradução profissional','dicionário de tradução profissional','fórmula mágica da linguagem','Especialista em + habilidade + e + resultado','elevator pitch','pitch','apresentação de 30 segundos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M06.A02-08', 'principal', 1, 6, 'V1.M06.A02 — Traduzindo a Rotina para o Mercado Digital', 'FAQ', 'Traduzindo a Rotina para o Mercado Digital', 'Método Sócia Invisível › Módulo 06 – Descobrindo as Habilidades que Você Já Possui › Aula 02 – Traduzindo a Rotina para o Mercado Digital › Pontos para o suporte

- "Não sei como me apresentar / como oferecer meu trabalho." Indicar este PDF: o dicionário de tradução e a fórmula do elevator pitch.
- "Isso não é mentir?" O próprio material responde: não é mentira, é descrever o que você já faz com as palavras certas.
- "Esta aula é em vídeo?" Não. É um material em PDF.', 'approved', ARRAY['Traduzindo a rotina para o mercado digital','Transformando habilidades em linguagem de mercado','linguagem de mercado','linguagem profissional','tradução profissional','dicionário de tradução profissional','fórmula mágica da linguagem','Especialista em + habilidade + e + resultado','elevator pitch','pitch','apresentação de 30 segundos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M06.A03-01', 'principal', 1, 6, 'V1.M06.A03 — O Seu Inventário de Ouro', 'Visão geral', 'O Seu Inventário de Ouro', 'Método Sócia Invisível › Módulo 06 – Descobrindo as Habilidades que Você Já Possui › Aula 03 – O Seu Inventário de Ouro › Visão geral da aula

Nome oficial da aula: O Seu Inventário de Ouro
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 06 – Descobrindo as Habilidades que Você Já Possui, Aula 03
Duração/formato: PDF (18 páginas)
Título dentro do material (PDF): Aula 3: Seu Diferencial como Vantagem Competitiva
Link na área de membros (abre a página do Módulo 06, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/6

Resumo:
É um material em PDF de mentalidade e autovalorização. A tese é que ser mulher não é desvantagem, é vantagem competitiva. O mercado, segundo o material, cansou de interações frias e impessoais e hoje valoriza quem ouve, compreende e se importa. O PDF apresenta 6 diferenciais naturais que a aluna já tem e como cada um gera valor no mercado digital. A mensagem final é: "Você não precisa mudar sua essência para prosperar, só aprender a usar o que já tem da forma certa."', 'approved', ARRAY['O seu inventário de ouro','inventário de ouro','Seu diferencial como vantagem competitiva','diferencial','vantagem competitiva','ser mulher é vantagem','mito da desvantagem','empatia','atenção aos detalhes','multitarefa','comunicação que conecta','cuidado','intuição','inteligência emocional','comunicação emocional']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M06.A03-02', 'principal', 1, 6, 'V1.M06.A03 — O Seu Inventário de Ouro', 'O mito da desvantagem', 'O Seu Inventário de Ouro', 'Método Sócia Invisível › Módulo 06 – Descobrindo as Habilidades que Você Já Possui › Aula 03 – O Seu Inventário de Ouro › O mito da desvantagem

Frases que a aluna deve deixar de acreditar: "você precisa se esforçar o dobro", "o mercado é difícil para mulheres", "é preciso agir de forma mais dura". O caso citado é o de uma aluna que se achava "sensível e emotiva demais" e hoje usa essa sensibilidade para ajudar pequenos negócios a se conectarem com as pessoas.', 'approved', ARRAY['O seu inventário de ouro','inventário de ouro','Seu diferencial como vantagem competitiva','diferencial','vantagem competitiva','ser mulher é vantagem','mito da desvantagem','empatia','atenção aos detalhes','multitarefa','comunicação que conecta','cuidado','intuição','inteligência emocional','comunicação emocional']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M06.A03-03', 'principal', 1, 6, 'V1.M06.A03 — O Seu Inventário de Ouro', 'Os 6 diferenciais naturais', 'O Seu Inventário de Ouro', 'Método Sócia Invisível › Módulo 06 – Descobrindo as Habilidades que Você Já Possui › Aula 03 – O Seu Inventário de Ouro › Os 6 diferenciais naturais

| # | Diferencial | O que é | Valor no mercado |
|---|---|---|---|
| 1 | Empatia | Inteligência emocional: perceber o que o outro sente e precisa | Cria conexões verdadeiras. |
| 2 | Atenção aos detalhes | Cuidado com a qualidade | Evita erros que dão prejuízo, como um texto mal escrito ou uma data esquecida. |
| 3 | Fazer várias coisas ao mesmo tempo | Organização e gestão | Lidar com várias demandas e responsabilidades. |
| 4 | Comunicação que conecta | Comunicação clara, envolvente e emocional | Grande diferencial no digital. Exemplo: aluna que começou escrevendo textos simples para uma loja e hoje cria conteúdos que geram resultado. |
| 5 | Cuidado com o que faz | Dedicação e excelência | Quem se preocupa com o resultado final se destaca. |
| 6 | Intuição | Leitura e análise: antecipar necessidades e problemas | Criar soluções antes de o problema aparecer. |
O que o mercado quer, e a aluna já tem: atenção verdadeira, cuidado com os detalhes, comunicação clara e empática, dedicação real e capacidade de criar conexões.', 'approved', ARRAY['O seu inventário de ouro','inventário de ouro','Seu diferencial como vantagem competitiva','diferencial','vantagem competitiva','ser mulher é vantagem','mito da desvantagem','empatia','atenção aos detalhes','multitarefa','comunicação que conecta','cuidado','intuição','inteligência emocional','comunicação emocional']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M06.A03-04', 'principal', 1, 6, 'V1.M06.A03 — O Seu Inventário de Ouro', 'Procedimento: o que a aluna deve fazer', 'O Seu Inventário de Ouro', 'Método Sócia Invisível › Módulo 06 – Descobrindo as Habilidades que Você Já Possui › Aula 03 – O Seu Inventário de Ouro › Procedimento: o que a aluna deve fazer

O material não traz exercício nem missão formal. A orientação implícita é:
1. Ler o PDF e reconhecer quais dos 6 diferenciais você tem, relacionando-os às habilidades mapeadas nas Aulas 01 e 02.
2. Valorizar essas características em vez de tentar mudá-las.
3. Seguir para a Aula 04 do Módulo 06, que ensina a criar o primeiro portfólio.', 'approved', ARRAY['O seu inventário de ouro','inventário de ouro','Seu diferencial como vantagem competitiva','diferencial','vantagem competitiva','ser mulher é vantagem','mito da desvantagem','empatia','atenção aos detalhes','multitarefa','comunicação que conecta','cuidado','intuição','inteligência emocional','comunicação emocional']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M06.A03-05', 'principal', 1, 6, 'V1.M06.A03 — O Seu Inventário de Ouro', 'FAQ', 'O Seu Inventário de Ouro', 'Método Sócia Invisível › Módulo 06 – Descobrindo as Habilidades que Você Já Possui › Aula 03 – O Seu Inventário de Ouro › Pontos para o suporte

- "Sou muito sensível / emotiva, isso atrapalha?" Segundo o material, não. Empatia e sensibilidade são diferenciais valorizados.
- "O que eu faço com esse PDF?" Ler, identificar os seus diferenciais entre os 6 e seguir para a próxima aula, sobre portfólio.
- "Esta aula é em vídeo?" Não. É um material em PDF.', 'approved', ARRAY['O seu inventário de ouro','inventário de ouro','Seu diferencial como vantagem competitiva','diferencial','vantagem competitiva','ser mulher é vantagem','mito da desvantagem','empatia','atenção aos detalhes','multitarefa','comunicação que conecta','cuidado','intuição','inteligência emocional','comunicação emocional']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M06.A04-01', 'principal', 1, 6, 'V1.M06.A04 — Como Empacotar o que Você Sabe', 'Visão geral', 'Como Empacotar o que Você Sabe', 'Método Sócia Invisível › Módulo 06 – Descobrindo as Habilidades que Você Já Possui › Aula 04 – Como Empacotar o que Você Sabe › Visão geral da aula

Nome oficial da aula: Como Empacotar o que Você Sabe
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 06 – Descobrindo as Habilidades que Você Já Possui, Aula 04
Duração/formato: PDF (19 páginas)
Título dentro do material (PDF): Aula 4: Criando Seu Primeiro Portfólio com o que Você Já Fez
Link na área de membros (abre a página do Módulo 06, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/6

Resumo:
É um material prático que ensina a montar o primeiro portfólio, mesmo sem experiência, sem ter trabalhado na área e sem clientes pagos. O PDF mostra como transformar experiências do dia a dia em cases profissionais com uma estrutura de 5 partes, sugere criar trabalhos para clientes fictícios quando não houver nenhuma experiência e indica ferramentas gratuitas para montar o portfólio. Também cita o bônus "Skills das Sub Demandas", com treinamentos práticos e certificado.
A mensagem central é: "Você não precisa de experiência. Precisa DECIDIR que vai começar."', 'approved', ARRAY['Como empacotar o que você sabe','empacotar','portfólio','portifólio','primeiro portfólio','cases','case profissional','estrutura de case','clientes fictícios','materiais fictícios','Skills das Sub Demandas','Skills das Subdemandas','Instagram Business','Google Drive','WhatsApp Business','catálogo','Canva']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M06.A04-02', 'principal', 1, 6, 'V1.M06.A04 — Como Empacotar o que Você Sabe', 'O que é portfólio (segundo o material)', 'Como Empacotar o que Você Sabe', 'Método Sócia Invisível › Módulo 06 – Descobrindo as Habilidades que Você Já Possui › Aula 04 – Como Empacotar o que Você Sabe › O que é portfólio (segundo o material)

Portfólio não é só trabalho pago. É uma prova de que você sabe fazer o que diz: resultados concretos, antes e depois, problemas resolvidos e pessoas ajudadas.', 'approved', ARRAY['Como empacotar o que você sabe','empacotar','portfólio','portifólio','primeiro portfólio','cases','case profissional','estrutura de case','clientes fictícios','materiais fictícios','Skills das Sub Demandas','Skills das Subdemandas','Instagram Business','Google Drive','WhatsApp Business','catálogo','Canva']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M06.A04-03', 'principal', 1, 6, 'V1.M06.A04 — Como Empacotar o que Você Sabe', 'Caso citado: Luciana', 'Como Empacotar o que Você Sabe', 'Método Sócia Invisível › Módulo 06 – Descobrindo as Habilidades que Você Já Possui › Aula 04 – Como Empacotar o que Você Sabe › Caso citado: Luciana

Dizia "não tenho nada para mostrar". Numa conversa, descobriu que tinha:
- organizado o casamento da irmã, para 200 pessoas;
- coordenado uma arrecadação de R$ 15.000 na escola dos filhos;
- criado um sistema de organização doméstica que 3 vizinhas copiaram.
Hoje tem um portfólio de organizadora de eventos.', 'approved', ARRAY['Como empacotar o que você sabe','empacotar','portfólio','portifólio','primeiro portfólio','cases','case profissional','estrutura de case','clientes fictícios','materiais fictícios','Skills das Sub Demandas','Skills das Subdemandas','Instagram Business','Google Drive','WhatsApp Business','catálogo','Canva']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M06.A04-04', 'principal', 1, 6, 'V1.M06.A04 — Como Empacotar o que Você Sabe', 'Procedimento: montar o portfólio', 'Como Empacotar o que Você Sabe', 'Método Sócia Invisível › Módulo 06 – Descobrindo as Habilidades que Você Já Possui › Aula 04 – Como Empacotar o que Você Sabe › Procedimento: montar o portfólio

### 1. Levantar experiências que já viraram "trabalho"
| Área | O que pode entrar no portfólio |
|---|---|
| Design | Convites de aniversário, apresentações de PowerPoint, artes para amigos e família, fotos editadas a pedido de alguém |
| Redes sociais | Ajudar alguém a criar perfil no Instagram, organizar postagens de um grupo de WhatsApp, dar ideias para as redes de um amigo |
### 2. Se nunca fez nada: criar para clientes fictícios
Exemplos: criar a identidade visual de uma loja de roupas femininas imaginária ou planejar o calendário de postagens de uma empresa fictícia.
### 3. Transformar cada experiência em case (estrutura de 5 partes)
1. Situação inicial: qual era o problema?
2. Desafio: o que precisava ser resolvido?
3. Solução aplicada: o que você fez, passo a passo.
4. Resultado obtido: números, benefícios ou melhorias.
5. Diferencial: o que você fez de especial.
Exemplo do material, "Gestão de Instagram para Loja de Roupas" (antes: "ajudei minha tia com o Instagram da loja"):
| Parte | Conteúdo |
|---|---|
| Situação inicial | Perfil desorganizado, sem identidade visual, postagens esporádicas e baixo engajamento |
| Desafio | Criar um cronograma, melhorar a estética do feed, aumentar seguidores e interações |
| Solução | Identidade visual simples (cores e fontes), 12 posts por mês (produtos, dicas e promoções), hashtags, interação nos comentários e no direct |
| Resultado | +40% de seguidores em 3 meses. Engajamento de 2% para 8%. Relato de aumento nas vendas |
| Diferencial | Templates editáveis no Canva para a cliente continuar sozinha |
### 4. Montar o portfólio visual
Não precisa ser perfeito. Precisa ser real e mostrar resultados. Ferramentas sugeridas, de preferência usadas juntas:
| Ferramenta | Como usar |
|---|---|
| Instagram Business | Posts organizados em destaques, com antes e depois |
| Google Drive | Pasta compartilhada com links públicos para os cases |
| WhatsApp Business | Catálogo com os serviços |
| Canva | Apresentações visuais simples, enviadas em PDF |', 'approved', ARRAY['Como empacotar o que você sabe','empacotar','portfólio','portifólio','primeiro portfólio','cases','case profissional','estrutura de case','clientes fictícios','materiais fictícios','Skills das Sub Demandas','Skills das Subdemandas','Instagram Business','Google Drive','WhatsApp Business','catálogo','Canva']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M06.A04-05', 'principal', 1, 6, 'V1.M06.A04 — Como Empacotar o que Você Sabe', 'Missão até a próxima aula', 'Como Empacotar o que Você Sabe', 'Método Sócia Invisível › Módulo 06 – Descobrindo as Habilidades que Você Já Possui › Aula 04 – Como Empacotar o que Você Sabe › Missão até a próxima aula

1. Documentar os cases usando a estrutura de 5 partes.
2. Começar a montar o portfólio visual em pelo menos uma das ferramentas.
Na próxima aula, o material promete ensinar as plataformas específicas para começar a trabalhar ainda esta semana.', 'approved', ARRAY['Como empacotar o que você sabe','empacotar','portfólio','portifólio','primeiro portfólio','cases','case profissional','estrutura de case','clientes fictícios','materiais fictícios','Skills das Sub Demandas','Skills das Subdemandas','Instagram Business','Google Drive','WhatsApp Business','catálogo','Canva']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M06.A04-06', 'principal', 1, 6, 'V1.M06.A04 — Como Empacotar o que Você Sabe', 'FAQ', 'Como Empacotar o que Você Sabe', 'Método Sócia Invisível › Módulo 06 – Descobrindo as Habilidades que Você Já Possui › Aula 04 – Como Empacotar o que Você Sabe › Pontos para o suporte

- "Não tenho experiência nem portfólio." Indicar este PDF: portfólio pode incluir experiências pessoais ou trabalhos para clientes fictícios.
- "Onde monto meu portfólio?" Em Instagram Business, Google Drive, catálogo do WhatsApp Business ou Canva (em PDF).
- "O que é o Skills das Sub Demandas?" Segundo o material, é um bônus com treinamentos práticos e certificado para atuar na área escolhida.
- "Esta aula é em vídeo?" Não. É um material em PDF.', 'approved', ARRAY['Como empacotar o que você sabe','empacotar','portfólio','portifólio','primeiro portfólio','cases','case profissional','estrutura de case','clientes fictícios','materiais fictícios','Skills das Sub Demandas','Skills das Subdemandas','Instagram Business','Google Drive','WhatsApp Business','catálogo','Canva']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M07.A01-01', 'principal', 1, 7, 'V1.M07.A01 — O Código das Demandas no 99Freelas', 'Visão geral', 'O Código das Demandas no 99Freelas', 'Método Sócia Invisível › Módulo 07 – O Mapa das Demandas Online › Aula 01 – O Código das Demandas no 99Freelas › Visão geral da aula

Nome oficial da aula: O Código das Demandas no 99Freelas
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 07 – O Mapa das Demandas Online, Aula 01
Duração/formato: 3:22
Link na área de membros (abre a página do Módulo 07, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/7

Resumo:
É a abertura do Módulo 07 e a primeira aula do curso que diz ONDE encontrar as demandas: a plataforma 99Freelas. Segundo a aula, é uma plataforma digital em que empresas, empreendedores e pessoas físicas publicam demandas rápidas que qualquer pessoa disposta a aprender pode executar. A aula apresenta a plataforma e explica por que ela foi escolhida. O passo a passo para criar o perfil fica para a Aula 02.', 'approved', ARRAY['99Freelas','99 Freelas','99 frilas','noventa e nove freelas','O mapa das demandas online','demandas rápidas','site de freelas','freelancer']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M07.A01-02', 'principal', 1, 7, 'V1.M07.A01 — O Código das Demandas no 99Freelas', 'O que a aula diz sobre o 99Freelas', 'O Código das Demandas no 99Freelas', 'Método Sócia Invisível › Módulo 07 – O Mapa das Demandas Online › Aula 01 – O Código das Demandas no 99Freelas › O que a aula diz sobre o 99Freelas

- O que é: plataforma onde empresas, empreendedores e pessoas físicas publicam demandas.
- Exemplos de demandas citados:
  - avaliar produtos e dar opinião;
  - testar aplicativos;
  - responder pesquisas;
  - organizar informações básicas;
  - fazer buscas na internet;
  - criar legendas simples e revisar textos pequenos;
  - interagir em redes sociais;
  - enviar mensagens padronizadas.
- Requisitos: só o celular e determinação. Não precisa de diploma, capital inicial nem sair de casa.
- Facilidade: "tão intuitiva quanto o WhatsApp".
- Custo: a aula diz que é "totalmente gratuita".
- Sem exposição: não é preciso aparecer, vender nem convencer ninguém. Basta executar bem o que foi pedido.', 'approved', ARRAY['99Freelas','99 Freelas','99 frilas','noventa e nove freelas','O mapa das demandas online','demandas rápidas','site de freelas','freelancer']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M07.A01-03', 'principal', 1, 7, 'V1.M07.A01 — O Código das Demandas no 99Freelas', 'Por que o 99Freelas (3 motivos da aula)', 'O Código das Demandas no 99Freelas', 'Método Sócia Invisível › Módulo 07 – O Mapa das Demandas Online › Aula 01 – O Código das Demandas no 99Freelas › Por que o 99Freelas (3 motivos da aula)

1. Confiança: cada demanda concluída prova que a aluna é capaz.
2. Clareza: a aluna descobre de que tipo de tarefa mais gosta e qual é o seu perfil.
3. Experiência real: aprende na prática como funciona o digital, como receber pagamentos e como se relacionar profissionalmente online.', 'approved', ARRAY['99Freelas','99 Freelas','99 frilas','noventa e nove freelas','O mapa das demandas online','demandas rápidas','site de freelas','freelancer']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M07.A01-04', 'principal', 1, 7, 'V1.M07.A01 — O Código das Demandas no 99Freelas', 'Procedimento: o que a aluna deve fazer', 'O Código das Demandas no 99Freelas', 'Método Sócia Invisível › Módulo 07 – O Mapa das Demandas Online › Aula 01 – O Código das Demandas no 99Freelas › Procedimento: o que a aluna deve fazer

1. Assistir à aula para conhecer a plataforma. Não há ação prática nesta aula.
2. Seguir para a Aula 02 do Módulo 07, que mostra tela a tela como criar o perfil no 99Freelas de forma estratégica.', 'approved', ARRAY['99Freelas','99 Freelas','99 frilas','noventa e nove freelas','O mapa das demandas online','demandas rápidas','site de freelas','freelancer']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M07.A01-05', 'principal', 1, 7, 'V1.M07.A01 — O Código das Demandas no 99Freelas', 'FAQ', 'O Código das Demandas no 99Freelas', 'Método Sócia Invisível › Módulo 07 – O Mapa das Demandas Online › Aula 01 – O Código das Demandas no 99Freelas › Pontos para o suporte

- "Onde eu encontro as demandas?" No 99Freelas, apresentado neste módulo. O cadastro é ensinado na Aula 02 do Módulo 07.
- "O 99Freelas é pago?" O cadastro é gratuito, mas a plataforma cobra taxa sobre os projetos e tem planos pagos opcionais. Não dizer que é "totalmente gratuito".
- "Preciso de computador?" Segundo a aula, dá para usar só o celular.
- "O 99Freelas é da Gabriela / do método?" Não. É uma plataforma independente. Problemas de conta, pagamento ou projeto dentro dela precisam ser resolvidos com o suporte do próprio 99Freelas. (Confirmar esta orientação com a equipe.)', 'approved', ARRAY['99Freelas','99 Freelas','99 frilas','noventa e nove freelas','O mapa das demandas online','demandas rápidas','site de freelas','freelancer']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M07.A02-01', 'principal', 1, 7, 'V1.M07.A02 — Construindo Sua Vitrine Digital no 99Freelas', 'Visão geral', 'Construindo Sua Vitrine Digital no 99Freelas', 'Método Sócia Invisível › Módulo 07 – O Mapa das Demandas Online › Aula 02 – Construindo Sua Vitrine Digital no 99Freelas › Visão geral da aula

Nome oficial da aula: Construindo Sua Vitrine Digital no 99Freelas
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 07 – O Mapa das Demandas Online, Aula 02
Duração/formato: 2:28
Link na área de membros (abre a página do Módulo 07, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/7

Resumo:
É uma aula prática, feita com gravação de tela, que ensina passo a passo:
1. criar a conta de freelancer no 99Freelas;
2. preencher o perfil ("vitrine digital");
3. cadastrar a conta bancária para receber pelos microprojetos.
A busca por projetos fica para a Aula 03.', 'approved', ARRAY['99Freelas','99 Freelance','99 Freelas','99 frilas','vitrine digital','editar perfil','criar conta','quero trabalhar','sou freelancer','cadastre-se','título profissional','conte-nos sobre você','resuma sua experiência profissional','áreas de interesse','contas','conta bancária','dados bancários','pessoa física','pessoa jurídica','microprojetos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M07.A02-02', 'principal', 1, 7, 'V1.M07.A02 — Construindo Sua Vitrine Digital no 99Freelas', 'Procedimento: passo a passo', 'Construindo Sua Vitrine Digital no 99Freelas', 'Método Sócia Invisível › Módulo 07 – O Mapa das Demandas Online › Aula 02 – Construindo Sua Vitrine Digital no 99Freelas › Procedimento: passo a passo

### Parte 1: Criar a conta
1. Abrir o Google e pesquisar "99Freelas". É o primeiro resultado ("contrate os melhores freelancers do Brasil").
2. Na página inicial, entre "Publicar projeto" e "Quero trabalhar", clicar em "Quero trabalhar".
3. Na tela "Sou cliente / Sou freelancer", seguir como freelancer. No topo, clicar em "Cadastre-se".
4. Na tela "Diga-nos o que você está procurando", escolher "Eu quero trabalhar" e clicar em Continuar.
5. Preencher nome completo, e-mail e senha.
6. Confirmar o "não sou robô" e aguardar.
### Parte 2: Editar o perfil (a vitrine)
Dentro da plataforma, ir em Editar perfil e preencher:
| Campo | Orientação da aula |
|---|---|
| Nome completo e nickname | Nome e apelido de exibição. |
| Título profissional | ⭐ O mais importante: é a primeira coisa que o contratante vê. Colocar o que você oferece. Exemplo da aula: "Social media, narradora e suporte". |
| Conte-nos sobre você | Texto sobre o seu trabalho e o que você oferece. |
| Resuma sua experiência profissional | Mesmo sem experiência, escrever o que você está oferecendo. |
| Áreas de interesse | Escolher as áreas de que quer receber projetos. |
| Habilidades | Adicionar quantas quiser. |
| Foto de perfil | Foto clara, mostrando o rosto e com aparência profissional. Pode ser tirada com o celular. |
Clicar em Salvar alterações.
### Parte 3: Cadastrar a conta bancária
1. Voltar à página inicial e ir em "Contas".
2. Escolher o tipo: pessoa física, como na aula, ou pessoa jurídica.
3. Preencher: nome do titular, CPF, banco, tipo de conta (corrente ou poupança), agência e conta.
4. Salvar alterações. A conta fica pronta para receber, e os pagamentos são feitos pela própria plataforma.', 'approved', ARRAY['99Freelas','99 Freelance','99 Freelas','99 frilas','vitrine digital','editar perfil','criar conta','quero trabalhar','sou freelancer','cadastre-se','título profissional','conte-nos sobre você','resuma sua experiência profissional','áreas de interesse','contas','conta bancária','dados bancários','pessoa física','pessoa jurídica','microprojetos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M07.A02-03', 'principal', 1, 7, 'V1.M07.A02 — Construindo Sua Vitrine Digital no 99Freelas', 'Dicas para usar com as aulas anteriores', 'Construindo Sua Vitrine Digital no 99Freelas', 'Método Sócia Invisível › Módulo 07 – O Mapa das Demandas Online › Aula 02 – Construindo Sua Vitrine Digital no 99Freelas › Dicas para usar com as aulas anteriores

- Título profissional: usar a fórmula de linguagem profissional da Aula 02 do M06 ("Especialista em + habilidade + resultado").
- Conte-nos sobre você: adaptar o elevator pitch da Aula 02 do M06.
- Habilidades: usar o mapeamento dos 5 círculos da Aula 01 do M06.
- Experiência e portfólio: usar os cases montados na Aula 04 do M06.', 'approved', ARRAY['99Freelas','99 Freelance','99 Freelas','99 frilas','vitrine digital','editar perfil','criar conta','quero trabalhar','sou freelancer','cadastre-se','título profissional','conte-nos sobre você','resuma sua experiência profissional','áreas de interesse','contas','conta bancária','dados bancários','pessoa física','pessoa jurídica','microprojetos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M07.A02-04', 'principal', 1, 7, 'V1.M07.A02 — Construindo Sua Vitrine Digital no 99Freelas', 'FAQ', 'Construindo Sua Vitrine Digital no 99Freelas', 'Método Sócia Invisível › Módulo 07 – O Mapa das Demandas Online › Aula 02 – Construindo Sua Vitrine Digital no 99Freelas › Pontos para o suporte

- "Como me cadastro no 99Freelas?" Google › 99Freelas › "Quero trabalhar" › "Cadastre-se" › "Eu quero trabalhar" › nome, e-mail e senha.
- "O que coloco no título profissional?" O serviço que você oferece. É o primeiro campo que o contratante vê. Exemplo: "Social media, narradora e suporte".
- "Não tenho experiência, o que escrevo?" Descrever o que você oferece. A aula diz que não é problema não ter experiência.
- "Como recebo o dinheiro?" Cadastrando a conta bancária em "Contas" (pessoa física: titular, CPF, banco, tipo, agência e conta). O pagamento chega pela plataforma.
- "Posso cadastrar conta de outra pessoa?" A aula não trata disso. Orientar a usar uma conta no próprio CPF, porque a plataforma pede o titular e o CPF.
- Problemas técnicos no 99Freelas (cadastro travado, verificação, saque): orientar a acionar o suporte do próprio 99Freelas.', 'approved', ARRAY['99Freelas','99 Freelance','99 Freelas','99 frilas','vitrine digital','editar perfil','criar conta','quero trabalhar','sou freelancer','cadastre-se','título profissional','conte-nos sobre você','resuma sua experiência profissional','áreas de interesse','contas','conta bancária','dados bancários','pessoa física','pessoa jurídica','microprojetos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M07.A03-01', 'principal', 1, 7, 'V1.M07.A03 — O Ciclo da Realização: Como Receber', 'Visão geral', 'O Ciclo da Realização: Como Receber', 'Método Sócia Invisível › Módulo 07 – O Mapa das Demandas Online › Aula 03 – O Ciclo da Realização: Como Receber › Visão geral da aula

Nome oficial da aula: O Ciclo da Realização: Como Receber
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 07 – O Mapa das Demandas Online, Aula 03
Duração/formato: 0:44
Link na área de membros (abre a página do Módulo 07, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/7

Resumo:
É uma aula curtíssima (44 segundos) que apresenta os 3 planos do 99Freelas e a quantidade de conexões mensais de cada um. A aula diz que dá para começar no plano gratuito e termina com um convite para "colocar em prática hoje mesmo".', 'approved', ARRAY['O ciclo da realização','como receber','99Freelas','99Freelance','99 Freelance','planos','plano gratuito','plano free','plano PRO','plano PREMIUM','assinatura','conexões','conexões mensais','propostas']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M07.A03-02', 'principal', 1, 7, 'V1.M07.A03 — O Ciclo da Realização: Como Receber', 'Planos do 99Freelas (segundo a aula)', 'O Ciclo da Realização: Como Receber', 'Método Sócia Invisível › Módulo 07 – O Mapa das Demandas Online › Aula 03 – O Ciclo da Realização: Como Receber › Planos do 99Freelas (segundo a aula)

| Plano | Preço | Conexões por mês |
|---|---|---|
| Gratuito (Free) | R$ 0 | 10 |
| PRO | R$ 49,90/mês | 120 |
| PREMIUM | R$ 89,90/mês | 240 |
"Quanto mais você melhorar na plataforma, mais projetos vai conseguir, mas você pode começar com o plano FREE."
As conexões são o que a freelancer usa para enviar propostas aos projetos. Quanto mais conexões, mais propostas por mês.', 'approved', ARRAY['O ciclo da realização','como receber','99Freelas','99Freelance','99 Freelance','planos','plano gratuito','plano free','plano PRO','plano PREMIUM','assinatura','conexões','conexões mensais','propostas']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M07.A03-03', 'principal', 1, 7, 'V1.M07.A03 — O Ciclo da Realização: Como Receber', 'Procedimento: o que a aluna deve fazer', 'O Ciclo da Realização: Como Receber', 'Método Sócia Invisível › Módulo 07 – O Mapa das Demandas Online › Aula 03 – O Ciclo da Realização: Como Receber › Procedimento: o que a aluna deve fazer

1. Começar no plano gratuito. Não é preciso assinar nada para começar.
2. Avaliar um plano pago só depois, conforme evoluir na plataforma.
3. Procurar trabalhos e enviar propostas. A busca é ensinada na Aula 04 deste módulo. O envio de proposta ainda não aparece em nenhuma aula.', 'approved', ARRAY['O ciclo da realização','como receber','99Freelas','99Freelance','99 Freelance','planos','plano gratuito','plano free','plano PRO','plano PREMIUM','assinatura','conexões','conexões mensais','propostas']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M07.A03-04', 'principal', 1, 7, 'V1.M07.A03 — O Ciclo da Realização: Como Receber', 'FAQ', 'O Ciclo da Realização: Como Receber', 'Método Sócia Invisível › Módulo 07 – O Mapa das Demandas Online › Aula 03 – O Ciclo da Realização: Como Receber › Pontos para o suporte

- "Preciso pagar o 99Freelas?" Não para começar. O plano gratuito dá 10 conexões (propostas) por mês. Os planos PRO (R$ 49,90) e PREMIUM (R$ 89,90) são opcionais.
- "O que são conexões?" São os créditos para enviar propostas aos projetos. Cada plano tem uma quantidade por mês.
- "Vale a pena assinar um plano?" A aula recomenda começar no gratuito e pensar em assinar conforme evoluir.
- "Como recebo?" Apesar do título, esta aula não explica o recebimento. O cadastro da conta bancária está na Aula 02 deste módulo (menu "Contas"). O pagamento é feito pela plataforma depois que o cliente libera o valor.', 'approved', ARRAY['O ciclo da realização','como receber','99Freelas','99Freelance','99 Freelance','planos','plano gratuito','plano free','plano PRO','plano PREMIUM','assinatura','conexões','conexões mensais','propostas']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M07.A04-01', 'principal', 1, 7, 'V1.M07.A04 — Mapeamento Inteligente: Identificando Demandas Lucrativas', 'Visão geral', 'Mapeamento Inteligente: Identificando Demandas Lucrativas', 'Método Sócia Invisível › Módulo 07 – O Mapa das Demandas Online › Aula 04 – Mapeamento Inteligente: Identificando Demandas Lucrativas › Visão geral da aula

Nome oficial da aula: Mapeamento Inteligente: Identificando Demandas Lucrativas
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 07 – O Mapa das Demandas Online, Aula 04
Duração/formato: 2:21
Link na área de membros (abre a página do Módulo 07, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/7

Resumo:
É uma aula prática, com gravação de tela, que ensina a encontrar microprojetos no 99Freelas: usar a aba Buscar projetos, filtrar por categoria, ler os detalhes do projeto, avaliar o cliente e fazer perguntas antes de se candidatar. O alerta principal da aula: as conexões são limitadas, então é preciso escolher bem onde gastá-las.', 'approved', ARRAY['99Freelas','99 frilas','99 filas','99 Freelance','buscar projetos','procurar projetos','encontrar microprojetos','microprojetos','conexões','20 conexões','10 conexões','categorias','subcategorias','suporte administrativo','assistente virtual','entrada de dados','pesquisa online','administração e contabilidade','faça perguntas','perguntas ao cliente','freelancer pro','24 horas para se candidatar','minha executiva']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M07.A04-02', 'principal', 1, 7, 'V1.M07.A04 — Mapeamento Inteligente: Identificando Demandas Lucrativas', 'Procedimento: passo a passo', 'Mapeamento Inteligente: Identificando Demandas Lucrativas', 'Método Sócia Invisível › Módulo 07 – O Mapa das Demandas Online › Aula 04 – Mapeamento Inteligente: Identificando Demandas Lucrativas › Procedimento: passo a passo

### 1. Abrir a busca
Clicar na aba "Buscar projetos". Aparecem milhares de microprojetos.
### 2. Filtrar por categoria
Como as conexões são limitadas, filtrar antes de escolher. Categorias e subcategorias mostradas na aula:
| Categoria | Subcategorias citadas |
|---|---|
| Suporte administrativo | Assistente virtual, entrada de dados, pesquisa online |
| Administração e contabilidade | Várias subcategorias |
Exemplo da aula: em Suporte administrativo, o projeto "Organizar loja na Shopee".
### 3. Ler os detalhes do projeto
Clicar no projeto e conferir:
- descrição feita pelo contratante;
- categoria e subcategoria;
- orçamento (aberto ou definido) e valor mínimo;
- nível de experiência exigido (exemplo: intermediário);
- visibilidade (exemplo: público);
- quantas propostas já foram enviadas e quantos interessados há;
- data de publicação. Dar preferência aos projetos recentes.
### 4. Avaliar o cliente
Abrir o perfil do contratante e verificar se ele tem boas avaliações, outros projetos publicados e histórico.
### 5. Tirar dúvidas antes de fechar
No projeto, clicar em "Faça perguntas" e usar o campo de mensagem para esclarecer dúvidas com o cliente.
### ⏱️ Atenção: regra das 24 horas
Quem não é "freelancer Pro", ou seja, não assina um plano pago, só pode se candidatar a um projeto depois de 24 horas da publicação. A aula diz que o significado de "Pro" será explicado em aulas futuras. Ver a Aula 03 deste módulo sobre os planos.', 'approved', ARRAY['99Freelas','99 frilas','99 filas','99 Freelance','buscar projetos','procurar projetos','encontrar microprojetos','microprojetos','conexões','20 conexões','10 conexões','categorias','subcategorias','suporte administrativo','assistente virtual','entrada de dados','pesquisa online','administração e contabilidade','faça perguntas','perguntas ao cliente','freelancer pro','24 horas para se candidatar','minha executiva']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M07.A04-03', 'principal', 1, 7, 'V1.M07.A04 — Mapeamento Inteligente: Identificando Demandas Lucrativas', 'FAQ', 'Mapeamento Inteligente: Identificando Demandas Lucrativas', 'Método Sócia Invisível › Módulo 07 – O Mapa das Demandas Online › Aula 04 – Mapeamento Inteligente: Identificando Demandas Lucrativas › Pontos para o suporte

- "Como eu acho projetos no 99Freelas?" Aba Buscar projetos › filtrar por categoria (exemplo: Suporte administrativo › Assistente virtual, Entrada de dados, Pesquisa online) › abrir o projeto e ler os detalhes.
- "Como sei se o projeto vale a pena?" Ver o orçamento, o nível de experiência, quantas propostas já foram enviadas, a data e as avaliações do cliente.
- "Por que não consigo me candidatar?" No plano gratuito, só é possível se candidatar 24 horas depois da publicação. Assinantes Pro/Premium têm acesso antes.
- "Acabaram minhas conexões." As conexões são limitadas por mês e dependem do plano (ver a Aula 03 deste módulo). Por isso a aula recomenda filtrar bem antes de se candidatar.
- "Como tiro dúvida com o cliente?" Pelo botão "Faça perguntas" dentro do projeto.', 'approved', ARRAY['99Freelas','99 frilas','99 filas','99 Freelance','buscar projetos','procurar projetos','encontrar microprojetos','microprojetos','conexões','20 conexões','10 conexões','categorias','subcategorias','suporte administrativo','assistente virtual','entrada de dados','pesquisa online','administração e contabilidade','faça perguntas','perguntas ao cliente','freelancer pro','24 horas para se candidatar','minha executiva']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M07.A05-01', 'principal', 1, 7, 'V1.M07.A05 — Bônus 01: Como Mandar Propostas Irresistíveis: Como Garantir o "Sim"', 'Visão geral', 'Bônus 01: Como Mandar Propostas Irresistíveis: Como Garantir o "Sim"', 'Método Sócia Invisível › Módulo 07 – O Mapa das Demandas Online › Aula 05 – Bônus 01: Como Mandar Propostas Irresistíveis: Como Garantir o "Sim" › Visão geral da aula

Nome oficial da aula: Bônus 01: Como Mandar Propostas Irresistíveis: Como Garantir o "Sim"
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 07 – O Mapa das Demandas Online, Aula 05
Duração/formato: 8:42
Link na área de membros (abre a página do Módulo 07, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/7

Resumo:
É a aula que ensina a escrever e enviar propostas para os projetos, o passo que faltava nas Aulas 03 e 04 deste módulo. A premissa é que "a maioria perde oportunidades porque não sabe escrever uma proposta que vende". O erro mais comum é mandar um "currículo disfarçado". O contratante quer saber se você entende o problema dele e consegue resolver.
A aula ensina uma estrutura de proposta em 8 partes e dá exemplos para design, organização e atendimento. Também traz uma proposta completa de exemplo, uma lista de erros fatais e uma missão prática.
Princípio: competir por valor, não por preço. Toda proposta deve responder a 3 perguntas do contratante:
1. Essa pessoa entende o meu problema?
2. Ela consegue resolver?
3. Vale o meu investimento?', 'approved', ARRAY['propostas irresistíveis','como mandar proposta','como escrever proposta','garantir o sim','enviar proposta','proposta no 99Freelas','proposta para cliente','assunto da proposta','abertura','prova social','escassez','autoridade','fechamento','copywriting em propostas','template de proposta','PDF bônus','anexo de valor','Skills das Subdemandas','Dominando a Arte da Comunicação Simples','supremas']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M07.A05-02', 'principal', 1, 7, 'V1.M07.A05 — Bônus 01: Como Mandar Propostas Irresistíveis: Como Garantir o "Sim"', 'Procedimento: estrutura da proposta em 8 partes', 'Bônus 01: Como Mandar Propostas Irresistíveis: Como Garantir o "Sim"', 'Método Sócia Invisível › Módulo 07 – O Mapa das Demandas Online › Aula 05 – Bônus 01: Como Mandar Propostas Irresistíveis: Como Garantir o "Sim" › Procedimento: estrutura da proposta em 8 partes (parte 1 de 2)

| # | Parte | O que fazer | Exemplo da aula |
|---|---|---|---|
| 1 | Assunto | Falar do resultado, não do serviço. | ❌ "Proposta para criação de logo" → ✅ "Como fazer o seu negócio ser lembrado pelos consumidores". ❌ "Proposta para organização de casa" → ✅ "Como ter uma casa organizada que economiza seu tempo" |
| 2 | Abertura | Começar pelo contratante, não por você. Mostrar que entendeu a necessidade real. | "Percebi que você está buscando um designer… imagino que queira algo que não seja só bonito, mas que conecte com seus consumidores, certo?" |
| 3 | Entender o problema | Mostrar que conhece as dores específicas desse tipo de cliente. | "Muitas empreendedoras ficam frustradas quando investem em design e o resultado não reflete a qualidade do serviço." |
| 4 | A sua grande ideia | Explicar como você pensa diferente, não listar tarefas. | "Design não é arte, é estratégia visual." / "Cada reclamação é uma oportunidade de criar um fã fiel." |
| 5 | Gatilhos naturais | Prova social específica, escassez real e autoridade conquistada. | "Entreguei um serviço similar para uma consultoria de RH…" / "Trabalho com no máximo 3 demandas por mês." |
| 6 | A proposta em si | O que vai entregar, como é o processo, investimento e prazo. | Logo principal, variações, manual e arquivos em alta resolução. Processo: briefing, primeira versão, revisões e entrega. R$ 497. |
| 7 | Pergunta de engajamento | Fazer uma pergunta específica que obrigue o cliente a responder. | "Você já tem alguma cor ou estilo em mente, ou prefere que eu apresente opções?" |
| 8 | Fechamento | Terminar assumindo o sim, nunca com "no aguardo do retorno". | "Quando quiser começar, é só me confirmar. Vou reservar um espaço na agenda e podemos iniciar o briefing ainda esta semana." |
### Diferencial: PDF bônus anexado
Anexar um PDF curto e útil para mostrar autoridade e entregar valor antes de ser contratada. Exemplos:
- Design: "3 erros que matam a identidade visual de pequenas empresas".', 'approved', ARRAY['propostas irresistíveis','como mandar proposta','como escrever proposta','garantir o sim','enviar proposta','proposta no 99Freelas','proposta para cliente','assunto da proposta','abertura','prova social','escassez','autoridade','fechamento','copywriting em propostas','template de proposta','PDF bônus','anexo de valor','Skills das Subdemandas','Dominando a Arte da Comunicação Simples','supremas']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M07.A05-03', 'principal', 1, 7, 'V1.M07.A05 — Bônus 01: Como Mandar Propostas Irresistíveis: Como Garantir o "Sim"', 'Procedimento: estrutura da proposta em 8 partes', 'Bônus 01: Como Mandar Propostas Irresistíveis: Como Garantir o "Sim"', 'Método Sócia Invisível › Módulo 07 – O Mapa das Demandas Online › Aula 05 – Bônus 01: Como Mandar Propostas Irresistíveis: Como Garantir o "Sim" › Procedimento: estrutura da proposta em 8 partes (parte 2 de 2)

### Diferencial: PDF bônus anexado (continuação)
- Organização: "5 erros que fazem a sua casa voltar a ficar bagunçada em uma semana".
- Atendimento: "3 frases que transformam reclamações em elogios".
### Perguntas de engajamento por área
- Design: "Já tem alguma cor ou estilo em mente, ou prefere opções baseadas no seu público?"
- Organização: "Qual ambiente mais te incomoda no dia a dia? Começamos por ele ou pelo de maior impacto visual?"
- Atendimento: "Qual é o tipo de reclamação mais comum que vocês recebem?"', 'approved', ARRAY['propostas irresistíveis','como mandar proposta','como escrever proposta','garantir o sim','enviar proposta','proposta no 99Freelas','proposta para cliente','assunto da proposta','abertura','prova social','escassez','autoridade','fechamento','copywriting em propostas','template de proposta','PDF bônus','anexo de valor','Skills das Subdemandas','Dominando a Arte da Comunicação Simples','supremas']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M07.A05-04', 'principal', 1, 7, 'V1.M07.A05 — Bônus 01: Como Mandar Propostas Irresistíveis: Como Garantir o "Sim"', 'Exemplo completo da aula (organização residencial)', 'Bônus 01: Como Mandar Propostas Irresistíveis: Como Garantir o "Sim"', 'Método Sócia Invisível › Módulo 07 – O Mapa das Demandas Online › Aula 05 – Bônus 01: Como Mandar Propostas Irresistíveis: Como Garantir o "Sim" › Exemplo completo da aula (organização residencial)

Assunto: Como ter uma casa organizada que economiza 2 horas do seu dia
Oi, percebi que você está buscando alguém para organizar a sua casa. Imagino que você não queira apenas um ambiente bonito, mas um sistema que realmente funcione no seu dia a dia e se mantenha organizado, correto?
Sei como é frustrante chegar em casa cansada e não conseguir encontrar nada no lugar, ou gastar o fim de semana inteiro organizando a mesma coisa que já organizou no mês passado.
Minha abordagem é diferente. Eu não apenas organizo: crio sistemas personalizados que se adaptam à sua rotina e personalidade.
[prova social] Semana passada organizei a casa de uma mãe com dois filhos pequenos. Um mês depois, ela disse que estava economizando mais de 2 horas por dia.
Meu processo inclui análise da rotina, organização de todos os ambientes, sistemas personalizados, etiquetagem visual, treinamento da família, manual de manutenção ilustrado e acompanhamento de 30 dias por WhatsApp.
Investimento: R$ 800, em até 2x. Prazo: 3 dias úteis de execução, mais 30 dias de acompanhamento.
Uma pergunta: qual ambiente da casa mais te incomoda no dia a dia? Prefere que comecemos por ele ou pelo de maior impacto visual?
Quando quiser começar, é só me confirmar. Vou reservar um espaço na agenda e podemos fazer a análise inicial ainda esta semana.', 'approved', ARRAY['propostas irresistíveis','como mandar proposta','como escrever proposta','garantir o sim','enviar proposta','proposta no 99Freelas','proposta para cliente','assunto da proposta','abertura','prova social','escassez','autoridade','fechamento','copywriting em propostas','template de proposta','PDF bônus','anexo de valor','Skills das Subdemandas','Dominando a Arte da Comunicação Simples','supremas']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M07.A05-05', 'principal', 1, 7, 'V1.M07.A05 — Bônus 01: Como Mandar Propostas Irresistíveis: Como Garantir o "Sim"', '❌ Erros fatais que matam a proposta', 'Bônus 01: Como Mandar Propostas Irresistíveis: Como Garantir o "Sim"', 'Método Sócia Invisível › Módulo 07 – O Mapa das Demandas Online › Aula 05 – Bônus 01: Como Mandar Propostas Irresistíveis: Como Garantir o "Sim" › ❌ Erros fatais que matam a proposta

1. Começar falando de você em vez do contratante.
2. Listar tarefas sem explicar o resultado.
3. Não demonstrar que entende as dores específicas.
4. Usar linguagem técnica demais.
5. Não incluir prova social.
6. Terminar de forma passiva ("no aguardo").
7. Não fazer uma pergunta de engajamento.
8. Competir só por preço.', 'approved', ARRAY['propostas irresistíveis','como mandar proposta','como escrever proposta','garantir o sim','enviar proposta','proposta no 99Freelas','proposta para cliente','assunto da proposta','abertura','prova social','escassez','autoridade','fechamento','copywriting em propostas','template de proposta','PDF bônus','anexo de valor','Skills das Subdemandas','Dominando a Arte da Comunicação Simples','supremas']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M07.A05-06', 'principal', 1, 7, 'V1.M07.A05 — Bônus 01: Como Mandar Propostas Irresistíveis: Como Garantir o "Sim"', 'Missão prática', 'Bônus 01: Como Mandar Propostas Irresistíveis: Como Garantir o "Sim"', 'Método Sócia Invisível › Módulo 07 – O Mapa das Demandas Online › Aula 05 – Bônus 01: Como Mandar Propostas Irresistíveis: Como Garantir o "Sim" › Missão prática

1. Reescrever as últimas 3 propostas com a estrutura de 8 partes.
2. Criar um template de proposta para cada tipo de demanda que você oferece.
3. Preparar 3 PDFs bônus para anexar às propostas.
4. Testar a nova estrutura em pelo menos 5 propostas nesta semana.
Material complementar indicado: bônus Skills das Subdemandas › Módulo 2 – "Dominando a Arte da Comunicação Simples", para quem quer escrever melhor.', 'approved', ARRAY['propostas irresistíveis','como mandar proposta','como escrever proposta','garantir o sim','enviar proposta','proposta no 99Freelas','proposta para cliente','assunto da proposta','abertura','prova social','escassez','autoridade','fechamento','copywriting em propostas','template de proposta','PDF bônus','anexo de valor','Skills das Subdemandas','Dominando a Arte da Comunicação Simples','supremas']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M07.A05-07', 'principal', 1, 7, 'V1.M07.A05 — Bônus 01: Como Mandar Propostas Irresistíveis: Como Garantir o "Sim"', 'FAQ', 'Bônus 01: Como Mandar Propostas Irresistíveis: Como Garantir o "Sim"', 'Método Sócia Invisível › Módulo 07 – O Mapa das Demandas Online › Aula 05 – Bônus 01: Como Mandar Propostas Irresistíveis: Como Garantir o "Sim" › Pontos para o suporte

- "Como escrevo minha proposta no 99Freelas?" Indicar esta aula e a estrutura de 8 partes: assunto com resultado, abertura falando do cliente, dor, abordagem, prova social, entrega e preço, pergunta e fechamento.
- "Mandei várias propostas e ninguém respondeu." Revisar se a proposta começa falando de si mesma, se termina com "no aguardo" ou se não tem pergunta. Esses são os "erros fatais" da aula.
- "Quanto devo cobrar?" A aula não ensina a precificar. Só dá exemplos (R$ 497 por uma logo, R$ 800 por uma organização residencial). Não tratar esses valores como tabela.
- "Não tenho prova social / nunca trabalhei." Orientar a não inventar experiências e a usar os cases e projetos de estudo do portfólio (M06 A04), sempre identificados como tal.', 'approved', ARRAY['propostas irresistíveis','como mandar proposta','como escrever proposta','garantir o sim','enviar proposta','proposta no 99Freelas','proposta para cliente','assunto da proposta','abertura','prova social','escassez','autoridade','fechamento','copywriting em propostas','template de proposta','PDF bônus','anexo de valor','Skills das Subdemandas','Dominando a Arte da Comunicação Simples','supremas']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M07.A06-01', 'principal', 1, 7, 'V1.M07.A06 — Bônus 02: Hacks Avançados para o 99Freelas', 'Visão geral', 'Bônus 02: Hacks Avançados para o 99Freelas', 'Método Sócia Invisível › Módulo 07 – O Mapa das Demandas Online › Aula 06 – Bônus 02: Hacks Avançados para o 99Freelas › Visão geral da aula

Nome oficial da aula: Bônus 02: Hacks Avançados para o 99Freelas
Onde fica: Vitrine 1 (Método Sócia Invisível), Módulo 07 – O Mapa das Demandas Online, Aula 06
Duração/formato: 8:15
Link na área de membros (abre a página do Módulo 07, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/1/7

Resumo:
A aula reúne 15 "hacks" para se destacar em plataformas de freela como o 99Freelas, cobrindo perfil, horários, proposta, preço, prazo, portfólio, palavras-chave, follow-up e especialização. Também lista erros fatais e um plano de crescimento em 4 meses. Retoma e complementa o Bônus 01 (Propostas Irresistíveis).
Caso citado: Marina ficou 3 meses sem nenhuma demanda. Depois dos hacks, conseguiu 5 demandas em 2 semanas e hoje ganha "mais de R$ 4 mil por mês" só pela plataforma.', 'approved', ARRAY['hacks avançados','hacks do 99Freelas','truques','segredos das redes de freela','redes de trabalho online','rede de freela','canais','perfil estratégico','foto profissional','título','descrição','horários nobres','melhor horário para enviar proposta','preço estratégico','segunda ou terceira mais cara','follow-up','follow up','cobrar resposta','palavras-chave','algoritmo']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M07.A06-02', 'principal', 1, 7, 'V1.M07.A06 — Bônus 02: Hacks Avançados para o 99Freelas', 'Procedimento: os 15 hacks', 'Bônus 02: Hacks Avançados para o 99Freelas', 'Método Sócia Invisível › Módulo 07 – O Mapa das Demandas Online › Aula 06 – Bônus 02: Hacks Avançados para o 99Freelas › Procedimento: os 15 hacks (parte 1 de 2)

### Perfil
| # | Hack | Como aplicar |
|---|---|---|
| 1 | Perfil que vende sozinho | Foto: nada de selfie. Usar luz natural, fundo neutro e roupa que transmita confiança; pode ser tirada com o celular. Título: específico, como "Especialista em organização doméstica", nunca "freelancer". Descrição: problema que resolve + como resolve + resultado + prova social. |
Exemplo de descrição da aula: "Ajudo mulheres ocupadas a terem uma casa organizada e funcional através de sistemas personalizados. Já organizei mais de 50 ambientes e minhas clientes economizam em média 2 horas por semana. Meu diferencial é o acompanhamento pós-organização."
### Quando e como enviar
| # | Hack | Como aplicar |
|---|---|---|
| 2 | Horários nobres | ✅ Segunda a quarta, 9h–11h e 14h–16h. ❌ Evitar sexta depois das 15h, fins de semana e segunda muito cedo. Se for o único horário disponível, enviar assim mesmo. |
| 3 | Primeiro parágrafo irresistível | Nunca "Olá, vi sua demanda e tenho interesse". Usar: "Percebi que você está buscando [repetir o pedido]. Imagino que você queira [necessidade real]. Correto?" |
| 4 | Fórmula da proposta | Entendimento do problema › dores específicas › solução única › prova social › processo › pergunta de engajamento. (Ver a estrutura completa no Bônus 01.) |
| 9 | Palavras-chave | Repetir as palavras exatas do contratante. Se ele escreveu "organizar closet", escrever "organizar closet", não "guarda-roupa". |
| 12 | Pergunta estratégica | Terminar com uma pergunta que obrigue o cliente a responder. Exemplo: "Prefere que eu comece pela área que mais te incomoda ou pela de maior impacto visual?" |
| 10 | Follow-up inteligente | Sem resposta em 48 h? Mandar uma mensagem que agregue valor, nunca "viu minha proposta?". Exemplo: "Esqueci de mencionar que tem uma técnica específica para [problema]. Posso explicar melhor se tiver interesse." |
### Preço, prazo e diferencial
| # | Hack | Como aplicar |
|---|---|---|
| 5 | Preço estratégico | Nem a mais barata nem a mais cara: ficar como a 2ª ou 3ª mais cara. Exemplo: propostas entre R$ 200 e R$ 800, propor R$ 600. Sempre justificar com o que está incluído. |', 'approved', ARRAY['hacks avançados','hacks do 99Freelas','truques','segredos das redes de freela','redes de trabalho online','rede de freela','canais','perfil estratégico','foto profissional','título','descrição','horários nobres','melhor horário para enviar proposta','preço estratégico','segunda ou terceira mais cara','follow-up','follow up','cobrar resposta','palavras-chave','algoritmo']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M07.A06-03', 'principal', 1, 7, 'V1.M07.A06 — Bônus 02: Hacks Avançados para o 99Freelas', 'Procedimento: os 15 hacks', 'Bônus 02: Hacks Avançados para o 99Freelas', 'Método Sócia Invisível › Módulo 07 – O Mapa das Demandas Online › Aula 06 – Bônus 02: Hacks Avançados para o 99Freelas › Procedimento: os 15 hacks (parte 2 de 2)

### Preço, prazo e diferencial (continuação)
| # | Hack | Como aplicar |
|---|---|---|
| 15 | Orçamento detalhado | Quebrar o valor em partes. Exemplo: R$ 500 = consultoria R$ 150 + execução R$ 250 + material R$ 50 + relatório e manual R$ 50. |
| 6 | Entrega rápida | Oferecer um prazo menor que o pedido (pediram 10 dias, oferecer 7), explicando que é por ter um método estruturado, e não por fazer correndo. |
| 7 | Diferencial que ninguém oferece | Incluir um extra: relatório de antes e depois, manual personalizado, suporte pós-entrega por WhatsApp, garantia de satisfação, revisão grátis em 30 dias. |
### Posicionamento e reputação
| # | Hack | Como aplicar |
|---|---|---|
| 8 | Portfólio estratégico | Mostrar só os cases relevantes para aquele tipo de demanda, com legenda de resultado em cada imagem. |
| 11 | Prova social específica | Nada de "tenho vários clientes satisfeitos". Usar fatos concretos. Exemplo da aula: "Semana passada organizei o escritório de uma advogada e a produtividade dela aumentou 40%." |
| 13 | Começar pequeno | No início, se candidatar só a demandas pequenas e de valor baixo. "Melhor 10 demandas de R$ 200 com 10 avaliações 5 estrelas do que uma de R$ 2 mil sem histórico." |
| 14 | Especialização | Não se posicionar como "faz tudo". Exemplo: "especialista em organização de closets" em vez de "organização geral". |', 'approved', ARRAY['hacks avançados','hacks do 99Freelas','truques','segredos das redes de freela','redes de trabalho online','rede de freela','canais','perfil estratégico','foto profissional','título','descrição','horários nobres','melhor horário para enviar proposta','preço estratégico','segunda ou terceira mais cara','follow-up','follow up','cobrar resposta','palavras-chave','algoritmo']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M07.A06-04', 'principal', 1, 7, 'V1.M07.A06 — Bônus 02: Hacks Avançados para o 99Freelas', '❌ Erros fatais', 'Bônus 02: Hacks Avançados para o 99Freelas', 'Método Sócia Invisível › Módulo 07 – O Mapa das Demandas Online › Aula 06 – Bônus 02: Hacks Avançados para o 99Freelas › ❌ Erros fatais

1. Copiar e colar a mesma proposta para demandas diferentes.
2. Mentir sobre a experiência. Ser honesta, mas apresentar de forma profissional.
3. Aceitar demandas fora da sua área só pelo dinheiro.
4. Brigar ou responder mal a contratantes. "Sua reputação é tudo."', 'approved', ARRAY['hacks avançados','hacks do 99Freelas','truques','segredos das redes de freela','redes de trabalho online','rede de freela','canais','perfil estratégico','foto profissional','título','descrição','horários nobres','melhor horário para enviar proposta','preço estratégico','segunda ou terceira mais cara','follow-up','follow up','cobrar resposta','palavras-chave','algoritmo']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M07.A06-05', 'principal', 1, 7, 'V1.M07.A06 — Bônus 02: Hacks Avançados para o 99Freelas', 'Plano de crescimento', 'Bônus 02: Hacks Avançados para o 99Freelas', 'Método Sócia Invisível › Módulo 07 – O Mapa das Demandas Online › Aula 06 – Bônus 02: Hacks Avançados para o 99Freelas › Plano de crescimento

| Período | Foco |
|---|---|
| Mês 1 | Demandas pequenas para construir reputação e avaliações. |
| Mês 2 | Aumentar o valor das demandas aos poucos. |
| Mês 3 | Começar a recusar demandas que não agregam valor. |
| Mês 4 em diante | Ser seletiva e cobrar o valor real. |', 'approved', ARRAY['hacks avançados','hacks do 99Freelas','truques','segredos das redes de freela','redes de trabalho online','rede de freela','canais','perfil estratégico','foto profissional','título','descrição','horários nobres','melhor horário para enviar proposta','preço estratégico','segunda ou terceira mais cara','follow-up','follow up','cobrar resposta','palavras-chave','algoritmo']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V1.M07.A06-06', 'principal', 1, 7, 'V1.M07.A06 — Bônus 02: Hacks Avançados para o 99Freelas', 'FAQ', 'Bônus 02: Hacks Avançados para o 99Freelas', 'Método Sócia Invisível › Módulo 07 – O Mapa das Demandas Online › Aula 06 – Bônus 02: Hacks Avançados para o 99Freelas › Pontos para o suporte

- "Qual o melhor horário para mandar proposta?" De segunda a quarta, das 9h às 11h e das 14h às 16h. Evitar sexta à tarde e fins de semana.
- "Quanto eu cobro?" A aula sugere ficar entre as 2ª e 3ª propostas mais caras e detalhar o orçamento. No começo, porém, a orientação é pegar demandas pequenas para ganhar avaliações (Hack 13).
- "O cliente não respondeu." Esperar 48 h e mandar um follow-up que agregue valor (Hack 10).
- "O que coloco na foto, título e descrição?" Ver o Hack 1 e a Aula 02 deste módulo.
- "Posso fechar com o cliente fora do 99Freelas?" Não orientar isso.', 'approved', ARRAY['hacks avançados','hacks do 99Freelas','truques','segredos das redes de freela','redes de trabalho online','rede de freela','canais','perfil estratégico','foto profissional','título','descrição','horários nobres','melhor horário para enviar proposta','preço estratégico','segunda ou terceira mais cara','follow-up','follow up','cobrar resposta','palavras-chave','algoritmo']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M05.A01-01', 'principal', 2, 5, 'V2.M05.A01 — Construindo Relacionamentos que Geram Indicações', 'Visão geral', 'Construindo Relacionamentos que Geram Indicações', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 05 – Máquina de Receita Recorrente 2.0 › Aula 01 – Construindo Relacionamentos que Geram Indicações › Visão geral da aula

Nome oficial da aula: Construindo Relacionamentos que Geram Indicações
Onde fica: Vitrine 2 (I BÔNUS – Skill''s das Demandas Lucrativas), Módulo 05 – Máquina de Receita Recorrente 2.0, Aula 01
Duração/formato: 2:50
Link na área de membros (abre a página do Módulo 05, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/2/22

Resumo:
É a aula de abertura do Módulo 05. A ideia central é que "ninguém cresce sozinha": o sucesso é construído em rede, e quem se conecta de forma estratégica deixa de só ser lembrada e passa a ser recomendada. A aula ensina 3 etapas:
1. conectar-se com profissionais de serviços parecidos ou complementares;
2. agregar valor com consistência;
3. gerar indicações espontâneas, entregando mais do que o prometido e pedindo a recomendação.
Fecha com uma tarefa prática: a lista de 5 pessoas.', 'approved', ARRAY['networking','rede de contatos','relacionamentos','conexões','indicação','recomendação','boca a boca','indicação espontânea','serviços complementares','colaboração estratégica','parceria','grupos online','grupo da área','entregar mais do que prometeu','bônus inesperado','mensagem de agradecimento']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M05.A01-02', 'principal', 2, 5, 'V2.M05.A01 — Construindo Relacionamentos que Geram Indicações', 'Procedimento: as 3 etapas', 'Construindo Relacionamentos que Geram Indicações', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 05 – Máquina de Receita Recorrente 2.0 › Aula 01 – Construindo Relacionamentos que Geram Indicações › Procedimento: as 3 etapas

### 1. Conectar-se com profissionais complementares
- Aproximar-se de mulheres com serviços parecidos ou complementares. Exemplo: quem escreve textos + uma designer. "Quem precisa de texto muitas vezes precisa de designer." O que uma não atende, indica para a outra (colaboração estratégica).
- Na prática:
  1. Procurar grupos online onde essas profissionais estão.
  2. Entrar com postura colaborativa: perguntar, compartilhar o que sabe, oferecer ajuda.
  3. Não chegar só querendo algo em troca.
  4. Manter o contato ativo no dia a dia, com mensagens e trocas úteis.
### 2. Agregar valor, com consistência
- "Não é sobre o que você pode ganhar, mas sobre o que você pode oferecer."
  - Conhece alguém começando? Compartilhe uma dica que te ajudou.
  - Já tem experiência? Recomende ferramentas que funcionaram.
- Consistência: reservar um tempo na semana para interagir com a rede. Não desaparecer.
### 3. Fazer as pessoas falarem de você
1. Entregar mais do que o prometido: ser atenciosa, cumprir prazos e surpreender (mensagem de agradecimento, bônus inesperado), o que cria impacto emocional.
2. Depois de entregar, pedir a indicação. Modelo da aula: "Se você conhecer alguém que precisa de um serviço parecido, eu ficarei muito feliz com a sua indicação."
3. Manter contato de tempos em tempos, para continuar sendo lembrada.', 'approved', ARRAY['networking','rede de contatos','relacionamentos','conexões','indicação','recomendação','boca a boca','indicação espontânea','serviços complementares','colaboração estratégica','parceria','grupos online','grupo da área','entregar mais do que prometeu','bônus inesperado','mensagem de agradecimento']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M05.A01-03', 'principal', 2, 5, 'V2.M05.A01 — Construindo Relacionamentos que Geram Indicações', 'Tarefa prática (para hoje)', 'Construindo Relacionamentos que Geram Indicações', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 05 – Máquina de Receita Recorrente 2.0 › Aula 01 – Construindo Relacionamentos que Geram Indicações › Tarefa prática (para hoje)

1. Fazer uma lista com 5 pessoas que já conhece.
2. Entrar em contato: perguntar como estão e contar o que está fazendo agora.
3. Se fizer sentido, pedir uma recomendação de forma natural.
4. Entrar em um grupo online da sua área e participar ativamente.', 'approved', ARRAY['networking','rede de contatos','relacionamentos','conexões','indicação','recomendação','boca a boca','indicação espontânea','serviços complementares','colaboração estratégica','parceria','grupos online','grupo da área','entregar mais do que prometeu','bônus inesperado','mensagem de agradecimento']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M05.A01-04', 'principal', 2, 5, 'V2.M05.A01 — Construindo Relacionamentos que Geram Indicações', 'FAQ', 'Construindo Relacionamentos que Geram Indicações', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 05 – Máquina de Receita Recorrente 2.0 › Aula 01 – Construindo Relacionamentos que Geram Indicações › Pontos para o suporte

- "Como consigo clientes por indicação?" Entregar mais do que o prometido e, depois da entrega, pedir a indicação com naturalidade. Manter contato de tempos em tempos.
- "Com quem devo fazer networking?" Com profissionais de serviços complementares ao seu (exemplo: redatora + designer), em grupos online da área.
- "Tenho vergonha de pedir indicação." Usar a frase-modelo da aula e pedir só depois de entregar um bom trabalho.
- "Por onde começo?" Pela lista de 5 pessoas conhecidas.', 'approved', ARRAY['networking','rede de contatos','relacionamentos','conexões','indicação','recomendação','boca a boca','indicação espontânea','serviços complementares','colaboração estratégica','parceria','grupos online','grupo da área','entregar mais do que prometeu','bônus inesperado','mensagem de agradecimento']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M05.A02-01', 'principal', 2, 5, 'V2.M05.A02 — Personal Branding: Tornando-se a Primeira Opção', 'Visão geral', 'Personal Branding: Tornando-se a Primeira Opção', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 05 – Máquina de Receita Recorrente 2.0 › Aula 02 – Personal Branding: Tornando-se a Primeira Opção › Visão geral da aula

Nome oficial da aula: Personal Branding: Tornando-se a Primeira Opção
Onde fica: Vitrine 2 (I BÔNUS – Skill''s das Demandas Lucrativas), Módulo 05 – Máquina de Receita Recorrente 2.0, Aula 02
Duração/formato: 2:34
Link na área de membros (abre a página do Módulo 05, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/2/22

Resumo:
A aula ensina personal branding: construir a imagem de forma estratégica para ser vista como referência confiável e única e virar a primeira opção de quem precisa do serviço. Ponto de partida: personal branding não é criar uma imagem falsa, mas destacar o que você já tem de melhor. São 4 passos:
1. definir o posicionamento único;
2. comunicar com provas;
3. construir reputação com consistência;
4. posicionar-se como profissional premium.
Fecha com a tarefa das 3 coisas que você faz de melhor.', 'approved', ARRAY['personal branding','marca pessoal','posicionamento','autoridade','referência','diferencial','posicionamento único','o que você faz que ninguém faz igual','portfólio','caso de sucesso','depoimento','prova social','profissional premium','preço justo','experiência completa']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M05.A02-02', 'principal', 2, 5, 'V2.M05.A02 — Personal Branding: Tornando-se a Primeira Opção', 'Procedimento: passo a passo', 'Personal Branding: Tornando-se a Primeira Opção', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 05 – Máquina de Receita Recorrente 2.0 › Aula 02 – Personal Branding: Tornando-se a Primeira Opção › Procedimento: passo a passo

### 1. Definir o posicionamento único
- Pergunta-chave: "O que você faz que ninguém mais faz igual?"
- Exemplos: atenção aos detalhes, rapidez, criatividade.
### 2. Comunicar com clareza e mostrar, não só dizer
- "Não basta dizer que você é boa. Você precisa mostrar."
- Usar exemplos reais do trabalho, resultados alcançados e depoimentos de clientes. "As pessoas confiam no que elas conseguem ver."
### 3. Construir reputação com consistência
- "Não adianta fazer um excelente trabalho hoje e desaparecer amanhã."
- Manter comunicação ativa nas redes ou nos grupos de que participa: compartilhar conhecimento e mostrar o que está fazendo.
- Em cada interação: ser profissional e cumprir o que promete. Cada contato é uma chance de fortalecer a reputação.
### 4. Posicionar-se como profissional premium
- Entregar uma experiência completa, do primeiro atendimento ao resultado final, e não apenas o serviço.
- Isso atrai clientes dispostos a pagar o preço justo, porque enxergam a qualidade.', 'approved', ARRAY['personal branding','marca pessoal','posicionamento','autoridade','referência','diferencial','posicionamento único','o que você faz que ninguém faz igual','portfólio','caso de sucesso','depoimento','prova social','profissional premium','preço justo','experiência completa']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M05.A02-03', 'principal', 2, 5, 'V2.M05.A02 — Personal Branding: Tornando-se a Primeira Opção', 'Tarefa prática (para hoje)', 'Personal Branding: Tornando-se a Primeira Opção', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 05 – Máquina de Receita Recorrente 2.0 › Aula 02 – Personal Branding: Tornando-se a Primeira Opção › Tarefa prática (para hoje)

1. Escrever 3 coisas que você faz de melhor e que te diferenciam.
2. Pensar em como mostrar isso ao público: compartilhar um caso de sucesso ou pedir um depoimento.
"Se posicionar como a primeira opção não é só sobre ser excelente no que faz, mas garantir que as pessoas percebam essa excelência."', 'approved', ARRAY['personal branding','marca pessoal','posicionamento','autoridade','referência','diferencial','posicionamento único','o que você faz que ninguém faz igual','portfólio','caso de sucesso','depoimento','prova social','profissional premium','preço justo','experiência completa']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M05.A02-04', 'principal', 2, 5, 'V2.M05.A02 — Personal Branding: Tornando-se a Primeira Opção', 'FAQ', 'Personal Branding: Tornando-se a Primeira Opção', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 05 – Máquina de Receita Recorrente 2.0 › Aula 02 – Personal Branding: Tornando-se a Primeira Opção › Pontos para o suporte

- "O que é personal branding?" É construir a sua imagem profissional de forma estratégica, destacando o que você tem de melhor, sem inventar uma imagem falsa.
- "Qual é o meu diferencial?" Responder: "O que eu faço que ninguém faz igual?" Por exemplo: atenção aos detalhes, rapidez, criatividade.
- "Ainda não tenho depoimentos." Começar mostrando exemplos do trabalho e, a cada entrega, pedir um depoimento ao cliente (ver a Vitrine 2, Módulo 05, Aula 01).
- "Como cobro mais?" Oferecer uma experiência completa (atendimento, prazo, acabamento) e se posicionar como premium.', 'approved', ARRAY['personal branding','marca pessoal','posicionamento','autoridade','referência','diferencial','posicionamento único','o que você faz que ninguém faz igual','portfólio','caso de sucesso','depoimento','prova social','profissional premium','preço justo','experiência completa']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M05.A03-01', 'principal', 2, 5, 'V2.M05.A03 — Funil de Clientes Recorrentes: Da Primeira Venda ao Cliente Fiel', 'Visão geral', 'Funil de Clientes Recorrentes: Da Primeira Venda ao Cliente Fiel', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 05 – Máquina de Receita Recorrente 2.0 › Aula 03 – Funil de Clientes Recorrentes: Da Primeira Venda ao Cliente Fiel › Visão geral da aula

Nome oficial da aula: Funil de Clientes Recorrentes: Da Primeira Venda ao Cliente Fiel
Onde fica: Vitrine 2 (I BÔNUS – Skill''s das Demandas Lucrativas), Módulo 05 – Máquina de Receita Recorrente 2.0, Aula 03
Duração/formato: 3:08
Link na área de membros (abre a página do Módulo 05, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/2/22

Resumo:
É a aula que dá sentido ao nome do módulo: como transformar uma primeira oportunidade em algo duradouro, fazendo com que "quem confia em você uma vez volte sempre". Ensina a montar um funil de clientes recorrentes em 4 etapas:
1. primeira impressão profissional;
2. relacionamento pós-entrega;
3. identificar a chance de transformar demandas pontuais em contrato mensal;
4. comunicar os benefícios da recorrência.
Fecha com a tarefa de retomar contato com quem já foi cliente.', 'approved', ARRAY['funil de clientes recorrentes','fidelização','cliente fiel','recorrência','contrato mensal','acompanhamento mensal','acompanhamento contínuo','pacote mensal','pós-venda','follow-up','mensagem de satisfação','demanda pontual','upsell','oferecer algo a mais']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M05.A03-02', 'principal', 2, 5, 'V2.M05.A03 — Funil de Clientes Recorrentes: Da Primeira Venda ao Cliente Fiel', 'Procedimento: o funil em 4 etapas', 'Funil de Clientes Recorrentes: Da Primeira Venda ao Cliente Fiel', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 05 – Máquina de Receita Recorrente 2.0 › Aula 03 – Funil de Clientes Recorrentes: Da Primeira Venda ao Cliente Fiel › Procedimento: o funil em 4 etapas

### 1. Primeira impressão (desde o primeiro contato)
- Fidelizar "não é só entregar o que foi combinado", é criar uma experiência que faça a pessoa querer voltar.
- Demonstrar profissionalismo, atenção e cuidado: responder com clareza, ser educada e mostrar compromisso em resolver o problema da melhor forma.
### 2. Relacionamento depois da entrega
- Manter contato quando o trabalho termina. Exemplo: mensagem perguntando se a pessoa ficou satisfeita ou precisa de algo mais.
- Oferecer algo a mais: uma dica, uma sugestão, uma ideia útil. Pequenos gestos fazem você ser lembrada e valorizada.
### 3. Identificar oportunidades de recorrência
- Quem te procurou para um problema pode ter outras necessidades que você atende.
- Exemplo: pediu um texto › provavelmente vai precisar de outros textos › sugerir um acompanhamento mensal, com entregas contínuas.
- O segredo: observar, entender a necessidade e oferecer uma solução que faça sentido.
### 4. Comunicar os benefícios do contrato recorrente
- Explicar que a pessoa terá o que precisa sem procurar outro profissional toda vez.
- Mostrar que você está pronta para entregar algo consistente e de qualidade, o que gera confiança e aumenta a chance de aceite.', 'approved', ARRAY['funil de clientes recorrentes','fidelização','cliente fiel','recorrência','contrato mensal','acompanhamento mensal','acompanhamento contínuo','pacote mensal','pós-venda','follow-up','mensagem de satisfação','demanda pontual','upsell','oferecer algo a mais']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M05.A03-03', 'principal', 2, 5, 'V2.M05.A03 — Funil de Clientes Recorrentes: Da Primeira Venda ao Cliente Fiel', 'Tarefa prática', 'Funil de Clientes Recorrentes: Da Primeira Venda ao Cliente Fiel', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 05 – Máquina de Receita Recorrente 2.0 › Aula 03 – Funil de Clientes Recorrentes: Da Primeira Venda ao Cliente Fiel › Tarefa prática

1. Fazer uma lista das pessoas que já confiaram no seu trabalho.
2. Pensar no que pode oferecer a mais para cada uma.
3. Entrar em contato, perguntar como estão e, se fizer sentido, apresentar a ideia do acompanhamento contínuo.
4. Fazer isso de forma natural, sem pressão.', 'approved', ARRAY['funil de clientes recorrentes','fidelização','cliente fiel','recorrência','contrato mensal','acompanhamento mensal','acompanhamento contínuo','pacote mensal','pós-venda','follow-up','mensagem de satisfação','demanda pontual','upsell','oferecer algo a mais']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M05.A03-04', 'principal', 2, 5, 'V2.M05.A03 — Funil de Clientes Recorrentes: Da Primeira Venda ao Cliente Fiel', 'FAQ', 'Funil de Clientes Recorrentes: Da Primeira Venda ao Cliente Fiel', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 05 – Máquina de Receita Recorrente 2.0 › Aula 03 – Funil de Clientes Recorrentes: Da Primeira Venda ao Cliente Fiel › Pontos para o suporte

- "Como faço o cliente voltar?" Atendimento cuidadoso desde o primeiro contato, mensagem de pós-venda perguntando se ficou satisfeito e pequenos extras (dicas, sugestões).
- "Como transformo um serviço avulso em mensal?" Observar se o cliente terá a mesma necessidade de novo e propor um acompanhamento mensal, explicando que ele não precisará procurar outra profissional a cada vez.
- "Como abordo ex-clientes sem parecer chata?" Começar perguntando como estão. Só apresentar a proposta se fizer sentido, sem pressão.', 'approved', ARRAY['funil de clientes recorrentes','fidelização','cliente fiel','recorrência','contrato mensal','acompanhamento mensal','acompanhamento contínuo','pacote mensal','pós-venda','follow-up','mensagem de satisfação','demanda pontual','upsell','oferecer algo a mais']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M05.A04-01', 'principal', 2, 5, 'V2.M05.A04 — Automação de Processos: Otimizando Tempo e Aumentando Lucro', 'Visão geral', 'Automação de Processos: Otimizando Tempo e Aumentando Lucro', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 05 – Máquina de Receita Recorrente 2.0 › Aula 04 – Automação de Processos: Otimizando Tempo e Aumentando Lucro › Visão geral da aula

Nome oficial da aula: Automação de Processos: Otimizando Tempo e Aumentando Lucro
Onde fica: Vitrine 2 (I BÔNUS – Skill''s das Demandas Lucrativas), Módulo 05 – Máquina de Receita Recorrente 2.0, Aula 04
Duração/formato: 2:45
Link na área de membros (abre a página do Módulo 05, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/2/22

Resumo:
A aula defende que o tempo é o recurso mais valioso e que automatizar tarefas repetitivas libera tempo para entregar com qualidade e buscar novas oportunidades, aumentando o lucro. Apresenta 3 áreas para automatizar: captação de contatos, entrega e administrativo. Fecha com a tarefa de listar as tarefas repetitivas e pensar em como simplificar cada uma.
A aula é conceitual: não cita nenhuma ferramenta pelo nome, só categorias.', 'approved', ARRAY['automação','automatizar','processos','tarefas repetitivas','produtividade','chatbot','mensagens automáticas','respostas rápidas','formulário','briefing','captação de contatos','propostas automáticas','organização de arquivos','compartilhamento','nuvem','acompanhar prazos','gestão de tarefas','apps de gestão','planilhas automatizadas','recibos','administrativo']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M05.A04-02', 'principal', 2, 5, 'V2.M05.A04 — Automação de Processos: Otimizando Tempo e Aumentando Lucro', 'Procedimento: passo a passo', 'Automação de Processos: Otimizando Tempo e Aumentando Lucro', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 05 – Máquina de Receita Recorrente 2.0 › Aula 04 – Automação de Processos: Otimizando Tempo e Aumentando Lucro › Procedimento: passo a passo

### 1. Identificar as tarefas repetitivas
Exemplos citados: responder mensagens, organizar informações, enviar propostas, acompanhar prazos.
### 2. Automatizar por área
| Área | O que a aula sugere | Exemplos de ferramentas (sugestão da documentação, não citadas na aula) |
|---|---|---|
| Captação de contatos | Sistemas que enviam respostas e propostas automáticas ("ninguém fica sem retorno"); formulários para entender a necessidade antes da conversa | WhatsApp Business (mensagem de saudação, ausência, respostas rápidas); Google Forms |
| Entrega | Organizar arquivos num único lugar e compartilhar rápido e com segurança; acompanhar prazos e etapas | Google Drive; Trello, Notion ou Google Agenda |
| Administrativo | Gerar recibos automaticamente e organizar pagamentos | Planilha de controle; emissor de recibo/nota |
### 3. Lista de categorias da aula
- Sistemas de automação de mensagens e chatbots;
- Ferramentas de organização;
- Planilhas automatizadas ou apps de gestão;
- Plataformas de envio e organização de arquivos.', 'approved', ARRAY['automação','automatizar','processos','tarefas repetitivas','produtividade','chatbot','mensagens automáticas','respostas rápidas','formulário','briefing','captação de contatos','propostas automáticas','organização de arquivos','compartilhamento','nuvem','acompanhar prazos','gestão de tarefas','apps de gestão','planilhas automatizadas','recibos','administrativo']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M05.A04-03', 'principal', 2, 5, 'V2.M05.A04 — Automação de Processos: Otimizando Tempo e Aumentando Lucro', 'Tarefa prática', 'Automação de Processos: Otimizando Tempo e Aumentando Lucro', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 05 – Máquina de Receita Recorrente 2.0 › Aula 04 – Automação de Processos: Otimizando Tempo e Aumentando Lucro › Tarefa prática

1. Escrever as tarefas que você faz repetidamente.
2. Ao lado de cada uma, anotar como simplificar ou automatizar.
3. Se perde muito tempo respondendo mensagens ou organizando documentos, buscar um sistema que faça isso.
"Automatizar processos é criar um sistema que te permita crescer sem se sobrecarregar."', 'approved', ARRAY['automação','automatizar','processos','tarefas repetitivas','produtividade','chatbot','mensagens automáticas','respostas rápidas','formulário','briefing','captação de contatos','propostas automáticas','organização de arquivos','compartilhamento','nuvem','acompanhar prazos','gestão de tarefas','apps de gestão','planilhas automatizadas','recibos','administrativo']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M05.A04-04', 'principal', 2, 5, 'V2.M05.A04 — Automação de Processos: Otimizando Tempo e Aumentando Lucro', 'FAQ', 'Automação de Processos: Otimizando Tempo e Aumentando Lucro', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 05 – Máquina de Receita Recorrente 2.0 › Aula 04 – Automação de Processos: Otimizando Tempo e Aumentando Lucro › Pontos para o suporte

- "Quais ferramentas devo usar?" A aula não indica ferramentas específicas. Para começar: WhatsApp Business (respostas rápidas e mensagens automáticas), Google Forms (briefing), Google Drive (arquivos) e Trello ou Google Agenda (prazos).
- "Por onde começo a automatizar?" Listar as tarefas repetitivas e atacar primeiro a que mais toma tempo, geralmente o atendimento por mensagens.
- "Preciso pagar por sistema?" Não necessariamente: as opções básicas citadas acima têm versões gratuitas.', 'approved', ARRAY['automação','automatizar','processos','tarefas repetitivas','produtividade','chatbot','mensagens automáticas','respostas rápidas','formulário','briefing','captação de contatos','propostas automáticas','organização de arquivos','compartilhamento','nuvem','acompanhar prazos','gestão de tarefas','apps de gestão','planilhas automatizadas','recibos','administrativo']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M05.A05-01', 'principal', 2, 5, 'V2.M05.A05 — Certificação', 'Visão geral', 'Certificação', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 05 – Máquina de Receita Recorrente 2.0 › Aula 05 – Certificação › Visão geral da aula

Nome oficial da aula: Certificação
Onde fica: Vitrine 2 (I BÔNUS – Skill''s das Demandas Lucrativas), Módulo 05 – Máquina de Receita Recorrente 2.0, Aula 05
Duração/formato: 1:33
Link na área de membros (abre a página do Módulo 05, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/2/22

Resumo:
É a aula de encerramento do Módulo 05, curta (1:33). Diferente das certificações anteriores, o foco aqui é como usar o certificado na prática: comunicá-lo em conversas, apresentações e canais de divulgação, para construir autoridade e confiança ("quem confia em você, te contrata e te recomenda") e ter um diferencial competitivo. Traz uma frase-modelo para usar com clientes e nas redes.
Não menciona PDF de resumo (diferente das certificações dos Módulos 02, 03 e 04) e não explica como emitir o certificado.', 'approved', ARRAY['certificado','certificação','selo','formação','diploma','autoridade','diferencial competitivo','posicionamento','divulgar certificado','redes sociais','conversa com cliente']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M05.A05-02', 'principal', 2, 5, 'V2.M05.A05 — Certificação', 'Procedimento: como usar o certificado', 'Certificação', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 05 – Máquina de Receita Recorrente 2.0 › Aula 05 – Certificação › Procedimento: como usar o certificado

1. Comunicar sempre que possível que é certificada: em conversas, apresentações e canais de divulgação (redes sociais, perfil).
2. Usar como diferencial competitivo: "muitas pessoas oferecem soluções, mas poucas buscam se qualificar de verdade".
3. Frase-modelo da aula: "Concluí uma formação onde aprendi a otimizar processos e entregar resultados eficientes. Estou pronta para te ajudar a alcançar os seus objetivos."
4. Usar a frase nas redes sociais e em conversas com clientes.', 'approved', ARRAY['certificado','certificação','selo','formação','diploma','autoridade','diferencial competitivo','posicionamento','divulgar certificado','redes sociais','conversa com cliente']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M05.A05-03', 'principal', 2, 5, 'V2.M05.A05 — Certificação', 'FAQ', 'Certificação', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 05 – Máquina de Receita Recorrente 2.0 › Aula 05 – Certificação › Pontos para o suporte

- "Como pego meu certificado?" A aula não explica. Confirmar o procedimento com a equipe (mesma lacuna das certificações da Vitrine 2, Módulo 02, Aula 07, M03 A12 e M04 A06).
- "Posso colocar o certificado no meu perfil?" Sim, a aula incentiva.
- "Tem PDF de resumo deste módulo?" A aula não menciona. Confirmar com a equipe.', 'approved', ARRAY['certificado','certificação','selo','formação','diploma','autoridade','diferencial competitivo','posicionamento','divulgar certificado','redes sociais','conversa com cliente']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M01.A01-01', 'principal', 2, 1, 'V2.M01.A01 — Encontrando Suas Skills Ocultas', 'Visão geral', 'Encontrando Suas Skills Ocultas', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 01 – Revelando Talentos Invisíveis › Aula 01 – Encontrando Suas Skills Ocultas › Visão geral da aula

Nome oficial da aula: Encontrando Suas Skills Ocultas
Onde fica: Vitrine 2 (I BÔNUS – Skill''s das Demandas Lucrativas), Módulo 01 – Revelando Talentos Invisíveis, Aula 01
Duração/formato: 5:02
Link na área de membros (abre a página do Módulo 01, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/2/18

Resumo:
É a aula de abertura do bônus Skill''s das Demandas Lucrativas, citado no M06 A04 e no Bônus 01 do M07 como "Skills das Subdemandas". É uma aula de autoconhecimento, com tom de fé ("Deus não escolhe os capacitados, capacita os escolhidos"), que ajuda a aluna a descobrir talentos que ela não enxerga olhando para o dia a dia, para as dificuldades que superou e para o que os outros pedem a ela. Traz a técnica do "inventário reverso" e dois exercícios escritos.', 'approved', ARRAY['Skills das Demandas Lucrativas','Skills das Demandas','Skills das Subdemandas','bônus 1','I Bônus','Revelando talentos invisíveis','skills ocultas','talentos escondidos','inventário reverso','quebra-cabeça da vida']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M01.A01-02', 'principal', 2, 1, 'V2.M01.A01 — Encontrando Suas Skills Ocultas', 'Procedimento: exercícios da aula', 'Encontrando Suas Skills Ocultas', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 01 – Revelando Talentos Invisíveis › Aula 01 – Encontrando Suas Skills Ocultas › Procedimento: exercícios da aula

### Exercício 1: as 3 perguntas
Num papel ou no celular, responder com calma, sem deixar nada de fora:
1. O que eu gosto de fazer? Mesmo que pareça bobo. Exemplos: cozinhar, organizar a casa, cuidar de plantas, ajudar os filhos com a lição, conversar, aconselhar, ouvir.
2. Que dificuldades eu já superei? Exemplos: economizar com pouco dinheiro, criar uma rotina com os filhos e a casa, lidar com problemas de saúde ou de família.
3. O que as pessoas sempre me pedem? Exemplos: organizar uma festa, ensinar uma receita, dar conselhos.
### Técnica: inventário reverso
Em vez de pensar "o que eu acho que sei fazer", olhar a lista e ver o que os outros já enxergaram em você:
| Se as pessoas te pedem… | …você tem habilidade de |
|---|---|
| Ajuda para organizar as contas | Planejamento |
| Dicas de beleza | Beleza / estética |
| Para resolver os problemas da casa | Encontrar soluções |
### Exercício 2: o que os próximos pedem
Pensar em amigos, família e vizinhos e anotar pelo menos 3 coisas que eles sempre pedem. Exemplos: "me ajuda a escolher roupas", "me ensina aquele bolo", "me explica como você economiza".
### Próximo passo
A próxima aula vai ensinar a transformar essas habilidades em algo que gera resultado.', 'approved', ARRAY['Skills das Demandas Lucrativas','Skills das Demandas','Skills das Subdemandas','bônus 1','I Bônus','Revelando talentos invisíveis','skills ocultas','talentos escondidos','inventário reverso','quebra-cabeça da vida']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M01.A01-03', 'principal', 2, 1, 'V2.M01.A01 — Encontrando Suas Skills Ocultas', 'FAQ', 'Encontrando Suas Skills Ocultas', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 01 – Revelando Talentos Invisíveis › Aula 01 – Encontrando Suas Skills Ocultas › Pontos para o suporte

- "Onde fica o bônus Skills das Subdemandas / Skill''s das Demandas Lucrativas?" Na área de membros, vitrine "I BÔNUS – Skill''s das Demandas Lucrativas". Esta é a Aula 01.
- "Não sei que habilidade eu tenho." Indicar esta aula: as 3 perguntas e o inventário reverso. Complementa o método dos 5 círculos (M06 A01).', 'approved', ARRAY['Skills das Demandas Lucrativas','Skills das Demandas','Skills das Subdemandas','bônus 1','I Bônus','Revelando talentos invisíveis','skills ocultas','talentos escondidos','inventário reverso','quebra-cabeça da vida']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M01.A02-01', 'principal', 2, 1, 'V2.M01.A02 — DNA de Talentos: Enxergando Além do Óbvio', 'Visão geral', 'DNA de Talentos: Enxergando Além do Óbvio', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 01 – Revelando Talentos Invisíveis › Aula 02 – DNA de Talentos: Enxergando Além do Óbvio › Visão geral da aula

Nome oficial da aula: DNA de Talentos: Enxergando Além do Óbvio
Onde fica: Vitrine 2 (I BÔNUS – Skill''s das Demandas Lucrativas), Módulo 01 – Revelando Talentos Invisíveis, Aula 02
Duração/formato: 4:52
Link na área de membros (abre a página do Módulo 01, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/2/18

Resumo:
A aula continua a Aula 01 e ensina a aluna a conectar as habilidades listadas e a enxergar o valor delas pelo impacto na vida de outras pessoas. A pergunta-chave é: "Como o que eu sei fazer pode resolver um problema ou atender a uma necessidade de alguém?" Apresenta a fórmula do talento, um passo a passo em 4 etapas, um questionário e o mapa do talento.', 'approved', ARRAY['DNA de talentos','enxergando além do óbvio','talento = facilidade + paixão + demanda','fórmula do talento','mapa do talento','conectar os pontos','valor das habilidades','impacto','resolver problemas','Skills das Demandas Lucrativas','Skills das Subdemandas']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M01.A02-02', 'principal', 2, 1, 'V2.M01.A02 — DNA de Talentos: Enxergando Além do Óbvio', 'A fórmula do talento', 'DNA de Talentos: Enxergando Além do Óbvio', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 01 – Revelando Talentos Invisíveis › Aula 02 – DNA de Talentos: Enxergando Além do Óbvio › A fórmula do talento

Talento = Facilidade + Paixão + Demanda
| Elemento | O que é |
|---|---|
| Facilidade | O que você faz com naturalidade, sem esforço, e que outras pessoas acham difícil |
| Paixão | O que você gosta de fazer, o que faz o tempo passar rápido |
| Demanda | O que as pessoas precisam e estão dispostas a pagar para resolver |
Exemplo da aula: gosta de cozinhar + economiza na cozinha + pedem receitas a você = sinal de um talento que pode virar algo maior. Outro exemplo: facilidade para organizar + gostar de ajudar + muita gente precisa organizar a casa ou a rotina = caminho claro.', 'approved', ARRAY['DNA de talentos','enxergando além do óbvio','talento = facilidade + paixão + demanda','fórmula do talento','mapa do talento','conectar os pontos','valor das habilidades','impacto','resolver problemas','Skills das Demandas Lucrativas','Skills das Subdemandas']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M01.A02-03', 'principal', 2, 1, 'V2.M01.A02 — DNA de Talentos: Enxergando Além do Óbvio', 'Procedimento: passo a passo', 'DNA de Talentos: Enxergando Além do Óbvio', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 01 – Revelando Talentos Invisíveis › Aula 02 – DNA de Talentos: Enxergando Além do Óbvio › Procedimento: passo a passo

1. Identificar a facilidade: na lista da Aula 01, marcar o que faz de forma natural (organizar, ensinar, criar, resolver problemas, desenhar…).
2. Descobrir a paixão: entre essas, quais você gosta de fazer?
3. Encontrar a demanda: quem precisa disso? Que problema resolve?
4. Conectar os pontos: juntar facilidade, paixão e demanda num caminho.', 'approved', ARRAY['DNA de talentos','enxergando além do óbvio','talento = facilidade + paixão + demanda','fórmula do talento','mapa do talento','conectar os pontos','valor das habilidades','impacto','resolver problemas','Skills das Demandas Lucrativas','Skills das Subdemandas']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M01.A02-04', 'principal', 2, 1, 'V2.M01.A02 — DNA de Talentos: Enxergando Além do Óbvio', 'Exercício: questionário', 'DNA de Talentos: Enxergando Além do Óbvio', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 01 – Revelando Talentos Invisíveis › Aula 02 – DNA de Talentos: Enxergando Além do Óbvio › Exercício: questionário

Responder num papel ou no celular:
1. Qual habilidade você faz com mais facilidade?
2. O que você realmente gosta de fazer?
3. Quem precisa do que você gosta de fazer?
4. Como isso pode ajudar outras pessoas?
5. Qual o impacto dessa habilidade na vida de alguém?', 'approved', ARRAY['DNA de talentos','enxergando além do óbvio','talento = facilidade + paixão + demanda','fórmula do talento','mapa do talento','conectar os pontos','valor das habilidades','impacto','resolver problemas','Skills das Demandas Lucrativas','Skills das Subdemandas']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M01.A02-05', 'principal', 2, 1, 'V2.M01.A02 — DNA de Talentos: Enxergando Além do Óbvio', 'Exercício: mapa do talento', 'DNA de Talentos: Enxergando Além do Óbvio', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 01 – Revelando Talentos Invisíveis › Aula 02 – DNA de Talentos: Enxergando Além do Óbvio › Exercício: mapa do talento

- No centro do papel, escrever o que você sabe fazer.
- Ao redor, escrever as formas como isso pode ajudar outras pessoas.
- Guardar o mapa. É o ponto de partida para os próximos módulos do bônus, que prometem ensinar a desenvolver ou melhorar essas habilidades.', 'approved', ARRAY['DNA de talentos','enxergando além do óbvio','talento = facilidade + paixão + demanda','fórmula do talento','mapa do talento','conectar os pontos','valor das habilidades','impacto','resolver problemas','Skills das Demandas Lucrativas','Skills das Subdemandas']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M01.A02-06', 'principal', 2, 1, 'V2.M01.A02 — DNA de Talentos: Enxergando Além do Óbvio', 'FAQ', 'DNA de Talentos: Enxergando Além do Óbvio', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 01 – Revelando Talentos Invisíveis › Aula 02 – DNA de Talentos: Enxergando Além do Óbvio › Pontos para o suporte

- "Descobri minhas habilidades, e agora?" Indicar esta aula: aplicar a fórmula Talento = Facilidade + Paixão + Demanda e montar o mapa do talento.
- "Como sei se uma habilidade dá dinheiro?" Pelo elemento Demanda: alguém precisa disso e pagaria para resolver?', 'approved', ARRAY['DNA de talentos','enxergando além do óbvio','talento = facilidade + paixão + demanda','fórmula do talento','mapa do talento','conectar os pontos','valor das habilidades','impacto','resolver problemas','Skills das Demandas Lucrativas','Skills das Subdemandas']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M02.A01-01', 'principal', 2, 2, 'V2.M02.A01 — Por que suas palavras não vendem (e como mudar isso hoje)', 'Visão geral', 'Por que suas palavras não vendem (e como mudar isso hoje)', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 02 – Comunicação Viral: O Código da Persuasão Digital › Aula 01 – Por que suas palavras não vendem (e como mudar isso hoje) › Visão geral da aula

Nome oficial da aula: Por que suas palavras não vendem (e como mudar isso hoje)
Onde fica: Vitrine 2 (I BÔNUS – Skill''s das Demandas Lucrativas), Módulo 02 – Comunicação Viral: O Código da Persuasão Digital, Aula 01
Duração/formato: 1:56
Link na área de membros (abre a página do Módulo 02, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/2/19

Resumo:
É uma aula curta de abertura do módulo de escrita persuasiva, que vale para produtos, propostas e textos de venda para clientes. A professora conta que, há cerca de 3 anos, estava "quebrada" e escrevia e-mails, posts e anúncios que não vendiam, até descobrir que o problema era como ela falava. A lição central: quem vende fala da transformação, da vida depois do produto; quem não vende lista características.', 'approved', ARRAY['Comunicação viral','código da persuasão digital','persuasão','copywriting','copy','Dominando a Arte da Comunicação Simples','palavras que vendem','textos de venda','propostas','anúncios','transformação','vida depois do produto','benefício × característica']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M02.A01-02', 'principal', 2, 2, 'V2.M02.A01 — Por que suas palavras não vendem (e como mudar isso hoje)', 'O princípio', 'Por que suas palavras não vendem (e como mudar isso hoje)', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 02 – Comunicação Viral: O Código da Persuasão Digital › Aula 01 – Por que suas palavras não vendem (e como mudar isso hoje) › O princípio

| ❌ Quem não vende | ✅ Quem vende |
|---|---|
| Fala do produto | Fala da transformação que o produto entrega |
| Lista características | Descreve a vida depois do produto |
| Pensa no que quer dizer | Pensa no que a pessoa precisa ouvir |
| Tenta vender | Tenta ajudar, e as vendas aparecem |
Exemplo da aula: um curso de inglês não vende "aulas de inglês". Vende a sensação de chegar num país estrangeiro e se sentir em casa, ou de assistir a um filme sem legenda e entender cada piada.', 'approved', ARRAY['Comunicação viral','código da persuasão digital','persuasão','copywriting','copy','Dominando a Arte da Comunicação Simples','palavras que vendem','textos de venda','propostas','anúncios','transformação','vida depois do produto','benefício × característica']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M02.A01-03', 'principal', 2, 2, 'V2.M02.A01 — Por que suas palavras não vendem (e como mudar isso hoje)', 'Procedimento: a primeira lição', 'Por que suas palavras não vendem (e como mudar isso hoje)', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 02 – Comunicação Viral: O Código da Persuasão Digital › Aula 01 – Por que suas palavras não vendem (e como mudar isso hoje) › Procedimento: a primeira lição

Antes de escrever qualquer texto (proposta, anúncio, post, descrição de serviço), perguntar:
"Como a vida dessa pessoa vai estar diferente depois que ela usar o meu produto ou serviço?"
Responder com honestidade e escrever a partir dessa resposta.
Próxima aula: identificar quem é a pessoa que você precisa convencer.', 'approved', ARRAY['Comunicação viral','código da persuasão digital','persuasão','copywriting','copy','Dominando a Arte da Comunicação Simples','palavras que vendem','textos de venda','propostas','anúncios','transformação','vida depois do produto','benefício × característica']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M02.A01-04', 'principal', 2, 2, 'V2.M02.A01 — Por que suas palavras não vendem (e como mudar isso hoje)', 'FAQ', 'Por que suas palavras não vendem (e como mudar isso hoje)', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 02 – Comunicação Viral: O Código da Persuasão Digital › Aula 01 – Por que suas palavras não vendem (e como mudar isso hoje) › Pontos para o suporte

- "Minhas propostas não são aceitas / meus textos não vendem." Indicar este módulo: falar da transformação, e não da tarefa. Complementa o Bônus 01 do M07 (propostas irresistíveis) e o M13 A05 (soluções completas).
- "Onde fica o módulo de comunicação indicado no Bônus 01 do M07?" É este: bônus Skill''s das Demandas Lucrativas › Módulo 02. No M07 A05, ele foi citado como "Dominando a Arte da Comunicação Simples".', 'approved', ARRAY['Comunicação viral','código da persuasão digital','persuasão','copywriting','copy','Dominando a Arte da Comunicação Simples','palavras que vendem','textos de venda','propostas','anúncios','transformação','vida depois do produto','benefício × característica']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M02.A02-01', 'principal', 2, 2, 'V2.M02.A02 — A Persona – Quem você está tentando convencer?', 'Visão geral', 'A Persona – Quem você está tentando convencer?', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 02 – Comunicação Viral: O Código da Persuasão Digital › Aula 02 – A Persona – Quem você está tentando convencer? › Visão geral da aula

Nome oficial da aula: A Persona – Quem você está tentando convencer?
Onde fica: Vitrine 2 (I BÔNUS – Skill''s das Demandas Lucrativas), Módulo 02 – Comunicação Viral: O Código da Persuasão Digital, Aula 02
Duração/formato: 4:40
Link na área de membros (abre a página do Módulo 02, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/2/19

Resumo:
A aula ensina a conhecer profundamente quem compra de você, a persona. Vai além de idade, cidade e renda: trata do que a pessoa sente, do que tira o sono dela e do que ela sonha em silêncio. A ideia central: "Quando você tenta falar com todo mundo, acaba não falando com ninguém." A aula apresenta os 3 pontos fundamentais (dor, sonho e medo) com o exemplo da "Maria".', 'approved', ARRAY['persona','público-alvo','cliente ideal','avatar','dor','sonho','medo','os 3 pontos','falar com uma pessoa só','empatia']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M02.A02-02', 'principal', 2, 2, 'V2.M02.A02 — A Persona – Quem você está tentando convencer?', 'Os 3 pontos da persona', 'A Persona – Quem você está tentando convencer?', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 02 – Comunicação Viral: O Código da Persuasão Digital › Aula 02 – A Persona – Quem você está tentando convencer? › Os 3 pontos da persona

| Ponto | Pergunta | Exemplo: Maria |
|---|---|---|
| 1. Dor mais profunda | O que realmente machuca e tira o sono? Não o problema superficial. | Não é só dinheiro: é sentir que a vida está parada, presa num ciclo, com medo de nunca melhorar. |
| 2. Sonho guardado | O que ela deseja e nem tem coragem de contar, por medo de ser julgada? | Ser admirada, que as pessoas sintam orgulho dela, ser reconhecida pelo esforço. |
| 3. Medo que trava | O que a faz hesitar antes de decidir? | Medo de tentar de novo e fracassar, porque já tentou antes e não deu certo. |
### Exemplo da persona "Maria"
35 anos, trabalha num lugar onde não se sente valorizada. O salário mal paga as contas. À noite, rola o Instagram vendo vidas "perfeitas" e pensa: "Quando vai ser a minha vez?" O que ela quer de fato é esperança: uma saída que não dependa de diploma caro, de contatos ou de sorte.
Como falar com ela: em vez de detalhes técnicos, falar da transformação (Aula 01): a liberdade de acordar na segunda-feira sem depender de ninguém para pagar as contas e o orgulho de ajudar a família.', 'approved', ARRAY['persona','público-alvo','cliente ideal','avatar','dor','sonho','medo','os 3 pontos','falar com uma pessoa só','empatia']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M02.A02-03', 'principal', 2, 2, 'V2.M02.A02 — A Persona – Quem você está tentando convencer?', 'Procedimento: aplicar na prática', 'A Persona – Quem você está tentando convencer?', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 02 – Comunicação Viral: O Código da Persuasão Digital › Aula 02 – A Persona – Quem você está tentando convencer? › Procedimento: aplicar na prática

1. Escolher uma única pessoa para quem você escreve, e não "todo mundo".
2. Responder por escrito, sobre essa pessoa:
  - Qual é a dor mais profunda dela?
  - Qual é o sonho que ela guarda?
  - Qual é o medo que a trava?
3. Escrever os textos (propostas, anúncios, descrições de serviço) falando com ela, a partir dessas respostas.
Próxima aula: como criar a ideia que faz a pessoa parar tudo para prestar atenção.', 'approved', ARRAY['persona','público-alvo','cliente ideal','avatar','dor','sonho','medo','os 3 pontos','falar com uma pessoa só','empatia']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M02.A02-04', 'principal', 2, 2, 'V2.M02.A02 — A Persona – Quem você está tentando convencer?', 'FAQ', 'A Persona – Quem você está tentando convencer?', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 02 – Comunicação Viral: O Código da Persuasão Digital › Aula 02 – A Persona – Quem você está tentando convencer? › Pontos para o suporte

- "Para quem eu escrevo minha proposta ou anúncio?" Para uma pessoa específica, a persona. Responder as 3 perguntas: dor, sonho e medo.
- "Como uso isso nas plataformas de freela?" Pensar no cliente típico do serviço (por exemplo, a dona de uma pequena loja que não tem tempo para as redes sociais) e escrever a proposta a partir da dor, do sonho e do medo dela. Complementa o Bônus 01 do M07 (parte 3 da proposta: "mostre que conhece as dores").', 'approved', ARRAY['persona','público-alvo','cliente ideal','avatar','dor','sonho','medo','os 3 pontos','falar com uma pessoa só','empatia']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M02.A03-01', 'principal', 2, 2, 'V2.M02.A03 — A Grande Ideia – O que faz alguém parar tudo pra te ouvir', 'Visão geral', 'A Grande Ideia – O que faz alguém parar tudo pra te ouvir', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 02 – Comunicação Viral: O Código da Persuasão Digital › Aula 03 – A Grande Ideia – O que faz alguém parar tudo pra te ouvir › Visão geral da aula

Nome oficial da aula: A Grande Ideia – O que faz alguém parar tudo pra te ouvir
Onde fica: Vitrine 2 (I BÔNUS – Skill''s das Demandas Lucrativas), Módulo 02 – Comunicação Viral: O Código da Persuasão Digital, Aula 03
Duração/formato: 5:01
Link na área de membros (abre a página do Módulo 02, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/2/19

Resumo:
A aula apresenta o conceito de "grande ideia" em copywriting: uma ideia única e central, interessante e benéfica para o leitor, em que uma peça de texto se concentra. É "o coração da mensagem". Quando ela é boa, "o resto do texto praticamente se escreve sozinho". Com base em Mike Palmer, a aula explica os 4 elementos de uma grande ideia e um processo em 5 passos para criá-la. A frase final: "Criatividade é repertório."', 'approved', ARRAY['grande ideia','big idea','ideia central','copy','copywriting','cópia','Mike Palmer','originalidade','intriga','benefício','afirmação','pesquisa','exploração','brainstorm','teste de originalidade','validação','mind map','mapa mental','SCAMPER','teste A/B']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M02.A03-02', 'principal', 2, 2, 'V2.M02.A03 — A Grande Ideia – O que faz alguém parar tudo pra te ouvir', 'Os 4 elementos de uma grande ideia (segundo Mike Palmer)', 'A Grande Ideia – O que faz alguém parar tudo pra te ouvir', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 02 – Comunicação Viral: O Código da Persuasão Digital › Aula 03 – A Grande Ideia – O que faz alguém parar tudo pra te ouvir › Os 4 elementos de uma grande ideia (segundo Mike Palmer)

| Elemento | O que é | Dica da aula |
|---|---|---|
| 1. Originalidade | Algo novo, que não foi visto antes | Não precisa reinventar a roda: muitas vezes vem de combinar duas ideias desconectadas ("café + leite = pingado") |
| 2. Intriga | Deixa o leitor curioso, querendo saber mais | "Se não prender a atenção logo de cara, já era" |
| 3. Benefício | Deixa claro o que o leitor ganha: tempo, dinheiro, paz de espírito | — |
| 4. Afirmação | Confirma algo que o leitor já acredita e cria conexão imediata | "Você sempre soube disso, mas nunca tinha percebido dessa forma" |', 'approved', ARRAY['grande ideia','big idea','ideia central','copy','copywriting','cópia','Mike Palmer','originalidade','intriga','benefício','afirmação','pesquisa','exploração','brainstorm','teste de originalidade','validação','mind map','mapa mental','SCAMPER','teste A/B']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M02.A03-03', 'principal', 2, 2, 'V2.M02.A03 — A Grande Ideia – O que faz alguém parar tudo pra te ouvir', 'Procedimento: os 5 passos para criar a grande ideia', 'A Grande Ideia – O que faz alguém parar tudo pra te ouvir', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 02 – Comunicação Viral: O Código da Persuasão Digital › Aula 03 – A Grande Ideia – O que faz alguém parar tudo pra te ouvir › Procedimento: os 5 passos para criar a grande ideia

1. Pesquisa. Coletar informações sobre o público-alvo, os concorrentes e as tendências. Ir além do demográfico: buscar dados psicográficos (comportamentos, atitudes, crenças, dores e desejos). Ver a persona da Aula 02.
2. Exploração. Consultar fontes variadas (livros, documentários, conversas) e conectar informações que parecem desconexas.
3. Brainstorm. Gerar ideias sem julgamento, usando:
  - mapa mental (mind map);
  - SCAMPER: Substituir, Combinar, Adaptar, Modificar, Propor outro uso, Eliminar, Reverter.
4. Teste de originalidade. Comparar com outras campanhas e ver se a ideia se destaca. "Originalidade não é complicação, é simplicidade com ângulo novo."
5. Validação. Checar se a ideia é intrigante, traz benefício claro e afirma crenças do público. Testar com pequenos grupos ou com testes A/B.
Atenção ao tempo: definir a grande ideia pode levar 50% ou mais do tempo de criação do texto.
Próxima aula: transformar a grande ideia em ação com os gatilhos certos.', 'approved', ARRAY['grande ideia','big idea','ideia central','copy','copywriting','cópia','Mike Palmer','originalidade','intriga','benefício','afirmação','pesquisa','exploração','brainstorm','teste de originalidade','validação','mind map','mapa mental','SCAMPER','teste A/B']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M02.A03-04', 'principal', 2, 2, 'V2.M02.A03 — A Grande Ideia – O que faz alguém parar tudo pra te ouvir', 'FAQ', 'A Grande Ideia – O que faz alguém parar tudo pra te ouvir', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 02 – Comunicação Viral: O Código da Persuasão Digital › Aula 03 – A Grande Ideia – O que faz alguém parar tudo pra te ouvir › Pontos para o suporte

- "O que é a grande ideia?" A ideia central de um texto de venda, que precisa ser original, intrigante, trazer benefício e confirmar algo que o leitor já acredita.
- "Como aplico isso numa proposta de freela?" Encontrar um ângulo que mostre ao cliente o resultado de forma nova. Exemplo do Bônus 01 do M07: em vez de "proposta para criação de logo", usar "como fazer o seu negócio ser lembrado pelos consumidores".', 'approved', ARRAY['grande ideia','big idea','ideia central','copy','copywriting','cópia','Mike Palmer','originalidade','intriga','benefício','afirmação','pesquisa','exploração','brainstorm','teste de originalidade','validação','mind map','mapa mental','SCAMPER','teste A/B']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M02.A04-01', 'principal', 2, 2, 'V2.M02.A04 — Os Gatilhos que Movem Pessoas', 'Visão geral', 'Os Gatilhos que Movem Pessoas', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 02 – Comunicação Viral: O Código da Persuasão Digital › Aula 04 – Os Gatilhos que Movem Pessoas › Visão geral da aula

Nome oficial da aula: Os Gatilhos que Movem Pessoas
Onde fica: Vitrine 2 (I BÔNUS – Skill''s das Demandas Lucrativas), Módulo 02 – Comunicação Viral: O Código da Persuasão Digital, Aula 04
Duração/formato: 4:15
Link na área de membros (abre a página do Módulo 02, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/2/19

Resumo:
A aula parte da ideia de que as pessoas compram com a emoção e justificam com a razão e apresenta os 5 gatilhos mentais que "mais convertem". O ponto central, que é o diferencial desta aula: os gatilhos só funcionam se forem verdadeiros. "Não são truques para manipular, são formas de comunicar verdades de um jeito que faz sentido para o cérebro humano." E: "O melhor gatilho mental é a honestidade."', 'approved', ARRAY['gatilhos mentais','gatilhos de persuasão','escassez real','prova social específica','autoridade conquistada','reciprocidade genuína','urgência verdadeira','emoção × razão']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M02.A04-02', 'principal', 2, 2, 'V2.M02.A04 — Os Gatilhos que Movem Pessoas', 'Os 5 gatilhos', 'Os Gatilhos que Movem Pessoas', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 02 – Comunicação Viral: O Código da Persuasão Digital › Aula 04 – Os Gatilhos que Movem Pessoas › Os 5 gatilhos

| # | Gatilho | Como usar (com verdade) | Exemplo da aula |
|---|---|---|---|
| 1 | Escassez real | Limitar de verdade, por um motivo real. Nunca "só restam 3 vagas" quando há mais. | "Só consigo atender 20 pessoas por mês porque faço questão de dar atenção individual." |
| 2 | Prova social específica | Nada de "nossos clientes adoraram". Contar histórias reais, com detalhes. | "João, contador de Curitiba, saiu de 3 mil para 15 mil em seis meses…" |
| 3 | Autoridade conquistada | Não é se gabar: é mostrar que já passou pelo problema da pessoa. | "Já estive quebrada, já fracassei, já duvidei de mim mesma, e foi por isso que descobri o que funciona." |
| 4 | Reciprocidade genuína | Entregar valor antes de pedir algo, sem segundas intenções. | Dar uma técnica útil de graça. |
| 5 | Urgência verdadeira | Baseada em consequências reais, e não em contadores falsos ou prazos inventados. | "Cada dia que você adia é um dia a menos para construir a vida que você quer." |', 'approved', ARRAY['gatilhos mentais','gatilhos de persuasão','escassez real','prova social específica','autoridade conquistada','reciprocidade genuína','urgência verdadeira','emoção × razão']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M02.A04-03', 'principal', 2, 2, 'V2.M02.A04 — Os Gatilhos que Movem Pessoas', 'Procedimento: como aplicar', 'Os Gatilhos que Movem Pessoas', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 02 – Comunicação Viral: O Código da Persuasão Digital › Aula 04 – Os Gatilhos que Movem Pessoas › Procedimento: como aplicar

1. Escolher o gatilho que corresponde a uma verdade da sua situação.
2. Escrevê-lo de forma específica e honesta: limite real, história real, experiência real.
3. Nunca inventar escassez, prova social ou urgência. "As pessoas percebem."
4. Ser transparente sobre resultados, limitações e fracassos, porque isso gera confiança, "o gatilho mais poderoso".
Próxima aula: onde aplicar tudo isso para "fazer dinheiro de verdade".', 'approved', ARRAY['gatilhos mentais','gatilhos de persuasão','escassez real','prova social específica','autoridade conquistada','reciprocidade genuína','urgência verdadeira','emoção × razão']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M02.A04-04', 'principal', 2, 2, 'V2.M02.A04 — Os Gatilhos que Movem Pessoas', 'FAQ', 'Os Gatilhos que Movem Pessoas', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 02 – Comunicação Viral: O Código da Persuasão Digital › Aula 04 – Os Gatilhos que Movem Pessoas › Pontos para o suporte

- "Posso usar ''vagas limitadas'' / ''últimas vagas'' na minha proposta?" Só se for verdade. Esta aula é clara: escassez e urgência falsas são percebidas e destroem a confiança.
- "Não tenho depoimentos, como faço prova social?" Usar apenas depoimentos reais, inclusive de trabalhos para amigos e familiares, identificados como tal. Nunca inventar.
- "O que são gatilhos mentais?" Formas de comunicar verdades de um jeito que facilita a decisão: escassez, prova social, autoridade, reciprocidade e urgência.', 'approved', ARRAY['gatilhos mentais','gatilhos de persuasão','escassez real','prova social específica','autoridade conquistada','reciprocidade genuína','urgência verdadeira','emoção × razão']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M02.A05-01', 'principal', 2, 2, 'V2.M02.A05 — Estratégias que Conectam: O Caminho para Resultados Reais', 'Visão geral', 'Estratégias que Conectam: O Caminho para Resultados Reais', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 02 – Comunicação Viral: O Código da Persuasão Digital › Aula 05 – Estratégias que Conectam: O Caminho para Resultados Reais › Visão geral da aula

Nome oficial da aula: Estratégias que Conectam: O Caminho para Resultados Reais
Onde fica: Vitrine 2 (I BÔNUS – Skill''s das Demandas Lucrativas), Módulo 02 – Comunicação Viral: O Código da Persuasão Digital, Aula 05
Duração/formato: 4:50
Link na área de membros (abre a página do Módulo 02, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/2/19

Resumo:
A aula apresenta 6 técnicas de comunicação persuasiva: AIDA, SPIN, storytelling, CTA, persuasão e antecipação de objeções. Fecha com um exercício que combina todas. A mensagem final: "Não é sobre falar bonito, é sobre falar com o coração, com verdade e com a intenção de ajudar."', 'approved', ARRAY['AIDA','atenção interesse desejo ação','SPIN','situação problema implicação necessidade','storytelling','storyline','contar histórias','CTA','call to action','chamada para ação','persuasão','objeções','quebra de objeções']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M02.A05-02', 'principal', 2, 2, 'V2.M02.A05 — Estratégias que Conectam: O Caminho para Resultados Reais', 'As técnicas', 'Estratégias que Conectam: O Caminho para Resultados Reais', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 02 – Comunicação Viral: O Código da Persuasão Digital › Aula 05 – Estratégias que Conectam: O Caminho para Resultados Reais › As técnicas

### 1. AIDA: estruturar a mensagem
| Etapa | O que fazer |
|---|---|
| Atenção | Frase impactante, pergunta que faz parar ou história que conecta |
| Interesse | Mostrar que entende o problema da pessoa |
| Desejo | Apresentar a solução de um jeito que a pessoa queira |
| Ação | Deixar claro o que ela deve fazer |
### 2. SPIN: entender quem está do outro lado
| Etapa | Pergunta |
|---|---|
| Situação | O que a pessoa está vivendo agora? |
| Problema | Qual é a dor, o que incomoda? |
| Implicação | O que acontece se ela não resolver? |
| Necessidade | Apresentar a solução de modo que ela perceba que precisa agora |
### 3. Storytelling
Histórias despertam emoção e fazem a pessoa se imaginar na situação. Podem ser algo que aconteceu com você ou com alguém que você conhece. A aula também admite "uma situação fictícia, mas realista".
### 4. CTA (chamada para ação)
Claro, direto e simples. Exemplos: "faça isso agora", "clique aqui", "comece hoje". Mostrar o que a pessoa ganha. "Não é pressionar, é guiar."
### 5. Persuasão (sem manipular)
1. Entender medos, desejos e dúvidas da pessoa.
2. Mostrar autoridade no assunto.
3. Usar provas: história de alguém que conseguiu, um dado ou algo que você viveu.
### 6. Antecipar objeções
Responder às dúvidas antes que apareçam:
- "Isso não é para mim" → contar a história de alguém na mesma situação que conseguiu;
- "Não tenho tempo" → mostrar que dá para fazer em pequenos momentos do dia.', 'approved', ARRAY['AIDA','atenção interesse desejo ação','SPIN','situação problema implicação necessidade','storytelling','storyline','contar histórias','CTA','call to action','chamada para ação','persuasão','objeções','quebra de objeções']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M02.A05-03', 'principal', 2, 2, 'V2.M02.A05 — Estratégias que Conectam: O Caminho para Resultados Reais', 'Exercício prático', 'Estratégias que Conectam: O Caminho para Resultados Reais', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 02 – Comunicação Viral: O Código da Persuasão Digital › Aula 05 – Estratégias que Conectam: O Caminho para Resultados Reais › Exercício prático

Pensar em algo que você quer apresentar (uma solução, uma ideia, uma proposta) e:
1. Estruturar a comunicação com AIDA.
2. Entender a pessoa com SPIN.
3. Criar uma história que conecte.
4. Terminar com um CTA claro.
5. Durante o texto, antecipar objeções e usar a persuasão para construir confiança.', 'approved', ARRAY['AIDA','atenção interesse desejo ação','SPIN','situação problema implicação necessidade','storytelling','storyline','contar histórias','CTA','call to action','chamada para ação','persuasão','objeções','quebra de objeções']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M02.A05-04', 'principal', 2, 2, 'V2.M02.A05 — Estratégias que Conectam: O Caminho para Resultados Reais', 'FAQ', 'Estratégias que Conectam: O Caminho para Resultados Reais', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 02 – Comunicação Viral: O Código da Persuasão Digital › Aula 05 – Estratégias que Conectam: O Caminho para Resultados Reais › Pontos para o suporte

- "Como estruturo minha proposta ou anúncio?" Usar AIDA: atenção, interesse, desejo e ação. Combina com a estrutura de 8 partes do Bônus 01 do M07.
- "Como termino a mensagem?" Com um CTA claro, por exemplo: "Me confirma por aqui que eu já reservo sua data."', 'approved', ARRAY['AIDA','atenção interesse desejo ação','SPIN','situação problema implicação necessidade','storytelling','storyline','contar histórias','CTA','call to action','chamada para ação','persuasão','objeções','quebra de objeções']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M02.A06-01', 'principal', 2, 2, 'V2.M02.A06 — Onde usar tudo isso pra fazer dinheiro', 'Visão geral', 'Onde usar tudo isso pra fazer dinheiro', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 02 – Comunicação Viral: O Código da Persuasão Digital › Aula 06 – Onde usar tudo isso pra fazer dinheiro › Visão geral da aula

Nome oficial da aula: Onde usar tudo isso pra fazer dinheiro
Onde fica: Vitrine 2 (I BÔNUS – Skill''s das Demandas Lucrativas), Módulo 02 – Comunicação Viral: O Código da Persuasão Digital, Aula 06
Duração/formato: 4:19
Link na área de membros (abre a página do Módulo 02, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/2/19

Resumo:
É a aula de aplicação prática do módulo de copywriting. Ela mostra 5 lugares do dia a dia onde a aluna pode usar o que aprendeu (persona, grande ideia, gatilhos) e dá exemplos de antes × depois para cada um. O conselho final: "Não espere estar pronta. O segredo do copy está na prática constante."', 'approved', ARRAY['onde aplicar copy','copywriting na prática','posts','Instagram','Facebook','estrutura de post','stories','status do WhatsApp','mensagens no WhatsApp','abordagem','bio','descrição do perfil','LinkedIn','99Freelas','conversas pessoais','pitch','o que você faz?']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M02.A06-02', 'principal', 2, 2, 'V2.M02.A06 — Onde usar tudo isso pra fazer dinheiro', 'Procedimento: os 5 lugares para aplicar copy', 'Onde usar tudo isso pra fazer dinheiro', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 02 – Comunicação Viral: O Código da Persuasão Digital › Aula 06 – Onde usar tudo isso pra fazer dinheiro › Procedimento: os 5 lugares para aplicar copy

### 1. Posts nas redes sociais (Instagram, Facebook)
- ❌ "Bom dia, pessoal!"
- ✅ Uma frase de abertura que desperta curiosidade, conecta com uma dor e promete uma solução. Exemplo da aula: "Você sabia que… [dor comum]? Eu descobri uma técnica simples que mudou minha manhã."
Estrutura de post:
1. Primeira linha: frase que capture a atenção.
2. Meio: conte uma história ou ensine algo útil.
3. Final: uma pergunta ou um convite para gerar interação.
### 2. Stories (Instagram e WhatsApp)
Mais íntimos e reais. Contar histórias do dia que tragam uma lição ou reflexão.
- Exemplo: "Acabei de sair do mercado e percebi uma coisa: o caixa me tratou super bem… sabe o que isso me ensinou sobre como tratar as pessoas?" Depois, desenvolver e conectar com o que você oferece.
### 3. Mensagens no WhatsApp
Nunca genéricas.
- ❌ "Oi, você tem interesse no meu [serviço]?"
- ✅ Personalizada, citando algo que a pessoa disse e oferecendo valor primeiro: "Oi, Maria! Vi que você comentou sobre [dificuldade]. Posso te passar uma dica rápida que me ajudou com isso?"
### 4. Descrição do perfil (Instagram, LinkedIn, 99Freelas etc.)
- ❌ "Empreendedora, mãe de família, apaixonada por tecnologia."
- ✅ Específica, mostrando quem você ajuda e como. Modelo: "Ajudo [quem] a [resultado] · [algo pessoal que gere identificação]."
### 5. Conversas pessoais
Quando alguém perguntar o que você faz:
- ❌ "Trabalho com marketing digital."
- ✅ "Ajudo empreendedoras a organizarem suas ideias e transformarem isso em resultados concretos."', 'approved', ARRAY['onde aplicar copy','copywriting na prática','posts','Instagram','Facebook','estrutura de post','stories','status do WhatsApp','mensagens no WhatsApp','abordagem','bio','descrição do perfil','LinkedIn','99Freelas','conversas pessoais','pitch','o que você faz?']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M02.A06-03', 'principal', 2, 2, 'V2.M02.A06 — Onde usar tudo isso pra fazer dinheiro', 'FAQ', 'Onde usar tudo isso pra fazer dinheiro', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 02 – Comunicação Viral: O Código da Persuasão Digital › Aula 06 – Onde usar tudo isso pra fazer dinheiro › Pontos para o suporte

- "O que escrevo na minha bio / descrição do perfil?" Usar o modelo "Ajudo [quem] a [resultado]". Complementa o elevator pitch do M06 A02.
- "Como chamo clientes pelo WhatsApp?" Mensagem personalizada, oferecendo valor antes de vender.
- "Como faço posts que engajam?" Primeira linha que prende a atenção, história ou dica no meio, pergunta ou convite no final.', 'approved', ARRAY['onde aplicar copy','copywriting na prática','posts','Instagram','Facebook','estrutura de post','stories','status do WhatsApp','mensagens no WhatsApp','abordagem','bio','descrição do perfil','LinkedIn','99Freelas','conversas pessoais','pitch','o que você faz?']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M02.A07-01', 'principal', 2, 2, 'V2.M02.A07 — Certificação', 'Visão geral', 'Certificação', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 02 – Comunicação Viral: O Código da Persuasão Digital › Aula 07 – Certificação › Visão geral da aula

Nome oficial da aula: Certificação
Onde fica: Vitrine 2 (I BÔNUS – Skill''s das Demandas Lucrativas), Módulo 02 – Comunicação Viral: O Código da Persuasão Digital, Aula 07
Duração/formato: 2:59
Link na área de membros (abre a página do Módulo 02, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/2/19

Resumo:
É a aula de encerramento do Módulo 02 (Comunicação Viral). É uma mensagem de parabéns pela conclusão e pelo certificado, que a aula apresenta como "a prova de que você decidiu investir em si mesma" e como ponto de partida, não o fim. Incentiva a aluna a aplicar o que aprendeu ("comece pequeno, mas comece") e a nunca parar de aprender. No fim, informa que há um e-book com o resumo de todo o conteúdo na descrição da aula.', 'approved', ARRAY['certificado','certificação','diploma','emitir certificado','e-book','ebook','resumo do módulo','material de apoio','PDF']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M02.A07-02', 'principal', 2, 2, 'V2.M02.A07 — Certificação', 'Procedimento: o que a aluna deve fazer', 'Certificação', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 02 – Comunicação Viral: O Código da Persuasão Digital › Aula 07 – Certificação › Procedimento: o que a aluna deve fazer

1. Baixar o e-book com o resumo do módulo, disponível na descrição desta aula.
2. Obter o certificado do módulo. ⚠️ A aula não explica como.
3. Começar a aplicar o que aprendeu em posts, stories, WhatsApp, bio e conversas (Aula 06).', 'approved', ARRAY['certificado','certificação','diploma','emitir certificado','e-book','ebook','resumo do módulo','material de apoio','PDF']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M02.A07-03', 'principal', 2, 2, 'V2.M02.A07 — Certificação', 'FAQ', 'Certificação', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 02 – Comunicação Viral: O Código da Persuasão Digital › Aula 07 – Certificação › Pontos para o suporte

- "Onde está o resumo / e-book do módulo de comunicação?" Na descrição da Aula 07 (Certificação) do Módulo 02 do bônus.
- "Como pego meu certificado?" A aula não explica. Confirmar o procedimento com a equipe antes de responder.', 'approved', ARRAY['certificado','certificação','diploma','emitir certificado','e-book','ebook','resumo do módulo','material de apoio','PDF']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M03.A01-01', 'principal', 2, 3, 'V2.M03.A01 — O Estúdio Secreto do Seu Smartphone', 'Visão geral', 'O Estúdio Secreto do Seu Smartphone', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 03 – Pocket Studio: Hollywood no Seu Bolso › Aula 01 – O Estúdio Secreto do Seu Smartphone › Visão geral da aula

Nome oficial da aula: O Estúdio Secreto do Seu Smartphone
Onde fica: Vitrine 2 (I BÔNUS – Skill''s das Demandas Lucrativas), Módulo 03 – Pocket Studio: Hollywood no Seu Bolso, Aula 01
Duração/formato: 4:05
Link na área de membros (abre a página do Módulo 03, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/2/20

Resumo:
É a abertura do módulo de produção de vídeo e foto com o celular. A aula ensina a transformar o smartphone num "estúdio completo" sem gastar nada, com 5 cuidados: luz, lente, configurações, estabilidade e som. Termina com um exercício de gravação de 30 segundos.', 'approved', ARRAY['Pocket Studio','Hollywood no seu bolso','estúdio no celular','luz natural','janela','iluminação','limpar a lente','câmera suja','resolução','1080p','Full HD','grade','linhas de grade','regra dos terços','estabilidade','tripé improvisado','altura dos olhos','áudio','som','fone com microfone','barulho de fundo']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M03.A01-02', 'principal', 2, 3, 'V2.M03.A01 — O Estúdio Secreto do Seu Smartphone', 'Procedimento: preparar o "estúdio"', 'O Estúdio Secreto do Seu Smartphone', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 03 – Pocket Studio: Hollywood no Seu Bolso › Aula 01 – O Estúdio Secreto do Seu Smartphone › Procedimento: preparar o "estúdio"

### 1. Luz
- Luz natural é a melhor amiga. Gravar perto de uma janela, com luz suave, sem sol forte.
- Sem uma boa janela, escolher o cômodo mais claro da casa (sala, quarto, cozinha).
### 2. Lente
- Limpar a lente com um paninho limpo ou uma camiseta de algodão antes de gravar. "Às vezes a câmera não é ruim, só está suja."
### 3. Configurações da câmera
- Ativar a maior resolução disponível: 1080p / Full HD.
- Ativar a grade (linhas que dividem a tela em 9 partes), que ajuda no enquadramento. O enquadramento será aprofundado em outra aula.
### 4. Estabilidade
- Sem tripé caro: apoiar o celular num pote, numa pilha de livros etc., na altura dos olhos.
- Segurando com a mão, apoiar os cotovelos numa mesa ou superfície firme.
### 5. Som
- Gravar um trecho de teste e ouvir antes de começar.
- Muito barulho de fundo? Ir para um lugar mais silencioso ou aproximar o celular.
- Dica: usar o fone com microfone que vem com o celular.', 'approved', ARRAY['Pocket Studio','Hollywood no seu bolso','estúdio no celular','luz natural','janela','iluminação','limpar a lente','câmera suja','resolução','1080p','Full HD','grade','linhas de grade','regra dos terços','estabilidade','tripé improvisado','altura dos olhos','áudio','som','fone com microfone','barulho de fundo']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M03.A01-03', 'principal', 2, 3, 'V2.M03.A01 — O Estúdio Secreto do Seu Smartphone', 'Exercício prático', 'O Estúdio Secreto do Seu Smartphone', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 03 – Pocket Studio: Hollywood no Seu Bolso › Aula 01 – O Estúdio Secreto do Seu Smartphone › Exercício prático

1. Escolher um lugar com boa luz natural.
2. Limpar a lente e ajustar as configurações.
3. Gravar um vídeo de 30 segundos falando de algo que gosta, ou mostrando um objeto e falando sobre ele (uma receita, uma dica, uma história).
4. Assistir e avaliar luz, enquadramento e áudio. Ajustar e regravar até se sentir confiante.', 'approved', ARRAY['Pocket Studio','Hollywood no seu bolso','estúdio no celular','luz natural','janela','iluminação','limpar a lente','câmera suja','resolução','1080p','Full HD','grade','linhas de grade','regra dos terços','estabilidade','tripé improvisado','altura dos olhos','áudio','som','fone com microfone','barulho de fundo']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M03.A01-04', 'principal', 2, 3, 'V2.M03.A01 — O Estúdio Secreto do Seu Smartphone', 'FAQ', 'O Estúdio Secreto do Seu Smartphone', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 03 – Pocket Studio: Hollywood no Seu Bolso › Aula 01 – O Estúdio Secreto do Seu Smartphone › Pontos para o suporte

- "Meu vídeo fica escuro / feio." Gravar perto de uma janela, com luz natural suave, e limpar a lente.
- "Meu vídeo fica tremido." Apoiar o celular num objeto firme, na altura dos olhos, ou apoiar os cotovelos.
- "O som fica ruim." Testar antes, procurar um lugar silencioso, aproximar o celular ou usar o fone com microfone.
- "Preciso comprar equipamento?" Não, segundo a aula.', 'approved', ARRAY['Pocket Studio','Hollywood no seu bolso','estúdio no celular','luz natural','janela','iluminação','limpar a lente','câmera suja','resolução','1080p','Full HD','grade','linhas de grade','regra dos terços','estabilidade','tripé improvisado','altura dos olhos','áudio','som','fone com microfone','barulho de fundo']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M03.A02-01', 'principal', 2, 3, 'V2.M03.A02 — Dominando a Iluminação Sem Equipamentos Caros', 'Visão geral', 'Dominando a Iluminação Sem Equipamentos Caros', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 03 – Pocket Studio: Hollywood no Seu Bolso › Aula 02 – Dominando a Iluminação Sem Equipamentos Caros › Visão geral da aula

Nome oficial da aula: Dominando a Iluminação Sem Equipamentos Caros
Onde fica: Vitrine 2 (I BÔNUS – Skill''s das Demandas Lucrativas), Módulo 03 – Pocket Studio: Hollywood no Seu Bolso, Aula 02
Duração/formato: 4:29
Link na área de membros (abre a página do Módulo 03, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/2/20

Resumo:
A aula ensina a iluminar vídeos e fotos com o que se tem em casa: aproveitar a luz natural (de preferência na golden hour), montar iluminação artificial caseira (abajur com difusor de papel e um refletor feito com caixa de papelão) e entender a diferença entre luz dura e luz suave. Termina com um exercício de comparação.', 'approved', ARRAY['iluminação','luz','luz natural','luz artificial','golden hour','hora dourada','difusor','papel sulfite','cortina fina','refletor caseiro','caixa de papelão','papel alumínio','pano branco','luz dura','luz suave','sombras']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M03.A02-02', 'principal', 2, 3, 'V2.M03.A02 — Dominando a Iluminação Sem Equipamentos Caros', 'Procedimento', 'Dominando a Iluminação Sem Equipamentos Caros', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 03 – Pocket Studio: Hollywood no Seu Bolso › Aula 02 – Dominando a Iluminação Sem Equipamentos Caros › Procedimento

### 1. Luz natural
- Melhores horários: golden hour (hora dourada), logo depois do nascer do sol e pouco antes do pôr do sol. A luz é suave e quente e não cria sombras duras.
- Em outros horários: gravar perto de uma janela com cortina fina, que difunde a luz.
### 2. Iluminação artificial caseira
a) Abajur com difusor
- Colocar uma folha de papel sulfite na frente da lâmpada. A luz fica mais suave e uniforme.
b) Refletor caseiro
1. Forrar o interior de uma caixa de papelão com papel alumínio, com o lado brilhante para dentro.
2. Colocar uma lâmpada no centro da caixa.
3. Cobrir a abertura com um pano branco, que difunde a luz.
- Bom para iluminar o rosto ou destacar um objeto.
### 3. Luz dura × luz suave
|  | Luz dura | Luz suave |
|---|---|---|
| Origem | Fonte pequena ou concentrada (lâmpada sem difusor, sol do meio-dia) | Fonte grande ou difusa (cortina, refletor caseiro) |
| Efeito | Sombras definidas, contraste forte | Sombras leves, transições suaves |
| Vantagem | Efeito dramático, destaca texturas | Aparência natural e agradável |
| Desvantagem | Acentua imperfeições | Destaca menos os detalhes |
| Quando usar | Destacar um produto, criar mistério | Vídeos de recomendação, receitas, conteúdo acolhedor |', 'approved', ARRAY['iluminação','luz','luz natural','luz artificial','golden hour','hora dourada','difusor','papel sulfite','cortina fina','refletor caseiro','caixa de papelão','papel alumínio','pano branco','luz dura','luz suave','sombras']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M03.A02-03', 'principal', 2, 3, 'V2.M03.A02 — Dominando a Iluminação Sem Equipamentos Caros', 'Exercício prático', 'Dominando a Iluminação Sem Equipamentos Caros', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 03 – Pocket Studio: Hollywood no Seu Bolso › Aula 02 – Dominando a Iluminação Sem Equipamentos Caros › Exercício prático

1. Gravar um vídeo curto ou tirar uma foto com luz natural, de preferência na golden hour.
2. Montar o refletor caseiro e gravar o mesmo cenário com ele.
3. Comparar os dois resultados e ver qual funciona melhor para o objetivo.', 'approved', ARRAY['iluminação','luz','luz natural','luz artificial','golden hour','hora dourada','difusor','papel sulfite','cortina fina','refletor caseiro','caixa de papelão','papel alumínio','pano branco','luz dura','luz suave','sombras']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M03.A02-04', 'principal', 2, 3, 'V2.M03.A02 — Dominando a Iluminação Sem Equipamentos Caros', 'FAQ', 'Dominando a Iluminação Sem Equipamentos Caros', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 03 – Pocket Studio: Hollywood no Seu Bolso › Aula 02 – Dominando a Iluminação Sem Equipamentos Caros › Pontos para o suporte

- "Qual o melhor horário para gravar?" Na golden hour: começo da manhã ou fim da tarde. Fora disso, perto de uma janela com cortina fina.
- "Não tenho luz boa em casa." Usar o abajur com papel sulfite ou montar o refletor caseiro.
- "Qual luz uso para vídeo de recomendação ou receita?" Luz suave.', 'approved', ARRAY['iluminação','luz','luz natural','luz artificial','golden hour','hora dourada','difusor','papel sulfite','cortina fina','refletor caseiro','caixa de papelão','papel alumínio','pano branco','luz dura','luz suave','sombras']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M03.A04-01', 'principal', 2, 3, 'V2.M03.A04 — Apps que Transformam Amadores em Profissionais', 'Visão geral', 'Apps que Transformam Amadores em Profissionais', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 03 – Pocket Studio: Hollywood no Seu Bolso › Aula 04 – Apps que Transformam Amadores em Profissionais › Visão geral da aula

Nome oficial da aula: Apps que Transformam Amadores em Profissionais
Onde fica: Vitrine 2 (I BÔNUS – Skill''s das Demandas Lucrativas), Módulo 03 – Pocket Studio: Hollywood no Seu Bolso, Aula 04
Duração/formato: 6:01
Link na área de membros (abre a página do Módulo 03, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/2/20

Resumo:
A aula apresenta 7 aplicativos de celular para dar acabamento profissional a vídeos, fotos, áudio e artes, a maioria gratuitos ou com versão gratuita. "Os apps são ferramentas: não fazem o trabalho sozinhos, mas elevam o nível." Para cada um, a aula mostra para que serve e como começar. Termina com um exercício de edição.', 'approved', ARRAY['aplicativos de edição','apps de edição','CapCut','Cap Cut','Snapseed','Snap Seed','InShot','In Shot','Audio Lab','Canva','Lightroom','Adobe Lightroom','presets','Photoshop','Photoshop Express','Adobe Photoshop mobile','formato vertical','quadrado','horizontal']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M03.A04-02', 'principal', 2, 3, 'V2.M03.A04 — Apps que Transformam Amadores em Profissionais', 'Os 7 aplicativos', 'Apps que Transformam Amadores em Profissionais', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 03 – Pocket Studio: Hollywood no Seu Bolso › Aula 04 – Apps que Transformam Amadores em Profissionais › Os 7 aplicativos

| App | Para que serve | Recursos destacados | Como começar |
|---|---|---|---|
| CapCut | Editar vídeos | Cortar, música, texto, transições, velocidade (câmera lenta ou acelerada), filtros e cor | Baixar, abrir um vídeo e explorar as ferramentas |
| Snapseed | Editar fotos | Brilho, contraste, saturação, Pincel (ajustar só uma parte, como clarear o rosto), filtros prontos | Abrir uma foto e testar "Ajustar imagem" e "Detalhes" |
| InShot | Vídeos dinâmicos | Textos animados, música, colagens, ajustar o formato para cada rede | Ajustar o formato: Instagram quadrado ou vertical, YouTube horizontal |
| Audio Lab | Melhorar o áudio | Redução de ruído, volume, equalização, efeitos sonoros | Gravar um áudio curto e testar redução de ruído e equalização |
| Canva | Artes com texto e gráficos | Capas de vídeo, posts, apresentações, modelos prontos | Escolher um modelo, editar textos e imagens, salvar no formato necessário |
| Lightroom | Cor e luz das fotos com precisão | Exposição, contraste, saturação, sombras e realces, presets (ajustes prontos para manter um padrão visual) | Abrir uma foto e testar luz e cor |
| Photoshop (mobile) | Edições criativas e correções | Remover objetos indesejados, ajustar proporção, elementos gráficos, tutoriais no app | Testar a ferramenta de correção para apagar pequenos defeitos |', 'approved', ARRAY['aplicativos de edição','apps de edição','CapCut','Cap Cut','Snapseed','Snap Seed','InShot','In Shot','Audio Lab','Canva','Lightroom','Adobe Lightroom','presets','Photoshop','Photoshop Express','Adobe Photoshop mobile','formato vertical','quadrado','horizontal']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M03.A04-03', 'principal', 2, 3, 'V2.M03.A04 — Apps que Transformam Amadores em Profissionais', 'Exercício prático', 'Apps que Transformam Amadores em Profissionais', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 03 – Pocket Studio: Hollywood no Seu Bolso › Aula 04 – Apps que Transformam Amadores em Profissionais › Exercício prático

Escolher um conteúdo já produzido e editar:
- Vídeo: cortar, pôr música e ajustar cores no CapCut ou no InShot.
- Foto: ajustar luz e cor no Lightroom ou no Snapseed.
- Arte do zero (capa, post): usar os modelos do Canva.
Próxima aula: como transformar fotos em conteúdos magnéticos.', 'approved', ARRAY['aplicativos de edição','apps de edição','CapCut','Cap Cut','Snapseed','Snap Seed','InShot','In Shot','Audio Lab','Canva','Lightroom','Adobe Lightroom','presets','Photoshop','Photoshop Express','Adobe Photoshop mobile','formato vertical','quadrado','horizontal']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M03.A04-04', 'principal', 2, 3, 'V2.M03.A04 — Apps que Transformam Amadores em Profissionais', 'FAQ', 'Apps que Transformam Amadores em Profissionais', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 03 – Pocket Studio: Hollywood no Seu Bolso › Aula 04 – Apps que Transformam Amadores em Profissionais › Pontos para o suporte

- "Qual app uso para editar vídeo?" CapCut ou InShot.
- "E para foto?" Snapseed (mais simples) ou Lightroom (mais preciso). Para remover objetos, Photoshop mobile.
- "Como faço capa ou post?" Canva, com modelos prontos.
- "O som do meu vídeo tem chiado." Usar um app de redução de ruído, como o citado Audio Lab.
- "Qual formato uso?" Instagram: vertical (reels e stories) ou quadrado (feed). YouTube: horizontal.
- "Os apps são pagos?" A maioria tem versão gratuita. Alguns recursos são pagos.', 'approved', ARRAY['aplicativos de edição','apps de edição','CapCut','Cap Cut','Snapseed','Snap Seed','InShot','In Shot','Audio Lab','Canva','Lightroom','Adobe Lightroom','presets','Photoshop','Photoshop Express','Adobe Photoshop mobile','formato vertical','quadrado','horizontal']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M03.A05-01', 'principal', 2, 3, 'V2.M03.A05 — Transformando Fotos em Conteúdo Magnético', 'Visão geral', 'Transformando Fotos em Conteúdo Magnético', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 03 – Pocket Studio: Hollywood no Seu Bolso › Aula 05 – Transformando Fotos em Conteúdo Magnético › Visão geral da aula

Nome oficial da aula: Transformando Fotos em Conteúdo Magnético
Onde fica: Vitrine 2 (I BÔNUS – Skill''s das Demandas Lucrativas), Módulo 03 – Pocket Studio: Hollywood no Seu Bolso, Aula 05
Duração/formato: 4:21
Link na área de membros (abre a página do Módulo 03, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/2/20

Resumo:
A aula ensina a criar fotos "magnéticas", que contam uma história, transmitem emoção e prendem o olhar, usando só o celular. Junta o que foi visto nas aulas anteriores do módulo (regra dos terços, fundo, iluminação, ângulo, apps) e acrescenta cores e molduras naturais. Termina com um exercício de fotografar e editar um objeto.
"Uma foto magnética não é só uma foto bonita: ela conta uma história."', 'approved', ARRAY['foto magnética','fotos que chamam atenção','fotografia com celular','elemento principal','foco','regra dos terços','fundo','iluminação','golden hour','ângulo','cores quentes','cores frias','psicologia das cores','moldura natural','enquadramento criativo','retoque','edição','Lightroom','Snapseed','Photoshop']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M03.A05-02', 'principal', 2, 3, 'V2.M03.A05 — Transformando Fotos em Conteúdo Magnético', 'Procedimento: os 7 elementos', 'Transformando Fotos em Conteúdo Magnético', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 03 – Pocket Studio: Hollywood no Seu Bolso › Aula 05 – Transformando Fotos em Conteúdo Magnético › Procedimento: os 7 elementos

| # | Elemento | Como aplicar |
|---|---|---|
| 1 | Elemento principal (foco) | Definir o que é o centro das atenções (rosto, objeto, paisagem) e posicioná-lo pela regra dos terços (Aula 03) |
| 2 | Fundo | Simples e limpo: parede lisa, cortina ou espaço ao ar livre (parque, praia). "O fundo não pode roubar a cena." |
| 3 | Iluminação | Luz natural na golden hour, ou luz artificial (abajur, refletor caseiro da Aula 02) iluminando o foco sem sombras duras |
| 4 | Ângulo | Ligeiramente acima dos olhos: proximidade e leveza. Mais baixo: imponência. Testar. |
| 5 | Cores | Tons que combinem entre si e com a mensagem. Quentes (vermelho, amarelo): energia e entusiasmo. Frias (azul, verde): calma e tranquilidade. Ajustar saturação e contraste no Lightroom ou no Snapseed. |
| 6 | Moldura natural | Usar janela, porta ou galhos como moldura ao redor do foco, direcionando o olhar |
| 7 | Retoque final | No Lightroom ou no Photoshop: corrigir luz e cor, remover pequenas distrações do fundo. Sem exagerar nos filtros: "melhorar, não deixar artificial". |', 'approved', ARRAY['foto magnética','fotos que chamam atenção','fotografia com celular','elemento principal','foco','regra dos terços','fundo','iluminação','golden hour','ângulo','cores quentes','cores frias','psicologia das cores','moldura natural','enquadramento criativo','retoque','edição','Lightroom','Snapseed','Photoshop']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M03.A05-03', 'principal', 2, 3, 'V2.M03.A05 — Transformando Fotos em Conteúdo Magnético', 'Exercício prático', 'Transformando Fotos em Conteúdo Magnético', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 03 – Pocket Studio: Hollywood no Seu Bolso › Aula 05 – Transformando Fotos em Conteúdo Magnético › Exercício prático

1. Escolher um objeto de que goste.
2. Fotografar aplicando os elementos: foco, fundo, iluminação, ângulos diferentes.
3. Editar num dos apps da Aula 04 (Lightroom, Snapseed etc.).
4. Observar o resultado e repetir.
Próxima aula: como usar o CapCut para transformar vídeos simples em conteúdos virais.', 'approved', ARRAY['foto magnética','fotos que chamam atenção','fotografia com celular','elemento principal','foco','regra dos terços','fundo','iluminação','golden hour','ângulo','cores quentes','cores frias','psicologia das cores','moldura natural','enquadramento criativo','retoque','edição','Lightroom','Snapseed','Photoshop']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M03.A05-04', 'principal', 2, 3, 'V2.M03.A05 — Transformando Fotos em Conteúdo Magnético', 'FAQ', 'Transformando Fotos em Conteúdo Magnético', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 03 – Pocket Studio: Hollywood no Seu Bolso › Aula 05 – Transformando Fotos em Conteúdo Magnético › Pontos para o suporte

- "Como tiro fotos melhores dos meus produtos ou serviços?" Indicar esta aula: foco na regra dos terços, fundo limpo, luz suave, testar ângulos, cores coerentes e edição leve.
- "Que cor uso?" Quentes para energia e entusiasmo, frias para calma e confiança, conforme a mensagem.', 'approved', ARRAY['foto magnética','fotos que chamam atenção','fotografia com celular','elemento principal','foco','regra dos terços','fundo','iluminação','golden hour','ângulo','cores quentes','cores frias','psicologia das cores','moldura natural','enquadramento criativo','retoque','edição','Lightroom','Snapseed','Photoshop']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M03.A07-01', 'principal', 2, 3, 'V2.M03.A07 — CapCut do Zero: Dominando os Primeiros Passos', 'Visão geral', 'CapCut do Zero: Dominando os Primeiros Passos', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 03 – Pocket Studio: Hollywood no Seu Bolso › Aula 07 – CapCut do Zero: Dominando os Primeiros Passos › Visão geral da aula

Nome oficial da aula: CapCut do Zero: Dominando os Primeiros Passos
Onde fica: Vitrine 2 (I BÔNUS – Skill''s das Demandas Lucrativas), Módulo 03 – Pocket Studio: Hollywood no Seu Bolso, Aula 07
Duração/formato: 13:45
Link na área de membros (abre a página do Módulo 03, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/2/20

Resumo:
É a primeira aula prática no CapCut, com gravação da tela do celular e conduzida por outro professor, Rafael. Ela ensina a baixar e configurar o app, fazer login, criar e renomear um projeto, entender a timeline e fazer um tour rápido por todas as ferramentas (cortes, efeitos, animações, áudio, texto, legendas, proporção, filtros, stickers e plano de fundo). O próprio professor avisa que o tour é rápido e que cada função será detalhada nas próximas aulas.', 'approved', ARRAY['CapCut','Cap Cut','Rafael','instalar','baixar','Play Store','App Store','login','conta TikTok','Google','e-mail','Facebook','novo projeto','importar vídeo','timeline','linha do tempo','renomear projeto','organização de arquivos','dividir','cortar','efeitos','animações','excluir','desfazer','áudio','sons','músicas','narração','gravar voz','texto','stickers','legendas automáticas','texto por áudio','desenho','proporção','9:16','1:1','16:9','Reels','TikTok','feed','YouTube','filtros','ajustar','correção de cor','predefinição','plano de fundo','chroma key','remover fundo','desfoque']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M03.A07-02', 'principal', 2, 3, 'V2.M03.A07 — CapCut do Zero: Dominando os Primeiros Passos', 'Procedimento: passo a passo', 'CapCut do Zero: Dominando os Primeiros Passos', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 03 – Pocket Studio: Hollywood no Seu Bolso › Aula 07 – CapCut do Zero: Dominando os Primeiros Passos › Procedimento: passo a passo (parte 1 de 2)

### 1. Instalar e configurar
1. Abrir a Play Store (Android) ou a App Store (iPhone), pesquisar "CapCut" e instalar.
2. Abrir e continuar nos termos de serviço.
3. Responder ao questionário inicial (perfil de uso, tipo de vídeo, como conheceu o app) e clicar em Iniciar.
### 2. Fazer login
1. No canto inferior direito, tocar em "Eu" › "Toque para entrar".
2. Entrar com TikTok, Google, e-mail ou Facebook.
### 3. Criar um projeto e importar vídeos
1. Ir em Editar › Novo projeto.
2. Selecionar os vídeos da galeria (tocando nas bolinhas).
3. Escolher a qualidade (HD) e tocar em Adicionar. Se aparecer a opção de importar em 4K, pode cancelar.
4. Os vídeos vão para a timeline, a "mesa de trabalho" na parte de baixo da tela, onde a edição acontece.
### 4. Renomear o projeto (organização)
- Fechar o projeto › três pontinhos › Renomear › dar um nome claro. Exemplo: "Aula 01 – Princípios básicos do CapCut".
- Por quê: quem trabalha com vários clientes e entregáveis (nichos de beleza, saúde, nutrição) precisa achar cada projeto rapidamente e poder exportar ou compartilhar sem confusão.
### 5. Tour pelas ferramentas
| Ferramenta | Para que serve |
|---|---|
| Editar › Dividir | Cortar o vídeo e selecionar os melhores momentos |
| Efeitos | Efeitos de vídeo (transição, abertura, fechamento, velocidade, retrô…), com intensidade ajustável e opção de redefinir |
| Animações | Entrada, saída e combinação: fade in, zoom in e out, loops |
| Excluir / Desfazer | Apagar um trecho. A seta desfaz uma ação feita sem querer. |
| Áudio | Sons, músicas (do celular, do TikTok, salvas) e gravar narração |
| Texto | Textos, stickers, legendas automáticas, texto a partir de áudio, desenho |
| Legendas | Vários modelos com efeitos e cores. Geração a partir do vídeo ou da locução. |
| Proporção | 9:16 (Reels e TikTok), 1:1 (feed), 16:9 (YouTube) |
| Filtros / Ajustar | Filtros prontos e ajuste manual de cor, saturação e iluminação. Permite criar predefinições. |
| Stickers | Ícones e assets (setas, "inscreva-se", ícones de redes) |', 'approved', ARRAY['CapCut','Cap Cut','Rafael','instalar','baixar','Play Store','App Store','login','conta TikTok','Google','e-mail','Facebook','novo projeto','importar vídeo','timeline','linha do tempo','renomear projeto','organização de arquivos','dividir','cortar','efeitos','animações','excluir','desfazer','áudio','sons','músicas','narração','gravar voz','texto','stickers','legendas automáticas','texto por áudio','desenho','proporção','9:16','1:1','16:9','Reels','TikTok','feed','YouTube','filtros','ajustar','correção de cor','predefinição','plano de fundo','chroma key','remover fundo','desfoque']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M03.A07-03', 'principal', 2, 3, 'V2.M03.A07 — CapCut do Zero: Dominando os Primeiros Passos', 'Procedimento: passo a passo', 'CapCut do Zero: Dominando os Primeiros Passos', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 03 – Pocket Studio: Hollywood no Seu Bolso › Aula 07 – CapCut do Zero: Dominando os Primeiros Passos › Procedimento: passo a passo (parte 2 de 2)

### 5. Tour pelas ferramentas (continuação)
| Ferramenta | Para que serve |
|---|---|
| Plano de fundo | Chroma key (remover ou trocar fundo), colocar imagem, desfocar o fundo |
### 6. Praticar
- Criar um projeto de teste (de preferência não um projeto de cliente) e mexer em todas as funções para aprender.', 'approved', ARRAY['CapCut','Cap Cut','Rafael','instalar','baixar','Play Store','App Store','login','conta TikTok','Google','e-mail','Facebook','novo projeto','importar vídeo','timeline','linha do tempo','renomear projeto','organização de arquivos','dividir','cortar','efeitos','animações','excluir','desfazer','áudio','sons','músicas','narração','gravar voz','texto','stickers','legendas automáticas','texto por áudio','desenho','proporção','9:16','1:1','16:9','Reels','TikTok','feed','YouTube','filtros','ajustar','correção de cor','predefinição','plano de fundo','chroma key','remover fundo','desfoque']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M03.A07-04', 'principal', 2, 3, 'V2.M03.A07 — CapCut do Zero: Dominando os Primeiros Passos', 'FAQ', 'CapCut do Zero: Dominando os Primeiros Passos', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 03 – Pocket Studio: Hollywood no Seu Bolso › Aula 07 – CapCut do Zero: Dominando os Primeiros Passos › Pontos para o suporte

- "Como baixo e começo no CapCut?" Play Store ou App Store › CapCut › login (Google, e-mail, TikTok ou Facebook) › Editar › Novo projeto › selecionar vídeos › Adicionar.
- "Qual proporção uso?" 9:16 para Reels e TikTok, 1:1 para feed quadrado, 16:9 para YouTube.
- "Apaguei um trecho sem querer." Usar a seta de desfazer.
- "Como coloco legenda automática?" Em Texto › Legendas automáticas. O vídeo precisa ter fala para ser reconhecido.
- "Ficou muito rápido / me perdi." O próprio professor avisa que esta aula é um panorama. As próximas detalham cada função.', 'approved', ARRAY['CapCut','Cap Cut','Rafael','instalar','baixar','Play Store','App Store','login','conta TikTok','Google','e-mail','Facebook','novo projeto','importar vídeo','timeline','linha do tempo','renomear projeto','organização de arquivos','dividir','cortar','efeitos','animações','excluir','desfazer','áudio','sons','músicas','narração','gravar voz','texto','stickers','legendas automáticas','texto por áudio','desenho','proporção','9:16','1:1','16:9','Reels','TikTok','feed','YouTube','filtros','ajustar','correção de cor','predefinição','plano de fundo','chroma key','remover fundo','desfoque']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M03.A08-01', 'principal', 2, 3, 'V2.M03.A08 — Cortes Perfeitos: Ritmo e Fluxo de Edição no CapCut', 'Visão geral', 'Cortes Perfeitos: Ritmo e Fluxo de Edição no CapCut', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 03 – Pocket Studio: Hollywood no Seu Bolso › Aula 08 – Cortes Perfeitos: Ritmo e Fluxo de Edição no CapCut › Visão geral da aula

Nome oficial da aula: Cortes Perfeitos: Ritmo e Fluxo de Edição no CapCut
Onde fica: Vitrine 2 (I BÔNUS – Skill''s das Demandas Lucrativas), Módulo 03 – Pocket Studio: Hollywood no Seu Bolso, Aula 08
Duração/formato: 12:34
Link na área de membros (abre a página do Módulo 03, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/2/20

Resumo:
É a segunda aula prática de CapCut, com o professor Rafael, que continua o projeto da Aula 07. Ela ensina o fluxo de edição: ordenar os takes, decupar (cortar as partes inúteis), corrigir a resolução (tirar bordas pretas com zoom), adicionar novos vídeos, ajustar a velocidade e inserir a música. O professor recomenda sempre seguir a mesma ordem de trabalho, para que o processo fique automático e mais rápido.', 'approved', ARRAY['CapCut','Rafael','fluxo de edição','fluxo de trabalho','organização da timeline','takes','ordenar takes','arrastar take','decupagem','decupar','cortar partes inúteis','dividir','excluir','agulha','cursor da timeline','resolução','1080p','720p','taxa de quadros','30 fps','bordas pretas','zoom','adicionar mais vídeos','botão +','take horizontal em vídeo vertical','velocidade','acelerar','câmera lenta','camada de áudio','música','sons']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M03.A08-02', 'principal', 2, 3, 'V2.M03.A08 — Cortes Perfeitos: Ritmo e Fluxo de Edição no CapCut', 'Fluxo de trabalho recomendado', 'Cortes Perfeitos: Ritmo e Fluxo de Edição no CapCut', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 03 – Pocket Studio: Hollywood no Seu Bolso › Aula 08 – Cortes Perfeitos: Ritmo e Fluxo de Edição no CapCut › Fluxo de trabalho recomendado

1. Criar o projeto › 2. Renomear (Aula 07) › 3. Ordenar os takes › 4. Decupar › 5. Efeitos (próxima aula) › 6. Música.', 'approved', ARRAY['CapCut','Rafael','fluxo de edição','fluxo de trabalho','organização da timeline','takes','ordenar takes','arrastar take','decupagem','decupar','cortar partes inúteis','dividir','excluir','agulha','cursor da timeline','resolução','1080p','720p','taxa de quadros','30 fps','bordas pretas','zoom','adicionar mais vídeos','botão +','take horizontal em vídeo vertical','velocidade','acelerar','câmera lenta','camada de áudio','música','sons']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M03.A08-03', 'principal', 2, 3, 'V2.M03.A08 — Cortes Perfeitos: Ritmo e Fluxo de Edição no CapCut', 'Procedimento: passo a passo', 'Cortes Perfeitos: Ritmo e Fluxo de Edição no CapCut', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 03 – Pocket Studio: Hollywood no Seu Bolso › Aula 08 – Cortes Perfeitos: Ritmo e Fluxo de Edição no CapCut › Procedimento: passo a passo (parte 1 de 2)

### 1. Ordenar os takes
- Tirar o zoom da timeline (pinça com dois dedos) para ver todos os trechos.
- Tocar e segurar um take e arrastá-lo para a posição desejada (o que vem primeiro, o que vem depois).
### 2. Decupar (cortar o que não serve)
Decupar = cortar as partes inúteis e manter só as úteis.
1. Posicionar a agulha (a linha branca da timeline) no ponto do corte.
2. Selecionar o take › Editar › Dividir.
3. Selecionar a parte indesejada › Excluir.
4. Para tirar um trecho do meio: dividir no início e no fim do trecho e excluir a parte do meio.
5. Para encurtar o fim de um take: selecionar e arrastar a borda para o lado.
### 3. Conferir e corrigir a resolução
- Tocar em resolução no topo (por exemplo, "Ultra HD com IA") para ver as configurações da timeline: exemplo 1080p, 30 fps.
- Take com bordas pretas (não está em 1080 ou foi gravado em outro formato): selecionar e dar zoom com dois dedos até preencher a tela.
- ⚠️ Cuidado com a qualidade:
  - take 1080p, 2K ou 4K numa timeline 1080 → pode dar zoom sem problema;
  - take 720p ampliado para 1080 → fica com qualidade ruim. Evitar.
  - Dica: se o vídeo preenche a tela sozinho ao importar, ele está em 1080p ou mais.
### 4. Adicionar mais vídeos depois
- Tocar no "+" ao lado da timeline › selecionar o vídeo (os já usados aparecem como "importado") › HD › Adicionar.
- Take horizontal num vídeo vertical: dar zoom e centralizar. Funciona se a qualidade for boa.
### 5. Velocidade
- Selecionar o take › Velocidade › Normal › deixar mais rápido ou mais lento.
- O professor prefere usar com moderação, por exemplo em takes rápidos de ambientes (restaurante, loja) com narração ao fundo.
### 6. Música
- Áudio › Sons › escolher uma música e adicionar. Ela vira uma camada de áudio na timeline.', 'approved', ARRAY['CapCut','Rafael','fluxo de edição','fluxo de trabalho','organização da timeline','takes','ordenar takes','arrastar take','decupagem','decupar','cortar partes inúteis','dividir','excluir','agulha','cursor da timeline','resolução','1080p','720p','taxa de quadros','30 fps','bordas pretas','zoom','adicionar mais vídeos','botão +','take horizontal em vídeo vertical','velocidade','acelerar','câmera lenta','camada de áudio','música','sons']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M03.A08-04', 'principal', 2, 3, 'V2.M03.A08 — Cortes Perfeitos: Ritmo e Fluxo de Edição no CapCut', 'Procedimento: passo a passo', 'Cortes Perfeitos: Ritmo e Fluxo de Edição no CapCut', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 03 – Pocket Studio: Hollywood no Seu Bolso › Aula 08 – Cortes Perfeitos: Ritmo e Fluxo de Edição no CapCut › Procedimento: passo a passo (parte 2 de 2)

### 6. Música (continuação)
- Projetos com narração ou institucionais: montar os vídeos com base no áudio, ou seja, ter takes suficientes para cobrir toda a duração da música ou da narração. Por isso é bom reservar takes mais longos.
Próxima aula: efeitos de áudio (fade), transições (in e out), tratamento de cor e de áudio, para deixar os cortes menos bruscos.', 'approved', ARRAY['CapCut','Rafael','fluxo de edição','fluxo de trabalho','organização da timeline','takes','ordenar takes','arrastar take','decupagem','decupar','cortar partes inúteis','dividir','excluir','agulha','cursor da timeline','resolução','1080p','720p','taxa de quadros','30 fps','bordas pretas','zoom','adicionar mais vídeos','botão +','take horizontal em vídeo vertical','velocidade','acelerar','câmera lenta','camada de áudio','música','sons']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M03.A08-05', 'principal', 2, 3, 'V2.M03.A08 — Cortes Perfeitos: Ritmo e Fluxo de Edição no CapCut', 'FAQ', 'Cortes Perfeitos: Ritmo e Fluxo de Edição no CapCut', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 03 – Pocket Studio: Hollywood no Seu Bolso › Aula 08 – Cortes Perfeitos: Ritmo e Fluxo de Edição no CapCut › Pontos para o suporte

- "O que é decupar?" Cortar as partes que não servem e deixar só os trechos úteis.
- "Como corto um pedaço do vídeo?" Posicionar a agulha › selecionar o take › Dividir › selecionar a parte indesejada › Excluir.
- "Meu vídeo ficou com bordas pretas." Selecionar o take e dar zoom com dois dedos até preencher. Se o vídeo for de baixa resolução (720p), ele pode ficar pixelado.
- "Como coloco mais vídeos no projeto?" No "+" ao lado da timeline.
- "Como acelero ou deixo lento?" Selecionar o take › Velocidade.', 'approved', ARRAY['CapCut','Rafael','fluxo de edição','fluxo de trabalho','organização da timeline','takes','ordenar takes','arrastar take','decupagem','decupar','cortar partes inúteis','dividir','excluir','agulha','cursor da timeline','resolução','1080p','720p','taxa de quadros','30 fps','bordas pretas','zoom','adicionar mais vídeos','botão +','take horizontal em vídeo vertical','velocidade','acelerar','câmera lenta','camada de áudio','música','sons']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M03.A09-01', 'principal', 2, 3, 'V2.M03.A09 — Impacto Visual: Texto, Legendas e Efeitos que Engajam', 'Visão geral', 'Impacto Visual: Texto, Legendas e Efeitos que Engajam', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 03 – Pocket Studio: Hollywood no Seu Bolso › Aula 09 – Impacto Visual: Texto, Legendas e Efeitos que Engajam › Visão geral da aula

Nome oficial da aula: Impacto Visual: Texto, Legendas e Efeitos que Engajam
Onde fica: Vitrine 2 (I BÔNUS – Skill''s das Demandas Lucrativas), Módulo 03 – Pocket Studio: Hollywood no Seu Bolso, Aula 09
Duração/formato: 28:00
Link na área de membros (abre a página do Módulo 03, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/2/20

Resumo:
É a terceira aula prática de CapCut, com o professor Rafael e o mesmo projeto das Aulas 07 e 08. É uma aula longa (28 min) e mostra na prática como:
- sincronizar os cortes com a música;
- escolher e aplicar transições;
- fazer o fade da música;
- inserir e animar textos, salvando predefinições;
- usar efeitos de tela;
- fazer correção de cor manual.
A exportação e a finalização ficam para a próxima aula.', 'approved', ARRAY['CapCut','Rafael','sincronizar com a música','batida','forma de onda','transição','quadradinho branco','flash','desfoque','blur','sobrepor','efeitos leves','fade in','fade out','volume','duplicar música','texto','fontes','estilos','animação de texto','predefinição','salvar como predefinição','efeitos de tela','grão','ruído','efeito de filmadora','filtros','ajustar','brilho','contraste','saturação','HSL','roda de cores','destaques','sombras','temperatura','vinheta']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M03.A09-02', 'principal', 2, 3, 'V2.M03.A09 — Impacto Visual: Texto, Legendas e Efeitos que Engajam', 'Procedimento: passo a passo', 'Impacto Visual: Texto, Legendas e Efeitos que Engajam', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 03 – Pocket Studio: Hollywood no Seu Bolso › Aula 09 – Impacto Visual: Texto, Legendas e Efeitos que Engajam › Procedimento: passo a passo (parte 1 de 2)

### 1. Sincronizar os cortes com a música
- Tocar o vídeo e observar a forma de onda do áudio na timeline para achar a batida ou o efeito sonoro.
- Arrastar o início do próximo take até esse ponto e ajustar até ficar no tempo certo.
- Dica: não sincronizar todos os cortes. A repetição cansa. Sincronizar alguns (por exemplo, o início) e deixar outros livres.
### 2. Transições
- Tocar no quadradinho branco entre dois takes para abrir as transições ("Populares", "Efeitos leves" etc.).
- Combinar a transição com o clima do vídeo: para vídeos calmos (paisagem, natureza, beleza, institucional), usar transições leves, como desfoque, blur, flash suave.
- Evitar transições pesadas ou com balanço de câmera nesse tipo de vídeo.
- Testar, ver o resultado e trocar se não combinar.
### 3. Fade na música
- Selecionar a camada de áudio › Fade in / Fade out.
- "Sempre termine de forma suave": usar fade out no fim da música.
- Outras funções de áudio citadas: ritmo automático (casar os takes), redução de ruído e duplicar a música.
### 4. Texto
1. Texto › Adicionar texto e digitar. Exemplo da aula: "Viva com intensidade".
2. Escolher a fonte, o estilo (cores), os efeitos e as animações (entrada, saída, loop).
3. Redimensionar e posicionar com os dedos.
4. Salvar como predefinição para reutilizar o mesmo estilo em outros projetos, o que ajuda a manter um padrão visual com cada cliente.
### 5. Efeitos de tela
- Efeitos › efeitos de tela: grão, ruído, efeito de "filmadora" ou drone etc. "Acrescentam muito" se usados de vez em quando.
- Ajustar a duração do efeito na timeline, arrastando as bordas.
### 6. Correção de cor
- Filtros: testar os prontos (paisagem, vívido, filme…). "Nunca alterem tanto as cores": ser conservadora.
- Ajustar (manual), valores que o professor usa como referência:
| Ajuste | Orientação do professor |
|---|---|
| Brilho | Aumentar um pouco |
| Contraste | Compensar, porque ao subir o brilho o contraste cai |
| Saturação / HSL | Ajustar cores específicas (exemplo: verde e amarelo) |
| Destaques (realces) | Cerca de −8 |', 'approved', ARRAY['CapCut','Rafael','sincronizar com a música','batida','forma de onda','transição','quadradinho branco','flash','desfoque','blur','sobrepor','efeitos leves','fade in','fade out','volume','duplicar música','texto','fontes','estilos','animação de texto','predefinição','salvar como predefinição','efeitos de tela','grão','ruído','efeito de filmadora','filtros','ajustar','brilho','contraste','saturação','HSL','roda de cores','destaques','sombras','temperatura','vinheta']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M03.A09-03', 'principal', 2, 3, 'V2.M03.A09 — Impacto Visual: Texto, Legendas e Efeitos que Engajam', 'Procedimento: passo a passo', 'Impacto Visual: Texto, Legendas e Efeitos que Engajam', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 03 – Pocket Studio: Hollywood no Seu Bolso › Aula 09 – Impacto Visual: Texto, Legendas e Efeitos que Engajam › Procedimento: passo a passo (parte 2 de 2)

### 6. Correção de cor (continuação)
| Ajuste | Orientação do professor |
|---|---|
| Sombras | Cerca de −7 |
| Brancos | Mexer pouco |
| Temperatura | Um pouco mais quente ("mais aconchegante") |
| Matiz / vinheta | Mexer pouco |
| Granulação | Um pouco (5 a 12) |
- A correção cria camadas de ajuste na timeline. Arrastar a camada para cobrir o trecho que deve ser alterado.', 'approved', ARRAY['CapCut','Rafael','sincronizar com a música','batida','forma de onda','transição','quadradinho branco','flash','desfoque','blur','sobrepor','efeitos leves','fade in','fade out','volume','duplicar música','texto','fontes','estilos','animação de texto','predefinição','salvar como predefinição','efeitos de tela','grão','ruído','efeito de filmadora','filtros','ajustar','brilho','contraste','saturação','HSL','roda de cores','destaques','sombras','temperatura','vinheta']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M03.A09-04', 'principal', 2, 3, 'V2.M03.A09 — Impacto Visual: Texto, Legendas e Efeitos que Engajam', 'FAQ', 'Impacto Visual: Texto, Legendas e Efeitos que Engajam', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 03 – Pocket Studio: Hollywood no Seu Bolso › Aula 09 – Impacto Visual: Texto, Legendas e Efeitos que Engajam › Pontos para o suporte

- "Como sincronizo os cortes com a música?" Olhar a forma de onda do áudio e arrastar o início do take até a batida.
- "Qual transição usar?" Em vídeos calmos, transições leves (desfoque, blur). Evitar as pesadas e as de balanço de câmera.
- "A música acaba de repente." Aplicar fade out.
- "Como salvo um estilo de texto para usar de novo?" Configurar o texto › Salvar como predefinição.
- "Como deixo as cores mais bonitas?" Testar os filtros ou ajustar à mão: brilho, contraste, temperatura um pouco mais quente. Sem exagero.', 'approved', ARRAY['CapCut','Rafael','sincronizar com a música','batida','forma de onda','transição','quadradinho branco','flash','desfoque','blur','sobrepor','efeitos leves','fade in','fade out','volume','duplicar música','texto','fontes','estilos','animação de texto','predefinição','salvar como predefinição','efeitos de tela','grão','ruído','efeito de filmadora','filtros','ajustar','brilho','contraste','saturação','HSL','roda de cores','destaques','sombras','temperatura','vinheta']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M03.A10-01', 'principal', 2, 3, 'V2.M03.A10 — Toque Final: Finalização, Exportação e Recapitulando Tudo', 'Visão geral', 'Toque Final: Finalização, Exportação e Recapitulando Tudo', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 03 – Pocket Studio: Hollywood no Seu Bolso › Aula 10 – Toque Final: Finalização, Exportação e Recapitulando Tudo › Visão geral da aula

Nome oficial da aula: Toque Final: Finalização, Exportação e Recapitulando Tudo
Onde fica: Vitrine 2 (I BÔNUS – Skill''s das Demandas Lucrativas), Módulo 03 – Pocket Studio: Hollywood no Seu Bolso, Aula 10
Duração/formato: 21:09
Link na área de membros (abre a página do Módulo 03, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/2/20

Resumo:
É a última aula prática de CapCut, com o professor Rafael, que finaliza o projeto das Aulas 07 a 09. Ela ensina:
- keyframes (animação de zoom suave);
- ajustes finais de texto (fonte, animação de entrada e saída);
- efeitos de vídeo e efeitos sonoros nas transições;
- outras ferramentas (transformar, opacidade, estabilização, redução de ruído);
- exportação, com as configurações recomendadas.
Fecha com uma recapitulação e um tour por recursos extras do app (modelos, remoção de fundo, voz, editor de fotos).', 'approved', ARRAY['CapCut','Rafael','keyframes','quadros-chave','chave de frames','animação de zoom','fonte Montserrat','animação de entrada e saída de texto','efeitos sonoros','film burn','camera shutter','glitch','transformar','espelhar','girar','recortar','opacidade','estabilização','reduzir ruído','exportar','exportação','1080p','30 fps','60 fps','taxa de bits','Mbps','modelos','templates','versão paga','CapCut Pro','remover plano de fundo','voz personalizada','editor de fotos','retoque']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M03.A10-02', 'principal', 2, 3, 'V2.M03.A10 — Toque Final: Finalização, Exportação e Recapitulando Tudo', 'Procedimento: passo a passo', 'Toque Final: Finalização, Exportação e Recapitulando Tudo', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 03 – Pocket Studio: Hollywood no Seu Bolso › Aula 10 – Toque Final: Finalização, Exportação e Recapitulando Tudo › Procedimento: passo a passo (parte 1 de 2)

### 1. Keyframes (animação de zoom)
1. Posicionar a agulha no início do trecho e adicionar um keyframe (ícone de losango).
2. Ir até o fim do trecho, dar um zoom sutil no vídeo: o app cria outro keyframe e anima entre os dois.
3. Ajustar a curva (gráfico) para deixar o movimento mais suave.
- É a "famosa animação de zoom in", o objeto se aproximando aos poucos.
### 2. Texto: acabamento
- Adicionar o texto (exemplo: "Desfrute de cada momento").
- Usar uma fonte mais profissional. O professor recomenda a Montserrat.
- Aplicar animação de entrada e de saída e ajustar a duração para não ficar rápido demais.
### 3. Efeitos de vídeo e filtros
- Efeitos de vídeo (retrô, distorção, tela…) e filtros, ajustando intensidade e brilho do filtro.
### 4. Efeitos sonoros nas transições
- Áudio › Efeitos sonoros: pesquisar e inserir sons que combinem com a transição (exemplo: "filme", "film burn", "camera shutter", "glitch").
- Posicionar o som exatamente no ponto da transição.
### 5. Outras ferramentas úteis
- Transformar: espelhar, girar, recortar ou redimensionar.
- Opacidade, estabilização, efeitos de áudio, redução de ruído.
- Final do vídeo: pode incluir um texto como "Obrigado por assistir" e remover o trecho final do CapCut.
### 6. Exportar
| Destino | Resolução | Taxa de quadros | Observação |
|---|---|---|---|
| Redes sociais (Instagram, TikTok, Facebook, WhatsApp) | 1080p | 30 fps (pessoa falando) ou testar 60 fps (movimento rápido) | As redes recebem em 1080p |
| Curso, documentário, institucional | 2K ou 4K | 30 ou 60 fps | Mais qualidade, arquivo mais pesado |
| Taxa de bits (Mbps) | — | — | Deixar na melhor qualidade possível |
Como exportar:
1. Conferir se tudo está pronto: cortes, cor, transições, sons, texto e legendas.
2. Tocar em Exportar (canto superior) com as configurações acima.
3. Aguardar. O vídeo fica salvo na galeria do celular.
### 7. Recursos extras do CapCut (tour final)
- Modelos e templates: muitos são da versão paga. A recomendação é usá-los como inspiração, sem pagar.
- Remover plano de fundo, voz personalizada, editor e retoque de fotos, gravação de voz.', 'approved', ARRAY['CapCut','Rafael','keyframes','quadros-chave','chave de frames','animação de zoom','fonte Montserrat','animação de entrada e saída de texto','efeitos sonoros','film burn','camera shutter','glitch','transformar','espelhar','girar','recortar','opacidade','estabilização','reduzir ruído','exportar','exportação','1080p','30 fps','60 fps','taxa de bits','Mbps','modelos','templates','versão paga','CapCut Pro','remover plano de fundo','voz personalizada','editor de fotos','retoque']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M03.A10-03', 'principal', 2, 3, 'V2.M03.A10 — Toque Final: Finalização, Exportação e Recapitulando Tudo', 'Procedimento: passo a passo', 'Toque Final: Finalização, Exportação e Recapitulando Tudo', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 03 – Pocket Studio: Hollywood no Seu Bolso › Aula 10 – Toque Final: Finalização, Exportação e Recapitulando Tudo › Procedimento: passo a passo (parte 2 de 2)

### Recapitulação do módulo (Aulas 07 a 10)
Criar e renomear o projeto › ordenar os takes › decupar › sincronizar com a música › transições › texto › efeitos › cor › keyframes › exportar. "Não esqueçam da ordem de edição e organização."', 'approved', ARRAY['CapCut','Rafael','keyframes','quadros-chave','chave de frames','animação de zoom','fonte Montserrat','animação de entrada e saída de texto','efeitos sonoros','film burn','camera shutter','glitch','transformar','espelhar','girar','recortar','opacidade','estabilização','reduzir ruído','exportar','exportação','1080p','30 fps','60 fps','taxa de bits','Mbps','modelos','templates','versão paga','CapCut Pro','remover plano de fundo','voz personalizada','editor de fotos','retoque']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M03.A10-04', 'principal', 2, 3, 'V2.M03.A10 — Toque Final: Finalização, Exportação e Recapitulando Tudo', 'FAQ', 'Toque Final: Finalização, Exportação e Recapitulando Tudo', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 03 – Pocket Studio: Hollywood no Seu Bolso › Aula 10 – Toque Final: Finalização, Exportação e Recapitulando Tudo › Pontos para o suporte

- "Em que resolução exporto?" 1080p para redes sociais (30 fps para pessoa falando, 60 fps para movimento). 2K ou 4K para conteúdos que precisam de mais qualidade.
- "Onde fica o vídeo depois de exportar?" Na galeria do celular.
- "Como faço aquele zoom suave?" Com keyframes: um no início, outro no fim com zoom, e ajustar a curva.
- "O modelo que eu quero é pago." Usar como inspiração e recriar à mão. Não é obrigatório pagar.
- "Como coloco legenda automática?" Não foi detalhado nas aulas.', 'approved', ARRAY['CapCut','Rafael','keyframes','quadros-chave','chave de frames','animação de zoom','fonte Montserrat','animação de entrada e saída de texto','efeitos sonoros','film burn','camera shutter','glitch','transformar','espelhar','girar','recortar','opacidade','estabilização','reduzir ruído','exportar','exportação','1080p','30 fps','60 fps','taxa de bits','Mbps','modelos','templates','versão paga','CapCut Pro','remover plano de fundo','voz personalizada','editor de fotos','retoque']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M03.A11-01', 'principal', 2, 3, 'V2.M03.A11 — Automatização Inteligente: Legendas Automáticas e Biblioteca do CapCut', 'Visão geral', 'Automatização Inteligente: Legendas Automáticas e Biblioteca do CapCut', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 03 – Pocket Studio: Hollywood no Seu Bolso › Aula 11 – Automatização Inteligente: Legendas Automáticas e Biblioteca do CapCut › Visão geral da aula

Nome oficial da aula: Automatização Inteligente: Legendas Automáticas e Biblioteca do CapCut
Onde fica: Vitrine 2 (I BÔNUS – Skill''s das Demandas Lucrativas), Módulo 03 – Pocket Studio: Hollywood no Seu Bolso, Aula 11
Duração/formato: 4:25
Link na área de membros (abre a página do Módulo 03, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/2/20

Resumo:
É uma aula curta e prática, com o professor Rafael, que preenche a lacuna das legendas deixada nas Aulas 09 e 10. Ela ensina a gerar legendas automáticas no CapCut, corrigir o que a IA errou, posicionar a legenda para o Instagram e trocar a fonte e o estilo. Na segunda metade, mostra a biblioteca de modelos (templates), que monta um vídeo automaticamente a partir dos takes escolhidos.', 'approved', ARRAY['CapCut','Rafael','legendas automáticas','gerar legendas','legenda por IA','transcrição automática','modelo de legenda','estilo da legenda','fontes','Montserrat','Gotham','trend','modelos','templates','biblioteca do CapCut','usar modelo','modelos pagos e gratuitos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M03.A11-02', 'principal', 2, 3, 'V2.M03.A11 — Automatização Inteligente: Legendas Automáticas e Biblioteca do CapCut', 'Procedimento: passo a passo', 'Automatização Inteligente: Legendas Automáticas e Biblioteca do CapCut', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 03 – Pocket Studio: Hollywood no Seu Bolso › Aula 11 – Automatização Inteligente: Legendas Automáticas e Biblioteca do CapCut › Procedimento: passo a passo

### 1. Gerar legendas automáticas
1. Criar um novo projeto e importar o vídeo (ver Aula 07).
  - ⚠️ O vídeo precisa ter fala/áudio. Sem fala, não há o que legendar.
2. Ir em Legendas e escolher o modelo de legenda. O professor costuma usar a terceira opção, mas todas funcionam da mesma forma.
3. Tocar em Gerar legendas. O CapCut transcreve o áudio automaticamente.
### 2. Revisar e corrigir
1. Selecionar a legenda gerada na timeline.
2. Tocar em Editar para corrigir palavras que a IA não reconheceu bem, ou incluir e tirar falas.
3. Assistir até o fim conferindo o texto. Na aula, ele revisa uma lista de ingredientes: "lâminas de coco, semente de girassol, semente de abóbora…".
### 3. Posicionar (Instagram)
- Subir a legenda um pouco acima do rodapé, para não ficar atrás da interface do Instagram (nome, descrição, botões).
- Para centralizar, arrastar até aparecer a guia azul de alinhamento.
- Regra geral: respeitar a área segura da plataforma onde o vídeo será publicado.
### 4. Trocar fonte e estilo
- Tocar na legenda › Estilo: mudar a fonte mesmo depois de gerada.
- Fontes sugeridas: Montserrat, Gotham e uma fonte de "trend".
- Escolher conforme o tom: vídeo mais profissional ou mais descontraído.
### 5. Modelos (templates) do CapCut
1. Abrir a aba Modelos. Há modelos gratuitos e pagos.
2. Escolher um modelo › Usar modelo.
3. Selecionar os takes que vão entrar no vídeo › Avançar.
4. O CapCut monta o vídeo automaticamente, respeitando o tempo e as trocas de cena do modelo.
- Modelos pagos: sem o plano pago, servem só como inspiração.', 'approved', ARRAY['CapCut','Rafael','legendas automáticas','gerar legendas','legenda por IA','transcrição automática','modelo de legenda','estilo da legenda','fontes','Montserrat','Gotham','trend','modelos','templates','biblioteca do CapCut','usar modelo','modelos pagos e gratuitos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M03.A11-03', 'principal', 2, 3, 'V2.M03.A11 — Automatização Inteligente: Legendas Automáticas e Biblioteca do CapCut', 'FAQ', 'Automatização Inteligente: Legendas Automáticas e Biblioteca do CapCut', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 03 – Pocket Studio: Hollywood no Seu Bolso › Aula 11 – Automatização Inteligente: Legendas Automáticas e Biblioteca do CapCut › Pontos para o suporte

- "Como coloco legenda automática?" Legendas › escolher o modelo › Gerar legendas › revisar em Editar. O vídeo precisa ter fala.
- "A legenda saiu com palavra errada." Selecionar a legenda › Editar e corrigir à mão. Sempre revisar antes de exportar.
- "A legenda fica atrás dos botões do Instagram." Subir a legenda um pouco e centralizar pela guia azul.
- "Dá para mudar a fonte depois?" Sim, em Estilo.
- "Como faço um vídeo rápido sem editar tudo?" Usar um modelo gratuito: Modelos › Usar modelo › escolher takes › Avançar.', 'approved', ARRAY['CapCut','Rafael','legendas automáticas','gerar legendas','legenda por IA','transcrição automática','modelo de legenda','estilo da legenda','fontes','Montserrat','Gotham','trend','modelos','templates','biblioteca do CapCut','usar modelo','modelos pagos e gratuitos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M03.A12-01', 'principal', 2, 3, 'V2.M03.A12 — Certificação', 'Visão geral', 'Certificação', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 03 – Pocket Studio: Hollywood no Seu Bolso › Aula 12 – Certificação › Visão geral da aula

Nome oficial da aula: Certificação
Onde fica: Vitrine 2 (I BÔNUS – Skill''s das Demandas Lucrativas), Módulo 03 – Pocket Studio: Hollywood no Seu Bolso, Aula 12
Duração/formato: 3:28
Link na área de membros (abre a página do Módulo 03, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/2/20

Resumo:
É a aula de encerramento do Módulo 03 (Pocket Studio). É uma mensagem motivacional de parabéns pela conclusão e pela certificação, que a aula apresenta como "reconhecimento de tudo que você aprendeu" e como ponto de partida, não ponto final. Recapitula os temas do módulo (celular como ferramenta, iluminação, enquadramento, edição, aplicativos, conteúdo magnético), reforça que o aprendizado real vem da prática ("testa, erra, ajusta e tenta de novo") e propõe uma reflexão sobre o que mudou. No fim, informa que há um PDF com todas as aulas resumidas na descrição da aula.
A estrutura e a mensagem são praticamente as mesmas da Aula 07 do Módulo 02 (Certificação).', 'approved', ARRAY['certificado','certificação','diploma','emitir certificado','PDF','resumo das aulas','material de apoio','e-book','descrição da aula']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M03.A12-02', 'principal', 2, 3, 'V2.M03.A12 — Certificação', 'Procedimento: o que a aluna deve fazer', 'Certificação', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 03 – Pocket Studio: Hollywood no Seu Bolso › Aula 12 – Certificação › Procedimento: o que a aluna deve fazer

1. Concluir as aulas do módulo e colocar em prática o que foi ensinado (fotos, iluminação, edição no CapCut).
2. Obter o certificado do módulo. ⚠️ A aula não explica como.
3. Baixar o PDF-resumo na descrição desta aula.', 'approved', ARRAY['certificado','certificação','diploma','emitir certificado','PDF','resumo das aulas','material de apoio','e-book','descrição da aula']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M03.A12-03', 'principal', 2, 3, 'V2.M03.A12 — Certificação', 'Exercício: reflexão e desafio', 'Certificação', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 03 – Pocket Studio: Hollywood no Seu Bolso › Aula 12 – Certificação › Exercício: reflexão e desafio

- Reflexão: "O que mudou desde que você começou?" Pode ter descoberto mais criatividade, percebido que pequenos ajustes fazem diferença ou encontrado uma nova paixão.
- Desafio: usar a certificação como ponto de partida e definir como aplicar o que aprendeu: criar conteúdo que impacte mais pessoas ou transformar em fonte de renda.', 'approved', ARRAY['certificado','certificação','diploma','emitir certificado','PDF','resumo das aulas','material de apoio','e-book','descrição da aula']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M03.A12-04', 'principal', 2, 3, 'V2.M03.A12 — Certificação', 'FAQ', 'Certificação', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 03 – Pocket Studio: Hollywood no Seu Bolso › Aula 12 – Certificação › Pontos para o suporte

- "Onde está o resumo do módulo?" Na descrição desta aula há um PDF com todas as aulas resumidas.
- "Como pego meu certificado?" A aula não explica. Confirmar o procedimento com a equipe antes de responder (mesma lacuna da Vitrine 2, Módulo 02, Aula 07).
- "Terminei o módulo, e agora?" Praticar: produzir fotos e vídeos com o que aprendeu e, se quiser, oferecer como serviço (edição de vídeo, conteúdo para redes) nas plataformas de demandas.', 'approved', ARRAY['certificado','certificação','diploma','emitir certificado','PDF','resumo das aulas','material de apoio','e-book','descrição da aula']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M04.A01-01', 'principal', 2, 4, 'V2.M04.A01 — Anatomia das Redes', 'Visão geral', 'Anatomia das Redes', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 04 – Conquistando o Digital: Dominando o Algoritmo › Aula 01 – Anatomia das Redes › Visão geral da aula

Nome oficial da aula: Anatomia das Redes
Onde fica: Vitrine 2 (I BÔNUS – Skill''s das Demandas Lucrativas), Módulo 04 – Conquistando o Digital: Dominando o Algoritmo, Aula 01
Duração/formato: 4:02
Link na área de membros (abre a página do Módulo 04, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/2/21

Resumo:
É a aula de abertura do Módulo 04. Ela explica que cada rede social tem sua "personalidade" e valoriza formatos diferentes, então o que funciona numa pode não funcionar em outra. Ensina a reaproveitar o mesmo conteúdo em várias redes, adaptando o formato. Explica de forma simples o que é o algoritmo e apresenta uma estrutura de 3 passos para posts: chamar a atenção, entregar valor e convidar à interação. Termina com um exercício prático.', 'approved', ARRAY['redes sociais','Instagram','Facebook','TikTok','LinkedIn','Reels','carrossel','vídeos curtos','áudios em alta','tendências','trends','algoritmo','alcance','engajamento','primeiros segundos','gancho','reaproveitar conteúdo','adaptar conteúdo','conteúdo multiplataforma','chamada para ação','CTA','curtir, comentar, compartilhar']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M04.A01-02', 'principal', 2, 4, 'V2.M04.A01 — Anatomia das Redes', 'A personalidade de cada rede', 'Anatomia das Redes', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 04 – Conquistando o Digital: Dominando o Algoritmo › Aula 01 – Anatomia das Redes › A personalidade de cada rede

| Rede | Personalidade | Formatos que funcionam melhor |
|---|---|---|
| Instagram | Muito visual | Fotos bem feitas, carrosséis com dicas práticas, vídeos curtos (Reels) |
| TikTok | Rápido, dinâmico, cheio de tendências | Vídeos rápidos com músicas ou áudios em alta |
| Facebook | Comunidades e conversas em grupos | Posts com imagens ou links para conteúdos mais longos |
| LinkedIn | Profissional, conexões, assuntos sérios | Histórias inspiradoras ou dicas práticas em tom profissional |', 'approved', ARRAY['redes sociais','Instagram','Facebook','TikTok','LinkedIn','Reels','carrossel','vídeos curtos','áudios em alta','tendências','trends','algoritmo','alcance','engajamento','primeiros segundos','gancho','reaproveitar conteúdo','adaptar conteúdo','conteúdo multiplataforma','chamada para ação','CTA','curtir, comentar, compartilhar']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M04.A01-03', 'principal', 2, 4, 'V2.M04.A01 — Anatomia das Redes', 'Reaproveitar o mesmo conteúdo', 'Anatomia das Redes', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 04 – Conquistando o Digital: Dominando o Algoritmo › Aula 01 – Anatomia das Redes › Reaproveitar o mesmo conteúdo

Não é preciso criar algo novo para cada rede. Exemplo: um vídeo curto ensinando algo útil pode virar:
- um Reels no Instagram;
- um post no TikTok;
- um texto com imagem no LinkedIn (ou no Facebook), contando a mesma ideia no tom daquele público.
O segredo é entender o que cada rede valoriza e ajustar o formato.', 'approved', ARRAY['redes sociais','Instagram','Facebook','TikTok','LinkedIn','Reels','carrossel','vídeos curtos','áudios em alta','tendências','trends','algoritmo','alcance','engajamento','primeiros segundos','gancho','reaproveitar conteúdo','adaptar conteúdo','conteúdo multiplataforma','chamada para ação','CTA','curtir, comentar, compartilhar']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M04.A01-04', 'principal', 2, 4, 'V2.M04.A01 — Anatomia das Redes', 'O algoritmo', 'Anatomia das Redes', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 04 – Conquistando o Digital: Dominando o Algoritmo › Aula 01 – Anatomia das Redes › O algoritmo

- São "robôs que decidem o que aparece para cada pessoa": eles analisam o que as pessoas curtem, comentam e compartilham e mostram mais do mesmo.
- No Instagram e no TikTok, os primeiros segundos do vídeo são cruciais. Se não prender a atenção, a pessoa passa e o algoritmo entende que o conteúdo não é interessante.', 'approved', ARRAY['redes sociais','Instagram','Facebook','TikTok','LinkedIn','Reels','carrossel','vídeos curtos','áudios em alta','tendências','trends','algoritmo','alcance','engajamento','primeiros segundos','gancho','reaproveitar conteúdo','adaptar conteúdo','conteúdo multiplataforma','chamada para ação','CTA','curtir, comentar, compartilhar']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M04.A01-05', 'principal', 2, 4, 'V2.M04.A01 — Anatomia das Redes', 'Procedimento: estrutura de 3 passos para cada conteúdo', 'Anatomia das Redes', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 04 – Conquistando o Digital: Dominando o Algoritmo › Aula 01 – Anatomia das Redes › Procedimento: estrutura de 3 passos para cada conteúdo

1. Chamar a atenção logo no início: uma pergunta, uma frase impactante ou uma imagem diferente.
2. Entregar valor: uma dica, uma história ou a solução para um problema.
3. Convidar à interação: pedir para curtir, comentar ou compartilhar, o que aumenta o alcance.', 'approved', ARRAY['redes sociais','Instagram','Facebook','TikTok','LinkedIn','Reels','carrossel','vídeos curtos','áudios em alta','tendências','trends','algoritmo','alcance','engajamento','primeiros segundos','gancho','reaproveitar conteúdo','adaptar conteúdo','conteúdo multiplataforma','chamada para ação','CTA','curtir, comentar, compartilhar']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M04.A01-06', 'principal', 2, 4, 'V2.M04.A01 — Anatomia das Redes', 'Exercício prático', 'Anatomia das Redes', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 04 – Conquistando o Digital: Dominando o Algoritmo › Aula 01 – Anatomia das Redes › Exercício prático

1. Escolher um tema que domina ou algo que aprendeu recentemente (dica de organização, receita, história inspiradora).
2. Criar um conteúdo sobre esse tema.
3. Adaptar para diferentes redes: um vídeo curto para Instagram e TikTok e um texto com imagem para Facebook ou LinkedIn.
Próxima aula: produzir conteúdo em lote para nunca ficar sem ideias.', 'approved', ARRAY['redes sociais','Instagram','Facebook','TikTok','LinkedIn','Reels','carrossel','vídeos curtos','áudios em alta','tendências','trends','algoritmo','alcance','engajamento','primeiros segundos','gancho','reaproveitar conteúdo','adaptar conteúdo','conteúdo multiplataforma','chamada para ação','CTA','curtir, comentar, compartilhar']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M04.A01-07', 'principal', 2, 4, 'V2.M04.A01 — Anatomia das Redes', 'FAQ', 'Anatomia das Redes', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 04 – Conquistando o Digital: Dominando o Algoritmo › Aula 01 – Anatomia das Redes › Pontos para o suporte

- "O que eu posto em cada rede?" Instagram: fotos, carrosséis e Reels. TikTok: vídeos rápidos com áudios em alta. Facebook: posts com imagem ou link. LinkedIn: histórias e dicas em tom profissional.
- "Preciso criar um conteúdo diferente para cada rede?" Não. Basta adaptar o mesmo conteúdo ao formato de cada uma.
- "O que é algoritmo?" O sistema que decide o que aparece para cada pessoa, com base no que ela curte, comenta e compartilha.
- "Meu vídeo não tem alcance." Revisar os primeiros segundos (gancho), a entrega de valor e o convite à interação.', 'approved', ARRAY['redes sociais','Instagram','Facebook','TikTok','LinkedIn','Reels','carrossel','vídeos curtos','áudios em alta','tendências','trends','algoritmo','alcance','engajamento','primeiros segundos','gancho','reaproveitar conteúdo','adaptar conteúdo','conteúdo multiplataforma','chamada para ação','CTA','curtir, comentar, compartilhar']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M04.A02-01', 'principal', 2, 4, 'V2.M04.A02 — Fábrica de Conteúdo: Produzindo 30 Posts em 1 Dia', 'Visão geral', 'Fábrica de Conteúdo: Produzindo 30 Posts em 1 Dia', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 04 – Conquistando o Digital: Dominando o Algoritmo › Aula 02 – Fábrica de Conteúdo: Produzindo 30 Posts em 1 Dia › Visão geral da aula

Nome oficial da aula: Fábrica de Conteúdo: Produzindo 30 Posts em 1 Dia
Onde fica: Vitrine 2 (I BÔNUS – Skill''s das Demandas Lucrativas), Módulo 04 – Conquistando o Digital: Dominando o Algoritmo, Aula 02
Duração/formato: PDF (9 páginas)
Link na área de membros (abre a página do Módulo 04, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/2/21

Resumo:
É uma aula em PDF, sem vídeo, com 9 páginas. Ela ensina a montar uma "fábrica de conteúdo":
- planejar com um calendário editorial;
- produzir em lote, separando textos, imagens e vídeos em etapas;
- usar templates e o framework AIDA para nunca ficar sem ideias;
- usar ferramentas como Canva, Google Docs/Notion e Meta Business Suite.
Também explica os dois tipos de algoritmo (de preferência e de sugestão), com estratégias para cada rede, e fecha com um exercício de criar 5 conteúdos sobre um tema.', 'approved', ARRAY['calendário editorial','planejamento de conteúdo','cronograma de posts','produção em lote','conteúdo em lote','batch','templates','moldes','frameworks','AIDA','Canva','Google Docs','Notion','Meta Business Suite','agendamento de posts','algoritmo de preferência','algoritmo de sugestão','Instagram','LinkedIn','Twitter','TikTok','YouTube','repostar','repost','primeiras horas','consistência','tempo de tela']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M04.A02-02', 'principal', 2, 4, 'V2.M04.A02 — Fábrica de Conteúdo: Produzindo 30 Posts em 1 Dia', 'Procedimento: passo a passo', 'Fábrica de Conteúdo: Produzindo 30 Posts em 1 Dia', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 04 – Conquistando o Digital: Dominando o Algoritmo › Aula 02 – Fábrica de Conteúdo: Produzindo 30 Posts em 1 Dia › Procedimento: passo a passo

### 1. Planejar (calendário editorial)
1. Definir o período: semana, 15 dias ou mês.
2. Escolher os temas: dicas rápidas, histórias inspiradoras, tutoriais práticos.
3. Definir os formatos: vídeo, imagem ou texto.
- Dica: anotar tudo no calendário, para manter consistência e clareza.
### 2. Produzir em lote
Criar vários conteúdos de uma vez, uma etapa por vez:
1. Escrever todos os textos de um tema.
2. Criar as imagens (por exemplo, no Canva).
3. Gravar todos os vídeos de uma vez.
- Por que funciona: foco em uma tarefa por vez, sem distrações.
### 3. Usar templates e frameworks
- Templates (moldes reutilizáveis): "5 dicas para [tema]", "3 erros que você deve evitar em [tema]".
- Framework AIDA:
| Letra | Etapa | O que fazer |
|---|---|---|
| A | Atenção | Começar com uma frase impactante |
| I | Interesse | Explicar por que o tema é importante |
| D | Desejo | Mostrar como isso pode transformar a vida da pessoa |
| A | Ação | Convidar a curtir, comentar ou compartilhar |
### 4. Ferramentas
| Ferramenta | Uso |
|---|---|
| Canva | Imagens e vídeos curtos com modelos prontos |
| Google Docs / Notion | Organizar ideias e textos |
| Meta Business Suite | Agendar posts (Facebook e Instagram) |', 'approved', ARRAY['calendário editorial','planejamento de conteúdo','cronograma de posts','produção em lote','conteúdo em lote','batch','templates','moldes','frameworks','AIDA','Canva','Google Docs','Notion','Meta Business Suite','agendamento de posts','algoritmo de preferência','algoritmo de sugestão','Instagram','LinkedIn','Twitter','TikTok','YouTube','repostar','repost','primeiras horas','consistência','tempo de tela']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M04.A02-03', 'principal', 2, 4, 'V2.M04.A02 — Fábrica de Conteúdo: Produzindo 30 Posts em 1 Dia', 'Os dois tipos de algoritmo (segundo o PDF)', 'Fábrica de Conteúdo: Produzindo 30 Posts em 1 Dia', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 04 – Conquistando o Digital: Dominando o Algoritmo › Aula 02 – Fábrica de Conteúdo: Produzindo 30 Posts em 1 Dia › Os dois tipos de algoritmo (segundo o PDF)

|  | Algoritmo de preferência | Algoritmo de sugestão |
|---|---|---|
| Redes | Instagram, LinkedIn, Twitter | TikTok, YouTube |
| Como funciona | Prioriza conteúdo de quem você segue, mas entrega só o mais relevante | Mostra conteúdo pelos interesses, independente de quem a pessoa segue |
| Fatores | Engajamento, tempo de tela, consistência | Teste com um grupo pequeno; se engajar, é entregue a mais pessoas. Cada conteúdo é avaliado isoladamente. |
| Dica do PDF | As primeiras horas após a publicação são cruciais | Repostar conteúdos que não performaram |
| Estratégia | Engajar com quem já segue (responder comentários, interagir nos stories); perguntas e enquetes | Caprichar nos primeiros segundos; repostar o que não performou |
Para todas as redes: consistência. Publicar com frequência mostra ao algoritmo que a conta está ativa.', 'approved', ARRAY['calendário editorial','planejamento de conteúdo','cronograma de posts','produção em lote','conteúdo em lote','batch','templates','moldes','frameworks','AIDA','Canva','Google Docs','Notion','Meta Business Suite','agendamento de posts','algoritmo de preferência','algoritmo de sugestão','Instagram','LinkedIn','Twitter','TikTok','YouTube','repostar','repost','primeiras horas','consistência','tempo de tela']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M04.A02-04', 'principal', 2, 4, 'V2.M04.A02 — Fábrica de Conteúdo: Produzindo 30 Posts em 1 Dia', 'Exercício prático', 'Fábrica de Conteúdo: Produzindo 30 Posts em 1 Dia', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 04 – Conquistando o Digital: Dominando o Algoritmo › Aula 02 – Fábrica de Conteúdo: Produzindo 30 Posts em 1 Dia › Exercício prático

1. Escolher um tema que domina ou que aprendeu recentemente.
2. Criar 5 conteúdos diferentes sobre ele:
  - Carrossel: "5 dicas rápidas para [tema]";
  - Vídeo curto: algo prático ou uma dica;
  - Imagem: frase inspiradora sobre o tema;
  - Texto: uma história pessoal ligada ao tema;
  - Vídeo explicativo: um passo a passo simples.
3. Programar os conteúdos no calendário editorial.
Próxima aula: escrever textos que convertem.', 'approved', ARRAY['calendário editorial','planejamento de conteúdo','cronograma de posts','produção em lote','conteúdo em lote','batch','templates','moldes','frameworks','AIDA','Canva','Google Docs','Notion','Meta Business Suite','agendamento de posts','algoritmo de preferência','algoritmo de sugestão','Instagram','LinkedIn','Twitter','TikTok','YouTube','repostar','repost','primeiras horas','consistência','tempo de tela']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M04.A02-05', 'principal', 2, 4, 'V2.M04.A02 — Fábrica de Conteúdo: Produzindo 30 Posts em 1 Dia', 'FAQ', 'Fábrica de Conteúdo: Produzindo 30 Posts em 1 Dia', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 04 – Conquistando o Digital: Dominando o Algoritmo › Aula 02 – Fábrica de Conteúdo: Produzindo 30 Posts em 1 Dia › Pontos para o suporte

- "Como produzo muito conteúdo sem perder tempo?" Planejar no calendário editorial e produzir em lote: todos os textos, depois todas as imagens, depois todos os vídeos.
- "Fiquei sem ideias." Usar templates ("5 dicas para…", "3 erros que você deve evitar em…") e o AIDA.
- "Como agendo posts?" No Meta Business Suite (Facebook e Instagram).
- "Onde está o vídeo desta aula?" Esta aula é só em PDF.', 'approved', ARRAY['calendário editorial','planejamento de conteúdo','cronograma de posts','produção em lote','conteúdo em lote','batch','templates','moldes','frameworks','AIDA','Canva','Google Docs','Notion','Meta Business Suite','agendamento de posts','algoritmo de preferência','algoritmo de sugestão','Instagram','LinkedIn','Twitter','TikTok','YouTube','repostar','repost','primeiras horas','consistência','tempo de tela']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M04.A03-01', 'principal', 2, 4, 'V2.M04.A03 — Copywriting, Hashtags e SEO para Redes Sociais', 'Visão geral', 'Copywriting, Hashtags e SEO para Redes Sociais', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 04 – Conquistando o Digital: Dominando o Algoritmo › Aula 03 – Copywriting, Hashtags e SEO para Redes Sociais › Visão geral da aula

Nome oficial da aula: Copywriting, Hashtags e SEO para Redes Sociais
Onde fica: Vitrine 2 (I BÔNUS – Skill''s das Demandas Lucrativas), Módulo 04 – Conquistando o Digital: Dominando o Algoritmo, Aula 03
Duração/formato: 4:13
Link na área de membros (abre a página do Módulo 04, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/2/21

Resumo:
A aula une duas habilidades: escrever textos que convertem (copy) e fazer esses textos serem encontrados (hashtags e SEO social). "Um texto perfeito não gera resultados se ninguém lê. E ser encontrado não adianta se o seu texto não convencer."
- Na parte de copy: headlines que param o scroll, conexão com o problema, CTAs específicos, storytelling em 4 etapas e o método AIDA.
- Na parte de descoberta: como escolher hashtags, o que o algoritmo prioriza e um checklist de otimização do perfil.
É praticamente um resumo condensado do Módulo 02 (Comunicação Viral), aplicado às redes.', 'approved', ARRAY['copywriting','copy','headline','gancho','parar o scroll','lacuna de curiosidade','CTA','chamada para ação','storytelling','introdução, conflito, solução, conclusão','AIDA','hashtags','SEO social','palavras-chave','busca orgânica','bio','nome de usuário','foto de perfil','link na bio','destaques']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M04.A03-02', 'principal', 2, 4, 'V2.M04.A03 — Copywriting, Hashtags e SEO para Redes Sociais', 'Parte 1: Copy que converte', 'Copywriting, Hashtags e SEO para Redes Sociais', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 04 – Conquistando o Digital: Dominando o Algoritmo › Aula 03 – Copywriting, Hashtags e SEO para Redes Sociais › Parte 1: Copy que converte

### 1. Headline (as primeiras palavras)
- A função é parar o scroll: despertar curiosidade, provocar emoção ou oferecer valor.
- Exemplos da aula:
  - "Você está cometendo esse erro sem perceber?"
  - "3 passos simples para transformar sua rotina hoje."
- Funcionam porque criam uma lacuna de informação, e "o cérebro não gosta de lacunas".
### 2. Interesse e conexão
- Mostrar que entende o problema da pessoa e que tem uma solução prática.
### 3. CTA (chamada para ação)
- Deve ser claro, específico e urgente.
| ❌ Genérico | ✅ Específico |
|---|---|
| "Clique aqui" | "Comente qual dica você vai aplicar hoje" |
|  | "Clique no link e descubra como mudar sua rotina agora" |
### 4. Storytelling em 4 etapas
1. Introdução: contexto e problema.
2. Conflito: a dificuldade e a frustração.
3. Solução: como superou o desafio.
4. Conclusão: o aprendizado.
### 5. AIDA
| Etapa | O que fazer |
|---|---|
| Atenção | Parar a pessoa com uma headline forte |
| Interesse | Mostrar a relevância com dados ou histórias |
| Desejo | Fazer a pessoa imaginar o benefício |
| Ação | Convidar a agir com um CTA claro |', 'approved', ARRAY['copywriting','copy','headline','gancho','parar o scroll','lacuna de curiosidade','CTA','chamada para ação','storytelling','introdução, conflito, solução, conclusão','AIDA','hashtags','SEO social','palavras-chave','busca orgânica','bio','nome de usuário','foto de perfil','link na bio','destaques']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M04.A03-03', 'principal', 2, 4, 'V2.M04.A03 — Copywriting, Hashtags e SEO para Redes Sociais', 'Parte 2: Hashtags e SEO social', 'Copywriting, Hashtags e SEO para Redes Sociais', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 04 – Conquistando o Digital: Dominando o Algoritmo › Aula 03 – Copywriting, Hashtags e SEO para Redes Sociais › Parte 2: Hashtags e SEO social

### Hashtags
- Funcionam como etiquetas: a hashtag #organização diz à plataforma qual é o tema do post e o mostra a quem busca por isso.
- Como escolher:
  1. Pesquisar na própria plataforma.
  2. Preferir hashtags com 10 mil a 500 mil usos (menos concorrência).
  3. Observar perfis do nicho para ter ideias.
  4. Montar listas e mesclar hashtags grandes, médias e pequenas, equilibrando alcance e assertividade.
### O que o algoritmo prioriza (alcance orgânico)
- Relevância, consistência e engajamento. Quanto mais interação, mais entrega.
### Checklist: perfil otimizado ("sua vitrine")
| Item | Como fazer |
|---|---|
| Nome | Claro, com palavras-chave do nicho no nome de usuário ou na descrição |
| Foto | Profissional, clara, que transmita confiança |
| Bio | Objetiva: quem você é e como ajuda |
| Link | Estratégico: site, WhatsApp ou material de vendas |
| Destaques | Organizados por categoria: dicas, depoimentos, sobre você |', 'approved', ARRAY['copywriting','copy','headline','gancho','parar o scroll','lacuna de curiosidade','CTA','chamada para ação','storytelling','introdução, conflito, solução, conclusão','AIDA','hashtags','SEO social','palavras-chave','busca orgânica','bio','nome de usuário','foto de perfil','link na bio','destaques']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M04.A03-04', 'principal', 2, 4, 'V2.M04.A03 — Copywriting, Hashtags e SEO para Redes Sociais', 'Exercício sugerido (implícito na aula)', 'Copywriting, Hashtags e SEO para Redes Sociais', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 04 – Conquistando o Digital: Dominando o Algoritmo › Aula 03 – Copywriting, Hashtags e SEO para Redes Sociais › Exercício sugerido (implícito na aula)

1. Reescrever a legenda de um post usando headline + AIDA + CTA específico.
2. Pesquisar e montar uma lista de hashtags do nicho (grandes, médias e pequenas).
3. Revisar o perfil com o checklist acima.', 'approved', ARRAY['copywriting','copy','headline','gancho','parar o scroll','lacuna de curiosidade','CTA','chamada para ação','storytelling','introdução, conflito, solução, conclusão','AIDA','hashtags','SEO social','palavras-chave','busca orgânica','bio','nome de usuário','foto de perfil','link na bio','destaques']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M04.A03-05', 'principal', 2, 4, 'V2.M04.A03 — Copywriting, Hashtags e SEO para Redes Sociais', 'FAQ', 'Copywriting, Hashtags e SEO para Redes Sociais', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 04 – Conquistando o Digital: Dominando o Algoritmo › Aula 03 – Copywriting, Hashtags e SEO para Redes Sociais › Pontos para o suporte

- "Como começo a legenda?" Com uma headline que gere curiosidade ou ofereça valor, por exemplo "3 passos simples para…".
- "O que escrevo no final do post?" Um CTA específico, como "Comente qual dica você vai aplicar hoje", e não só "clique aqui".
- "Quais hashtags usar?" Pesquisar na plataforma, preferir as de 10 mil a 500 mil usos e misturar tamanhos.
- "Como deixo meu perfil mais profissional?" Nome com palavra-chave, foto clara, bio objetiva, link estratégico e destaques organizados.', 'approved', ARRAY['copywriting','copy','headline','gancho','parar o scroll','lacuna de curiosidade','CTA','chamada para ação','storytelling','introdução, conflito, solução, conclusão','AIDA','hashtags','SEO social','palavras-chave','busca orgânica','bio','nome de usuário','foto de perfil','link na bio','destaques']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M04.A04-01', 'principal', 2, 4, 'V2.M04.A04 — Criando Reels, Stories e TikToks que Vendem', 'Visão geral', 'Criando Reels, Stories e TikToks que Vendem', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 04 – Conquistando o Digital: Dominando o Algoritmo › Aula 04 – Criando Reels, Stories e TikToks que Vendem › Visão geral da aula

Nome oficial da aula: Criando Reels, Stories e TikToks que Vendem
Onde fica: Vitrine 2 (I BÔNUS – Skill''s das Demandas Lucrativas), Módulo 04 – Conquistando o Digital: Dominando o Algoritmo, Aula 04
Duração/formato: 4:26
Link na área de membros (abre a página do Módulo 04, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/2/21

Resumo:
A aula divide o trabalho nas redes em duas funções:
- Vídeos curtos (Reels e TikTok) para atrair pessoas que ainda não conhecem a aluna;
- Stories para converter essas visualizações em vendas.
Ela ensina:
- a estrutura de 3 partes de um vídeo curto;
- o uso de trends e áudios em alta;
- horários e frequência de postagem;
- um funil de vendas em 4 etapas nos stories, com ferramentas interativas (enquete, caixa de perguntas, quiz).
Termina com uma tarefa prática dupla.', 'approved', ARRAY['Reels','TikTok','vídeos curtos','stories','gancho','começo do vídeo','introdução, desenvolvimento, conclusão','trends','tendências','áudios virais','áudios em alta','efeitos','horário de postagem','frequência','3 vídeos por semana','consistência','enquete','caixa de perguntas','quiz','ferramentas interativas','funil de vendas nos stories','nutrir audiência','bastidores','depoimento','CTA','link da bio','direct','garantir sua vaga']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M04.A04-02', 'principal', 2, 4, 'V2.M04.A04 — Criando Reels, Stories e TikToks que Vendem', 'Parte 1: Vídeos curtos que atraem', 'Criando Reels, Stories e TikToks que Vendem', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 04 – Conquistando o Digital: Dominando o Algoritmo › Aula 04 – Criando Reels, Stories e TikToks que Vendem › Parte 1: Vídeos curtos que atraem

### Procedimento
1. Começo (o mais importante): prender a atenção nos primeiros segundos com uma pergunta intrigante ("Você sabia que está cometendo esse erro todos os dias?") ou algo visualmente curioso.
2. Estrutura em 3 partes:
| Parte | O que fazer | Exemplo da aula |
|---|---|---|
| Introdução | Apresentar o problema ou tema logo de cara | Falta de foco no dia |
| Desenvolvimento | Entregar a solução | "Separe 10 minutos no final do dia para planejar o dia seguinte" |
| Conclusão | CTA: curtir, comentar ou compartilhar | — |
1. Trends e áudios em alta: ver o que está em alta nas redes e adaptar ao seu nicho.
2. Horário: publicar quando o público está mais ativo. No Instagram, a aula cita manhã, almoço e início da noite.
3. Frequência: começar com 3 vídeos por semana e ir aumentando.', 'approved', ARRAY['Reels','TikTok','vídeos curtos','stories','gancho','começo do vídeo','introdução, desenvolvimento, conclusão','trends','tendências','áudios virais','áudios em alta','efeitos','horário de postagem','frequência','3 vídeos por semana','consistência','enquete','caixa de perguntas','quiz','ferramentas interativas','funil de vendas nos stories','nutrir audiência','bastidores','depoimento','CTA','link da bio','direct','garantir sua vaga']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M04.A04-03', 'principal', 2, 4, 'V2.M04.A04 — Criando Reels, Stories e TikToks que Vendem', 'Parte 2: Stories que vendem', 'Criando Reels, Stories e TikToks que Vendem', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 04 – Conquistando o Digital: Dominando o Algoritmo › Aula 04 – Criando Reels, Stories e TikToks que Vendem › Parte 2: Stories que vendem

Por que os stories: duram 24 horas (senso de urgência), são consumidos de forma casual e são o lugar dos bastidores e da confiança.
### Procedimento
1. Nutrir a audiência: dicas rápidas, histórias pessoais e o dia a dia. Exemplo: quem trabalha com organização mostra como organiza a própria agenda, o que prova que entende do assunto.
2. Engajar com ferramentas interativas: enquetes, caixas de perguntas, quiz. Exemplo: "Você costuma planejar o seu dia? Sim/Não". Mais interação significa mais entrega dos stories.
3. Montar o funil de vendas (de espectadora a cliente), em sequência:
| Etapa | Story |
|---|---|
| 1. Atrair a atenção | Um story que desperte curiosidade |
| 2. Entregar valor | Uma dica prática ou uma história útil |
| 3. Criar desejo | Mostrar o benefício do que vende, resultados ou depoimentos de clientes |
| 4. Chamada para ação | CTA claro: "Clica no link da bio para saber mais" ou "Me manda um direct para garantir sua vaga" |', 'approved', ARRAY['Reels','TikTok','vídeos curtos','stories','gancho','começo do vídeo','introdução, desenvolvimento, conclusão','trends','tendências','áudios virais','áudios em alta','efeitos','horário de postagem','frequência','3 vídeos por semana','consistência','enquete','caixa de perguntas','quiz','ferramentas interativas','funil de vendas nos stories','nutrir audiência','bastidores','depoimento','CTA','link da bio','direct','garantir sua vaga']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M04.A04-04', 'principal', 2, 4, 'V2.M04.A04 — Criando Reels, Stories e TikToks que Vendem', 'Tarefa prática dupla', 'Criando Reels, Stories e TikToks que Vendem', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 04 – Conquistando o Digital: Dominando o Algoritmo › Aula 04 – Criando Reels, Stories e TikToks que Vendem › Tarefa prática dupla

1. Criar um vídeo curto (Reels ou TikTok) com a estrutura introdução › desenvolvimento › conclusão, usando um áudio em alta.
2. Criar uma sequência de stories de funil (atrair › entregar valor › criar desejo › CTA) com pelo menos uma enquete.
3. Testar, observar os resultados e ajustar.
Próxima aula: interpretar os dados das redes sociais para otimizar resultados.', 'approved', ARRAY['Reels','TikTok','vídeos curtos','stories','gancho','começo do vídeo','introdução, desenvolvimento, conclusão','trends','tendências','áudios virais','áudios em alta','efeitos','horário de postagem','frequência','3 vídeos por semana','consistência','enquete','caixa de perguntas','quiz','ferramentas interativas','funil de vendas nos stories','nutrir audiência','bastidores','depoimento','CTA','link da bio','direct','garantir sua vaga']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M04.A04-05', 'principal', 2, 4, 'V2.M04.A04 — Criando Reels, Stories e TikToks que Vendem', 'FAQ', 'Criando Reels, Stories e TikToks que Vendem', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 04 – Conquistando o Digital: Dominando o Algoritmo › Aula 04 – Criando Reels, Stories e TikToks que Vendem › Pontos para o suporte

- "Como começo meu vídeo?" Com uma pergunta intrigante ou algo visualmente curioso nos primeiros segundos.
- "Quantos vídeos devo postar?" Começar com 3 por semana e aumentar aos poucos, sempre com constância.
- "Qual o melhor horário?" A aula cita manhã, almoço e início da noite para o Instagram, mas o ideal é ver os horários do seu próprio público (próxima aula, dados).
- "Como vendo pelos stories?" Sequência: curiosidade › dica de valor › benefício e depoimentos › CTA (link da bio ou direct). Usar enquetes para engajar.', 'approved', ARRAY['Reels','TikTok','vídeos curtos','stories','gancho','começo do vídeo','introdução, desenvolvimento, conclusão','trends','tendências','áudios virais','áudios em alta','efeitos','horário de postagem','frequência','3 vídeos por semana','consistência','enquete','caixa de perguntas','quiz','ferramentas interativas','funil de vendas nos stories','nutrir audiência','bastidores','depoimento','CTA','link da bio','direct','garantir sua vaga']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M04.A05-01', 'principal', 2, 4, 'V2.M04.A05 — Analytics e Otimização: Lendo os Dados como um Profissional', 'Visão geral', 'Analytics e Otimização: Lendo os Dados como um Profissional', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 04 – Conquistando o Digital: Dominando o Algoritmo › Aula 05 – Analytics e Otimização: Lendo os Dados como um Profissional › Visão geral da aula

Nome oficial da aula: Analytics e Otimização: Lendo os Dados como um Profissional
Onde fica: Vitrine 2 (I BÔNUS – Skill''s das Demandas Lucrativas), Módulo 04 – Conquistando o Digital: Dominando o Algoritmo, Aula 05
Duração/formato: 3:13
Link na área de membros (abre a página do Módulo 04, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/2/21

Resumo:
A aula ensina a ler os dados das redes para melhorar os resultados:
- separar métricas de vaidade das métricas que importam;
- interpretar os insights (alcance × impressões, interações);
- usar testes A/B, mudando uma variável por vez, para otimizar continuamente.
Termina com uma tarefa: analisar um post antigo e testar duas abordagens novas sobre o mesmo tema.', 'approved', ARRAY['analytics','insights','métricas','dados das redes sociais','métricas de vaidade','seguidores','curtidas','taxa de engajamento','alcance','impressões','visualizações','interações','cliques no link','taxa de conversão','teste A/B','testes A e B','uma variável por vez']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M04.A05-02', 'principal', 2, 4, 'V2.M04.A05 — Analytics e Otimização: Lendo os Dados como um Profissional', 'Métricas: vaidade × as que importam', 'Analytics e Otimização: Lendo os Dados como um Profissional', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 04 – Conquistando o Digital: Dominando o Algoritmo › Aula 05 – Analytics e Otimização: Lendo os Dados como um Profissional › Métricas: vaidade × as que importam

| Tipo | Métrica | O que mostra |
|---|---|---|
| ❌ Vaidade | Número de seguidores, curtidas isoladas | Parecem impressionantes, mas não dizem se há engajamento ou vendas |
| ✅ Importa | Taxa de engajamento | Interações (curtidas, comentários, compartilhamentos, cliques) em relação a quem viu o post |
| ✅ Importa | Alcance | Quantas pessoas únicas viram |
| ✅ Importa | Cliques no link | Essencial quando o objetivo é levar a um site ou página de vendas |
| ✅ Importa | Taxa de conversão | Quantas pessoas fizeram a ação final (comprar, se inscrever) |', 'approved', ARRAY['analytics','insights','métricas','dados das redes sociais','métricas de vaidade','seguidores','curtidas','taxa de engajamento','alcance','impressões','visualizações','interações','cliques no link','taxa de conversão','teste A/B','testes A e B','uma variável por vez']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M04.A05-03', 'principal', 2, 4, 'V2.M04.A05 — Analytics e Otimização: Lendo os Dados como um Profissional', 'Procedimento', 'Analytics e Otimização: Lendo os Dados como um Profissional', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 04 – Conquistando o Digital: Dominando o Algoritmo › Aula 05 – Analytics e Otimização: Lendo os Dados como um Profissional › Procedimento

### 1. Interpretar os insights
- Alcance = pessoas únicas. Impressões = quantas vezes o conteúdo foi exibido.
- Impressões muito maiores que o alcance significam que as pessoas viram mais de uma vez, um ótimo sinal de interesse.
- Interações mostram o quanto o conteúdo engaja.
- Um formato com mais alcance e interação merece mais investimento. Se foi mal, o tema ou o horário podem não ter sido ideais.
- Observar padrões e ajustar a estratégia.
### 2. Teste A/B
1. Criar duas versões de um conteúdo. Exemplo da aula, para divulgar um curso: um carrossel com os benefícios e um vídeo curto com depoimentos.
2. Publicar em horários parecidos.
3. Comparar qual teve mais impacto e ajustar os próximos conteúdos.
- O que testar: horários, CTAs, estilo visual, formato.
- ⚠️ Testar uma variável por vez, para saber exatamente o que fez a diferença.
- A otimização é um processo contínuo.', 'approved', ARRAY['analytics','insights','métricas','dados das redes sociais','métricas de vaidade','seguidores','curtidas','taxa de engajamento','alcance','impressões','visualizações','interações','cliques no link','taxa de conversão','teste A/B','testes A e B','uma variável por vez']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M04.A05-04', 'principal', 2, 4, 'V2.M04.A05 — Analytics e Otimização: Lendo os Dados como um Profissional', 'Tarefa prática', 'Analytics e Otimização: Lendo os Dados como um Profissional', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 04 – Conquistando o Digital: Dominando o Algoritmo › Aula 05 – Analytics e Otimização: Lendo os Dados como um Profissional › Tarefa prática

1. Escolher um conteúdo já publicado e analisar alcance, interações e cliques.
2. Criar dois novos conteúdos sobre o mesmo tema, com abordagens diferentes, e publicar.
3. Comparar os resultados e usar os insights para planejar os próximos posts.', 'approved', ARRAY['analytics','insights','métricas','dados das redes sociais','métricas de vaidade','seguidores','curtidas','taxa de engajamento','alcance','impressões','visualizações','interações','cliques no link','taxa de conversão','teste A/B','testes A e B','uma variável por vez']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M04.A05-05', 'principal', 2, 4, 'V2.M04.A05 — Analytics e Otimização: Lendo os Dados como um Profissional', 'FAQ', 'Analytics e Otimização: Lendo os Dados como um Profissional', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 04 – Conquistando o Digital: Dominando o Algoritmo › Aula 05 – Analytics e Otimização: Lendo os Dados como um Profissional › Pontos para o suporte

- "Tenho poucos seguidores, estou indo mal?" Não necessariamente. Seguidores são métrica de vaidade. Olhar engajamento, alcance, cliques e conversão.
- "Qual a diferença entre alcance e impressões?" Alcance = pessoas únicas. Impressões = número de exibições.
- "O que é teste A/B?" Publicar duas versões que mudam uma única coisa e ver qual vai melhor.
- "Onde vejo esses dados?" Nos insights ou no painel profissional da rede.', 'approved', ARRAY['analytics','insights','métricas','dados das redes sociais','métricas de vaidade','seguidores','curtidas','taxa de engajamento','alcance','impressões','visualizações','interações','cliques no link','taxa de conversão','teste A/B','testes A e B','uma variável por vez']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M04.A06-01', 'principal', 2, 4, 'V2.M04.A06 — Certificação', 'Visão geral', 'Certificação', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 04 – Conquistando o Digital: Dominando o Algoritmo › Aula 06 – Certificação › Visão geral da aula

Nome oficial da aula: Certificação
Onde fica: Vitrine 2 (I BÔNUS – Skill''s das Demandas Lucrativas), Módulo 04 – Conquistando o Digital: Dominando o Algoritmo, Aula 06
Duração/formato: 2:29
Link na área de membros (abre a página do Módulo 04, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/2/21

Resumo:
É a aula de encerramento do Módulo 04. Diferente das certificações dos Módulos 02 e 03, que eram só mensagens motivacionais, esta traz uma recapitulação objetiva dos 5 pilares do módulo e um desafio final prático em 3 etapas (planejar, executar e analisar). Informa que há um PDF com todo o conteúdo na descrição da aula.', 'approved', ARRAY['certificado','certificação','diploma','emitir certificado','PDF','resumo do treinamento','material de apoio','descrição da aula','desafio final','calendário editorial de 1 semana','relatório de resultados','storylines','carrocéis']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M04.A06-02', 'principal', 2, 4, 'V2.M04.A06 — Certificação', 'Recapitulação: os 5 pilares do módulo', 'Certificação', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 04 – Conquistando o Digital: Dominando o Algoritmo › Aula 06 – Certificação › Recapitulação: os 5 pilares do módulo

| # | Pilar | Aula |
|---|---|---|
| 1 | Produção estratégica: calendário editorial e produção em lote ("30 posts em 1 dia") | A02 |
| 2 | Copy: headlines, CTAs, storytelling, AIDA | A03 |
| 3 | Hashtags e SEO social: otimizar o perfil e ser encontrada organicamente | A03 |
| 4 | Vídeos curtos e stories: estrutura de atenção nos vídeos, funil de vendas interativo nos stories | A04 |
| 5 | Análise e otimização: ler métricas e interpretar dados | A05 |
A Aula 01 (Anatomia das Redes) não aparece na recapitulação.', 'approved', ARRAY['certificado','certificação','diploma','emitir certificado','PDF','resumo do treinamento','material de apoio','descrição da aula','desafio final','calendário editorial de 1 semana','relatório de resultados','storylines','carrocéis']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M04.A06-03', 'principal', 2, 4, 'V2.M04.A06 — Certificação', 'Procedimento: desafio final em 3 etapas', 'Certificação', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 04 – Conquistando o Digital: Dominando o Algoritmo › Aula 06 – Certificação › Procedimento: desafio final em 3 etapas

1. Planejamento: criar um calendário editorial de 1 semana com 7 conteúdos diferentes (carrosséis, vídeos, stories), cada um com um objetivo claro: engajamento, alcance ou conversão.
2. Execução: escolher 2 desses conteúdos e publicar, aplicando o AIDA, hashtags estratégicas e ferramentas interativas.
3. Análise: depois de 48 horas, avaliar alcance, interações e cliques dos 2 posts e fazer um breve relatório: o que funcionou e o que melhorar.
Depois: baixar o PDF na descrição, usar como guia e manter a consistência. "As redes sociais mudam rápido, então continue testando e se adaptando."', 'approved', ARRAY['certificado','certificação','diploma','emitir certificado','PDF','resumo do treinamento','material de apoio','descrição da aula','desafio final','calendário editorial de 1 semana','relatório de resultados','storylines','carrocéis']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M04.A06-04', 'principal', 2, 4, 'V2.M04.A06 — Certificação', 'FAQ', 'Certificação', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 04 – Conquistando o Digital: Dominando o Algoritmo › Aula 06 – Certificação › Pontos para o suporte

- "Onde está o resumo do módulo?" Na descrição desta aula há um PDF com todo o conteúdo.
- "Como pego meu certificado?" A aula não explica. Confirmar o procedimento com a equipe (mesma lacuna da Vitrine 2, Módulo 02, Aula 07 e da Vitrine 2, Módulo 03, Aula 12).
- "O desafio final é obrigatório para o certificado?" A aula diz que o desafio serve "para garantir que você está pronta", mas não diz se é requisito. Confirmar com a equipe.
- "Preciso enviar o relatório para alguém?" A aula não pede envio. É um exercício pessoal.', 'approved', ARRAY['certificado','certificação','diploma','emitir certificado','PDF','resumo do treinamento','material de apoio','descrição da aula','desafio final','calendário editorial de 1 semana','relatório de resultados','storylines','carrocéis']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M06.A01-01', 'principal', 2, 6, 'V2.M06.A01 — Matriz de Prioridades: Focando no que Realmente Importa', 'Visão geral', 'Matriz de Prioridades: Focando no que Realmente Importa', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 06 – Multiplicando Seu Tempo › Aula 01 – Matriz de Prioridades: Focando no que Realmente Importa › Visão geral da aula

Nome oficial da aula: Matriz de Prioridades: Focando no que Realmente Importa
Onde fica: Vitrine 2 (I BÔNUS – Skill''s das Demandas Lucrativas), Módulo 06 – Multiplicando Seu Tempo, Aula 01
Duração/formato: 1:56
Link na área de membros (abre a página do Módulo 06, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/2/23

Resumo:
É a aula de abertura do Módulo 06, curta (1:56). Ela parte da ideia de que "todo mundo tem as mesmas 24 horas" e de que a "falta de tempo" geralmente é falta de clareza sobre prioridades. Apresenta a matriz de prioridades, conhecida como matriz de Eisenhower (a aula não usa esse nome), que divide as tarefas em 4 quadrantes por urgência × importância. Propõe uma auditoria do tempo de 1 a 2 dias e um exercício com folha dividida em 4.', 'approved', ARRAY['matriz de prioridades','matriz de Eisenhower','urgente × importante','4 quadrantes','gestão de prioridades','gestão de tempo','falta de tempo','auditoria do tempo','registrar atividades','delegar','dizer não','eliminar distrações','apagar incêndios']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M06.A01-02', 'principal', 2, 6, 'V2.M06.A01 — Matriz de Prioridades: Focando no que Realmente Importa', 'A matriz de prioridades', 'Matriz de Prioridades: Focando no que Realmente Importa', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 06 – Multiplicando Seu Tempo › Aula 01 – Matriz de Prioridades: Focando no que Realmente Importa › A matriz de prioridades

|  | Urgente | Não urgente |
|---|---|---|
| Importante | 1. Fazer agora. Problemas de última hora, prazos no limite. "Resolva sempre isso primeiro." | 2. Foco principal. Resultados de longo prazo: estudar, planejar o futuro. "Se ignorar, viverá apagando incêndios." |
| Não importante | 3. Delegar ou dizer não. Parece urgente, mas não é: mensagens sem relevância. "Aprenda a dizer não." | 4. Eliminar. Distrações puras, como redes sociais sem propósito. Eliminar ou reduzir ao máximo. |', 'approved', ARRAY['matriz de prioridades','matriz de Eisenhower','urgente × importante','4 quadrantes','gestão de prioridades','gestão de tempo','falta de tempo','auditoria do tempo','registrar atividades','delegar','dizer não','eliminar distrações','apagar incêndios']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M06.A01-03', 'principal', 2, 6, 'V2.M06.A01 — Matriz de Prioridades: Focando no que Realmente Importa', 'Procedimento', 'Matriz de Prioridades: Focando no que Realmente Importa', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 06 – Multiplicando Seu Tempo › Aula 01 – Matriz de Prioridades: Focando no que Realmente Importa › Procedimento

1. Auditoria do tempo: durante 1 ou 2 dias, anotar tudo o que faz e classificar cada atividade num quadrante.
2. Exercício na folha: dividir uma folha em 4 partes, nomear com os 4 quadrantes e distribuir as atividades diárias.
3. Ação imediata: escolher uma tarefa do quadrante 2 (importante, não urgente) e começar hoje.
"Priorizar te dá controle, paz e resultados. O tempo não volta, então use-o com sabedoria."', 'approved', ARRAY['matriz de prioridades','matriz de Eisenhower','urgente × importante','4 quadrantes','gestão de prioridades','gestão de tempo','falta de tempo','auditoria do tempo','registrar atividades','delegar','dizer não','eliminar distrações','apagar incêndios']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M06.A01-04', 'principal', 2, 6, 'V2.M06.A01 — Matriz de Prioridades: Focando no que Realmente Importa', 'FAQ', 'Matriz de Prioridades: Focando no que Realmente Importa', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 06 – Multiplicando Seu Tempo › Aula 01 – Matriz de Prioridades: Focando no que Realmente Importa › Pontos para o suporte

- "Não tenho tempo para nada." Fazer a auditoria de 1 a 2 dias e classificar as atividades. Geralmente aparece tempo perdido no quadrante 4 (distrações) e no 3 (urgências sem importância).
- "O que faço primeiro?" Primeiro o urgente e importante. O foco diário deve ir para o importante, não urgente.
- "Não tenho para quem delegar." No quadrante 3, a saída é dizer não, adiar ou agrupar (por exemplo, responder mensagens em horários fixos).', 'approved', ARRAY['matriz de prioridades','matriz de Eisenhower','urgente × importante','4 quadrantes','gestão de prioridades','gestão de tempo','falta de tempo','auditoria do tempo','registrar atividades','delegar','dizer não','eliminar distrações','apagar incêndios']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M06.A03-01', 'principal', 2, 6, 'V2.M06.A03 — Arquitetura de Projetos: Do Caos à Execução', 'Visão geral', 'Arquitetura de Projetos: Do Caos à Execução', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 06 – Multiplicando Seu Tempo › Aula 03 – Arquitetura de Projetos: Do Caos à Execução › Visão geral da aula

Nome oficial da aula: Arquitetura de Projetos: Do Caos à Execução
Onde fica: Vitrine 2 (I BÔNUS – Skill''s das Demandas Lucrativas), Módulo 06 – Multiplicando Seu Tempo, Aula 03
Duração/formato: 2:13
Link na área de membros (abre a página do Módulo 06, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/2/23

Resumo:
A aula diz que inicia a "fase 2" do módulo, voltada a gestão de projetos, e se propõe a mostrar "como encontrar oportunidades nesse nicho usando as habilidades que você já tem". Ensina 4 ferramentas de quem lidera projetos:
1. planejamento reverso;
2. divisão em marcos;
3. prazos e responsabilidades definidos;
4. cronograma realista com margem de segurança.
Fecha com o exemplo de uma campanha em 3 meses planejada de trás para frente.', 'approved', ARRAY['gestão de projetos','gerenciamento de projetos','liderar projeto','planejamento reverso','de trás para frente','backward planning','marcos','milestones','etapas','prazos e responsabilidades','quem faz o quê até quando','cronograma','margem de segurança','imprevistos','fase 2','reunião de alinhamento','lançamento','campanha']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M06.A03-02', 'principal', 2, 6, 'V2.M06.A03 — Arquitetura de Projetos: Do Caos à Execução', 'Procedimento: passo a passo', 'Arquitetura de Projetos: Do Caos à Execução', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 06 – Multiplicando Seu Tempo › Aula 03 – Arquitetura de Projetos: Do Caos à Execução › Procedimento: passo a passo

### 1. Planejamento reverso
- Partir do resultado final e voltar no tempo.
- Exemplo: lançar um produto em 6 meses. O que precisa estar pronto até lá? Pesquisa de público, produto finalizado, campanha.
- Desmontar cada passo em ações menores. Exemplo, a pesquisa: definir o público › escolher quem fará a coleta › analisar os dados.
### 2. Dividir em marcos
- Em projetos complexos, dividir o trabalho em marcos (entregas intermediárias), cada um com resultado claro e prático.
- Exemplo (lançamento): produto pronto › equipe de vendas treinada › divulgação organizada.
  - "Equipe treinada" exige criar e aplicar um treinamento específico.
### 3. Definir prazos e responsabilidades
- Quem faz o quê e até quando, para evitar confusão e garantir a execução.
### 4. Cronograma realista com margem de segurança
- Regra da aula: se uma tarefa leva 5 dias, planejar 7, uma folga de cerca de 40% para imprevistos.', 'approved', ARRAY['gestão de projetos','gerenciamento de projetos','liderar projeto','planejamento reverso','de trás para frente','backward planning','marcos','milestones','etapas','prazos e responsabilidades','quem faz o quê até quando','cronograma','margem de segurança','imprevistos','fase 2','reunião de alinhamento','lançamento','campanha']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M06.A03-03', 'principal', 2, 6, 'V2.M06.A03 — Arquitetura de Projetos: Do Caos à Execução', 'Exemplo prático: campanha em 3 meses (de trás para frente)', 'Arquitetura de Projetos: Do Caos à Execução', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 06 – Multiplicando Seu Tempo › Aula 03 – Arquitetura de Projetos: Do Caos à Execução › Exemplo prático: campanha em 3 meses (de trás para frente)

| Quando | O que precisa estar pronto |
|---|---|
| Dia D | Lançamento da campanha |
| 2 semanas antes | Materiais prontos |
| 1 mês antes | Conceito criativo definido |
| … | Retroceder sucessivamente |
| Início | Reunião de alinhamento |
Dividir em etapas claras permite ajustar a rota rapidamente se algo sair do plano.
"Liderar é ter clareza, método e saber guiar as pessoas."', 'approved', ARRAY['gestão de projetos','gerenciamento de projetos','liderar projeto','planejamento reverso','de trás para frente','backward planning','marcos','milestones','etapas','prazos e responsabilidades','quem faz o quê até quando','cronograma','margem de segurança','imprevistos','fase 2','reunião de alinhamento','lançamento','campanha']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M06.A03-04', 'principal', 2, 6, 'V2.M06.A03 — Arquitetura de Projetos: Do Caos à Execução', 'FAQ', 'Arquitetura de Projetos: Do Caos à Execução', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 06 – Multiplicando Seu Tempo › Aula 03 – Arquitetura de Projetos: Do Caos à Execução › Pontos para o suporte

- "O que é planejamento reverso?" Começar pela data e pelo resultado final e voltar no tempo, definindo o que precisa estar pronto em cada etapa.
- "Como evito atrasar entregas?" Planejar com margem de segurança: se uma tarefa leva 5 dias, prometer 7.
- "O que são marcos?" Entregas intermediárias do projeto, cada uma com um resultado claro.
- "Como acho trabalhos de gestão de projetos?" A aula não explica.', 'approved', ARRAY['gestão de projetos','gerenciamento de projetos','liderar projeto','planejamento reverso','de trás para frente','backward planning','marcos','milestones','etapas','prazos e responsabilidades','quem faz o quê até quando','cronograma','margem de segurança','imprevistos','fase 2','reunião de alinhamento','lançamento','campanha']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M06.A04-01', 'principal', 2, 6, 'V2.M06.A04 — Gestão Inteligente: Produtividade e Prazos', 'Visão geral', 'Gestão Inteligente: Produtividade e Prazos', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 06 – Multiplicando Seu Tempo › Aula 04 – Gestão Inteligente: Produtividade e Prazos › Visão geral da aula

Nome oficial da aula: Gestão Inteligente: Produtividade e Prazos
Onde fica: Vitrine 2 (I BÔNUS – Skill''s das Demandas Lucrativas), Módulo 06 – Multiplicando Seu Tempo, Aula 04
Duração/formato: 4:30
Link na área de membros (abre a página do Módulo 06, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/2/23

Resumo:
Continua o tema de liderar projetos, unindo duas ideias:
1. Fazer mais com menos: os recursos (tempo, dinheiro, equipe, ferramentas) sempre serão limitados, então é preciso usá-los de forma estratégica, sem trabalhar mais horas.
2. Acompanhamento inteligente: um sistema de pontos de controle com 4 métricas (prazo, qualidade, escopo, satisfação) e técnicas de pivotagem quando algo sai do plano.', 'approved', ARRAY['fazer mais com menos','recursos limitados','otimizar recursos','otimizar processos','desperdício','reuniões curtas com pauta','delegar','distribuir tarefas','acompanhamento','pontos de controle','reuniões de revisão','checkpoints','prazo, qualidade, escopo, satisfação','checklist','lista de verificação','escopo','mudança de escopo','scope creep','pivotar','pivotagem','ajustar a rota','plano B']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M06.A04-02', 'principal', 2, 6, 'V2.M06.A04 — Gestão Inteligente: Produtividade e Prazos', 'Parte 1: Fazer mais com menos (4 passos)', 'Gestão Inteligente: Produtividade e Prazos', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 06 – Multiplicando Seu Tempo › Aula 04 – Gestão Inteligente: Produtividade e Prazos › Parte 1: Fazer mais com menos (4 passos)

| # | Passo | Como aplicar | Exemplo da aula |
|---|---|---|---|
| 1 | Clareza de prioridades | Perguntar: "Qual é o resultado mais importante que eu preciso entregar agora?" | Aumentar vendas com orçamento limitado: focar no que dá mais retorno (um treinamento específico), em vez de atirar para todos os lados |
| 2 | Otimizar processos | Mapear o que é feito e perguntar: "Isso é realmente necessário?" O problema costuma ser desperdício, não falta de recurso. | Reuniões longas e improdutivas › reuniões curtas com pauta e objetivo |
| 3 | Delegar | Confiar nas pessoas e dar a elas as ferramentas. Fazer tudo sozinha sobrecarrega. | Campanha: uma pessoa no texto, outra no visual, e você alinha a estratégia |
| 4 | Medir resultados | Manter o que funciona, cortar o que não funciona e redirecionar recursos para o que dá certo | "Ajustar as velas do barco para aproveitar o vento" |', 'approved', ARRAY['fazer mais com menos','recursos limitados','otimizar recursos','otimizar processos','desperdício','reuniões curtas com pauta','delegar','distribuir tarefas','acompanhamento','pontos de controle','reuniões de revisão','checkpoints','prazo, qualidade, escopo, satisfação','checklist','lista de verificação','escopo','mudança de escopo','scope creep','pivotar','pivotagem','ajustar a rota','plano B']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M06.A04-03', 'principal', 2, 6, 'V2.M06.A04 — Gestão Inteligente: Produtividade e Prazos', 'Parte 2: Acompanhamento inteligente', 'Gestão Inteligente: Produtividade e Prazos', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 06 – Multiplicando Seu Tempo › Aula 04 – Gestão Inteligente: Produtividade e Prazos › Parte 2: Acompanhamento inteligente

"Acompanhar não é só perguntar ''e aí, tá tudo bem?''. É ter um sistema claro."
### Procedimento
1. Dividir o trabalho em etapas e definir pontos de controle. Exemplo: campanha de 3 meses › reuniões de revisão a cada 2 semanas (o que foi feito, o que falta, quais são os bloqueios).
2. Em cada ponto de controle, monitorar 4 métricas:
| Métrica | O que verificar | Ação |
|---|---|---|
| Prazo | Há atrasos? | Descobrir cedo; redistribuir tarefas ou buscar ajuda extra |
| Qualidade | Está no padrão? | Usar checklists com os elementos obrigatórios |
| Escopo | Está dentro do combinado no início? | Evitar adicionar coisas no meio do caminho; avaliar se a mudança é necessária |
| Satisfação | Equipe motivada? Cliente satisfeito? | Ouvir as pessoas e ajustar |
### Pivotagem (quando sai do planejado)
1. Identificar o problema e a causa real (sobrecarga? imprevisto?).
2. Avaliar as opções.
3. Comunicar a mudança a todos os envolvidos (o passo mais importante).
- Exemplo: o fornecedor atrasou › buscar outro fornecedor rapidamente ou ajustar o cronograma, sempre avisando a equipe com clareza.
"Use as limitações como impulso para ser mais estratégica."', 'approved', ARRAY['fazer mais com menos','recursos limitados','otimizar recursos','otimizar processos','desperdício','reuniões curtas com pauta','delegar','distribuir tarefas','acompanhamento','pontos de controle','reuniões de revisão','checkpoints','prazo, qualidade, escopo, satisfação','checklist','lista de verificação','escopo','mudança de escopo','scope creep','pivotar','pivotagem','ajustar a rota','plano B']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M06.A04-04', 'principal', 2, 6, 'V2.M06.A04 — Gestão Inteligente: Produtividade e Prazos', 'FAQ', 'Gestão Inteligente: Produtividade e Prazos', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 06 – Multiplicando Seu Tempo › Aula 04 – Gestão Inteligente: Produtividade e Prazos › Pontos para o suporte

- "Estou sobrecarregada no projeto." Revisar prioridades (qual o resultado mais importante agora?), cortar o desnecessário e, se possível, delegar.
- "O cliente fica pedindo coisas a mais." É mudança de escopo. Avaliar se é necessária e, se for, renegociar prazo ou valor. O ajuste de valor é uma sugestão da documentação; a aula fala só em avaliar a necessidade.
- "Como acompanho um projeto longo?" Pontos de controle (por exemplo, a cada 2 semanas) checando prazo, qualidade, escopo e satisfação.
- "Deu tudo errado, e agora?" Pivotar: entender a causa, avaliar opções e comunicar a mudança a todos.', 'approved', ARRAY['fazer mais com menos','recursos limitados','otimizar recursos','otimizar processos','desperdício','reuniões curtas com pauta','delegar','distribuir tarefas','acompanhamento','pontos de controle','reuniões de revisão','checkpoints','prazo, qualidade, escopo, satisfação','checklist','lista de verificação','escopo','mudança de escopo','scope creep','pivotar','pivotagem','ajustar a rota','plano B']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M06.A05-01', 'principal', 2, 6, 'V2.M06.A05 — Certificação em Gestão Integrada de Tempo e Projetos', 'Visão geral', 'Certificação em Gestão Integrada de Tempo e Projetos', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 06 – Multiplicando Seu Tempo › Aula 05 – Certificação em Gestão Integrada de Tempo e Projetos › Visão geral da aula

Nome oficial da aula: Certificação em Gestão Integrada de Tempo e Projetos
Onde fica: Vitrine 2 (I BÔNUS – Skill''s das Demandas Lucrativas), Módulo 06 – Multiplicando Seu Tempo, Aula 05
Duração/formato: 1:49
Link na área de membros (abre a página do Módulo 06, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/2/23

Resumo:
É a aula de encerramento do Módulo 06. Diferente das outras certificações, ela propõe um projeto final com 2 objetivos:
1. implementar um sistema pessoal de organização;
2. aplicar o aprendizado num projeto real, do início ao fim.
A partir disso, a aluna cria a sua metodologia personalizada de produtividade. É também a primeira aula de certificação que diz onde emitir o certificado: "aqui, abaixo dessa aula".', 'approved', ARRAY['certificado','certificação','certificado oficial','emitir certificado','abaixo da aula','gestão integrada de tempo e liderança','tempo e projetos','projeto final','sistema pessoal de organização','metodologia personalizada de produtividade','buffers','margem de segurança','planejamento reverso','divisão em etapas','rotina de revisão','documentar o processo']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M06.A05-02', 'principal', 2, 6, 'V2.M06.A05 — Certificação em Gestão Integrada de Tempo e Projetos', 'Procedimento: projeto final', 'Certificação em Gestão Integrada de Tempo e Projetos', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 06 – Multiplicando Seu Tempo › Aula 05 – Certificação em Gestão Integrada de Tempo e Projetos › Procedimento: projeto final

### Objetivo 1: sistema pessoal de organização
"Ninguém lidera de forma eficiente sem antes organizar a própria vida."
1. Revisar as ferramentas do módulo que mais fizeram sentido: planejamento reverso (A03), divisão em etapas e marcos (A03), buffers ou margens de segurança para imprevistos (A03). Também cabem a matriz de prioridades (A01) e hábitos e KPIs (A02).
2. Escolher o que funciona e aplicar em algo da rotina, como a agenda ou uma entrega importante.
3. Testar e ajustar.
### Objetivo 2: projeto real
1. Liderar algo do início ao fim, no trabalho ou na vida pessoal.
2. Aplicar planejamento, métricas e ajustes (A03 e A04).
3. Documentar todo o processo, para avaliar a evolução.
### Metodologia própria
- Combinar as ferramentas "com a sua cara".
- Estabelecer rotinas de revisão que consiga manter com consistência.
### Emitir o certificado
- Emitir o certificado "aqui, abaixo dessa aula", na área de membros.
Resumo da aula: criar o sistema › aplicar num projeto real › desenvolver a metodologia › conquistar o certificado.', 'approved', ARRAY['certificado','certificação','certificado oficial','emitir certificado','abaixo da aula','gestão integrada de tempo e liderança','tempo e projetos','projeto final','sistema pessoal de organização','metodologia personalizada de produtividade','buffers','margem de segurança','planejamento reverso','divisão em etapas','rotina de revisão','documentar o processo']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M06.A05-03', 'principal', 2, 6, 'V2.M06.A05 — Certificação em Gestão Integrada de Tempo e Projetos', 'FAQ', 'Certificação em Gestão Integrada de Tempo e Projetos', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 06 – Multiplicando Seu Tempo › Aula 05 – Certificação em Gestão Integrada de Tempo e Projetos › Pontos para o suporte

- "Como pego meu certificado?" Segundo a aula, ele é emitido abaixo desta aula, na área de membros.
- "Preciso entregar o projeto final para alguém?" A aula não pede envio nem avaliação. É um exercício pessoal. Confirmar se o certificado depende dele.
- "Que projeto real eu faço?" Qualquer um com começo, meio e fim: uma entrega para cliente, a organização de um evento, uma mudança na rotina da casa.
- "O que são buffers?" São margens de segurança no prazo. Exemplo da A03: se uma tarefa leva 5 dias, planejar 7.', 'approved', ARRAY['certificado','certificação','certificado oficial','emitir certificado','abaixo da aula','gestão integrada de tempo e liderança','tempo e projetos','projeto final','sistema pessoal de organização','metodologia personalizada de produtividade','buffers','margem de segurança','planejamento reverso','divisão em etapas','rotina de revisão','documentar o processo']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M07.A01-01', 'principal', 2, 7, 'V2.M07.A01 — UGC: Entendendo o Negócio por Trás do Conteúdo', 'Visão geral', 'UGC: Entendendo o Negócio por Trás do Conteúdo', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 07 – UGC Monetizando Sua Autenticidade › Aula 01 – UGC: Entendendo o Negócio por Trás do Conteúdo › Visão geral da aula

Nome oficial da aula: UGC: Entendendo o Negócio por Trás do Conteúdo
Onde fica: Vitrine 2 (I BÔNUS – Skill''s das Demandas Lucrativas), Módulo 07 – UGC Monetizando Sua Autenticidade, Aula 01
Duração/formato: PDF (6 páginas)
Link na área de membros (abre a página do Módulo 07, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/2/24

Resumo:
É a aula de abertura do Módulo 07, em PDF, sem vídeo. Explica o que é UGC (User Generated Content): não é ser influencer, é prestação de serviço. Empresas pagam pessoas comuns para gravar vídeos simples, em estilo de depoimento, que geram identificação e confiança. A criadora grava, entrega e recebe, sem precisar postar no próprio perfil, ter seguidores ou engajamento. O PDF também apresenta o mercado como "consolidado e em alta" e lista o que o módulo vai ensinar.', 'approved', ARRAY['UGC','User Generated Content','conteúdo gerado pelo usuário','criadora UGC','creator UGC','vídeo de depoimento','vídeo estilo depoimento','conteúdo autêntico','prestação de serviço','gravar e entregar','não precisa postar','influencer × UGC','seguidores','engajamento']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M07.A01-02', 'principal', 2, 7, 'V2.M07.A01 — UGC: Entendendo o Negócio por Trás do Conteúdo', 'O que é UGC', 'UGC: Entendendo o Negócio por Trás do Conteúdo', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 07 – UGC Monetizando Sua Autenticidade › Aula 01 – UGC: Entendendo o Negócio por Trás do Conteúdo › O que é UGC

| UGC não é | UGC é |
|---|---|
| Ser influencer | Prestação de serviço |
| Ter seguidores | Empresas pagando pessoas comuns |
| Se expor no próprio perfil | Vídeos simples, parecidos com depoimentos reais |
Por que as empresas querem: "as pessoas não acreditam mais em propagandas perfeitas, mas confiam em gente real."', 'approved', ARRAY['UGC','User Generated Content','conteúdo gerado pelo usuário','criadora UGC','creator UGC','vídeo de depoimento','vídeo estilo depoimento','conteúdo autêntico','prestação de serviço','gravar e entregar','não precisa postar','influencer × UGC','seguidores','engajamento']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M07.A01-03', 'principal', 2, 7, 'V2.M07.A01 — UGC: Entendendo o Negócio por Trás do Conteúdo', 'Como funciona (o fluxo)', 'UGC: Entendendo o Negócio por Trás do Conteúdo', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 07 – UGC Monetizando Sua Autenticidade › Aula 01 – UGC: Entendendo o Negócio por Trás do Conteúdo › Como funciona (o fluxo)

1. Você grava o vídeo (com o celular).
2. Entrega para a empresa.
3. Recebe pelo serviço.
Não precisa: postar no seu perfil, ter engajamento ou aparecer todos os dias.', 'approved', ARRAY['UGC','User Generated Content','conteúdo gerado pelo usuário','criadora UGC','creator UGC','vídeo de depoimento','vídeo estilo depoimento','conteúdo autêntico','prestação de serviço','gravar e entregar','não precisa postar','influencer × UGC','seguidores','engajamento']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M07.A01-04', 'principal', 2, 7, 'V2.M07.A01 — UGC: Entendendo o Negócio por Trás do Conteúdo', 'Por que o UGC funciona', 'UGC: Entendendo o Negócio por Trás do Conteúdo', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 07 – UGC Monetizando Sua Autenticidade › Aula 01 – UGC: Entendendo o Negócio por Trás do Conteúdo › Por que o UGC funciona

- Confiança em pessoas reais: consumidores preferem conteúdo autêntico a propagandas polidas.
- Simplicidade: vídeos gravados com celular bastam.', 'approved', ARRAY['UGC','User Generated Content','conteúdo gerado pelo usuário','criadora UGC','creator UGC','vídeo de depoimento','vídeo estilo depoimento','conteúdo autêntico','prestação de serviço','gravar e entregar','não precisa postar','influencer × UGC','seguidores','engajamento']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M07.A01-05', 'principal', 2, 7, 'V2.M07.A01 — UGC: Entendendo o Negócio por Trás do Conteúdo', 'O mercado (segundo o PDF)', 'UGC: Entendendo o Negócio por Trás do Conteúdo', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 07 – UGC Monetizando Sua Autenticidade › Aula 01 – UGC: Entendendo o Negócio por Trás do Conteúdo › O mercado (segundo o PDF)

- Consolidado e em alta, mas "falta mão de obra qualificada".
- Oportunidade para iniciantes: quem sabe gravar vídeos simples "já tem o principal requisito". O resto é método.', 'approved', ARRAY['UGC','User Generated Content','conteúdo gerado pelo usuário','criadora UGC','creator UGC','vídeo de depoimento','vídeo estilo depoimento','conteúdo autêntico','prestação de serviço','gravar e entregar','não precisa postar','influencer × UGC','seguidores','engajamento']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M07.A01-06', 'principal', 2, 7, 'V2.M07.A01 — UGC: Entendendo o Negócio por Trás do Conteúdo', 'O que o módulo vai ensinar', 'UGC: Entendendo o Negócio por Trás do Conteúdo', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 07 – UGC Monetizando Sua Autenticidade › Aula 01 – UGC: Entendendo o Negócio por Trás do Conteúdo › O que o módulo vai ensinar

1. Onde estão as empresas que contratam UGC.
2. Como elas contratam.
3. Como entrar no mercado, mesmo começando do zero.', 'approved', ARRAY['UGC','User Generated Content','conteúdo gerado pelo usuário','criadora UGC','creator UGC','vídeo de depoimento','vídeo estilo depoimento','conteúdo autêntico','prestação de serviço','gravar e entregar','não precisa postar','influencer × UGC','seguidores','engajamento']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M07.A01-07', 'principal', 2, 7, 'V2.M07.A01 — UGC: Entendendo o Negócio por Trás do Conteúdo', 'FAQ', 'UGC: Entendendo o Negócio por Trás do Conteúdo', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 07 – UGC Monetizando Sua Autenticidade › Aula 01 – UGC: Entendendo o Negócio por Trás do Conteúdo › Pontos para o suporte

- "O que é UGC?" Um serviço: você grava vídeos simples, em estilo de depoimento, para empresas usarem na divulgação delas, e recebe por isso.
- "Preciso ter seguidores?" Não. O vídeo é entregue à empresa. Não precisa postar no seu perfil.
- "Preciso de equipamento?" Segundo o PDF, o celular basta. Ver também o Módulo 03 (Pocket Studio) para iluminação, enquadramento e edição.
- "Onde acho empresas?" Nas próximas aulas deste módulo.
- "Quanto se ganha?" O PDF não fala de valores. Não prometer números.', 'approved', ARRAY['UGC','User Generated Content','conteúdo gerado pelo usuário','criadora UGC','creator UGC','vídeo de depoimento','vídeo estilo depoimento','conteúdo autêntico','prestação de serviço','gravar e entregar','não precisa postar','influencer × UGC','seguidores','engajamento']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M07.A02-01', 'principal', 2, 7, 'V2.M07.A02 — Ecossistema UGC: Onde Encontrar Marcas que Pagam', 'Visão geral', 'Ecossistema UGC: Onde Encontrar Marcas que Pagam', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 07 – UGC Monetizando Sua Autenticidade › Aula 02 – Ecossistema UGC: Onde Encontrar Marcas que Pagam › Visão geral da aula

Nome oficial da aula: Ecossistema UGC: Onde Encontrar Marcas que Pagam
Onde fica: Vitrine 2 (I BÔNUS – Skill''s das Demandas Lucrativas), Módulo 07 – UGC Monetizando Sua Autenticidade, Aula 02
Duração/formato: PDF (6 páginas)
Link na área de membros (abre a página do Módulo 07, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/2/24

Resumo:
Aula em PDF, sem vídeo. Aponta o maior erro de quem começa em UGC: mandar direct para marcas no Instagram. Segundo o PDF, as empresas que pagam por UGC estão em plataformas próprias, não nas redes sociais. Apresenta a plataforma MIS como ferramenta principal: as empresas publicam campanhas com briefing, quantidade de vídeos e prazo, e as criadoras se candidatam, sem precisar "convencer ou se vender". "O segredo não é convencer empresas, mas se posicionar no lugar certo."', 'approved', ARRAY['MIS','MIS app','MIS - Marketing de Influência','mis-app.com','Miss','M.I.S','plataforma de UGC','campanhas','candidatar-se','briefing','prazo','quantidade de vídeos','perfil de criadora','descrição','subir vídeos','portfólio','mandar direct para marcas','prospecção no Instagram']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M07.A02-02', 'principal', 2, 7, 'V2.M07.A02 — Ecossistema UGC: Onde Encontrar Marcas que Pagam', 'Procedimento: entrar na MIS', 'Ecossistema UGC: Onde Encontrar Marcas que Pagam', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 07 – UGC Monetizando Sua Autenticidade › Aula 02 – Ecossistema UGC: Onde Encontrar Marcas que Pagam › Procedimento: entrar na MIS

1. Baixar o app da MIS no celular. Na App Store aparece como "MIS - Marketing de Influência".
2. Criar a conta: cadastro simples com nome, e-mail e país.
3. Completar o perfil com uma descrição curta e objetiva. Modelo do PDF: "Criadora de UGC focada em vídeos naturais para anúncios."
4. Subir seus vídeos: vídeos simples, "sem necessidade de portfólio perfeito".', 'approved', ARRAY['MIS','MIS app','MIS - Marketing de Influência','mis-app.com','Miss','M.I.S','plataforma de UGC','campanhas','candidatar-se','briefing','prazo','quantidade de vídeos','perfil de criadora','descrição','subir vídeos','portfólio','mandar direct para marcas','prospecção no Instagram']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M07.A02-03', 'principal', 2, 7, 'V2.M07.A02 — Ecossistema UGC: Onde Encontrar Marcas que Pagam', 'Procedimento: participar das campanhas', 'Ecossistema UGC: Onde Encontrar Marcas que Pagam', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 07 – UGC Monetizando Sua Autenticidade › Aula 02 – Ecossistema UGC: Onde Encontrar Marcas que Pagam › Procedimento: participar das campanhas

1. Dentro do app, ver as campanhas disponíveis. Cada uma mostra:
| Item | O que é |
|---|---|
| Briefing | O que a empresa precisa |
| Quantidade de vídeos | Quantos vídeos entregar |
| Prazo | Data limite de entrega |
1. Analisar e decidir se a campanha faz sentido para você.
2. Candidatar-se. Não é preciso mandar mensagens para marcas.', 'approved', ARRAY['MIS','MIS app','MIS - Marketing de Influência','mis-app.com','Miss','M.I.S','plataforma de UGC','campanhas','candidatar-se','briefing','prazo','quantidade de vídeos','perfil de criadora','descrição','subir vídeos','portfólio','mandar direct para marcas','prospecção no Instagram']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M07.A02-04', 'principal', 2, 7, 'V2.M07.A02 — Ecossistema UGC: Onde Encontrar Marcas que Pagam', 'FAQ', 'Ecossistema UGC: Onde Encontrar Marcas que Pagam', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 07 – UGC Monetizando Sua Autenticidade › Aula 02 – Ecossistema UGC: Onde Encontrar Marcas que Pagam › Pontos para o suporte

- "Onde encontro marcas que pagam por UGC?" Segundo a aula, na plataforma MIS (app "MIS - Marketing de Influência"), em vez de mandar direct para marcas.
- "Preciso de portfólio para começar?" Não precisa ser perfeito: vídeos simples já servem. Ver o Módulo 03 para gravar e editar no celular.
- "O que escrevo no perfil?" Algo curto, como "Criadora de UGC focada em vídeos naturais para anúncios."
- "Quanto paga uma campanha?" O PDF não informa valores nem como funciona o pagamento ou o saque. Não prometer números.
- "Fui recusada / não recebo campanhas." O PDF não trata disso.', 'approved', ARRAY['MIS','MIS app','MIS - Marketing de Influência','mis-app.com','Miss','M.I.S','plataforma de UGC','campanhas','candidatar-se','briefing','prazo','quantidade de vídeos','perfil de criadora','descrição','subir vídeos','portfólio','mandar direct para marcas','prospecção no Instagram']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M07.A03-01', 'principal', 2, 7, 'V2.M07.A03 — Vitrine Criativa: Construindo Portfólio que Vende Sozinho', 'Visão geral', 'Vitrine Criativa: Construindo Portfólio que Vende Sozinho', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 07 – UGC Monetizando Sua Autenticidade › Aula 03 – Vitrine Criativa: Construindo Portfólio que Vende Sozinho › Visão geral da aula

Nome oficial da aula: Vitrine Criativa: Construindo Portfólio que Vende Sozinho
Onde fica: Vitrine 2 (I BÔNUS – Skill''s das Demandas Lucrativas), Módulo 07 – UGC Monetizando Sua Autenticidade, Aula 03
Duração/formato: PDF (5 páginas)
Link na área de membros (abre a página do Módulo 07, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/2/24

Resumo:
É uma aula em PDF, sem vídeo. Explica que, em UGC, o portfólio não é currículo: ele não mostra onde você trabalhou, é uma prova de execução de que você sabe gravar vídeos simples, autênticos e diretos. As empresas não exigem experiência prévia com marcas. Ensina a gravar vídeos de portfólio com produtos que já tem em casa, seguindo a estrutura problema › uso › benefício, e a montar o portfólio no Canva, gerando um link para compartilhar. Recado principal: não esperar perfeição.', 'approved', ARRAY['portfólio','vitrine','prova de execução','produtos de casa','skincare','cabelo','roupas','acessórios','estrutura problema › uso › benefício','Canva','modelo limpo','link do portfólio','compartilhar link','criadora de UGC','vídeos naturais']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M07.A03-02', 'principal', 2, 7, 'V2.M07.A03 — Vitrine Criativa: Construindo Portfólio que Vende Sozinho', 'Procedimento: passo a passo', 'Vitrine Criativa: Construindo Portfólio que Vende Sozinho', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 07 – UGC Monetizando Sua Autenticidade › Aula 03 – Vitrine Criativa: Construindo Portfólio que Vende Sozinho › Procedimento: passo a passo

### 1. Gravar os vídeos de portfólio
1. Escolher produtos que já tem em casa: skincare, cabelo, roupas, acessórios.
2. Gravar seguindo a estrutura básica:
| Etapa | O que mostrar |
|---|---|
| Problema | O problema que o produto resolve |
| Uso | Como o produto é usado |
| Benefício | O resultado ou benefício final |
(Para gravar e editar no celular, ver o Módulo 03 – Pocket Studio.)
### 2. Montar o portfólio no Canva
1. Escolher um modelo limpo e profissional.
2. Adicionar:
  - seu nome;
  - o que você faz, por exemplo "Criadora de UGC focada em vídeos naturais";
  - seus vídeos, um por página, sem poluição visual.
3. Gerar um link para compartilhar como portfólio profissional.
### 3. Usar o portfólio
- Subir os vídeos e o link no perfil da plataforma MIS (ver a Vitrine 2, Módulo 07, Aula 02) e enviar quando pedirem.', 'approved', ARRAY['portfólio','vitrine','prova de execução','produtos de casa','skincare','cabelo','roupas','acessórios','estrutura problema › uso › benefício','Canva','modelo limpo','link do portfólio','compartilhar link','criadora de UGC','vídeos naturais']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M07.A03-03', 'principal', 2, 7, 'V2.M07.A03 — Vitrine Criativa: Construindo Portfólio que Vende Sozinho', 'Dicas do PDF', 'Vitrine Criativa: Construindo Portfólio que Vende Sozinho', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 07 – UGC Monetizando Sua Autenticidade › Aula 03 – Vitrine Criativa: Construindo Portfólio que Vende Sozinho › Dicas do PDF

- Não espere perfeição: um portfólio simples já mostra a habilidade.
- Praticidade acima de tudo: "Empresas querem autenticidade, não vídeos perfeitos."', 'approved', ARRAY['portfólio','vitrine','prova de execução','produtos de casa','skincare','cabelo','roupas','acessórios','estrutura problema › uso › benefício','Canva','modelo limpo','link do portfólio','compartilhar link','criadora de UGC','vídeos naturais']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M07.A03-04', 'principal', 2, 7, 'V2.M07.A03 — Vitrine Criativa: Construindo Portfólio que Vende Sozinho', 'FAQ', 'Vitrine Criativa: Construindo Portfólio que Vende Sozinho', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 07 – UGC Monetizando Sua Autenticidade › Aula 03 – Vitrine Criativa: Construindo Portfólio que Vende Sozinho › Pontos para o suporte

- "Não tenho experiência com marcas, como faço portfólio?" Gravar com produtos que já tem em casa, na estrutura problema › uso › benefício. Não precisa de experiência prévia.
- "Quantos vídeos coloco?" O PDF não define. Sugestão: começar com 3 a 5 vídeos de nichos diferentes. A quantidade é sugestão da documentação e precisa ser validada.
- "Como monto o portfólio?" No Canva: modelo limpo › nome › o que faz › um vídeo por página › gerar link para compartilhar.
- "Meus vídeos não estão perfeitos." O PDF reforça que as empresas querem autenticidade, não perfeição.', 'approved', ARRAY['portfólio','vitrine','prova de execução','produtos de casa','skincare','cabelo','roupas','acessórios','estrutura problema › uso › benefício','Canva','modelo limpo','link do portfólio','compartilhar link','criadora de UGC','vídeos naturais']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M07.A04-01', 'principal', 2, 7, 'V2.M07.A04 — Propostas que Fecham Contratos', 'Visão geral', 'Propostas que Fecham Contratos', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 07 – UGC Monetizando Sua Autenticidade › Aula 04 – Propostas que Fecham Contratos › Visão geral da aula

Nome oficial da aula: Propostas que Fecham Contratos
Onde fica: Vitrine 2 (I BÔNUS – Skill''s das Demandas Lucrativas), Módulo 07 – UGC Monetizando Sua Autenticidade, Aula 04
Duração/formato: PDF (5 páginas)
Link na área de membros (abre a página do Módulo 07, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/2/24

Resumo:
É uma aula em PDF, sem vídeo, e curta. Propõe uma mudança de mentalidade: "Você não está pedindo oportunidade. Está oferecendo um serviço." Ensina a candidatar-se a campanhas na MIS com uma mensagem curta e objetiva, que traz o prazo de entrega e o link do portfólio. Defende que mensagens curtas transmitem profissionalismo e explicações longas podem passar insegurança.', 'approved', ARRAY['proposta','candidatura','aplicar','botão Aplicar','se candidatar','MIS','plataforma MIS','campanha','mensagem objetiva','mensagem curta','modelo de proposta','link do portfólio','prazo de entrega','entrego em X dias']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M07.A04-02', 'principal', 2, 7, 'V2.M07.A04 — Propostas que Fecham Contratos', 'Procedimento: candidatar-se a uma campanha', 'Propostas que Fecham Contratos', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 07 – UGC Monetizando Sua Autenticidade › Aula 04 – Propostas que Fecham Contratos › Procedimento: candidatar-se a uma campanha

1. Escolher uma campanha na plataforma MIS (ver a Vitrine 2, Módulo 07, Aula 02).
2. Clicar em "Aplicar".
3. Escrever uma mensagem objetiva. Modelo do PDF: "Olá, posso gravar os vídeos conforme solicitado. Entrego em X dias. Segue meu portfólio."
4. Colar o link do portfólio (Canva, ver a Vitrine 2, Módulo 07, Aula 03).
5. Enviar.', 'approved', ARRAY['proposta','candidatura','aplicar','botão Aplicar','se candidatar','MIS','plataforma MIS','campanha','mensagem objetiva','mensagem curta','modelo de proposta','link do portfólio','prazo de entrega','entrego em X dias']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M07.A04-03', 'principal', 2, 7, 'V2.M07.A04 — Propostas que Fecham Contratos', 'Dicas do PDF', 'Propostas que Fecham Contratos', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 07 – UGC Monetizando Sua Autenticidade › Aula 04 – Propostas que Fecham Contratos › Dicas do PDF

| Dica | Por quê |
|---|---|
| Seja direta | Mensagens curtas transmitem profissionalismo. Explicações longas podem passar insegurança. |
| Foco na execução | "Empresas valorizam quem entrega resultados, não quem ''fala bonito''." |
| Mostre que entendeu o pedido | Deixar claro que entendeu o que foi solicitado e que pode executar |
| Destaque o prazo | O prazo de entrega é um dos pontos centrais da mensagem |', 'approved', ARRAY['proposta','candidatura','aplicar','botão Aplicar','se candidatar','MIS','plataforma MIS','campanha','mensagem objetiva','mensagem curta','modelo de proposta','link do portfólio','prazo de entrega','entrego em X dias']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M07.A04-04', 'principal', 2, 7, 'V2.M07.A04 — Propostas que Fecham Contratos', 'FAQ', 'Propostas que Fecham Contratos', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 07 – UGC Monetizando Sua Autenticidade › Aula 04 – Propostas que Fecham Contratos › Pontos para o suporte

- "O que escrevo na candidatura?" Uma mensagem curta: "Olá, posso gravar os vídeos conforme solicitado. Entrego em X dias. Segue meu portfólio." Depois, o link do portfólio.
- "Que prazo coloco?" Um prazo que consiga cumprir com folga. Ver a margem de segurança da Vitrine 2, Módulo 06, Aula 03: se leva 5 dias, prometer 7.
- "Quanto devo cobrar?" O PDF não fala de preço nem se a campanha já vem com valor definido.
- "Me candidatei e não fui chamada." O PDF não trata disso.', 'approved', ARRAY['proposta','candidatura','aplicar','botão Aplicar','se candidatar','MIS','plataforma MIS','campanha','mensagem objetiva','mensagem curta','modelo de proposta','link do portfólio','prazo de entrega','entrego em X dias']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M07.A05-01', 'principal', 2, 7, 'V2.M07.A05 — Produção Inteligente: Máxima Qualidade, Mínimo Equipamento', 'Visão geral', 'Produção Inteligente: Máxima Qualidade, Mínimo Equipamento', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 07 – UGC Monetizando Sua Autenticidade › Aula 05 – Produção Inteligente: Máxima Qualidade, Mínimo Equipamento › Visão geral da aula

Nome oficial da aula: Produção Inteligente: Máxima Qualidade, Mínimo Equipamento
Onde fica: Vitrine 2 (I BÔNUS – Skill''s das Demandas Lucrativas), Módulo 07 – UGC Monetizando Sua Autenticidade, Aula 05
Duração/formato: PDF (5 páginas)
Link na área de membros (abre a página do Módulo 07, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/2/24

Resumo:
É uma aula em PDF, sem vídeo, e curta. Mostra que, para UGC, não é preciso câmera profissional: bastam celular, luz natural e o celular na altura dos olhos. Ensina a gravar falando para a câmera como se falasse com uma amiga, sem buscar perfeição, e a editar no CapCut só com cortes e ajuste de ritmo, sem efeitos. A frase-chave é "UGC vende porque parece real, não porque parece perfeito. Menos é mais."', 'approved', ARRAY['produção de vídeo UGC','gravar com celular','sem câmera profissional','luz natural','altura dos olhos','enquadramento natural','falar olhando para a câmera','como se falasse com uma amiga','naturalidade','CapCut','cortar erros','ajustar ritmo','sem efeitos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M07.A05-02', 'principal', 2, 7, 'V2.M07.A05 — Produção Inteligente: Máxima Qualidade, Mínimo Equipamento', 'Equipamento básico', 'Produção Inteligente: Máxima Qualidade, Mínimo Equipamento', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 07 – UGC Monetizando Sua Autenticidade › Aula 05 – Produção Inteligente: Máxima Qualidade, Mínimo Equipamento › Equipamento básico

| Item | Como usar |
|---|---|
| Celular | Para gravar os vídeos |
| Luz natural | Aproveitar a iluminação do dia |
| Altura dos olhos | Posicionar o celular para um enquadramento natural |', 'approved', ARRAY['produção de vídeo UGC','gravar com celular','sem câmera profissional','luz natural','altura dos olhos','enquadramento natural','falar olhando para a câmera','como se falasse com uma amiga','naturalidade','CapCut','cortar erros','ajustar ritmo','sem efeitos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M07.A05-03', 'principal', 2, 7, 'V2.M07.A05 — Produção Inteligente: Máxima Qualidade, Mínimo Equipamento', 'Procedimento', 'Produção Inteligente: Máxima Qualidade, Mínimo Equipamento', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 07 – UGC Monetizando Sua Autenticidade › Aula 05 – Produção Inteligente: Máxima Qualidade, Mínimo Equipamento › Procedimento

### Gravar
1. Falar olhando para a câmera, como se conversasse com uma amiga.
2. Gravar com naturalidade, sem buscar perfeição. O objetivo é parecer real.
3. Resultado: um vídeo autêntico e pronto para uso.
### Editar (CapCut)
1. Cortar os erros.
2. Ajustar o ritmo do vídeo.
3. Evitar efeitos e exageros.
Para aprofundar, ver o Módulo 03 – Pocket Studio: iluminação na A02, enquadramento na A03 e CapCut nas A07 a A11.', 'approved', ARRAY['produção de vídeo UGC','gravar com celular','sem câmera profissional','luz natural','altura dos olhos','enquadramento natural','falar olhando para a câmera','como se falasse com uma amiga','naturalidade','CapCut','cortar erros','ajustar ritmo','sem efeitos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M07.A05-04', 'principal', 2, 7, 'V2.M07.A05 — Produção Inteligente: Máxima Qualidade, Mínimo Equipamento', 'FAQ', 'Produção Inteligente: Máxima Qualidade, Mínimo Equipamento', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 07 – UGC Monetizando Sua Autenticidade › Aula 05 – Produção Inteligente: Máxima Qualidade, Mínimo Equipamento › Pontos para o suporte

- "Preciso comprar câmera, ring light ou microfone?" Não, segundo a aula: celular e luz natural bastam.
- "Onde posiciono o celular?" Na altura dos olhos.
- "Como edito?" No CapCut, só cortando erros e ajustando o ritmo, sem efeitos. Passo a passo no Módulo 03 (A07 a A11).
- "Meu vídeo não está perfeito." É o esperado: UGC precisa parecer real.', 'approved', ARRAY['produção de vídeo UGC','gravar com celular','sem câmera profissional','luz natural','altura dos olhos','enquadramento natural','falar olhando para a câmera','como se falasse com uma amiga','naturalidade','CapCut','cortar erros','ajustar ritmo','sem efeitos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M07.A06-01', 'principal', 2, 7, 'V2.M07.A06 — Lucro Recorrente com Mesmo Conteúdo', 'Visão geral', 'Lucro Recorrente com Mesmo Conteúdo', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 07 – UGC Monetizando Sua Autenticidade › Aula 06 – Lucro Recorrente com Mesmo Conteúdo › Visão geral da aula

Nome oficial da aula: Lucro Recorrente com Mesmo Conteúdo
Onde fica: Vitrine 2 (I BÔNUS – Skill''s das Demandas Lucrativas), Módulo 07 – UGC Monetizando Sua Autenticidade, Aula 06
Duração/formato: PDF (7 páginas)
Link na área de membros (abre a página do Módulo 07, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/2/24

Resumo:
É uma aula em PDF, sem vídeo. A ideia central é que "ganhar mais não significa gravar mais", e sim vender melhor o que você já grava. Apresenta 3 estratégias:
1. trabalhar com pacotes de vídeos;
2. cobrar pelos direitos de uso quando o vídeo vai para anúncios pagos;
3. organizar uma tabela de valores para responder com clareza e não negociar no impulso.
Não informa valores de referência.', 'approved', ARRAY['pacote de vídeos','variações de fala','variações de gancho','direitos de uso','licença de uso','uso orgânico','uso em anúncios pagos','ads','tráfego pago','tabela de preços','valor por vídeo','valor por pacote','valor para anúncios','precificação UGC','quanto cobrar UGC']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M07.A06-02', 'principal', 2, 7, 'V2.M07.A06 — Lucro Recorrente com Mesmo Conteúdo', 'Procedimento: as 3 estratégias', 'Lucro Recorrente com Mesmo Conteúdo', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 07 – UGC Monetizando Sua Autenticidade › Aula 06 – Lucro Recorrente com Mesmo Conteúdo › Procedimento: as 3 estratégias

### 1. Trabalhar com pacotes
- Por que funcionam: aumentam o valor do contrato e facilitam a decisão da empresa.
- Exemplo do PDF: se a empresa pede 1 vídeo, responder: "Posso gravar 1 vídeo, ou um pacote com 3 vídeos com variações de fala."
- Resultado: mais valor para o cliente e maior faturamento para você.
### 2. Cobrar pelos direitos de uso
- O que são: quando a empresa usa seu vídeo em anúncios pagos, está usando sua imagem para vender, e isso tem valor adicional.
- Como comunicar (frase-modelo): "Esse valor considera uso orgânico. Para anúncios pagos, ajustamos o valor."
- Mostra profissionalismo e garante remuneração justa.
### 3. Organizar a tabela de valores
| Item da tabela | Exemplo de uso |
|---|---|
| Valor por vídeo | Pedido avulso |
| Valor por pacote | 3 vídeos com variações |
| Valor para uso em anúncios | Adicional quando o vídeo vai para tráfego pago |
- Benefício: quando a empresa pede algo extra, você consulta a tabela e responde com clareza, sem negociar no impulso.', 'approved', ARRAY['pacote de vídeos','variações de fala','variações de gancho','direitos de uso','licença de uso','uso orgânico','uso em anúncios pagos','ads','tráfego pago','tabela de preços','valor por vídeo','valor por pacote','valor para anúncios','precificação UGC','quanto cobrar UGC']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M07.A06-03', 'principal', 2, 7, 'V2.M07.A06 — Lucro Recorrente com Mesmo Conteúdo', 'FAQ', 'Lucro Recorrente com Mesmo Conteúdo', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 07 – UGC Monetizando Sua Autenticidade › Aula 06 – Lucro Recorrente com Mesmo Conteúdo › Pontos para o suporte

- "Como ganho mais sem gravar mais?" Oferecer pacotes (por exemplo 3 vídeos com variações de fala) e cobrar a mais pelo uso em anúncios pagos.
- "O que é uso orgânico × anúncio pago?" Orgânico = a marca posta no perfil dela. Anúncio pago = a marca impulsiona o vídeo como propaganda, o que vale mais.
- "Quanto cobro?" O PDF não dá valores. Orientar a montar a tabela própria (vídeo, pacote, anúncio) e pesquisar valores praticados. Não passar números sem validação da equipe.
- "Na MIS a campanha já tem valor, posso negociar?" Não está claro no módulo.', 'approved', ARRAY['pacote de vídeos','variações de fala','variações de gancho','direitos de uso','licença de uso','uso orgânico','uso em anúncios pagos','ads','tráfego pago','tabela de preços','valor por vídeo','valor por pacote','valor para anúncios','precificação UGC','quanto cobrar UGC']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M07.A07-01', 'principal', 2, 7, 'V2.M07.A07 — Do Zero ao Sucesso: Seu PIX com UGC', 'Visão geral', 'Do Zero ao Sucesso: Seu PIX com UGC', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 07 – UGC Monetizando Sua Autenticidade › Aula 07 – Do Zero ao Sucesso: Seu PIX com UGC › Visão geral da aula

Nome oficial da aula: Do Zero ao Sucesso: Seu PIX com UGC
Onde fica: Vitrine 2 (I BÔNUS – Skill''s das Demandas Lucrativas), Módulo 07 – UGC Monetizando Sua Autenticidade, Aula 07
Duração/formato: PDF (6 páginas)
Link na área de membros (abre a página do Módulo 07, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/2/24

Resumo:
É a aula de fechamento do Módulo 07, em PDF, sem vídeo. Defende que ação é o que faz a diferença: o que separa quem ganha com UGC de "quem só assiste ao curso" é fazer, sem esperar o momento perfeito. Traz um plano simples em 3 passos:
1. perfil na MIS;
2. portfólio de 3 a 5 vídeos;
3. candidatar-se a campanhas todos os dias.
Avisa que no início é normal não ter respostas ("não é rejeição, é questão de volume") e que o UGC pode ser feito no seu tempo, sem largar tudo.', 'approved', ARRAY['primeiro PIX','primeiro trabalho UGC','plano de ação','começar hoje','consistência','volume','MIS','portfólio 3 a 5 vídeos','candidatar-se todos os dias','sem resposta','rejeição','normal no início']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M07.A07-02', 'principal', 2, 7, 'V2.M07.A07 — Do Zero ao Sucesso: Seu PIX com UGC', 'Procedimento: plano de ação em 3 passos', 'Do Zero ao Sucesso: Seu PIX com UGC', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 07 – UGC Monetizando Sua Autenticidade › Aula 07 – Do Zero ao Sucesso: Seu PIX com UGC › Procedimento: plano de ação em 3 passos

| Passo | O que fazer | Aula de referência |
|---|---|---|
| 1. Perfil na MIS | Perfil simples, com descrição clara (ex.: "Criadora de UGC focada em vídeos naturais para anúncios"), e subir os vídeos no app | Vitrine 2, Módulo 07, Aula 02 |
| 2. Portfólio | 3 a 5 vídeos são suficientes. Usar produtos que já tem em casa, sem esperar cenário ou produto ideal. | Vitrine 2, Módulo 07, Aula 03 |
| 3. Candidaturas | Candidatar-se todos os dias, nem que seja a uma campanha por dia | Vitrine 2, Módulo 07, Aula 04 |
Sobre a falta de resposta: "No início, pode ser que você não receba respostas. Isso é normal. Não é rejeição, é questão de volume."', 'approved', ARRAY['primeiro PIX','primeiro trabalho UGC','plano de ação','começar hoje','consistência','volume','MIS','portfólio 3 a 5 vídeos','candidatar-se todos os dias','sem resposta','rejeição','normal no início']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M07.A07-03', 'principal', 2, 7, 'V2.M07.A07 — Do Zero ao Sucesso: Seu PIX com UGC', 'Dicas do PDF', 'Do Zero ao Sucesso: Seu PIX com UGC', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 07 – UGC Monetizando Sua Autenticidade › Aula 07 – Do Zero ao Sucesso: Seu PIX com UGC › Dicas do PDF

- No seu tempo: não precisa largar tudo para começar. Adaptar ao seu ritmo e disponibilidade.
- Confiança cresce com a prática: "Fechar o primeiro trabalho muda tudo."
"UGC não é questão de sorte, mas de método. Comece hoje, aplique com consistência e veja os resultados."', 'approved', ARRAY['primeiro PIX','primeiro trabalho UGC','plano de ação','começar hoje','consistência','volume','MIS','portfólio 3 a 5 vídeos','candidatar-se todos os dias','sem resposta','rejeição','normal no início']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M07.A07-04', 'principal', 2, 7, 'V2.M07.A07 — Do Zero ao Sucesso: Seu PIX com UGC', 'FAQ', 'Do Zero ao Sucesso: Seu PIX com UGC', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 07 – UGC Monetizando Sua Autenticidade › Aula 07 – Do Zero ao Sucesso: Seu PIX com UGC › Pontos para o suporte

- "Por onde começo?" Pelos 3 passos: perfil na MIS › portfólio de 3 a 5 vídeos › candidatar-se todo dia.
- "Quantos vídeos no portfólio?" 3 a 5, segundo esta aula.
- "Me candidatei e ninguém respondeu." É normal no início: é questão de volume. Manter pelo menos uma candidatura por dia. Se continuar sem resposta por muito tempo, revisar o portfólio e a mensagem (A03 e A04).
- "Preciso largar meu emprego?" Não. O UGC pode ser feito no seu tempo.
- "Quando recebo meu PIX?" O módulo não explica prazos nem a forma de pagamento.', 'approved', ARRAY['primeiro PIX','primeiro trabalho UGC','plano de ação','começar hoje','consistência','volume','MIS','portfólio 3 a 5 vídeos','candidatar-se todos os dias','sem resposta','rejeição','normal no início']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M07.A08-01', 'principal', 2, 7, 'V2.M07.A08 — BÔNUS: Clube das Testadoras Secretas', 'Visão geral', 'BÔNUS: Clube das Testadoras Secretas', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 07 – UGC Monetizando Sua Autenticidade › Aula 08 – BÔNUS: Clube das Testadoras Secretas › Visão geral da aula

Nome oficial da aula: BÔNUS: Clube das Testadoras Secretas
Onde fica: Vitrine 2 (I BÔNUS – Skill''s das Demandas Lucrativas), Módulo 07 – UGC Monetizando Sua Autenticidade, Aula 08
Duração/formato: PDF (informado) — o arquivo enviado é transcrição de fala, provavelmente vídeo
Link na área de membros (abre a página do Módulo 07, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/2/24

Resumo:
É a aula bônus do Módulo 07. Promete colocar a aluna na "lista VIP das empresas que enviam produtos para mulheres testarem em casa". Apresenta programas e plataformas de teste de produtos: Home Tester Club, programas da Nivea, Philips e Nestlé, BzzAgent e The Insiders. Depois ensina 4 passos:
1. descobrir onde estão as oportunidades;
2. montar um perfil que se destaca;
3. candidatar-se de forma específica;
4. entregar avaliações detalhadas e honestas.
Os links dos programas estão na descrição da aula.
⚠️ Os programas citados enviam produtos, não dinheiro.', 'approved', ARRAY['testadora de produtos','testar produtos em casa','receber produtos grátis','amostras grátis','lista VIP','Home Tester Club','hometesterclub','BzzAgent','BuzzAgent','Buzz Agent','The Insiders','The Insiders Brasil','theinsidersnet','Nivea','Philips','Nestlé','Natura','Pantene','LOréal','Lancôme','Tupperware','Comfort','Neutrogena','Pampers','Vichy','La Roche-Posay','avaliação detalhada','review','unboxing']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M07.A08-02', 'principal', 2, 7, 'V2.M07.A08 — BÔNUS: Clube das Testadoras Secretas', 'Os programas citados', 'BÔNUS: Clube das Testadoras Secretas', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 07 – UGC Monetizando Sua Autenticidade › Aula 08 – BÔNUS: Clube das Testadoras Secretas › Os programas citados

| Programa | Marcas citadas | Como funciona (segundo a aula) |
|---|---|---|
| Home Tester Club | Natura, Pantene | Cadastro › perfil › participar das campanhas |
| Programa Nivea | Nivea | Receber produtos para testar e opinar |
| Programa Philips | Philips | Cadastro › responder perguntas › se selecionada, recebe em casa |
| Programa Nestlé | Nestlé | Experimentar novidades ou produtos populares sem custo |
| BzzAgent | L''Oréal, Lancôme | Perfil detalhado de interesses › campanha compatível › recebe o produto. Incentiva compartilhar nas redes. |
| The Insiders Brasil | Tupperware, Comfort, Neutrogena, Pampers, Vichy, La Roche-Posay | Cadastro › escolher campanhas › se selecionada, recebe. Valoriza feedback detalhado e compartilhar com amigos e redes. |', 'approved', ARRAY['testadora de produtos','testar produtos em casa','receber produtos grátis','amostras grátis','lista VIP','Home Tester Club','hometesterclub','BzzAgent','BuzzAgent','Buzz Agent','The Insiders','The Insiders Brasil','theinsidersnet','Nivea','Philips','Nestlé','Natura','Pantene','LOréal','Lancôme','Tupperware','Comfort','Neutrogena','Pampers','Vichy','La Roche-Posay','avaliação detalhada','review','unboxing']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M07.A08-03', 'principal', 2, 7, 'V2.M07.A08 — BÔNUS: Clube das Testadoras Secretas', 'Procedimento: os 4 passos', 'BÔNUS: Clube das Testadoras Secretas', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 07 – UGC Monetizando Sua Autenticidade › Aula 08 – BÔNUS: Clube das Testadoras Secretas › Procedimento: os 4 passos

### 1. Descobrir as oportunidades
- Acessar os links na descrição da aula e se cadastrar nos programas.
### 2. Montar um perfil que se destaca
1. Foto: clara, bem iluminada, que transmita confiança.
2. Biografia: interesses de forma autêntica (beleza, tecnologia, culinária…).
3. Conectar as redes sociais, mesmo que pequenas.
- "O perfil é o seu cartão de visita."
### 3. Candidatar-se com especificidade
- Quando houver campo de motivação, evitar respostas genéricas. Modelo da aula: "Eu adoraria testar esse produto porque já acompanho a marca e acredito que a minha experiência pode contribuir com uma avaliação detalhada e útil para outras pessoas."
### 4. Entregar uma avaliação que impressiona
1. Fotos e vídeos: o produto em vários ângulos, a abertura da embalagem e, se possível, um vídeo de uso.
2. Texto específico: textura, cheiro, embalagem, resultados percebidos. Explicar o porquê.
3. Honestidade com classe: em vez de "não gostei da textura", dizer "achei que a textura poderia ser um pouco mais leve, mas o resultado final fica excelente".', 'approved', ARRAY['testadora de produtos','testar produtos em casa','receber produtos grátis','amostras grátis','lista VIP','Home Tester Club','hometesterclub','BzzAgent','BuzzAgent','Buzz Agent','The Insiders','The Insiders Brasil','theinsidersnet','Nivea','Philips','Nestlé','Natura','Pantene','LOréal','Lancôme','Tupperware','Comfort','Neutrogena','Pampers','Vichy','La Roche-Posay','avaliação detalhada','review','unboxing']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M07.A08-04', 'principal', 2, 7, 'V2.M07.A08 — BÔNUS: Clube das Testadoras Secretas', 'FAQ', 'BÔNUS: Clube das Testadoras Secretas', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 07 – UGC Monetizando Sua Autenticidade › Aula 08 – BÔNUS: Clube das Testadoras Secretas › Pontos para o suporte

- "Onde me cadastro?" Nos links da descrição da aula: Home Tester Club, BzzAgent, The Insiders e programas das marcas.
- "Me cadastrei e não recebi nada." O cadastro não garante o envio. As marcas selecionam perfis por campanha. Manter o perfil completo e candidatar-se sempre.
- "Quanto eu ganho testando produtos?" Esses programas, em geral, não pagam em dinheiro: a aluna recebe o produto em troca da avaliação. Não prometer renda.
- "Posso usar os produtos recebidos no meu portfólio de UGC?" Pode ajudar a praticar (Vitrine 2, Módulo 07, Aula 03), respeitando as regras do programa e sem fingir parceria paga com a marca.
- "Preciso postar nas redes?" Alguns programas, como a BzzAgent e a The Insiders, incentivam compartilhar. Ver as regras de cada um.', 'approved', ARRAY['testadora de produtos','testar produtos em casa','receber produtos grátis','amostras grátis','lista VIP','Home Tester Club','hometesterclub','BzzAgent','BuzzAgent','Buzz Agent','The Insiders','The Insiders Brasil','theinsidersnet','Nivea','Philips','Nestlé','Natura','Pantene','LOréal','Lancôme','Tupperware','Comfort','Neutrogena','Pampers','Vichy','La Roche-Posay','avaliação detalhada','review','unboxing']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M07.A09-01', 'principal', 2, 7, 'V2.M07.A09 — Certificação UGC', 'Visão geral', 'Certificação UGC', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 07 – UGC Monetizando Sua Autenticidade › Aula 09 – Certificação UGC › Visão geral da aula

Nome oficial da aula: Certificação UGC
Onde fica: Vitrine 2 (I BÔNUS – Skill''s das Demandas Lucrativas), Módulo 07 – UGC Monetizando Sua Autenticidade, Aula 09
Duração/formato: PDF (57 páginas)
Link na área de membros (abre a página do Módulo 07, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/2/24

Resumo:
O PDF é um guia visual de 57 páginas, com pouco texto por página, que resume as 7 aulas do Módulo 07 e o bônus. Junta ferramentas práticas:
- checklist do portfólio;
- modelo de candidatura;
- estrutura de preços para preencher;
- kickstart de 7 dias;
- banco de scripts;
- glossário.
Cada aula resumida termina com uma "Ação da aula". O fio condutor é "UGC não é sobre fama, é sobre prestação de serviço" e "o que separa quem ganha de quem não ganha é executar com consistência".', 'approved', ARRAY['material complementar','guia de estudo','guia de consulta','PDF do módulo','certificação UGC','certificado','kickstart de 7 dias','plano de 7 dias','banco de scripts','modelos de mensagem','roteiro Problema-Uso-Benefício','glossário','briefing','uso orgânico','direitos de uso','pacote de vídeos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M07.A09-02', 'principal', 2, 7, 'V2.M07.A09 — Certificação UGC', 'Estrutura do guia', 'Certificação UGC', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 07 – UGC Monetizando Sua Autenticidade › Aula 09 – Certificação UGC › Estrutura do guia

| Seção | Conteúdo-chave |
|---|---|
| Como usar | Volte ao guia ao montar portfólio, candidatar-se, gravar ou precificar. "Pequeno, mas feito." |
| 01 – O negócio | UGC é / não é (tabela). Modelo: recebe produto ou roteiro › grava › entrega › recebe. "Único requisito: saber gravar um vídeo simples no celular." |
| 02 – Ecossistema | Marcas não contratam por DM. Usam plataformas como o MIS. Fluxo: empresa publica › você analisa › você se candidata. Ação: criar cadastro e explorar campanhas. |
| 03 – Portfólio | Estrutura Problema › Uso › Benefício. Checklist: 3 a 5 vídeos com produtos de casa; Canva, um por página; link pronto. |
| 04 – Propostas | Novo modelo de candidatura (abaixo). Comparação "fala com clareza × se explica demais". Ação: enviar uma candidatura. |
| 05 – Produção | Luz natural perto da janela; celular na altura dos olhos, firme; falar como com uma amiga; CapCut com leveza. Ação: gravar e editar um vídeo de teste. |
| 06 – Lucro com o mesmo conteúdo | Pacotes (2, 3 ou 5), direitos de uso à parte para anúncios, estrutura de preços (campos para preencher: avulso, pacote, adicional de anúncios). |
| 07 – Do zero ao PIX | 3 passos (perfil › portfólio › candidatar-se todo dia) + Kickstart de 7 dias (abaixo). |
| Bônus – Testadoras | Tabela de programas, aviso "confirme sempre no site oficial", estrutura de uma boa avaliação. |
| Banco de scripts | 6 modelos prontos (abaixo). |
| Glossário | 12 termos: UGC, criadora de UGC, briefing, plataforma, portfólio, Problema-Uso-Benefício, candidatura, uso orgânico, direitos de uso, pacote, programa de testes, avaliação. |', 'approved', ARRAY['material complementar','guia de estudo','guia de consulta','PDF do módulo','certificação UGC','certificado','kickstart de 7 dias','plano de 7 dias','banco de scripts','modelos de mensagem','roteiro Problema-Uso-Benefício','glossário','briefing','uso orgânico','direitos de uso','pacote de vídeos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M07.A09-03', 'principal', 2, 7, 'V2.M07.A09 — Certificação UGC', 'Procedimento: Kickstart de 7 dias', 'Certificação UGC', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 07 – UGC Monetizando Sua Autenticidade › Aula 09 – Certificação UGC › Procedimento: Kickstart de 7 dias

| Dia | Ação |
|---|---|
| 1 | Criar o cadastro e preencher o perfil |
| 2 a 4 | Gravar e editar 3 a 5 vídeos de portfólio |
| 5 | Montar o portfólio no Canva e pegar o link |
| 6 e 7 | Candidatar-se às primeiras campanhas e não parar |', 'approved', ARRAY['material complementar','guia de estudo','guia de consulta','PDF do módulo','certificação UGC','certificado','kickstart de 7 dias','plano de 7 dias','banco de scripts','modelos de mensagem','roteiro Problema-Uso-Benefício','glossário','briefing','uso orgânico','direitos de uso','pacote de vídeos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M07.A09-04', 'principal', 2, 7, 'V2.M07.A09 — Certificação UGC', 'Banco de scripts (do PDF)', 'Certificação UGC', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 07 – UGC Monetizando Sua Autenticidade › Aula 09 – Certificação UGC › Banco de scripts (do PDF)

- Descrição de perfil: "Criadora de conteúdo UGC. Produzo vídeos autênticos e naturais de produtos, gravados com cuidado e prontos para uso da marca. Aberta a campanhas de beleza, casa e lifestyle."
- Candidatura a campanha: "Olá! Tenho experiência criando vídeos autênticos de UGC e adoraria participar desta campanha. Segue o link do meu portfólio: [link]. Fico à disposição para produzir conforme o briefing. Obrigada!"
- Oferecer pacote: "Posso montar um pacote de 3 vídeos com um valor especial, ótimo para você variar o conteúdo e manter consistência nas redes."
- Direitos de uso: "O valor combinado cobre o uso orgânico do vídeo. Caso queira utilizá-lo em anúncios pagos, incluo os direitos de uso por um adicional."
- Candidatura a programa de testes: "Tenho muito interesse em testar este produto porque [razão específica: tipo de pele, rotina, público]. Posso entregar uma avaliação detalhada, com fotos e vídeo do uso real."
- Roteiro de vídeo: "[Problema] Sabe quando…? [Uso] Foi aí que comecei a usar [produto], assim, ó… [Benefício] E o resultado foi… recomendo para quem…"
Estrutura de uma boa avaliação (testadoras): primeira impressão (embalagem, cheiro) › experiência de uso (textura, facilidade) › resultado (foto ou vídeo) › recomendação honesta (para quem é ideal).', 'approved', ARRAY['material complementar','guia de estudo','guia de consulta','PDF do módulo','certificação UGC','certificado','kickstart de 7 dias','plano de 7 dias','banco de scripts','modelos de mensagem','roteiro Problema-Uso-Benefício','glossário','briefing','uso orgânico','direitos de uso','pacote de vídeos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V2.M07.A09-05', 'principal', 2, 7, 'V2.M07.A09 — Certificação UGC', 'FAQ', 'Certificação UGC', 'I BÔNUS – Skill''s das Demandas Lucrativas › Módulo 07 – UGC Monetizando Sua Autenticidade › Aula 09 – Certificação UGC › Pontos para o suporte

- "Onde está o resumo do módulo de UGC?" Neste PDF (material complementar), na Aula 09.
- "Por onde começo?" Pelo Kickstart de 7 dias: perfil › 3 a 5 vídeos › Canva › candidaturas.
- "Tem modelo de mensagem?" Sim, no Banco de scripts: perfil, candidatura, pacote, direitos de uso, programa de testes e roteiro.
- "Como pego o certificado de UGC?" Este material não fala de certificado. Pela regra informada na Vitrine 2, Módulo 06, Aula 05, o certificado seria emitido "abaixo da aula". Confirmar com a equipe.
- "Quanto cobro?" O guia traz só campos em branco para a aluna preencher. Continua sem valores de referência.', 'approved', ARRAY['material complementar','guia de estudo','guia de consulta','PDF do módulo','certificação UGC','certificado','kickstart de 7 dias','plano de 7 dias','banco de scripts','modelos de mensagem','roteiro Problema-Uso-Benefício','glossário','briefing','uso orgânico','direitos de uso','pacote de vídeos']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V3.M01.A01-01', 'principal', 3, 1, 'V3.M01.A01 — Descobrindo o Mundo UpWork', 'Visão geral', 'Descobrindo o Mundo UpWork', 'II BÔNUS: Missão Dólar Rápido › Módulo 01 – Passaporte da Prosperidade › Aula 01 – Descobrindo o Mundo UpWork › Visão geral da aula

Nome oficial da aula: Descobrindo o Mundo UpWork
Onde fica: Vitrine 3 (II BÔNUS: Missão Dólar Rápido), Módulo 01 – Passaporte da Prosperidade, Aula 01
Duração/formato: 1:07
Link na área de membros (abre a página do Módulo 01, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/3/25

Resumo:
É a aula de abertura do II Bônus, curta (1:07), com a Gabi. É só motivacional: fala da oportunidade de trabalhar de qualquer lugar, receber em dólar "mesmo sem precisar falar inglês" e entrar no mercado de microprojetos remunerados internacionais. A Gabriela conta que começou "com mil dúvidas". Anuncia que vai mostrar "como funciona a plataforma Freelancer", mas o título da aula fala em Upwork. Não há passo a passo nesta aula.', 'approved', ARRAY['Upwork','Up Work','Freelancer','Freelancer.com','Gabriela Vitorino','mentoria Projetos Remunerados','microprojetos remunerados internacionais','receber em dólar','moeda forte','sem falar inglês']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V3.M01.A01-02', 'principal', 3, 1, 'V3.M01.A01 — Descobrindo o Mundo UpWork', 'Pontos principais', 'Descobrindo o Mundo UpWork', 'II BÔNUS: Missão Dólar Rápido › Módulo 01 – Passaporte da Prosperidade › Aula 01 – Descobrindo o Mundo UpWork › Pontos principais

- Trabalhar de qualquer lugar, fazer a própria renda e ser dona do seu tempo.
- Receber em dólar, "mesmo sem precisar falar inglês".
- "Você não precisa ser expert nem fluente, só precisa estar disposta a aprender e aplicar."
- Pede que a aluna siga o passo a passo até o final do bônus.', 'approved', ARRAY['Upwork','Up Work','Freelancer','Freelancer.com','Gabriela Vitorino','mentoria Projetos Remunerados','microprojetos remunerados internacionais','receber em dólar','moeda forte','sem falar inglês']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V3.M01.A01-03', 'principal', 3, 1, 'V3.M01.A01 — Descobrindo o Mundo UpWork', 'FAQ', 'Descobrindo o Mundo UpWork', 'II BÔNUS: Missão Dólar Rápido › Módulo 01 – Passaporte da Prosperidade › Aula 01 – Descobrindo o Mundo UpWork › Pontos para o suporte

- "Preciso saber inglês?" A aula diz que não.
- "Qual plataforma vou usar, Upwork ou Freelancer?" Não está claro: o título diz Upwork e a fala diz Freelancer.
- "O que é a mentoria Projetos Remunerados?" É o nome dito na gravação, mas não é o nome do produto da aluna.', 'approved', ARRAY['Upwork','Up Work','Freelancer','Freelancer.com','Gabriela Vitorino','mentoria Projetos Remunerados','microprojetos remunerados internacionais','receber em dólar','moeda forte','sem falar inglês']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V3.M02.A01-01', 'principal', 3, 2, 'V3.M02.A01 — Estratégias de Alta Performance no 99Freelas', 'Visão geral', 'Estratégias de Alta Performance no 99Freelas', 'II BÔNUS: Missão Dólar Rápido › Módulo 02 – Multiplicando Resultados com Demandas Lucrativas › Aula 01 – Estratégias de Alta Performance no 99Freelas › Visão geral da aula

Nome oficial da aula: Estratégias de Alta Performance no 99Freelas
Onde fica: Vitrine 3 (II BÔNUS: Missão Dólar Rápido), Módulo 02 – Multiplicando Resultados com Demandas Lucrativas, Aula 01
Duração/formato: 3:49
Link na área de membros (abre a página do Módulo 02, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/3/26

Resumo:
É uma aula com gravação de tela. Anuncia "uma dica rapidinha" sobre 99Freelas e Workana, mas só mostra o 99Freelas. A "dica" é assinar um plano pago. Compara os planos Básico (gratuito), Pro e Premium (conexões, prazo de recebimento, taxa, recursos) e recomenda começar pelo Pro (R$ 49,90). Afirma que, pagando o plano, "com certeza você já vai ter um retorno imediato" e poderá fazer "entre 1 a 10 projetos por dia".', 'approved', ARRAY['99Freelas','99 frilas','99 Freelas','Workana','plano Básico','plano Pro','plano Premium','plano trimestral','assinatura','conexões mensais','taxa de intermediação','dias úteis para receber','selo de autenticação','projetos exclusivos','24 horas','proposta destacada','promover proposta','projetos remunerados','minha executiva']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V3.M02.A01-02', 'principal', 3, 2, 'V3.M02.A01 — Estratégias de Alta Performance no 99Freelas', 'Procedimento', 'Estratégias de Alta Performance no 99Freelas', 'II BÔNUS: Missão Dólar Rápido › Módulo 02 – Multiplicando Resultados com Demandas Lucrativas › Aula 01 – Estratégias de Alta Performance no 99Freelas › Procedimento

1. Entrar no 99Freelas (login ou cadastro com Gmail, Facebook ou e-mail; ver o Vitrine 1, Módulo 07).
2. Escolher "Quero trabalhar" e abrir a página de planos ("Escolha seu plano, maximize o seu sucesso e ganhos").
3. Comparar os planos:
|  | Básico (grátis) | Pro | Premium |
|---|---|---|---|
| Preço | R$ 0 | R$ 49,90/mês (trimestral: R$ 119,90) | Não dito na aula (o Vitrine 1, Módulo 07 cita R$ 89,90) |
| Conexões por mês | 10 | 120 | Mais (não especificado) |
| Prazo para receber | 6 dias úteis | 4 dias úteis | 2 dias úteis |
| Taxa de intermediação | 20% | 15% | 10% |
| Áreas de interesse / habilidades | 5 / 10 | Mais / 30 | Mais |
| Trabalhos no portfólio | 3 | 12 | Mais |
| Tamanho do anexo | 16 MB | 32 MB | Mais |
| Extras | — | Promover 2 propostas, seguir clientes, projetos exclusivos, destaque na pesquisa, proposta destacada, ícone Pro, ver valor médio das propostas, e-mail na hora de novo projeto | Todos do Pro, ampliados |
1. Projetos com selo de autenticação: em alguns, quem não assina só pode mandar proposta depois de 24 horas.
2. Recomendação da aula: começar pelo Pro. Quando estiver "craque", considerar o trimestral (R$ 119,90) ou o Premium.', 'approved', ARRAY['99Freelas','99 frilas','99 Freelas','Workana','plano Básico','plano Pro','plano Premium','plano trimestral','assinatura','conexões mensais','taxa de intermediação','dias úteis para receber','selo de autenticação','projetos exclusivos','24 horas','proposta destacada','promover proposta','projetos remunerados','minha executiva']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V3.M02.A01-03', 'principal', 3, 2, 'V3.M02.A01 — Estratégias de Alta Performance no 99Freelas', 'FAQ', 'Estratégias de Alta Performance no 99Freelas', 'II BÔNUS: Missão Dólar Rápido › Módulo 02 – Multiplicando Resultados com Demandas Lucrativas › Aula 01 – Estratégias de Alta Performance no 99Freelas › Pontos para o suporte

- "Preciso pagar o 99Freelas?" Não é obrigatório. O plano gratuito tem 10 conexões por mês. Esta aula recomenda o Pro (R$ 49,90) para ter mais conexões, receber mais rápido (4 dias úteis) e pagar menos taxa (15%).
- "Qual a diferença entre os planos?" Ver a tabela: conexões, prazo de recebimento, taxa e acesso antecipado a projetos.
- "Paguei o Pro e não tive retorno." O plano não garante projetos nem retorno. Revisar perfil e propostas (Vitrine 1, Módulo 07).
- "E a Workana?" Está na Aula 02 deste módulo e no Vitrine 1, Módulo 08.', 'approved', ARRAY['99Freelas','99 frilas','99 Freelas','Workana','plano Básico','plano Pro','plano Premium','plano trimestral','assinatura','conexões mensais','taxa de intermediação','dias úteis para receber','selo de autenticação','projetos exclusivos','24 horas','proposta destacada','promover proposta','projetos remunerados','minha executiva']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V3.M02.A02-01', 'principal', 3, 2, 'V3.M02.A02 — O Código da Excelência no Workana', 'Visão geral', 'O Código da Excelência no Workana', 'II BÔNUS: Missão Dólar Rápido › Módulo 02 – Multiplicando Resultados com Demandas Lucrativas › Aula 02 – O Código da Excelência no Workana › Visão geral da aula

Nome oficial da aula: O Código da Excelência no Workana
Onde fica: Vitrine 3 (II BÔNUS: Missão Dólar Rápido), Módulo 02 – Multiplicando Resultados com Demandas Lucrativas, Aula 02
Duração/formato: 2:35
Link na área de membros (abre a página do Módulo 02, onde fica esta aula): https://alunos.demandasinvisiveis.com/member/3/26

Resumo:
É a continuação da Aula 01 (99Freelas), agora no Workana, com gravação de tela. Assim como na aula anterior, a "dica para se destacar" é assinar um plano pago. Mostra onde ficam os planos de assinatura e compara o plano grátis com os pagos. Recomenda começar pelo plano mensal de R$ 21,90, "para testar", e depois evoluir para Profissional ou Explorer e, por fim, para o trimestral. Termina dizendo "tenho certeza que você vai fechar muitos projetos" e pedindo depoimento de faturamento.', 'approved', ARRAY['Workana','Plano de Assinatura','Encontre trabalho','mensal','trimestral','plano grátis','plano de R$ 21,90','Profissional','Explorer','contatos semanais','projetos em andamento','saque mensal','saque semanal','minha executiva','depoimento']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V3.M02.A02-02', 'principal', 3, 2, 'V3.M02.A02 — O Código da Excelência no Workana', 'Procedimento', 'O Código da Excelência no Workana', 'II BÔNUS: Missão Dólar Rápido › Módulo 02 – Multiplicando Resultados com Demandas Lucrativas › Aula 02 – O Código da Excelência no Workana › Procedimento

1. Buscar "Workana" no Google e entrar no site.
2. Se ainda não tem cadastro: "Quero trabalhar como freelancer" › entrar com Google, Facebook, Apple ou e-mail (ver o Vitrine 1, Módulo 08). Adicionar o número de telefone.
3. Com o perfil completo, ir em Encontre trabalho › Plano de Assinatura.
4. ⚠️ A página abre no valor trimestral. A aula recomenda mudar para o mensal no começo.
5. Comparar os planos (valores da gravação):
|  | Grátis | Plano de entrada (R$ 21,90/mês) | Profissional / Explorer |
|---|---|---|---|
| Contatos (propostas) por semana | 2 | Não dito | 17 (citado como exemplo) |
| Projetos em andamento | 1 | Não dito | 5 |
| Saque | 1 por mês (início do mês) | Não dito | Semanal |
1. Sequência recomendada: plano de R$ 21,90 (teste, "investimento não tão alto") › Profissional ou Explorer quando estiver lucrando › trimestral, que "compensa bastante" quando estiver lucrando ainda mais.', 'approved', ARRAY['Workana','Plano de Assinatura','Encontre trabalho','mensal','trimestral','plano grátis','plano de R$ 21,90','Profissional','Explorer','contatos semanais','projetos em andamento','saque mensal','saque semanal','minha executiva','depoimento']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
insert into public.course_chunks (id, product, level, module, lesson, topic, title, content, status, keywords, source_type, source_version) values ('V3.M02.A02-03', 'principal', 3, 2, 'V3.M02.A02 — O Código da Excelência no Workana', 'FAQ', 'O Código da Excelência no Workana', 'II BÔNUS: Missão Dólar Rápido › Módulo 02 – Multiplicando Resultados com Demandas Lucrativas › Aula 02 – O Código da Excelência no Workana › Pontos para o suporte

- "Preciso pagar o Workana?" Não é obrigatório. O plano grátis tem 2 contatos por semana, 1 projeto em andamento e 1 saque por mês. A aula sugere o plano de entrada de R$ 21,90/mês para testar.
- "Por que só consigo sacar uma vez por mês?" No plano grátis, o saque é mensal (início do mês). Os planos superiores permitem saque semanal, segundo a aula.
- "A página só mostra o preço trimestral." É o padrão da página. Dá para mudar para o mensal.
- "Paguei e não fechei projetos." O plano não garante projetos. Revisar perfil e propostas (Vitrine 1, Módulo 08).', 'approved', ARRAY['Workana','Plano de Assinatura','Encontre trabalho','mensal','trimestral','plano grátis','plano de R$ 21,90','Profissional','Explorer','contatos semanais','projetos em andamento','saque mensal','saque semanal','minha executiva','depoimento']::text[], 'course_lesson', '2026-10-04') on conflict (id) do update set product = excluded.product, level = excluded.level, module = excluded.module, lesson = excluded.lesson, topic = excluded.topic, title = excluded.title, content = excluded.content, status = excluded.status, keywords = excluded.keywords, source_type = excluded.source_type, source_version = excluded.source_version, updated_at = now();
commit;
