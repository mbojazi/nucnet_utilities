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
;    IDL function to retrieve the number of groups from a standard multi-zone 
;    hdf5 output file (less the nuclide data group)
;
; :Params:
;    file = the name of the input file
;
; :Returns:
;    a long integer of the number of groups    
;    
; :Example (copy and paste):
;    IDL>print, h5_get_number_of_groups( 'my_file.h5' )
;-

function h5_get_number_of_groups, file

file_id = h5f_open( file )
n_groups = h5g_get_nmembers( file_id, '/' )
h5f_close, file_id

return, n_groups - 1 

end
