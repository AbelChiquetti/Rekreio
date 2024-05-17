import supabase from './supabaseConfig';

export async function signIn(email, password) {
 const { user, session, error } = await supabase.auth.signIn({
    email,
    password,
 });

 if (error) throw error;

 return { user, session };
}