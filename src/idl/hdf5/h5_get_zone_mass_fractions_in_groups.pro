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
;    IDL function to retrieve the mass fraction of one or more species for all 
;    groups in a given zone from a standard multi-zone hdf5 output file
;
; :Params:
;    file = the name of the input file
;    zone = a three-element vector identifying the zone
;    species = the name of the species (more than one as an array)
;
; :Returns:
;    a double of the mass fraction of one species for the zone in all groups; 
;    or a two-dimensional array for the zone containing doubles of the mass 
;    fractions of multiple species in all groups, the first dimension 
;    corresponding to each species and the second dimension corresponding to 
;    each group 
;
; :Example (copy and paste):
;    (if my_output.h5)
;    IDL>print, h5_get_zone_mass_fractions_in_groups( 'my_output.h5', [4,9,7], 'Step 00021', 'mg24' )
;    IDL>print, h5_get_zone_mass_fractions_in_groups( 'my_output.h5', [4,9,7], 'Step 00021', ['mg24','mg25','mg26'] )
;    
;    (if my_stars.h5 or my_remnants.h5)
;    IDL>print, h5_get_zone_mass_fractions_in_groups( 'my_stars.h5', [0,0,0], 'Star 000000000195962', 'mg24' )
;    IDL>print, h5_get_zone_mass_fractions_in_groups( 'my_remnants.h5', [0,0,0], 'Star 000000000195962', ['mg24','mg25','mg26'] )
;-

function h5_get_zone_mass_fractions_in_groups, file, zone, species

file_id = h5f_open( file )

x_array = make_array( n_elements( species ), 1, /double, value = 0. )

for n = 0, h5g_get_num_objs( file_id ) - 1 do begin
  s = h5g_get_obj_name_by_idx( file_id, n )

  if s ne 'Nuclide Data' then begin
    x = h5_get_group_zone_species_mass_fractions( file, s, zone, species )
    x_array = [[x_array],[x]]
  endif
endfor

return, x_array[0:n_elements( species ) - 1,1:h5g_get_num_objs( file_id ) - 1]

h5f_close, file_id

end
