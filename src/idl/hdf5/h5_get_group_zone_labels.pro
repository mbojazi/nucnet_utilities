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
;    IDL function to retrieve all zone labels for a given group from a standard 
;    multi-zone hdf5 output file
;
; :Params:
;    file = the name of the input file
;    group = the group identifier (in the form 'Group 00030')
;
; :Returns:
;    an array of structures, each structure (in the form 
;    { label_1 label_2 label_3 }) containing the labels of a zone for the group
;
; :Example:
;    IDL>print, h5_get_group_zone_labels( 'my_file.h5', 'Group 00021' )
;-

function h5_get_group_zone_labels, file, group
 
file_id = h5f_open( file )
group_id = h5g_open( file_id, group )
zone_labels_id = h5d_open( group_id, 'Zone Labels' )

zone_labels = h5d_read( zone_labels_id )

h5d_close, zone_labels_id
h5g_close, group_id
h5f_close, file_id

return, zone_labels

end
