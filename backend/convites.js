// Exemplo de inserção de convite
const { data, error } = await supabase
  .from('Convites')
  .insert({ email_destinatario: 'email_destinatario@email.com', comunidade_id: idDaComunidade, token_convite: 'token_unico' });
