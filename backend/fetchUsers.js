// Importe o SDK do Supabase
const { createClient } = require('@supabase/supabase-js');

// Configure o cliente Supabase com sua URL do projeto e a chave de API apropriada
const supabaseUrl = 'https://xydsadaoeosaddcvuvmu.supabase.co';
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh5ZHNhZGFvZW9zYWRkY3Z1dm11Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTUwNDIzNzcsImV4cCI6MjAzMDYxODM3N30.oYtwLwzQRK9rUOEhEXQdsfVIFppc4qmj1lIDcofDIME';
const supabase = createClient(supabaseUrl, supabaseKey);

// Exemplo de consulta de todos os usuários
async function fetchUsers() {
  try {
    const { data, error } = await supabase.from('users').select('*');
    if (error) {
      throw error;
    }
    console.log('Users:', data);
  } catch (error) {
    console.error('Error fetching users:', error.message);
  }
}

// Chame a função para buscar os usuários
fetchUsers();