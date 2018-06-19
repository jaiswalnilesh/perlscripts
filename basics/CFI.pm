#
# $Source: /project/hal_test/iauto/lib/CFI.pm,v $
#
# $Id: CFI.pm,v 1.27 2009/08/03 10:48:59 hmarne Exp $
#
# $Copyright: Copyright (c) 2010 Symantec Corporation.
# All rights reserved.
#
# THIS SOFTWARE CONTAINS CONFIDENTIAL INFORMATION AND TRADE SECRETS OF
# SYMANTEC CORPORATION.  USE, DISCLOSURE OR REPRODUCTION IS PROHIBITED
# WITHOUT THE PRIOR EXPRESS WRITTEN PERMISSION OF SYMANTEC CORPORATION.
#
# The Licensed Software and Documentation are deemed to be commercial
# computer software as defined in FAR 12.212 and subject to restricted
# rights as defined in FAR Section 52.227-19 "Commercial Computer
# Software - Restricted Rights" and DFARS 227.7202, "Rights in
# Commercial Computer Software or Commercial Computer Software
# Documentation", as applicable, and any successor regulations. Any use,
# modification, reproduction release, performance, display or disclosure
# of the Licensed Software and Documentation by the U.S. Government
# shall be solely in accordance with the terms of this Agreement.  $
#
package CFI;

use strict;
use warnings;
use JSON::PP;
use File::Spec;
use File::Basename;
use Env;
use Cwd;

##### Defining function prototypes #####
sub mprint ($$);
sub print_n_bold ($);
sub do_exit ($);
sub get_cur_sub ();
sub clean_string ($);
sub get_json_object ($);
sub print_in_json_format ($$);
sub get_master_config ($);
sub get_install_result_dirpath ($$);
sub get_install_status_files ($);
sub compare_perl_objects ($$);
sub help_on_run_envrmnt ();
sub get_absolute_path ($$);
sub get_logger ($);
sub get_timestamp ();
sub get_log_filepath ($$);
sub browse ($);
sub get_next_file ($$$);
sub get_lines ($);
sub convert_string_to_reg_expn ($);
sub get_filepath_to_write ($$);

##### Defining sub-routine #####

sub mprint ($$) {
	my ( $_fhs, $_line_to_print) = @_;
	map { print ($_ "$_line_to_print"); } @{$_fhs};
}; #End of mprint ($$)

##### Defining sub-routine #####

sub print_n_bold ($) {
	system "tput bold";
	print STDOUT "$_[0]"; 
	system "tput sgr 0";
}; #End of print_n_bold ($)

##### Defining sub-routine #####

sub do_exit ($) {
	my $_exit_value = shift;
	print "\nQuitting execution..\n";
	exit $_exit_value;
} #End of do_exit ()

##### Defining sub-routine #####

sub get_cur_sub () {
	my($cur_sub) = (caller(2))[3];
	return $cur_sub ? $cur_sub : 'MAIN';
} #End of get_cur_sub ()

##### Defining sub-routine #####

sub clean_string ($) {
	my $_str = shift;
	chomp $_str; $_str =~ s/^\s+//g; $_str =~ s/\s+$//g;
	return $_str;
} #End of clean_string ($)

##### Defining sub-routine #####

sub get_json_object ($) {
	
	my $_json_text_filepath = shift;
	open (JSON_TEXT, $_json_text_filepath) or die "Could not open - $_json_text_filepath: $!\n";
	
	#my @lines = <JSON_TEXT>;
	#eval { my $df = JSON->new->relaxed->decode(join('', @lines)); };
	#if ( $@ ) { die "Error parsing $json_text_filepath: $@\n"; }

	local $/ = "";
	my $_json_text = <JSON_TEXT>;
	close JSON_TEXT;
	my $_json = new JSON::PP;
	my $_json_object;

	eval { $_json_object = $_json->decode ($_json_text); };
	if ($@) { die "Error in JSON file - $_json_text_filepath : $@\n"; };

	return $_json_object;

}; #End of get_json_obj ()

