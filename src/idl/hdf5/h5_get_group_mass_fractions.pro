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
;    IDL function to retrieve the mass fractions of all species in all zones
;    for a given group from a standard multi-zone hdf5 output file
;
; :Params:
;    file = the name of the input file
;    group = the group identifier (in the form 'Step 00030' or 
;            'Star 000000000195962')
;
; :Returns:
;    a two-dimensional array for the group containing doubles of the mass 
;    fractions of all species in all zones, the first dimension corresponding 
;    to each species and the second dimension corresponding to each zone
;    
; :Example (copy and paste):
;    (if my_output.h5)
;    IDL>print, h5_get_group_mass_fractions( 'my_output.h5', 'Step 00025' )
;    
;    (if my_stars.h5)
;    IDL>print, h5_get_group_mass_fractions( 'my_stars.h5', 'Star 000000000195962' )
;-

function h5_get_group_mass_fractions, file, group

file_id = h5f_open( file )
group_id = h5g_open( file_id, group )
mass_fractions_id = h5d_open( group_id, 'Mass Fractions' )

mass_fractions = h5d_read( mass_fractions_id )

h5d_close, mass_fractions_id
h5g_close, group_id
h5f_close, file_id

return, mass_fractions

end
