#!/usr/bin/perl

use strict;
use utf8::all;

#TO DO
#Processar paragrafo a paragrafo
#Sempre que encontrar /[A-Z\-]{2,}\n/ -> (word to define)
#Apanha tudo após /Defn:/ até linha em branco -> (definition)
#Resultando na regra RESPOND TO "Definition of /word/i" WITH definition 