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
;    IDL function to retrieve all group names (less the nuclear data) from a
;    standard multi-zone hdf5 output file
;
; :Params:
;    file = the name of the input file
;
; :Returns:
;    a string array containing the names of the groups
;
; :Example (copy and paste):
;    IDL>print, h5_get_group_names( 'my_file.h5' )
;-

function h5_get_group_names, file

file_id = h5f_open( file )

s_names = ['']

for n = 0, h5g_get_num_objs( file_id ) - 1 do begin
  s = h5g_get_obj_name_by_idx( file_id, n )

  if s ne 'Nuclide Data' then begin
    s_names = [s_names,s]
  endif
endfor
 
h5f_close, file_id

return, s_names[1:*]

end
