use strict;
my $count=0;
while(<>) {
    $count++;
    if ($count<2){
        next;
    }
    elsif ($count==2){
        $_ =~ /^([\w\s]*)\d+\.\s([\w]*)\s([\(\)STC]*)\s([\w+\.?\s]*)\s([INCU\(\)]*)$/;
        print "$1:$2:$3:$4:$5\n";
    }else {
        chomp($_);
        #$_ =~ m/^(\d+).\s+((?:[\w\(\)\.]+\s+)*)([\w\(\)]+\s+)$/;
        #$_ =~ /^\d+\.\s([\w+\(?\)?\.?)]*)\s([\(\)STC]*)\s([\w+\.?\s]*)\s([INCU\(\)]*)$/;
        $_ =~ /^\d+\.\s([\w]*)\s([\(\)STC]*)\s([\w+\.?\s]*)\s([INCU\(\)]*)$/;
        #$_ =~ /([INCU\(\)]*)$/;
        #print "$_\n";
        print "$1:$2:$3:$4\n";
    }
}


while ( my ($key, $value) = each(%hash) ) {
        print "$key => $value\n";
    }
#    $_ =~ /^\d+\.\s([\w]*)\s([\w]*)\s([\w\.?\s]*)\s([\w\(\)]*)$/;
    ###    print "$1:$2:$3:$4\n";    
    #print "We have $1\n" if grep {/$1/} keys %hash;    
    #    } 
