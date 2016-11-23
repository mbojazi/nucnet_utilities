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
;    IDL function to retrieve the index of a given zone for a given group from 
;    a standard multi-zone hdf5 output file
;
; :Params:
;    file = the name of the input file
;    group = the group identifier (in the form 'Step 00030' or 
;            'Star 000000000195962')
;    zone = a three-element vector identifying the zone
;
; :Returns:
;    a long integer of the index of the zone for the group
;
; :Example (copy and paste):
;    (if my_output.h5)
;    IDL>print, h5_get_group_zone_index( 'my_output.h5', 'Step 00021', [4,9,7] )
;
;    (if my_stars.h5 or my_remnants.h5)
;    IDL>print, h5_get_group_zone_index( 'my_stars.h5', 'Star 000000000195962', [0,0,0] )
;-

function h5_get_group_zone_index, file, group, zone

zone_labels = h5_get_group_zone_labels( file, group )

if( n_elements( zone ) eq 1 ) then begin
  index = where( zone_labels.label_1 eq zone[0] )
endif
if( n_elements( zone ) eq 2 ) then begin
  index = where( zone_labels.label_1 eq zone[0]$
                 and zone_labels.label_2 eq zone[1] )
endif
if( n_elements( zone ) eq 3 ) then begin
  index = where( zone_labels.label_1 eq zone[0]$
                 and zone_labels.label_2 eq zone[1]$
                 and zone_labels.label_3 eq zone[2] )
endif

return, index

end
