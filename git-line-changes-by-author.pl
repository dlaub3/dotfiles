#!/usr/bin/env perl

#
# credit https://stackoverflow.com/a/60383068/7805487
#
use strict;
use warnings;

# save the args to pass to the git log command
my $ARGS = join(' ', @ARGV);

#get the repo slug
my $NAME = _get_repo_slug();

#get list of authors
my @authors = _get_authors();
my ($projectFiles, $projectInsertions, $projectDeletions) = (0,0,0);
#for each author
printf(
  "%s,%s,%s,+%s,-%s,%s\n",
  'Name',
  'Author',
  'Files',
  'Insertions',
  'Deletions',
  'Additions' 
);

foreach my $author (@authors) {
  my $command = qq{git log $ARGS --author="$author" --oneline --shortstat --no-merges};
  my ($files, $insertions, $deletions) = (0,0,0);
  my @lines = `$command`;
  foreach my $line (@lines) {
    if ($line =~ m/^\s(\d+)\s\w+\s\w+,\s(\d+)\s\w+\([\+|\-]\),\s(\d+)\s\w+\([\+|\-]\)$|^\s(\d+)\s\w+\s\w+,\s(\d+)\s\w+\(([\+|\-])\)$/) {
      my $lineFiles = $1 ? $1 : $4;
      my $lineInsertions = (defined $6 && $6 eq '+') ? $5 : (defined $2) ? $2 : 0;
      my $lineDeletions = (defined $6 && $6 eq '-') ? $5 : (defined $3) ? $3 : 0;
      $files += $lineFiles;
      $insertions += $lineInsertions;
      $deletions += $lineDeletions;
      $projectFiles += $lineFiles;
      $projectInsertions += $lineInsertions;
      $projectDeletions += $lineDeletions;
    }
  }
  if ($files || $insertions || $deletions) {
    printf(
      "%s,%s,%s,+%s,-%s,%s\n",
      $NAME,
      $author,
      $files,
      $insertions,
      $deletions,
      $insertions - $deletions
    );
  }
}

printf(
  "%s,%s,%s,+%s,-%s,%s\n",
  $NAME,
  'PROJECT_TOTAL',
  $projectFiles,
  $projectInsertions,
  $projectDeletions,
  $projectInsertions - $projectDeletions
);

exit 0;

#get the remote.origin.url joins that last two pieces (project and repo folder)
#and removes any .git from the results. 
sub _get_repo_slug {
  my $get_remote_url = "git config --get remote.origin.url";
  my $remote_url = `$get_remote_url`;
  chomp $remote_url;

  my @parts = split('/', $remote_url);

  my $slug = join('-', @parts[-2..-1]);
  $slug =~ s/\.git//;

  return $slug;
}

sub _get_authors {
  my $git_authors = 'git shortlog -s | cut -c8-';
  my @authors = `$git_authors`;
  chomp @authors;

  return @authors;
}
