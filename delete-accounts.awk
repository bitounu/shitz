# by paczor 2012
# I do not know awk! I have very deep feeling there's oneliner which does the same but
# I've just want to make it in awk.
# It's very ugly script to take list of accounts to delete from passwd or shadow
# script builds table of accounts to delete from first input file
# then builds second table from second input file (a shadow or passwd)
# then do recursive job on second table to delete accounts listed in first
# then prints out what's left.

# Do I need to say?
function usage() {
        print "Usage: awk -f usun.awk deletelist_file passwd_file" > "/dev/stderr"
        exit 1
}
BEGIN {
        if (ARGC < 3) { usage() }                       # checking arguments
        FS=":"                                          # Field separator is ':' - usefull for passwd or shadow files
}
ARGIND==1{
        for (i=1; i <= FNR; i++) { kasuj[$i]=$0 }       # load kasuj table with accounts from 1st file
                                                        # index is just $i
        next                                            # No lines from first file get below here
}

ARGIND==2{
        for (i=1; i <= FNR; i++) { shadow[$1]=$0 }      # load shadow table with lines from 2nd file
                                                        # index is first field (account name)
                                                        # I'll use it for comparison in END
}

END {
        for (konto in shadow)  {
                for (fKasuj in kasuj) {                 # for each element in shadow table
                        if (fKasuj == konto) {          # if both elements are same
                                delete shadow[konto]    # delete it from shadow
                                delete kasuj[fKasuj]    # delete it from kasuj to shorten iteration (beautifier only)                                                                                                                                               }                                                                                                                                                                                                                   
                }
        }
        for ( x in shadow) {printf("%s\n", shadow[x])}  # output shadow table
}
