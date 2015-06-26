%{
/*
 * Symbol table in use to add rules at runtime
 */

enum {
    LOOKUP = 0,
    VERB,
    NOUN
};

int state;
int add_word(int type, char *word);
int lookup_word(char *word);

%}

%%

\n { state = LOOKUP; }

^verb { state = VERB; }

^noun { state = NOUN; }

[a-zA-Z]+ {
  if (state != LOOKUP) {
    add_word(state, yytext);
  } else {
    switch(lookup_word(yytext)) {
    case VERB: printf("VERB found: %s", yytext);
      break;
    case NOUN: printf("NOUN found: %s", yytext);
      break;
    default: printf("Word not found in symbol table: %s", yytext);
      break;
    }
  }
}

. /* ignore everything else */
%%

int main(int argc, const char* argv[]) {
  yylex();
}

/* define a linked list of words and types */
struct word {
  char *word_name;
  int word_type;
  struct word *next;
};

struct word *word_list;

extern void *malloc();

int add_word(int type, char *word) {
  struct word *wp;

  if (lookup_word(word) != LOOKUP) {
    printf("!!! warning: word %s is already defined\n", word);
    return 0;
  }

  wp = (struct word *) malloc(sizeof(struct word));

  wp->word_name = (char *) malloc(strlen(word) + 1);
  strcpy(wp->word_name, word);

  wp->word_type = type;
  wp->next = word_list;

  word_list = wp;
  return 1;
}

int lookup_word(char *word) {
  struct word *wp = word_list;

  for(; wp; wp = wp->next) {
    if (strcmp(wp->word_name, word) == 0) return wp->word_type;
  }
  return LOOKUP;
}
