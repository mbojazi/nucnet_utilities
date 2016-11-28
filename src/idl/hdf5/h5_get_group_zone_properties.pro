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
;    IDL function to retrieve the value of one or more properties in a given 
;    zone for a given group from a standard multi-zone hdf5 output file
;
; :Params:
;    file = the name of the input file
;    group = the group identifier (in the form 'Step 00030' or 
;            'Star 000000000195962')
;    zone = a three-element vector identifying the zone
;    property = an array of strings, each string 
;               (in the form 'name,tag_1 (optional),tag_2 (optional)') 
;               containing the name of the property to be retrieved and 
;               optional tag specifiers, or a string of the name and optional 
;               tag specifiers if only a single property is to be retrieved 
;               (see examples below)
;    
; :Returns:
;    a string array containing the value of one or more properties in the zone 
;    for the group
;    
; :Example (copy and paste):
;    (if my_output.h5)
;    IDL>print, h5_get_group_zone_properties( 'my_output.h5', 'Step 00021', [4,9,7], ['time,0,0','zone mass,0,0'] )
;    IDL>print, h5_get_group_zone_properties( 'my_output.h5', 'Step 00021', [4,9,7], ['time,0,0','zone mass,0'] )
;    IDL>print, h5_get_group_zone_properties( 'my_output.h5', 'Step 00021', [4,9,7], ['time','zone mass,0,0'] )
;    IDL>print, h5_get_group_zone_properties( 'my_output.h5', 'Step 00021', [4,9,7], ['time,0','zone mass,0'] )
;    IDL>print, h5_get_group_zone_properties( 'my_output.h5', 'Step 00021', [4,9,7], ['time,0','zone mass'] )
;    IDL>print, h5_get_group_zone_properties( 'my_output.h5', 'Step 00021', [4,9,7], ['time','zone mass'] )
;    IDL>print, h5_get_group_zone_properties( 'my_output.h5', 'Step 00021', [4,9,7], 'time,0,0' )
;    IDL>print, h5_get_group_zone_properties( 'my_output.h5', 'Step 00021', [4,9,7], 'zone mass,0' )
;    IDL>print, h5_get_group_zone_properties( 'my_output.h5', 'Step 00021', [4,9,7], 'time' )
;    
;    (if my_stars.h5 or my_remnants.h5)
;    IDL>print, h5_get_group_zone_properties( 'my_stars.h5', 'Star 000000000195962', [0,0,0], ['formation time,0,0','real y,0,0'] )
;    IDL>print, h5_get_group_zone_properties( 'my_stars.h5', 'Star 000000000195962', [0,0,0], ['formation time,0,0','real y,0'] )
;    IDL>print, h5_get_group_zone_properties( 'my_remnants.h5', 'Star 000000000195962', [0,0,0], ['formation time','real y,0,0'] )
;    IDL>print, h5_get_group_zone_properties( 'my_remnants.h5', 'Star 000000000195962', [0,0,0], ['formation time,0','real y,0'] )
;    IDL>print, h5_get_group_zone_properties( 'my_stars.h5', 'Star 000000000195962', [0,0,0], ['formation time,0','real y'] )
;    IDL>print, h5_get_group_zone_properties( 'my_remnants.h5', 'Star 000000000195962', [0,0,0], ['formation time','real y'] )
;    IDL>print, h5_get_group_zone_properties( 'my_stars.h5', 'Star 000000000195962', [0,0,0], 'formation time,0,0' )
;    IDL>print, h5_get_group_zone_properties( 'my_stars.h5', 'Star 000000000195962', [0,0,0], 'real y,0' )
;    IDL>print, h5_get_group_zone_properties( 'my_remnants.h5', 'Star 000000000195962', [0,0,0], 'formation time' )
;-

function h5_get_group_zone_properties, file, group, zone, property

file_id = h5f_open( file )
group_id = h5g_open( file_id, group )
props_id = h5g_open( group_id, 'Zone Properties' )
zone_id =$
  h5d_open($
    props_id,$
    strtrim( string( h5_get_group_zone_index( file, group, zone ) ), 2 )$
  )

s = h5d_read( zone_id )

h5d_close, zone_id
h5g_close, props_id
h5g_close, group_id
h5f_close, file_id

property_array = ['']

for n = 0, n_elements( property ) - 1 do begin
  i = 0
  cnt = 0

  while( i ne -1 ) do begin
    i = strpos( property[n], ',', i )
    
    if( i ne -1 ) then begin
      cnt = cnt + 1
      i = i + 1   
    endif
  endwhile
  
  str = strsplit( property[n], ',', /extract )

  if( cnt gt 2 ) then begin
    return, "Too many substrings in " + property[n] 
  endif
  if( cnt eq 2 ) then begin
    prop = where( s.name eq str[0] and s.tag_1 eq str[1] and s.tag_2 eq str[2] )
  endif   
  if( cnt eq 1 ) then begin
    prop = where( s.name eq str[0] and s.tag_1 eq str[1] )
  endif   
  if( cnt eq 0 ) then begin
    prop = where( s.name eq property[n] )
  endif   

  property_array = [property_array,s[prop].value]      
endfor

return, property_array[1:n_elements( property )]

end
