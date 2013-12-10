#!/usr/bin/perl
# paragraphs.pl - generate HTML paragraphs

use strict;
use warnings;
use CGI qw(:standard escape escapeHTML);
use Cookbook;

my $title = "Query Output Display - Paragraphs";

print header (), start_html (-title => $title, -bgcolor => "white");

my $dbh = Cookbook::connect ();
my ($now, $version, $user, $db);
my $para;

#@ _DISPLAY_PARAGRAPH_
($now, $version, $user, $db) =
  $dbh->selectrow_array ("SELECT NOW(), VERSION(), USER(), DATABASE()");
$db = "NONE" unless defined ($db);
print p (escapeHTML ("Local time on the MySQL server is $now."));
print p (escapeHTML ("The server version is $version."));
print p (escapeHTML ("The current user is $user."));
print p (escapeHTML ("The default database is $db."));
#@ _DISPLAY_PARAGRAPH_

$dbh->disconnect ();

print end_html ();
