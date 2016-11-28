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
;    IDL function to retrieve the value of one or more properties in all zones 
;    for a given group from a standard multi-zone hdf5 output file
;
; :Params:
;    file = the name of the input file
;    group = the group identifier (in the form 'Step 00030' or 
;            'Star 000000000195962')
;    property = an array of strings, each string 
;               (in the form 'name,tag_1 (optional),tag_2 (optional)') 
;               containing the name of the property to be retrieved and 
;               optional tag specifiers, or a string of the name and optional 
;               tag specifiers if only a single property is to be retrieved 
;               (see examples below)
;    
; :Returns:
;    a two-dimensional array for the group containing strings of the value of 
;    one or more properties in all zones, the first dimension corresponding to 
;    each property and the second dimension corresponding to each zone 
;    
; :Example (copy and paste):
;    (if my_output.h5)
;    IDL>print, h5_get_group_properties_in_zones( 'my_output.h5', 'Step 00021', ['time,0,0','zone mass,0,0'] )
;    IDL>print, h5_get_group_properties_in_zones( 'my_output.h5', 'Step 00021', ['time,0,0','zone mass,0'] )
;    IDL>print, h5_get_group_properties_in_zones( 'my_output.h5', 'Step 00021', ['time','zone mass,0,0'] )
;    IDL>print, h5_get_group_properties_in_zones( 'my_output.h5', 'Step 00021', ['time,0','zone mass,0'] )
;    IDL>print, h5_get_group_properties_in_zones( 'my_output.h5', 'Step 00021', ['time,0','zone mass'] )
;    IDL>print, h5_get_group_properties_in_zones( 'my_output.h5', 'Step 00021', ['time','zone mass'] )
;    IDL>print, h5_get_group_properties_in_zones( 'my_output.h5', 'Step 00021', 'time,0,0' )
;    IDL>print, h5_get_group_properties_in_zones( 'my_output.h5', 'Step 00021', 'zone mass,0' )
;    IDL>print, h5_get_group_properties_in_zones( 'my_output.h5', 'Step 00021', 'time' )
;    
;    (if my_stars.h5 or my_remnants.h5)
;    IDL>print, h5_get_group_properties_in_zones( 'my_stars.h5', 'Star 000000000195962', ['formation time,0,0','real y,0,0'] )
;    IDL>print, h5_get_group_properties_in_zones( 'my_stars.h5', 'Star 000000000195962', ['formation time,0,0','real y,0'] )
;    IDL>print, h5_get_group_properties_in_zones( 'my_remnants.h5', 'Star 000000000195962', ['formation time','real y,0,0'] )
;    IDL>print, h5_get_group_properties_in_zones( 'my_remnants.h5', 'Star 000000000195962', ['formation time,0','real y,0'] )
;    IDL>print, h5_get_group_properties_in_zones( 'my_stars.h5', 'Star 000000000195962', ['formation time,0','real y'] )
;    IDL>print, h5_get_group_properties_in_zones( 'my_remnants.h5', 'Star 000000000195962', ['formation time','real y'] )
;    IDL>print, h5_get_group_properties_in_zones( 'my_stars.h5', 'Star 000000000195962', 'formation time,0,0' )
;    IDL>print, h5_get_group_properties_in_zones( 'my_stars.h5', 'Star 000000000195962', 'real y,0'] )
;    IDL>print, h5_get_group_properties_in_zones( 'my_remnants.h5', 'Star 000000000195962', 'formation time' )
;-

function h5_get_group_properties_in_zones, file, group, property
 
n_zones = h5_get_number_of_zones( file, group ) 
zone_labels = h5_get_group_zone_labels( file, group )

property_array = make_array( n_elements( property ), 1, /string, value = '' )

for n = 0, n_zones - 1 do begin
  zone =$
    [zone_labels[n].label_1, zone_labels[n].label_2, zone_labels[n].label_3]

  property_array =$
    [$
      [property_array],$
      [h5_get_group_zone_properties( file, group, zone, property )]$
    ]
endfor

return, property_array[0:n_elements( property ) - 1,1:n_zones]

end
