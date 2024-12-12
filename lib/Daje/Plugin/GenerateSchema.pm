package Daje::Plugin::GenerateSchema;
use Mojo::Base 'Daje::Plugin::Base::Common', -base, -signatures;



# NAME
#
# Daje::Plugin::GenerateSchema - It's new $module
#
# SYNOPSIS
# ========
#
#    use Daje::Plugin::GenerateSchema;
#
# DESCRIPTION
#
# Daje::Plugin::GenerateSchema is ...
#
# LICENSE
# =======
# Copyright (C) janeskil1525.
#
# This library is free software; you can redistribute it and/or modify
# it under the same terms as Perl itself.
#
# AUTHOR
#
# janeskil1525 E<lt>janeskil1525@gmail.comE<gt>
#
#

our $VERSION = "0.01";

use Mojo::JSON qw{to_json};
use Daje::Plugin::Schema::Create;
use Mojo::Pg;

sub process ($self) {
    $self->_load_config();
    my $schema = $self->_load_db_schema();
    my $json = $self->_build_json($schema);
    $self->_save_json($json);

    return 1;
}

sub _load_db_schema($self) {
    my $connection = $self->config->{DATABASE}->{connection};
    my $pg = Mojo::Pg->new->dsn($connection);

    my $dbschema = Daje::Plugin::Schema::Create->new(
        db => $pg->db
    )->get_db_schema('public');

    return $dbschema;
}

sub _build_json($self, $schema) {
    my $json = to_json($schema);

    return $json;
}

sub _save_json($self, $json) {

    my $path = $self->config->{DATABASE}->{output_dir};
    open(my $fh, ">", $path . 'schema.json')
        or die "could not open $path . 'schema.json";
    print $fh $json;
    close $fh;

}

1;
__END__



#################### pod generated by Pod::Autopod - keep this line to make pod updates possible ####################

=head1 NAME

Daje::Plugin::GenerateSchema


=head1 SYNOPSIS


   use Daje::Plugin::GenerateSchema;

DESCRIPTION

Daje::Plugin::GenerateSchema is ...



=head1 DESCRIPTION

NAME

Daje::Plugin::GenerateSchema - It's new $module



=head1 REQUIRES

L<Mojo::Pg> 

L<Daje::Plugin::Schema::Create> 

L<Mojo::JSON> 

L<Mojo::Base> 


=head1 METHODS

=head2 process

 process();


=head1 LICENSE

Copyright (C) janeskil1525.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

AUTHOR

janeskil1525 E<lt>janeskil1525@gmail.comE<gt>




=cut