##### Defining sub-routine #####

sub print_in_json_format ($$) {

	my ($_perl_object, $_output_file) = @_;
	my $_json = new JSON::PP;
	$_json->pretty(1) ;
	my $_json_text = $_json->encode ($_perl_object);
	open (OFILE, ">$_output_file") or die "Could not write to $_output_file\n";
	print OFILE "$_json_text";
	close OFILE;

	return 0;

}; #End of print_in_json_format

##### Defining sub-routine #####

sub get_install_result_dirpath ($$) {
	
	my ($_install_result_product_dir, $_build) = @_;
	my ( $_install_result_dirpath, $_result_dirname);

	if ( -d $_install_result_product_dir ) {
	
		my @_rdirs = sort ( glob ( "$_install_result_product_dir/*" ) );
		my @_suffix_nos;
	
		foreach my $_rdir ( @_rdirs ) {
		    my $_rdirname = basename $_rdir;
			next if ( $_rdirname =~ /^[.|..]$/ );
	        next unless ( $_rdirname =~ /^$_build(?:_)(\d+)$/ );
		    push @_suffix_nos, $1;
		}

		if ( scalar @_suffix_nos ) {
			my @_sorted_suffix_nos = sort {$a <=> $b} @_suffix_nos;
			my $_latest_suffix_no = $_sorted_suffix_nos[$#_sorted_suffix_nos];
			$_result_dirname = $_build . "_" . ++$_latest_suffix_no;
		} else {
			$_result_dirname = $_build . "_1";
		}
	} else {
			$_result_dirname = $_build . "_1";
	}
	
	$_install_result_dirpath = File::Spec->catfile ($_install_result_product_dir, $_result_dirname);
	return $_install_result_dirpath;

} #End of get_install_result_dirpath ()

##### Defining sub-routine #####

sub get_install_status_files ($) {
	
	my $_install_result_dirpath = shift;
	my $_install_status_files;

	my @_install_status_filepaths = sort ( glob ("$_install_result_dirpath/install_status_*.txt") );

	my ( @_suffix_nos, @_sorted_suffix_nos);

	foreach my $_install_status_filepath (@_install_status_filepaths) {
		next unless ( $_install_status_filepath =~ /install_status_(\d+)\.txt$/ );
		push @_suffix_nos, $1;
	} #End of FOREACH loop to process each tc status file

	if ( scalar @_suffix_nos) {

		if ( scalar @_suffix_nos > 1 ) {
			@_sorted_suffix_nos = sort {$a <=> $b} @_suffix_nos;
		} else {
			@_sorted_suffix_nos = @_suffix_nos;
		}

		foreach my $_suffix_no ( @_sorted_suffix_nos ) {
			foreach my $_install_status_filepath ( @_install_status_filepaths ) {
				my $_install_status_file = basename $_install_status_filepath;
				my $_filename_in_seq = "install_status_" . $_suffix_no . ".txt";
				if ( $_install_status_file eq $_filename_in_seq ) {
					push @{$_install_status_files}, $_install_status_file;
					last;
				};
			} #Pushing install_status_file in ascending order
		} #End of FOREACH to loop over each $_suffix_no

	} #Reoder files if valid ones exist

	return $_install_status_files;

} #End of get_install_status_files ($)

##### Defining sub-routine #####

sub compare_perl_objects ($$) {

	my ( $_obj1, $_obj2) = @_;
	my ( $_obj_type_1, $_obj_type_2);

	$_obj_type_1 = ref $_obj1, $_obj_type_2 = ref $_obj2;
#	print "Object types are $_obj_type_1 and $_obj_type_2 resp.\n";

	if ( $_obj_type_1 ne $_obj_type_2 ) {
		return 0;
	} #Returning FALSE if object types are different

	if ( $_obj_type_1 eq "ARRAY" && $_obj_type_2 eq "ARRAY" ) {

#		print "Procssing ARRAY\n";
		if ( scalar @{$_obj1} != scalar @{$_obj2} ) {
			return 0;
		} else {
			foreach my $_elem1 ( @{$_obj1} ) {
				foreach my $_elem2 ( @{$_obj2} ) {
					compare_perl_objects ( $_elem1, $_elem2);
				}
			}
			return 1;
		}
	} #End of IF to process if objects are ARRAY ref.

	if ( $_obj_type_1 eq "HASH" && $_obj_type_2 eq "HASH" ) {

#		print "Procssing HASH\n";
		if ( scalar ( keys %{$_obj1} ) != scalar ( keys %{$_obj2} ) ) {
			return 0;
		} else {
			foreach my $_elem1 ( sort ( keys %{$_obj1} ) ) {
				foreach my $_elem2 ( sort ( keys %{$_obj2} ) ) {
					compare_perl_objects ( $_elem1, $_elem2 );
				}
			}
			return 1;
		}
	} #End of IF to process if objects are HASH ref.
	
} #End of subroutine - compare_perl_objects ($$)

##### Defining sub-routine #####

sub help_on_run_envrmnt () {

print<<PHELP;
------------------------------------------------------------------
Check if the test bed has "Run_Envrmnt" section with below fields.
------------------------------------------------------------------
	"Product" : "CCS",
	"Release" : "51_RP1",
	"Build" : "169",
	"System_Database_File" : "conf/system_creds.txt",
	"Product_Database_File" : "data/install_input.txt",
	"Install_Result_BaseDir" : "install_results"
------------------------------------------------------------------
PHELP

	do_exit (-3);

}; #End of sub help_on_run_envrmnt ()

##### Defining sub-routine #####

sub get_absolute_path ($$) {
	
	my ($_working_dir, $_input_dir) = @_;
	my $_absolute_path;

	my $_very_first_char = $1 if ( $_input_dir =~ /^(.)/ );

	if ( $_very_first_char eq '/' ) {
		$_absolute_path = ""; #Input dir is starting from root
	} elsif ( $_very_first_char eq '~' ) {
		 $_absolute_path = $ENV{HOME};
	} else {
		$_absolute_path = $_working_dir; #Input dir is a relative path. So start from working dir.
	}

	my @_input_dir_splits = split ( /\//, $_input_dir );

	foreach my $_input_dir_split ( @_input_dir_splits ) {
		
		my ($_first_char, $_second_char);

		if ( length $_input_dir_split >= 2 ) {
			($_first_char, $_second_char) = ($1, $2) if ( $_input_dir_split =~ /^(.)(.)/ );
		} elsif ( length $_input_dir_split == 1 ) { $_first_char = $1;}

		SW1: {
			
			unless ( defined $_first_char && defined $_second_char ) {
				last SW1;
			}; #Skip if split has nothing. May be required for last part

			if ( $_first_char =~ /_|[a-z]|[0-9]/i ) {
				$_absolute_path = File::Spec->catfile ($_absolute_path, $_input_dir_split);
				last SW1;
			}; #Concatenate for normal name

			if ( $_first_char eq '.' && ! defined $_second_char ) {
				last SW1;
			}; #Skip if same directory

			if ( $_first_char eq '.' && $_second_char =~ /[_a-zA-Z0-9]/ ) {
				$_absolute_path = File::Spec->catfile ($_absolute_path, $_input_dir_split);
				last SW1;
			}; #Concatenate for hidden path

			if ( $_first_char eq '.' && $_second_char eq '.' ) {
				$_absolute_path = dirname ($_absolute_path);
				last SW1;
			}; #One step below if .. 
		
		} #End of switch block - SW1

	}; #End of FOREACH to loop over each part of the input-dir
	
	return $_absolute_path;

}; #End of sub get_absolute_path ($$)

##### Defining sub-routine #####

sub get_logger ($) {
		
	my $_pkg = shift;
	my $_logger;

        if ( -e "$ENV{IAUTO_PATH}/conf/Log4Perl.conf" ) {
	 	Log::Log4perl->init("$ENV{IAUTO_PATH}/conf/Log4Perl.conf");
                $_logger = Log::Log4perl->get_logger ($_pkg);
        } else {
                print STDOUT "Could not find PERL logging conifiguration file - $ENV{IAUTO_PATH}/conf/Log4Perl.conf\n";
		CFI::do_exit(-20);
        }
		
	return (\$_logger);

}; #End of sub get_logger ($); 

##### Defining sub-routine #####

sub get_input ($$) {

	my ( $_message, $_default_value ) = @_;
	$_default_value = undef if ($_default_value =~ /^$/);

	my $_input = undef;

	until ( defined $_input ) {
		print STDOUT "\n";
		CFI::print_n_bold ("$_message");
		$_input = <STDIN>;
		$_input = CFI::clean_string ($_input);
		$_input = $_default_value if ($_input =~ /^$/);
	}; 

	return $_input;

}; #End of get_input ($$)

##### Defining sub-routine #####

sub get_range_input ($$) {

	my ($_max_limit, $_input_type) = @_;

	my $_message;
	$_message = "Enter choice: [1-$_max_limit, q] - " if ( $_input_type eq "S" );
	$_message = "Enter multiple choices separated by space: [1-$_max_limit, q] - " if ( $_input_type eq "M" );

	my ($_valid_range_input, $_range_input);
	$_range_input = undef;

	until ( defined $_valid_range_input && $_valid_range_input ) {
		CFI::print_n_bold ("$_message");
		$_range_input = <STDIN>; 
		$_range_input = CFI::clean_string ($_range_input);
		if ( $_range_input =~ /^q$/i ) {
			$_range_input = undef; last;
		};
		print STDOUT "\n";
		$_valid_range_input = validate_range_input ($_range_input, $_max_limit, $_input_type);
	} #End of UNTIL for validating system choices

	return $_range_input;

}; #End of sub get_range_input ($$);

##### Defining sub-routine #####

sub get_choice ($$) {

	my ( $_message, $def_answer ) = @_;
	my $choice;
	
	until ( defined $choice && $choice =~ /^(?:y|yes|n|no|q|quit)$/i ) {
		print STDOUT "\n";
		CFI::print_n_bold ("$_message");
		$choice = <STDIN>;
		$choice = CFI::clean_string $choice;
		$choice = $def_answer if ( $choice =~ /^$/ );
	}; #End of UNTIL to get choice

	return $choice;

}; #End of sub get_choice ($$)

##### Defining sub-routine #####

sub select_from_list ($$$) {

	my ($_list, $_message, $_selection_mode) = @_;
	my $_selected_items = undef;

	print STDOUT "\n";
	CFI::print_n_bold ($_message);
	my $i = 0;
	map { $i++; print STDOUT "\t$i) $_\n"; } @{$_list};
	my $_selection_input = get_range_input ( $i, $_selection_mode );

	if ( defined $_selection_input ) {
		$_selected_items = get_array_elements ( $_list, $_selection_input);
	}; 

	return $_selected_items;

}; #End of sub select_from_list ($$$)

##### Defining sub-routine #####

sub set_global_value ($$$) {

	my ($_new_value, $_value_type, $_global_paras) = @_;
	my $_global_value = undef;
			
	my $set_global_value = get_choice ("Do you want to set Global Para: $_value_type=$_new_value? [y/n] (n) - ", "n");
				
	if ( $set_global_value =~ /^(?:y|yes)$/i ) {
		$_global_paras->{$_value_type} = $_new_value;
		$_global_value = $_new_value;
	};

	return $_global_value;

}; #end of set_global_value ($$$)

##### Defining sub-routine #####

sub override_global_value ($$) {

	my ($_global_value, $_global_value_name) = @_;

	my $_override_global_value = get_choice ("Do you want to override Global Para: $_global_value_name=$_global_value? [y/n] (n) - ", "n");

	$_override_global_value = 0 if ($_override_global_value =~ /^(?:n|no)$/); 	
	$_override_global_value = 1 if ($_override_global_value =~ /^(?:y|yes)$/); 	

	return $_override_global_value;
	
}; #End of  sub override_global_value

##### Defining sub-routine #####

sub validate_range_input ($$$) {

	my ( $_input, $_max_range, $_selection_type ) = @_;
	my $_valid_range_input = 1;
	my @_input_nos = split /\s+/, $_input;
	my @_invalid_input_nos;

	if ( $_selection_type eq "S" && scalar @_input_nos > 1 ) {
		print STDOUT "Single choice is expected\n";
		$_valid_range_input = 0;
		return $_valid_range_input;
	};

	my (%_uniq_input, @_duplicate_input);

	foreach my $_input_no ( @_input_nos ) {

		if ( $_uniq_input{$_input_no} ) {
			push @_duplicate_input, $_input_no;			
			$_valid_range_input = 0;
		} else {
			$_uniq_input{$_input_no} = 1;
		};

		if ( $_input_no !~ /^\d+$/ ) {
			CFI::print_n_bold ("$_input_no is not numeric\n");
			$_valid_range_input = 0;
			return $_valid_range_input;
		};

		if ( $_input_no < 1 || $_input_no > $_max_range ) {
			push @_invalid_input_nos, $_input_no;
			$_valid_range_input = 0;
		};

	}; #End of FOREACH to validate each system number selected

	if ( scalar @_invalid_input_nos ) {
		CFI::print_n_bold ("Below numbers are out of range: 1-$_max_range -\n\t");
		map { print STDOUT "$_ " } @_invalid_input_nos;
		print STDOUT "\n\n";
	};

	if ( scalar @_duplicate_input ) {
		CFI::print_n_bold ("Below numbers are entered for more than 1 time: -\n\t");
		map { print STDOUT "$_ " } @_duplicate_input;
		print STDOUT "\n\n";
	};

	return $_valid_range_input;

}; #End of validate_range_input ($)

##### Defining sub-routine #####

sub get_array_elements ($$) {

	my ( $_array_ref, $_index_list ) = @_;

	my @_index_nos = split /\s+/, $_index_list;

	my $_array_elements = undef;

	foreach my $_index_no ( split /\s+/, $_index_list ) {

		for ( my $i = 0; $i < scalar @{$_array_ref}; $i++) {

			if ( ($_index_no-1) == $i ) {
				push @{$_array_elements}, $_array_ref->[$i];
				last;
			};
		}; #End of FOR to loop over each element in array

	}; #End of FOREACH to loop over each element in index list
	
	return $_array_elements;

}; #End of get_array_elements ($$)

##### Defining sub-routine #####

sub get_timestamp () {
	
	my %_month_hash = (
		Jan => 1, Feb => 2, Mar => 3, Apr => 4, May => 5, Jun => 6,
		Jul => 7, Aug => 8, Sep => 9, Oct => 10, Nov => 11, Dec => 12
	);

	my $_localtime = localtime;
	my @_time_fields = split /\s+/, $_localtime;
	my $_mon = $_month_hash{$_time_fields[1]};
	$_time_fields[3] =~ s/:/./g;	
	
	my $_time_stamp = $_time_fields[4] . "-" . $_mon . "-" . $_time_fields[2] . "_" . $_time_fields[3];

	return $_time_stamp;
}; #End of sub get_timestamp ()

##### Defining sub-routine #####

sub get_log_filepath ($$) {

	my ( $_log_base_dir, $_prepend ) = @_;

	$_prepend .= "_";
	my $_logfilename = $_prepend . $$ . ".log";
	my $_logfilepath = File::Spec->catfile ( $_log_base_dir, $_logfilename );

	return $_logfilepath;

}; #End of sub get_log_filepath ($$);

##### Defining sub-routine #####

sub browse ($) {

	my $_input = shift;

	if ( -d $_input ) {

		my $_succ_open_dir = opendir ( INDIR, $_input );

		#my @_dir_contents = grep { -f "$_selection/$_" } readdir(INDIR); close INDIR;
		my @_dir_contents;

		if ( $_succ_open_dir ) {
			foreach my $_dir_content ( sort readdir(INDIR) ) {
				if ( $_dir_content !~ /(?:^\.|^CVS$)/ ) { push @_dir_contents, $_dir_content };
			};
			close INDIR;
		};

		my $_selection = CFI::select_from_list ( \@_dir_contents, "Directory contents:\n", "S");

		return $_selection unless ( defined $_selection );

		$_selection = $_selection->[0];
		$_input = File::Spec->catfile ($_input, $_selection);
		$_input = browse ($_input) if ( -d $_input );

	}; #End of IF to present directory contents for selection

	return $_input;

}; #End of sub browse ();

##### Defining sub-routine #####

sub get_next_file ($$$) {
	
	my ( $_dirpath, $_filename_prefix, $_file_type ) = @_;

=pod	
	This function gives the name of the next file matching the
	$_filename_prefix and then incrementing the cnt number.
	e.g. If prefix is 'test_input_' and filetype is 'dat'; then
	function will return 'test_input_1.dat' if dirpath do not
	have any file by that name else it will return 'test_input_2.dat'
	if 'test_input_1.dat' is already existing.
=cut

	$_file_type = "." . $_file_type;
	my $_file_search_pat = $_filename_prefix . "*" . $_file_type;
	my @_files = sort ( glob ("$_dirpath/$_file_search_pat") );

	my ( @_suffix_nos, @_sorted_suffix_nos);

	foreach my $_file (@_files) {
		next unless ( $_file =~ /$_filename_prefix(\d+)$_file_type$/ );
		push @_suffix_nos, $1;
	} #End of FOREACH loop to process each tc status file

	my $_filename;

	if ( scalar @_suffix_nos) {
		@_sorted_suffix_nos = sort {$a <=> $b} @_suffix_nos;
		my $_latest_suffix_no = $_sorted_suffix_nos[$#_sorted_suffix_nos];
		$_filename = $_filename_prefix . ++$_latest_suffix_no . $_file_type;
	} else {
		$_filename = $_filename_prefix . "1" . $_file_type;
	} #End of IF for deciding $_filename_prefixfilename

	my $_filepath = File::Spec->catfile ( $_dirpath, $_filename );

	return $_filepath;

}; #End of get_install_status_filepath ($)

#### Defining sub-routine ####

sub get_lines ($) {

	my $_file = shift;
	my $lines = undef;

	open ( FILE, $_file ) or warn "Could not open QAR - $_file";

	while ( <FILE> ) {
		chomp; s/^\s+//g; s/\s+$//g; #celan input
		next if /^$/; #skip balnk line
		next if /^#/; #skip comment line
		push @{$lines}, $_;
	};

	return $lines;

};# End of sub get_file_hash ($)

##### Defining sub-routine #####

sub convert_string_to_reg_expn ($) {

	my $_string = shift;
	my ($_reg_expn, $_reg_expn_sep);

	if ( $_string =~ '\.' ) {
		$_reg_expn_sep = '\.';
	} elsif ( $_string =~ '-' ) {
		$_reg_expn_sep = '-';
	};

	my @_string_parts = split /$_reg_expn_sep/, $_string;

	for( my $_str_part_cnt = 0; $_str_part_cnt < scalar @_string_parts; $_str_part_cnt++ ) {

		my $_string_part = $_string_parts[$_str_part_cnt];
		my @_chars = split //, $_string_part;
		my($_alpha_digit_cnt, $_char_cnt) = (0, 0);
		my $_alpha_digit;
		my $_chars_cnt = scalar @_chars;

		foreach my $_char ( @_chars ) {

			my $_found_alpha_digit;

			if ( $_char =~ /[A-Za-z]/ ) {
				$_found_alpha_digit = "w";
			} elsif ($_char =~ /\d/) {
				$_found_alpha_digit = "d";
			};

			if ( ! defined $_alpha_digit ) {

				$_alpha_digit = $_found_alpha_digit;

				if ( ! defined $_reg_expn ) {
					if ( $_found_alpha_digit eq "w" ) {
						$_reg_expn = "[A-Za-z]";
					} elsif ( $_found_alpha_digit eq "d" ) {
						$_reg_expn = "\\d";
					};
				} else {
					if ( $_found_alpha_digit eq "w" ) {
						$_reg_expn .= "[A-Za-z]";
					} elsif ( $_found_alpha_digit eq "d" ) {
						$_reg_expn .= "\\d";
					};
				};

				$_alpha_digit_cnt++; $_char_cnt++;

				if ( $_alpha_digit_cnt == $_chars_cnt ) {
					$_reg_expn .= '{' . $_alpha_digit_cnt . '}';
				};

			} else {

				if ( $_alpha_digit eq $_found_alpha_digit ) {

					$_alpha_digit_cnt++; $_char_cnt++;

					if ( $_alpha_digit_cnt == $_chars_cnt ) {
						$_reg_expn .= '{' . $_alpha_digit_cnt . '}';
					};

				} else {

					$_alpha_digit = $_found_alpha_digit;

					if ( $_found_alpha_digit eq "w" ) {
						$_reg_expn .= '{' . $_alpha_digit_cnt . '}' . "[A-Za-z]" ;
					} elsif ( $_found_alpha_digit eq "d" ) {
						$_reg_expn .= '{' . $_alpha_digit_cnt . '}' . "\\d";
					};

					$_alpha_digit_cnt = 1; $_char_cnt++;

					if ( $_char_cnt == $_chars_cnt ) {
						$_reg_expn .=  '{' . $_alpha_digit_cnt . '}';
					};

				};
				
			};

		}; #End of FOR to loop over each char in string part

		if ( $_str_part_cnt < (scalar @_string_parts -1) ) {
			$_reg_expn .= $_reg_expn_sep;
		};
	
	}; #End of FOREACH to loop over each string part

	return $_reg_expn;

}; # End of sub convert_string_to_reg_expn ($)

##### Defining sub-routine #####

sub get_filepath_to_write ($$) {

	my ($_message, $_def_filename) = @_;
	my $_working_dir = cwd ();

	my $_filepath = CFI::get_input ($_message, $_def_filename);

	my ($_filename, $_dirpath);

	if ( $_filepath =~ /\// ) {
		($_filename, $_dirpath ) = fileparse ($_filepath);	
		$_dirpath = CFI::get_absolute_path ($_working_dir, $_dirpath);
	} else {
		$_filename = $_filepath; 
		$_dirpath = $_working_dir;
	};

	$_filepath = File::Spec->catfile ($_dirpath, $_filename);

	if ( -e $_filepath ) {

		print "\t$_filepath already exists.\n\n";
		my $_overwrite_file = CFI::get_choice ("Do you want to over-write abvoe file? [y/n] (n) - ", "n");

		if ( $_overwrite_file =~ /^(?:n|no)$/i ) {
			$_filepath = undef;
		};	

		if ( defined $_filepath && ! -w $_filepath && $_overwrite_file =~ /^(?:y|yes)$/i ) {
			print "\nCould not write to - $_filepath\n\n";
			$_filepath = undef;
		};

		return $_filepath;

	} else {

		if ( -e $_dirpath ) {

			if ( ! -w $_dirpath ) {
				print "\nCould not write to - $_filepath";
				$_filepath = undef;
			};

		} else {
	
			eval {
				mkpath ( $_dirpath, {verbose => 0, mode => 0755} );
			};

			if ( $@ ) {
				print "\nCould not create directory - $_dirpath";
				$_filepath = undef;
			};

		};

		return $_filepath;

	};

}; #get_filepath_to_write ($$)

1; #Indicates success of package loading
