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
;    IDL function to retrieve the value of one or more properties in all groups 
;    for a given zone from a standard multi-zone hdf5 output file
;
; :Params:
;    file = the name of the input file
;    zone = a three-element vector identifying the zone
;    property = an array of strings, each string 
;               (in the form 'name,tag_1 (optional),tag_2 (optional)') 
;               containing the name of the property to be retrieved and 
;               optional tag specifiers, or a string of the name and optional 
;               tag specifiers if only a single property is to be retrieved 
;               (see examples below)
;
; :Returns:
;    a two-dimensional array for the zone containing strings of the value of 
;    one or more properties in all groups, the first dimension corresponding to 
;    each property and the second dimension corresponding to each group 
;
; :Example (copy and paste):
;    (if my_output.h5)
;    IDL>print, h5_get_zone_properties_in_groups( 'my_output.h5', [4,9,7], ['time,0,0','zone mass,0,0'] )
;    IDL>print, h5_get_zone_properties_in_groups( 'my_output.h5', [4,9,7], ['time,0,0','zone mass,0'] )
;    IDL>print, h5_get_zone_properties_in_groups( 'my_output.h5', [4,9,7], ['time','zone mass,0,0'] )
;    IDL>print, h5_get_zone_properties_in_groups( 'my_output.h5', [4,9,7], ['time,0','zone mass,0'] )
;    IDL>print, h5_get_zone_properties_in_groups( 'my_output.h5', [4,9,7], ['time,0','zone mass'] )
;    IDL>print, h5_get_zone_properties_in_groups( 'my_output.h5', [4,9,7], ['time','zone mass'] )
;    IDL>print, h5_get_zone_properties_in_groups( 'my_output.h5', [4,9,7], 'time,0,0' )
;    IDL>print, h5_get_zone_properties_in_groups( 'my_output.h5', [4,9,7], 'zone mass,0' )
;    IDL>print, h5_get_zone_properties_in_groups( 'my_output.h5', [4,9,7], 'time' )
;    
;    (if my_stars.h5 or my_remnants.h5)
;    IDL>print, h5_get_zone_properties_in_groups( 'my_stars.h5', [0,0,0], ['formation time,0,0','real y,0,0'] )
;    IDL>print, h5_get_zone_properties_in_groups( 'my_stars.h5', [0,0,0], ['formation time,0,0','real y,0'] )
;    IDL>print, h5_get_zone_properties_in_groups( 'my_remnants.h5', [0,0,0], ['formation time','real y,0,0'] )
;    IDL>print, h5_get_zone_properties_in_groups( 'my_remnants.h5', [0,0,0], ['formation time,0','real y,0'] )
;    IDL>print, h5_get_zone_properties_in_groups( 'my_stars.h5', [0,0,0], ['formation time,0','real y'] )
;    IDL>print, h5_get_zone_properties_in_groups( 'my_remnants.h5', [0,0,0], ['formation time','real y'] )
;    IDL>print, h5_get_zone_properties_in_groups( 'my_stars.h5', [0,0,0], 'formation time,0,0' )
;    IDL>print, h5_get_zone_properties_in_groups( 'my_stars.h5', [0,0,0], 'real y,0' )
;    IDL>print, h5_get_zone_properties_in_groups( 'my_remnants.h5', [0,0,0], 'formation time' )
;-

function h5_get_zone_properties_in_groups, file, zone, property
 
file_id = h5f_open( file )

property_array = make_array( n_elements( property ), 1, /string, value = '' )

for n = 0, h5g_get_num_objs( file_id ) - 1 do begin
  s = h5g_get_obj_name_by_idx( file_id, n )

  if s ne 'Nuclide Data' then begin
    prop = h5_get_group_zone_properties( file, s, zone, property )
    property_array = [[property_array],[prop]]
  endif
endfor

h5f_close, file_id

return, property_array[0:n_elements( property ) - 1,1:*]

end
