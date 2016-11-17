;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  This file was originally written by Bradley S. Meyer and Michael J. Bojazi.
;
;  This is free software; you can redistribute it and/or modify it
;  under the terms of the GNU General Public License as published by
;  the Free Software Foundation; either version 3 of the License, or
;  (at your option) any later version.
;  but WITHOUT ANY WARRANTY; without even the implied warranty of
;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;  GNU General Public License for more details.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;+
; :Description:
;    IDL function to retrieve the mass fraction of one or more species in a 
;    given zone for a given group from a standard multi-zone hdf5 output file
;
; :Params:
;    file = the name of the input file
;    group = the group identifier (in the form 'Group 00030')
;    zone = a three-element vector identifying the zone
;    species = the name of the species (more than one as an array)
;
; :Returns:
;    a double of the mass fraction of one species or double array containing 
;    the mass fractions of multiple species in the zone for the group
;
; :Example:
;    IDL>print, h5_get_group_zone_species_mass_fractions( 'my_file.h5', 'Group 000
;    21', [1,0,0], 'mg24' )
;    IDL>print, h5_get_group_zone_species_mass_fractions( 'my_file.h5', 'Group 000
;    21', [1,0,0], ['mg24','mg25','mg26'] )
;-

function h5_get_group_zone_species_mass_fractions, file, group, zone, species

mass_fractions = h5_get_group_mass_fractions( file, group )
species_indices = h5_get_species_indices( file, species )
zone_index = h5_get_group_zone_index( file, group, zone ) 

x_array = [0.]

for n = 0, n_elements( species ) - 1 do begin
  x =$
    mass_fractions[species_indices[n],zone_index]
  x_array = [x_array,x]
endfor

return, x_array[1:n_elements( species )]

end
