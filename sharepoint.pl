#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;
use Net::Google::Spreadsheets;
use Date::Calc qw(Delta_Days);
my $service = Net::Google::Spreadsheets->new( username => '', password => '' );
my $spreadsheet = $service->spreadsheet( { title => 'PO 24/7 Support Payment' } );
my $worksheet = $spreadsheet->worksheet( { title => 'test' } );
my $sharepointConnection = new SharePoint::Connection( "username" => 'ee\\', "password" => '',"endpoint" => 'http://intranet.playtech.corp/CustomerRelations/TechSupport/_layouts/_vti_bin/lists.asmx' );
my @items;
@items = $sharepointConnection->GetListItems( "{818DABFC-77A4-4D83-9B8D-026C86E1F384}","{4762CDE6-972C-4352-A3FA-5D27A994DEF9}" );
for ($a=0;$a<$#items; $a++)
{
	if(($items[$a]{'ows_SomeRole'} =~ /(HUB|Portal)/)){
		my @user = split(/#/,$items[$a]{'ows_Specialist'});
		my @date_from = split(/ /,$items[$a]{'ows_From'});
		my @date_to = split(/ /,$items[$a]{'ows_To'});
		my @date_from1 = split(/-/,$date_from[0]);
		my @date_to1 = split(/-/,$date_to[0]);
		my @arr1 = ($date_from1[0],$date_from1[1],$date_from1[2]);
		my @arr2 = ($date_to1[0],$date_to1[1],$date_to1[2]);
		my $count= Delta_Days(@arr1,@arr2);
#		print $date_from[0]." ".$date_to[0]." ".$count."\n";
#		print $items[$a]{'ows_SomeRole'}." ".$user[1]." ".$date_from[0]." ".$date_to[0]."\n";
		my $record = $worksheet->add_row(
   		{
		        name => $user[1],
		        from => $date_from[0],
		        to => $date_to[0],
			count => $count
		}
  	);
	}
}
exit;

package SharePoint::Connection;

use LWP::UserAgent;
use LWP::Debug;
use Authen::NTLM;
use SOAP::Lite on_action => sub { "$_[0]$_[1]"; };
sub new
{
	my( $class, %opts ) = @_;

	if( !defined $opts{debug} ) { $opts{debug} = 0; }
	if( !defined $opts{on_error} ) { $opts{on_error} = \&die; }

	if( $opts{debug} )
	{
		LWP::Debug::level('+');
		SOAP::Lite->import(+trace => 'all');
	}

	my $self = bless {}, $class;
	$self->{opts} = \%opts;
	$self->{soap} = SOAP::Lite->proxy( $opts{endpoint}, keep_alive => 1);
	$self->{soap}->uri("http://schemas.microsoft.com/sharepoint/soap/");
	eval "sub SOAP::Transport::HTTP::Client::get_basic_credentials { return ('$opts{username}' => '$opts{password}') };"; 
	return $self;
}
sub error
{
	my( $self, $msg ) = @_;
	&{$self->{opts}->{on_error}}( $msg );
}
sub GetListItems
{
	my( $self, $listName, $viewName, $rowLimit ) = @_;
	
	$viewName = '' unless defined $viewName;
	$rowLimit = 99999 unless defined $rowLimit;
	my $in_listName = SOAP::Data::name('listName' => $listName);
	my $in_viewName = SOAP::Data::name('viewName' => $viewName);
	my $in_rowLimit = SOAP::Data::name('rowLimit' => $rowLimit);
	my $call = $self->{soap}->GetListItems($in_listName, $in_viewName, $in_rowLimit);
	$self->error($call->faultstring()) if defined $call->fault();
	return $self->attrFromList( $call->dataof('//GetListItemsResult/listitems/data/row') );
}
sub attrFromList
{
	my( $self, @list ) = @_;

	my @r = ();
	foreach my $item ( @list )
	{
		push @r, $item->attr;
	}
	return @r;
}

1;
