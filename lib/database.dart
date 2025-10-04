import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class Database {
  // These table names need to be better
  // They are so bad
  // IDK if this works

  // Table of all contents. Start of with all the ingredients in recipes first. Can add more when people add to fridge
  final contentTable = supabase
      .from('ContentTable')
      .insert(supabase.from('RecipeSample').select('ingredients'));
  // Need to concat list of ingredients and then lowercase and then get unique entries before inserting

  final recipesTable = supabase
      .from('RecipesTable')
      .insert(
        supabase.from('RecipeSample').select('''
            name 
            steps
            '''),
      );

  final recipeToContentTable = supabase
      .from('RecipeToContent')
      .insert(supabase.from('RecipeSample').select('ingredients'));

  final streamForFridge = supabase
      .from('FridgeContent')
      .stream(primaryKey: ['fridge_content_id'])
      .eq('fridge_id', 1);
}
