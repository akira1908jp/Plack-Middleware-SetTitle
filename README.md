# NAME
Plack::Middlerware::SetTitle 

#SYNOPSIS

use Plack::Builder;

my $app = sub {
    return [ 
        200 ,
        [ "Content-Type" => "text/html" ],
        [ "<body><h1>Hello</h1>\n<p>World!</p></body>" ]
    ];
};

builder  {
    enable "SetTitle",
    'title' => 'kichijojipm';
    $app;
};


<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>
kichijojipm
    </title>
  </head>
  <body>
    <div class="container">
<h1>Hello</h1>
<p>World!</p>
    </div>
  </body>
</html>


# DESCRIPTION
htmlのテンプレートにheadのtitleに文字列を差し込むを事ができる簡単な実装


# SEE ALSO

- [Plack::Middleware](https://metacpan.org/pod/Plack::Middleware)
- [Plack::Builder](https://metacpan.org/pod/Plack::Builder)
- [Plack::Middleware-Bootstrap](https://metacpan.org/release/Plack-Middleware-Bootstrap)



