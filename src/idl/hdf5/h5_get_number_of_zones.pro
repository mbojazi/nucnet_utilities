;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;  This file was originally written by Bradley S. Meyer and Michael J. Bojazi.
;
;  This is free software; you can redistribute it and/or modify it
;  under the terms of the GNU General Public License as published by
;  the Free Software Foundation; either version 2 of the License, or
;  (at your option) any later version.
;  but WITHOUT ANY WARRANTY; without even the implied warranty of
;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;  GNU General Public License for more details.
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;+
; :Description:
;    IDL function to retrieve the number of zones for a given group from a 
;    standard multi-zone hdf5 output file
;
; :Params:
;    file = the name of the input file
;    group = the group identifier (in the form 'Step 00030' or 
;            'Star 000000000195962')
;
; :Returns:
;    a long integer of the number of zones for the group    
;
; :Example (copy and paste):
;    (if my_output.h5)
;    IDL>print, h5_get_number_of_zones( 'my_output.h5', 'Step 00021' )
;
;    (if my_stars.h5 or my_remnants.h5)
;    IDL>print, h5_get_number_of_zones( 'my_stars.h5', 'Star 000000000195962' )
;-

function h5_get_number_of_zones, file, group

file_id = h5f_open( file )
group_id = h5g_open( file_id, group )

n_zones = h5g_get_nmembers( group_id, 'Zone Properties' )

h5g_close, group_id
h5f_close, file_id

return, n_zones

end
