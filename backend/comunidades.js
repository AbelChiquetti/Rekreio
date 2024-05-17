// Exemplo de inserção de comunidade
const { data, error } = await supabase
  .from('Comunidades')
  .insert({ nome: 'Nome da Comunidade', descricao: 'Descrição da Comunidade', criador_id: idDoCriador });
