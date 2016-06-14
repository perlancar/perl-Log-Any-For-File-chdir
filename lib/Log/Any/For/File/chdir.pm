package Log::Any::For::File::chdir;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;
use Log::Any '$log';

use File::chdir ();
use Monkey::Patch::Action qw(patch_package);

our $h = patch_package(
    'File::chdir::SCALAR',
    '_chdir',
    'wrap',
    sub {
        my $ctx = shift;
        $log->tracef("[File::chdir] chdir(%s)", $_[0]);
        $ctx->{orig}->(@_);
    },
);

1;
# ABSTRACT: Add logging to File::chdir

=head1 SYNOPSIS

 use Log::Any::For::File::chdir;
 use File::chdir;

 $CWD = "foo";
 ...
 $CWD = "bar";
 ...

Now everytime C<$CWD> is set, the directory name will be logged. To see the log
messages at the screen, use this for example:

 % TRACE=1 perl -MLog::Any::Adapter=Screen -MLog::Any::For::File::chdir -MFile::chdir -e'$CWD = "foo"; ...'
 [File::chdir] chdir(foo)


=head1 SEE ALSO

L<File::chdir>
