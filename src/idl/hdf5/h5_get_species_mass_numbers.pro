;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;  This file was originally written by Bradley S. Meyer and Michael J. Bojazi.
;
;  This is free software; you can redistribute it and/or modify it
;  under the terms of the GNU General Public License as published by
;  the Free Software Foundation; either version 3 of the License, or
;  (at your option) any later version.
;  but WITHOUT ANY WARRANTY; without even the implied warranty of
;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;  GNU General Public License for more details.
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;+
; :Description:
;    IDL function to retrieve the mass number of one or more species from a
;    standard multi-zone hdf5 output file
;
; :Params:
;    file = the name of the input file
;    species = the name of the species (more than one as an array)
;
; :Returns:
;    a ulong array containing the mass numbers of one or more species
;    
; :Example (copy and paste):
;    (if my_output.h5 or my_stars.h5)
;    IDL>print, h5_get_species_mass_numbers( 'my_output.h5', 'si28' )
;    IDL>print, h5_get_species_mass_numbers( 'my_stars.h5', ['si28','mn60'] )
;-

function h5_get_species_mass_numbers, file, species
 
file_id = h5f_open( file )
nuclide_data_id = h5d_open( file_id, 'Nuclide Data' )
 
nuclide_data = h5d_read( nuclide_data_id )
 
h5d_close, nuclide_data_id
h5f_close, file_id

index_array = [0]

for n = 0, n_elements( species ) - 1 do begin
  index = where( nuclide_data.name eq species[n] )
  index_array = [index_array,nuclide_data[index].a]
endfor

return, index_array[1:n_elements( species )]

end
