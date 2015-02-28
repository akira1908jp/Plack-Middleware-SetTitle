package Plack::Middleware::SetTitle;
use 5.008001;
use strict;
use warnings;

use parent qw(Plack::Middleware);
use Plack::Util();
use Plack::Response;
use Plack::Util::Accessor qw (
    title
);


use Text::MicroTemplate::DataSection qw();
use HTML::TreeBuilder::XPath;

sub call {
    my ($self, $env) = @_;
    my $title = $self->title;

    Plack::Util::response_cb(
        $self->app->($env),
        sub {
            my $res = shift;

            my $plack_res = Plack::Response->new(@$res);
            return unless $plack_res->content_type =~ /\Atext\/html/;

            my $content;
            Plack::Util::foreach($res->[2] || [], sub { $content .= $_[0] });

            my $tree = HTML::TreeBuilder::XPath->new();
            $tree->ignore_unknown(0);
            $tree->store_comments(1);
            $tree->parse_content($content);

            my $head = join "\n" ,map { ref($_) ? $_->as_HTML(q{&<>'"}, '', {}) : $_ } $tree->findnodes('//head')->[0]->content_list;
            my $body = join "\n", map { ref($_) ? $_->as_HTML(q{&<>'"}, '', {}) : $_ } $tree->findnodes('//body')->[0]->content_list;


            my $renderer = Text::MicroTemplate::DataSection->new(
                escape_func => undef
            );
            $res->[2] = [ $renderer->render_mt('template.mt' ,$head, $body, $title) ];
            Plack::Util::header_remove($res->[1], 'Content-Length');
        });
}


1;
__DATA__
@@ template.mt
? my ($head, $body, $title) = @_;
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
?= $head
    <title>
?= $title
    </title>
  </head>
  <body>
    <div class="container">
?= $body
    </div>
  </body>
</html>
__END__
