#!/opt/VRTSperl/bin/perl -w

use Inline C;
use strict;

my $go = 1;
$SIG{INT} = sub{ $go = 0;
                 &detach_m(); #detach the shared mem 
                 &close_m()   #close up the shared mem 
                };

my $segment_id = init_m();
print "shmid-> $segment_id\n";
my $i = 0;

while($go){
          send_m($i);
          $i++;
          select(undef,undef,undef,1);
          print "i [$i]\n";
          last if ! $go;
        }

__END__
__C__
/* code adapted from */ 
/* http://www.advancedlinuxprogramming.com/alp-folder */ 
#include <stdio.h> 
#include <sys/shm.h> 
#include <sys/stat.h> 
 
int segment_id; 
char* shared_memory; 
struct shmid_ds shmbuffer; 
int segment_size; 
const int shared_segment_size = 0x800; 
 
int init_m() 
{ 
  /* Allocate a shared memory segment.  */ 
  segment_id = shmget (IPC_PRIVATE, shared_segment_size, 
                       IPC_CREAT | IPC_EXCL | S_IRUSR | S_IWUSR); 
 
  /* Attach the shared memory segment.  */ 
  shared_memory = (char*) shmat (segment_id, 0, 0); 
  printf ("shared memory attached at address %p\n id->%d\n",  
           shared_memory,segment_id); 
   
  /* Determine the segment's size.  */ 
  shmctl (segment_id, IPC_STAT, &shmbuffer); 
  segment_size = shmbuffer.shm_segsz; 
  printf ("segment size: %d\n", segment_size); 
 
return(segment_id); 
} 
 
int send_m (int i) {     
   /* Write a string to the shared memory segment.  */ 
   sprintf (shared_memory, "%d",i);  
   return 0; 
  } 
 
int detach_m(){ 
  /* Detach the shared memory segment.  */ 
  shmdt (shared_memory); 
  return 0; 
} 
 
int close_m(){ 
  /* Deallocate the shared memory segment.  */ 
  shmctl (segment_id, IPC_RMID, 0); 
 
  return 0; 
}
