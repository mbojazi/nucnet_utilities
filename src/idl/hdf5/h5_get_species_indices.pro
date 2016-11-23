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
;    IDL function to retrieve the index of one or more species from a standard 
;    multi-zone hdf5 output file
;
; :Params:
;    file = the name of the input file
;    species = the name of the species (more than one as an array)
;
; :Returns:
;    a long integer of the index of one species or long-integer array 
;    containing the indices of multiple species
;    
; :Example (copy and paste):
;    IDL>print, h5_get_species_indices( 'my_file.h5', 'si28' )
;    IDL>print, h5_get_species_indices( 'my_file.h5', ['si28','mn60','n15'] )
;-

function h5_get_species_indices, file, species_names
 
file_id = h5f_open( file )
nuclide_data_id = h5d_open( file_id, 'Nuclide Data' )
nuclide_data = h5d_read( nuclide_data_id )
 
h5d_close, nuclide_data_id
h5f_close, file_id

index_array = [0]

for n = 0, n_elements( species_names ) - 1 do begin
  index = where( nuclide_data.name eq species_names[n] )
  index_array = [index_array,index]
endfor

return, index_array[1:n_elements( species_names )]

end
