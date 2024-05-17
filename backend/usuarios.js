// Exemplo de inserção de usuário usando a biblioteca cliente do Supabase
const { data, error } = await supabase
  .from('Usuarios')
  .insert({ email: 'exemplo@email.com', nome: 'Nome Exemplo', senha_hash: 'hash_da_senha' });
