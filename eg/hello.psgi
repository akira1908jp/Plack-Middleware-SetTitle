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

