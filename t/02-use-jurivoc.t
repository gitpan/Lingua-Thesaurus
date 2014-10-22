#!perl
use strict;
use warnings FATAL => 'all';
use Test::More;
use FindBin;
use Lingua::Thesaurus;
use List::MoreUtils qw/firstval/;

plan tests => 5;

my $db_file    = 'TEST.sqlite';
my $thesaurus = Lingua::Thesaurus->new(SQLite => $db_file);

my @terms   = $thesaurus->search_terms('accord*');
my $n_terms = @terms;
ok ($n_terms, "found $n_terms terms 'accord*'");

my $term = $thesaurus->fetch_term('ACC�S � UN TRIBUNAL');
my $SN   = $term->SN;
is ($SN, "seulement au sens de l'art. 29a Cst. et de l'art. 6 CEDH; au sens de l'art. 5 par. 4 CEDH, utiliser CONTR�LE DE LA D�TENTION & AUTORIT� JUDICIAIRE(TRIBUNAL)", "continuation line OK");

my @UF = $term->UF;
is(scalar(@UF), 5, "5 UF terms for 'ACC�S � UN TRIBUNAL'");

my $first_UF = $term->UF;
is($first_UF, "acc�s", "scalar UF 'ACC�S � UN TRIBUNAL' is 'acc�s'");


# Test loading the same file a 2nd time (2nd creation of the Term class)
undef $thesaurus;
$thesaurus = Lingua::Thesaurus->new(SQLite => $db_file);
@terms   = $thesaurus->search_terms('accord*');
$n_terms = @terms;
ok ($n_terms, "found again $n_terms terms 'accord*'");



