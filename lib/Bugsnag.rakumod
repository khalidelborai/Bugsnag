use Cro::HTTP::Client;
use Bugsnag::Organizations;

unit class Bugsnag;

has Cro::HTTP::Client $.client;
has Bugsnag::Organizations $.organizations;

has $.orgs = $!organizations;

multi method new(Str $api_key) {

	my $client = Cro::HTTP::Client.new(
			headers => ["Authorization" => "token $api_key", "User-Agent" => "Bugsnag-Raku-SDK", "Accept" => "application/json; version=2",],
			base-uri => "https://api.bugsnag.com");
	return self.new(:$client, :organizations(Bugsnag::Organizations.new(:$client)),);
}

multi method new(Str $username,Str $password) {
	my $client = Cro::HTTP::Client.new(
			headers => ["User-Agent" => "Bugsnag-Raku-SDK", "Accept" => "application/json; version=2",],
			base-uri => "https://api.bugsnag.com", auth => {
				:$username, :$password,
			},
			);
	return self.new(:$client, :organizations(Bugsnag::Organizations.new(:$client)));
}

=begin pod

=head1 NAME

Bugsnag - Bugsnag SDK for Raku

=head1 SYNOPSIS

=begin code :lang<raku>

use Bugsnag;

my $bugsnag = Bugsnag.new("TOKEN");

my $orgs = $bugsnag.orgs.list;

=end code

=head1 DESCRIPTION

SDK for Bugsnag L<Bugsnag Data Access API|https://bugsnagapiv2.docs.apiary.io/#>

=head1 AUTHOR

khalidelborai <elboraikhalid@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright 2023 khalidelborai

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod



