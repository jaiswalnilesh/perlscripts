#
# $Source: /project/hal_test/iauto/lib/Systems.pm,v $
#
# $Id: Systems.pm,v 1.10 2009/06/30 12:20:19 hmarne Exp $
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
package Systems;

use strict;
use warnings;
use CFI;

sub new () {

	my $_this = shift;
	my $_class = ref $_this || $_this;

	my $_run_envrmnt = shift;
	my $_system_database_filepath = $_run_envrmnt->{System_Database_File};
	my $_system_database = CFI::get_json_object ($_system_database_filepath);

	bless $_system_database, $_class;
	return $_system_database;

} #Constructor

sub get_system_creds () {

	my $_this = shift;
	my $_class = ref $_this || $_this;

	my $_hostname = shift;
	my $_creds = undef;
	
	if ( exists $_this->{$_hostname} ) {

		if ( exists $_this->{$_hostname}{Login} && exists $_this->{$_hostname}{Password} && exists $_this->{$_hostname}{ConnectionType} ) {

				$_creds->{Login} = $_this->{$_hostname}{Login};
				$_creds->{Password} = $_this->{$_hostname}{Password};
				$_creds->{ConnectionType} = $_this->{$_hostname}{ConnectionType};
				if ( defined $_this->{$_hostname}{OS} ) {
					$_creds->{OS} = $_this->{$_hostname}{OS};
				};

		}; 

	}; 

	return $_creds;

}; #End of sub-routine

1; #Indicates success of package inclusion
