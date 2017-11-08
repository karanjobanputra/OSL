use DBI;
use strict;

my $driver = "mysql";
my $database = "perl";
my $dsn = "DBI:$driver:database=$database";
my $userid = "karanjobanputra";
my $password = "qwerty123";
my $sec;
my $min;
my $hour;
my $mday;
my $mon;
my $year;
my $wday;
my $yday;
my $isdst;
my $dbh = DBI->connect($dsn, $userid, $password ) or die $DBI::errstr;

sub insertRecord()
{
		print "\nEnter the category!\n";
		my $category = <>;
		print "\nEnter the amount\n";
		my $amount = <>;
		($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime();
		$year += 1900;
		$mon++;
		my $date = $year."-".$mon."-".$mday;
		$dbh->do('INSERT INTO expenses (date, category, amount) VALUES (?, ?, ?)',undef,$date, $category, $amount);
}

sub showAll()
{
		my $sql = 'SELECT * FROM expenses';
		my $sth = $dbh->prepare($sql);
		$sth->execute();
		while (my @row = $sth->fetchrow_array)
		{
		   print "\nID:$row[0]\nDate:$row[1]\nCategory:$row[2]\nAmount:$row[3]\n----------------------";
		}

}
sub showCurrentMonthsAllExpenses
{
		($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime();
		$year += 1900;
		$mon++;
		my $sql = 'SELECT * FROM expenses where MONTH(date)='.$mon.' AND YEAR(date)='.$year;
		my $sth = $dbh->prepare($sql);
		$sth->execute();
		my $count = 0;
		while (my @row = $sth->fetchrow_array)
		{
				$count++;
		   print "\nID:$row[0]\nDate:$row[1]\nCategory:$row[2]\nAmount:$row[3]\n----------------------";
		}
		if($count == 0)
		{
			print "\nThere are no expenses in the database\n";
		}
}


sub showCurrentMonthsExpensesTotal
{
		($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime();
		$year += 1900;
		$mon++;
		my $sql = 'SELECT sum(amount) FROM expenses where MONTH(date)='.$mon.' AND YEAR(date)='.$year;
		my $sth = $dbh->prepare($sql);
		$sth->execute();
		while (my @row = $sth->fetchrow_array)
		{
		   print "\nTotal Expense for $mon/$year is $row[0]\n";
		}
}

sub showPerticularMonthsExpense
{
		print "Enter the month in numeric\n";
		my $mon = <>;
		print "Enter the year in numeric\n";
		my $year = <>;
		my $sql = 'SELECT * FROM expenses where MONTH(date)='.$mon.' AND YEAR(date)='.$year;
		my $sth = $dbh->prepare($sql);
		$sth->execute();
		my $count = 0;
		while (my @row = $sth->fetchrow_array)
		{
			$count++;
		   print "\nID:$row[0]\nDate:$row[1]\nCategory:$row[2]\nAmount:$row[3]\n----------------------";
		}
		if($count == 0)
		{
			print "\nThere are no expenses in the database\n";
		}
}


print "1.Insert Record \n2.Show All Records\n3.Show Current month's all expenses\n4.Show current month's total expenses\n".
"5.View Expenses of a perticular month\n6.Exit\n";

my $choice = <>;

while($choice != 6)
{
		if($choice == 1)
		{
				insertRecord();
		}
		elsif($choice == 2)
		{
			showAll();
		}
		elsif($choice == 3)
		{
			showCurrentMonthsAllExpenses();
		}
		elsif($choice == 4)
		{
			showCurrentMonthsExpensesTotal();
		}
		elsif($choice == 5)
		{
			showPerticularMonthsExpense();
		}
		elsif($choice == 6)
		{
			
		}
		else
		{
			print "Please enter proper choice";
		}

		print "\n1.Insert Record \n2.Show All Records\n3.Show Current month's all expenses\n4.Show current month's total expenses\n".
		"5.View Expenses of a perticular month\n6.Exit\n";

		$choice = <>;
}
