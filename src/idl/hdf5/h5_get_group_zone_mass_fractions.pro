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
;    IDL function to retrieve the mass fraction of one or more species in a 
;    given zone for a given group from a standard multi-zone hdf5 output file
;
; :Params:
;    file = the name of the input file
;    group = the group identifier (in the form 'Step 00030' or 
;            'Star 000000000195962')
;    zone = a three-element vector identifying the zone
;    species = the name of the species (more than one as an array)
;
; :Returns:
;    a double array containing the mass fraction of one or more species in the 
;    zone for the group
;
; :Example (copy and paste):
;    (if my_output.h5)
;    IDL>print, h5_get_group_zone_mass_fractions( 'my_output.h5', 'Step 00021', [4,9,7], 'mg24' )
;    IDL>print, h5_get_group_zone_mass_fractions( 'my_output.h5', 'Step 00021', [4,9,7], ['mg24','mg25','mg26'] )
;
;    (if my_stars.h5 or my_remnants.h5)
;    IDL>print, h5_get_group_zone_mass_fractions( 'my_stars.h5', 'Star 000000000195962', [0,0,0], 'mg24' )
;    IDL>print, h5_get_group_zone_mass_fractions( 'my_remnants.h5', 'Star 000000000195962', [0,0,0], ['mg24','mg25','mg26'] )
;-

function h5_get_group_zone_mass_fractions, file, group, zone, species

mass_fractions = h5_get_group_mass_fractions( file, group )
species_indices = h5_get_species_indices( file, species )
zone_index = h5_get_group_zone_index( file, group, zone ) 

x_array = [0.]

for n = 0, n_elements( species ) - 1 do begin
  x = mass_fractions[species_indices[n],zone_index]
  x_array = [x_array,x]
endfor

return, x_array[1:n_elements( species )]

end
