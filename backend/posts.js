// Exemplo de inserção de post
const { data, error } = await supabase
  .from('Posts')
  .insert({ titulo: 'Título do Post', conteudo: 'Conteúdo do Post', autor_id: idDoAutor, comunidade_id: idDaComunidade });
