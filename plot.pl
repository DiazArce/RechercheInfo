#!/usr/bin/perl
use Chart::Gnuplot;
 
my @freq;
my @rang;

open(FILE, "./TPRIEtu2019/OUTPUT/file.occurrence") or die "Sorry!! couldn't open";

while (my $line = <FILE>) {
	my ($rang, $word, $freq) = split / /, $line	;
	push @rang, $rang;
	push @freq, $freq;
}

# create chart
my $chart = Chart::Gnuplot->new(

output => "fig/plot.png",
title => " Loi de zipf ",
xlabel => "Rang",
ylabel => "frequence",
);

my $dataSet = Chart::Gnuplot::DataSet->new(

xdata => \@rang,
xdata => \@freq,
style => "linespoints",

);

$chart -> plot2d($dataSet);
