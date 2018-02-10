BOT "ELISE".

RESPOND TO /como te chamas?/ WITH "Sou a $BOT_NAME".
RESPOND TO /adeus/ WITH "bye" OR "bye bye".
RESPOND TO /trola-me/ WITH "Never gonna give you up. Never gonna let you down...".
RESPOND TO /ola/ WITH "ola".
# SAY "está aí alguém?" 5 SECONDS AFTER LAST_MESSAGE.
#ASK "Como te chamas?".

RESPOND TO /o meu nome e ([a-z]*)/ WITH "Ola $1".

RESPOND TO /merda|caralho|puta|foda|fodido/ WITH "Essa linguagem é totalmente desnecessária." OR "É escusado falares assim." OR "Beijas a tua mãe com essa boca?" OR "Mas é que nem vou falar do assunto se continuas com essa linguagem".

#RESPOND TO /qual e a letra da musica ((?:\w+\s*)+) (?:do|dos|da|das) ((?:\w+\s*)+) [?]?/ WITH PARSE 
#<<< "http://lyrics.wikia.com/wiki/".$2.":".$1 >>> USING <<< >>>.

RESPOND TO /qual e a letra da musica ((?:\w+\s*)+) (?:dos|das|do|da) ((?:\w+\s*)+)[?]?/ WITH PARSE 
<<< 
    my @musica=split /\s+/, $1; my @autor=split /\s+/, $2;
    "http://lyrics.wikia.com/wiki/".join("_",@autor).":".join("_",@musica)
>>> USING <<< 
    # Parser definition
    { '-html' => 1,
      'div' => sub{ if($v{class} eq "lyricbox") {
                       print $c;
                    }}
    }
>>>.

RESPOND TO /Fala-me (?:dos|das|do|da) ((?:\w+\s*)+)/ WITH PARSE
<<<
	$_ = $1;
	s/\b(\w)(\w+)/\U$1\L$2/g;
	my @artist = split /\s+/;
	"http://wikipedia.org/wiki/".join("_",@artist)
>>> USING <<<
	# Parser definition
	{ '-html' => 1,
	  'div' => sub{ if($v{class} eq "mw-body-content") {
		  				$content = $c =~ m/<p>(.+?)<\/p>/;
						print $content;
	  				}}
	}
>>>.

DEFAULT TO "Não percebi, por favor refaz a tua pergunta." OR "Tá errado".

# records the name in the environment
#ASK "Como te chamas?" AND RECORD IN "name".
#SAY "Ola".
#SAY "Ola $env{name}" 10 SECONDS AFTER LAST_MESSAGE.

# resets the environment (for new users, after logout)
RESET WHEN "adeus" OR "Bye" OR "Ate depois".
