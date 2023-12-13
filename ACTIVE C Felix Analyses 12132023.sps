* Encoding: UTF-8.

*Try to Filter without Excluding for Baseline Depression for memory analyses. 

USE ALL.
COMPUTE filter_$=(intgrp ne 2 and intgrp ne 3).
VARIABLE LABELS filter_$ 'intgrp ne 1 and intgrp ne 2 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.


*Try to Filter and Excluding for Baseline Depression memory analyses. 
USE ALL.
COMPUTE filter_$=(intgrp ne 2 and intgrp ne 3 and dep_9_bin_b ne 1).
VARIABLE LABELS filter_$ 'intgrp ne 1 and intgrp ne 2 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.  

*Using continuous depression score. 
GENLINMIXED
  /FIELDS TARGET=  memcb
    /TARGET_OPTIONS DISTRIBUTION=NORMAL LINK=IDENTITY
/FIXED EFFECTS= visit yrseduc intgrp  cesdtot_b cesdtot intgrp*visit  cesdtot_wp*visit intgrp*cesdtot_wp
intgrp*visit*cesdtot_wp Race female baseage basemmse USE_INTERCEPT=TRUE
    /RANDOM USE_INTERCEPT=TRUE SUBJECTS=ID  COVARIANCE_TYPE=VARIANCE_COMPONENTS.    

*Using depression cutoff. 
GENLINMIXED
  /FIELDS TARGET=  memcb
    /TARGET_OPTIONS DISTRIBUTION=NORMAL LINK=IDENTITY
/FIXED EFFECTS= visit yrseduc intgrp  depression intgrp*visit  depression*visit intgrp*depression
intgrp*visit*depression Race female baseage basemmse USE_INTERCEPT=TRUE
    /RANDOM USE_INTERCEPT=TRUE SUBJECTS=ID  COVARIANCE_TYPE=VARIANCE_COMPONENTS.    


*Try to Filter without Excluding for Baseline Depression for reasoning analyses. 


DATASET ACTIVATE DataSet1.
USE ALL.
COMPUTE filter_$=(intgrp ne 1 and intgrp ne 3).
VARIABLE LABELS filter_$ 'intgrp ne 1 and intgrp ne 2 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

*Try to Filter  Excluding for Baseline Depression for reasoning analyses. 
DATASET ACTIVATE DataSet1.
USE ALL.
COMPUTE filter_$=(intgrp ne 1 and intgrp ne 3 and dep_9_bin_b ne 1).
VARIABLE LABELS filter_$ 'intgrp ne 1 and intgrp ne 2 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

*Try as continuous depression score.
GENLINMIXED
  /FIELDS TARGET=  reascb
    /TARGET_OPTIONS DISTRIBUTION=NORMAL LINK=IDENTITY
/FIXED EFFECTS= visit yrseduc intgrp  cesdtot_b cesdtot_wp intgrp*visit  cesdtot_b*visit intgrp*cesdtot_b
intgrp*visit*cesdtot_b Race female baseage basemmse USE_INTERCEPT=TRUE
    /RANDOM USE_INTERCEPT=TRUE SUBJECTS=ID  COVARIANCE_TYPE=VARIANCE_COMPONENTS.

*Using depression cutoff. 
GENLINMIXED
  /FIELDS TARGET= reascb
    /TARGET_OPTIONS DISTRIBUTION=NORMAL LINK=IDENTITY
/FIXED EFFECTS= visit yrseduc intgrp  depression  intgrp*visit  depression*visit intgrp*depression 
intgrp*visit*depression Race female baseage basemmse 
 USE_INTERCEPT=TRUE
    /RANDOM USE_INTERCEPT=TRUE SUBJECTS=ID  COVARIANCE_TYPE=VARIANCE_COMPONENTS.    



*Try to Filter without Excluding for Baseline Depression for sop analyses. 

DATASET ACTIVATE DataSet1.
USE ALL.
COMPUTE filter_$=(intgrp ne 1 and intgrp ne 2).
VARIABLE LABELS filter_$ 'intgrp ne 1 and intgrp ne 2 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.



*Try to Filter without  for Baseline Depression for sop analyses. 

DATASET ACTIVATE DataSet1.
USE ALL.
COMPUTE filter_$=(intgrp ne 1 and intgrp ne 2 and dep_9_bin_b ne 1).
VARIABLE LABELS filter_$ 'intgrp ne 1 and intgrp ne 2 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.


*Try as continuous depression score.
GENLINMIXED
  /FIELDS TARGET=  zspdcb
    /TARGET_OPTIONS DISTRIBUTION=NORMAL LINK=IDENTITY
/FIXED EFFECTS= visit yrseduc intgrp  cesdtot_b cesdtot_wp intgrp*visit  cesdtot_wp*visit intgrp*cesdtot_wp
intgrp*visit*cesdtot_wp Race female baseage basemmse USE_INTERCEPT=TRUE
    /RANDOM USE_INTERCEPT=TRUE SUBJECTS=ID  COVARIANCE_TYPE=VARIANCE_COMPONENTS.


*Using depression cutoff. 
GENLINMIXED
  /FIELDS TARGET= zspdcb
    /TARGET_OPTIONS DISTRIBUTION=NORMAL LINK=IDENTITY
/FIXED EFFECTS= visit zyrseduc intgrp  depression  intgrp*visit  depression*visit intgrp*depression 
intgrp*visit*depression Race female zbaseage zbasemmse 
 USE_INTERCEPT=TRUE
    /RANDOM USE_INTERCEPT=TRUE SUBJECTS=ID  COVARIANCE_TYPE=VARIANCE_COMPONENTS.    
