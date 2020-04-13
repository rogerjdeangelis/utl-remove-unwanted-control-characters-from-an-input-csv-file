Remove unwanted imbedded control characters from an input csv file;

SOAPBOX ON
Look up FSLIST it is easier to use than my macro.
However, you may need classic SAS not 'new coke' sas.
SOAPBOX OFF

github
https://tinyurl.com/r7n3jgv
https://github.com/rogerjdeangelis/utl-remove-unwanted-control-characters-from-an-input-csv-file

related repos
https://github.com/rogerjdeangelis?tab=repositories&q=utlrulr+hex&type=&language=

SAS Forum
https://tinyurl.com/wysgtyj
https://communities.sas.com/t5/SAS-Programming/Read-CSV-file-with-embedded-CRLF/td-p/183296

macros
https://tinyurl.com/y9nfugth
https://github.com/rogerjdeangelis/utl-macros-used-in-many-of-rogerjdeangelis-repositories

*_                   _
(_)_ __  _ __  _   _| |_
| | '_ \| '_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
;

Download 1 record csv file from

https://tinyurl.com/wysgtyj into "d:/csv/ss.csv";

Here is the problem, you have a unix '0A'x end of line character imbedded in your csv file

* this does a hex dump;
%UTLRULR
   (

    UINFLT =d:/csv/ss.csv,
    UPRNLEN =72,
    ULRECL  =72,
    URECFM   =f,
    UOBS = 5,
    UOTFLT =d:/txt/ss.txt
);



ASCII Flatfile Ruler & Hex
utlrulr
d:/csv/ss.csv
d:/txt/ss.txt


 --- Record Number ---  1   ---  Record Length ---- 72

 REFERENCE NO,DESCRIPTION,ACCOUNTNUM,ACCOUNTNAME,,AMOUNT,MESSAGE_STATUS,
1...5....10...15...20...25...30...35...40...45...50...55...60...65...70.
254445444424424454545544424444545454244445454444224445452445544455545552
0256525E350EFC453329049FEC133F5E4E5DC133F5E4E1D5CC1DF5E4CD533175F341453C


 --- Record Number ---  2   ---  Record Length ---- 72

CR_ACC,CR_ACC_NAME,TRANSACTION NO,CLIENT_CODE,CLIENT_CODE_DESC,MAKER_ID,
1...5....10...15...20...25...30...35...40...45...50...55...60...65...70.
455444245544454444255445445444244244444554444244444554444544542444455442
32F133C32F133FE1D5C421E31349FE0EFC3C95E4F3F45C3C95E4F3F45F4533CD1B52F94C


 --- Record Number ---  3   ---  Record Length ---- 66

" ._DATE",CHECKER_ID,AUTH_DTE,TRAN_TYPE,BENEFICIARY_CD,FILE_NAME..
1...5....10...15...20...25...30...35...40...45...50...55...60...65
220544542244444455442455454542554455554244444444455544244445444400
20AF41452C3853B52F94C1548F445C421EF4905C25E56939129F34C69C5FE1D5DA
  ^                                                              ^
  |                                                              |
  |                                                              |
  Here is the problem '0A'x is a line feed                   Keep this '0D0A'x
  Remove '0A'x

*            _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| '_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|
;


Fixed csv file
d:/csv/ssfix.csv


ASCII Flatfile Ruler & Hex
utlrulr
d:/csv/ssfix.csv
d:/csv/ssfix.txt


 --- Record Number ---  1   ---  Record Length ---- 72

 REFERENCE NO,DESCRIPTION,ACCOUNTNUM,ACCOUNTNAME,,AMOUNT,MESSAGE_STATUS,
1...5....10...15...20...25...30...35...40...45...50...55...60...65...70.
254445444424424454545544424444545454244445454444224445452445544455545552
0256525E350EFC453329049FEC133F5E4E5DC133F5E4E1D5CC1DF5E4CD533175F341453C


 --- Record Number ---  2   ---  Record Length ---- 72

CR_ACC,CR_ACC_NAME,TRANSACTION NO,CLIENT_CODE,CLIENT_CODE_DESC,MAKER_ID,
1...5....10...15...20...25...30...35...40...45...50...55...60...65...70.
455444245544454444255445445444244244444554444244444554444544542444455442
32F133C32F133FE1D5C421E31349FE0EFC3C95E4F3F45C3C95E4F3F45F4533CD1B52F94C


 --- Record Number ---  3   ---  Record Length ---- 65

" _DATE",CHECKER_ID,AUTH_DTE,TRAN_TYPE,BENEFICIARY_CD,FILE_NAME..
1...5....10...15...20...25...30...35...40...45...50...55...60...6
22544542244444455442455454542554455554244444444455544244445444400
20F41452C3853B52F94C1548F445C421EF4905C25E56939129F34C69C5FE1D5DA
  ^
  |
  |
  '0A'x is gone

*          _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __
/ __|/ _ \| | | | | __| |/ _ \| '_ \
\__ \ (_) | | |_| | |_| | (_) | | | |
|___/\___/|_|\__,_|\__|_|\___/|_| |_|

;

data _null_;

  infile "d:/csv/ss.csv"  termstr=CRLF ;
  input;
   _infile_=compress(_infile_,'0A'x);
   file "d:/csv/ssfix.csv";
   put _infile_;
   putlog _infile_;
run;quit;


* demonstrate that it has benn fixed;

%UTLRULR
   (

    UINFLT =d:/csv/ssfix.csv,
    UPRNLEN =72,
    ULRECL  =72,
    URECFM   =f,
    UOBS = 5,
    UOTFLT =d:/csv/ssfix.txt
);



