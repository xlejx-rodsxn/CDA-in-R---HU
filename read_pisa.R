### Reading PISA files to compile document
setwd("D:\\PhD\\Lectures\\PISA")
library(tidyverse)
# SPSS
library(haven)
# Files for specific or special studies (only some countries)
#CY6_MS_CM2_SCH_QQQ <- read_sav(file = "CY6_MS_CM2_SCH_QQQ.sav")
#CY6_MS_CM2_STU_COG <- read_sav(file = "CY6_MS_CM2_STU_COG.sav")
#CY6_MS_CM2_STU_CPS <- read_sav(file = "CY6_MS_CM2_STU_CPS.sav")
#CY6_MS_CM2_STU_QQ2 <- read_sav(file = "CY6_MS_CM2_STU_QQ2.sav")
#CY6_MS_CM2_STU_QQQ <- read_sav(file = "CY6_MS_CM2_STU_QQQ.sav")
#CY6_MS_CM2_STU_QTM <- read_sav(file = "CY6_MS_CM2_STU_QTM.sav")
#CY6_MS_CM2_TCH_QQQ <- read_sav(file = "CY6_MS_CM2_TCH_QQQ.sav")

# Files for all countries
#CY6_MS_CMB_SCH_QQQ <- read_sav(file = "CY6_MS_CMB_SCH_QQQ.sav")
#CY6_MS_CMB_STU_COG <- read_sav(file = "CY6_MS_CMB_STU_COG.sav")
#CY6_MS_CMB_STU_CPS <- read_sav(file = "CY6_MS_CMB_STU_CPS.sav")
#CY6_MS_CMB_STU_FLT <- read_sav(file = "CY6_MS_CMB_STU_FLT.sav")
#CY6_MS_CMB_STU_QQ2 <- read_sav(file = "CY6_MS_CMB_STU_QQ2.sav")
CY6_MS_CMB_STU_QQQ <- read_sav(file = "CY6_MS_CMB_STU_QQQ.sav")
#CY6_MS_CMB_STU_QTM <- read_sav(file = "CY6_MS_CMB_STU_QTM.sav")
#CY6_MS_CMB_TCH_QQQ <- read_sav(file = "CY6_MS_CMB_TCH_QQQ.sav")

# Create a smaller set with some variables to start playing around with the data
CY6_MS_CMB_STU_QQQ_DE <- filter(CY6_MS_CMB_STU_QQQ, CNTRYID==276) # only Germany
CY6_MS_CMB_STU_QQQ_DE <- select(CY6_MS_CMB_STU_QQQ_DE, c(CNTSTUID,ST001D01T,ST003D02T,ST003D03T,ST004D01T,ST005Q01TA,ST007Q01TA,
                                     ST011Q02TA,ST011Q03TA,ST011Q04TA,ST011Q05TA,ST011Q06TA,ST011Q07TA,ST011Q08TA,
                                     ST011Q09TA,ST011Q10TA,ST011Q11TA,ST011Q12TA,ST011Q16NA,ST011D17TA,ST011D18TA,
                                     ST011D19TA,ST012Q01TA,ST012Q02TA,ST012Q03TA,ST012Q05NA,ST012Q06NA,ST012Q07NA,
                                     ST012Q08NA,ST012Q09NA,ST013Q01TA,ST019AQ01T,ST019BQ01T,ST019CQ01T,ST076Q01NA,
                                     EC030Q01NA,EC030Q02NA,EC030Q03NA,EC030Q04NA,EC030Q05NA,EC030Q06NA,EC030Q07NA,
                                     PA042Q01TA,PROGN,DISCLISCI,TEACHSUP,IBTEACH,TDTEACH,ENVAWARE,ENVOPT,JOYSCIE,
                                     INTBRSCI,INSTSCIE,SCIEEFF,EPIST,SCIEACT,BSMJ,GRADE,IMMIG,MISCED,FISCED,HISCED,
                                     HOMESCH,ENTUSE,BMMJ1,BFMJ2,hisei,REPEAT,DURECEC,OUTHOURS,PV1MATH,PV1READ)) # select variables

#save data file
saveRDS(object = CY6_MS_CMB_STU_QQQ_DE, file = "germany_pisa2015",)

'
CHOSEN VARIABLES LABELS
ST004D01T	Student (Standardized) Gender	NUM	1.0	29	1 - 2		
1	Female
2	Male

ST005Q01TA	What is the <highest level of schooling> completed by your mother?	NUM	2.0	30	1 - 5		
1	<ISCED level 3A>
  2	<ISCED level 3B, 3C>
  3	<ISCED level 2>
  4	<ISCED level 1>
  5	She did not complete <ISCED level 1>
  97 / .N	Not Applicable
98 / .I	Invalid
99 / .M	No Response
SYSTEM MISSING	Missing

ST007Q01TA	What is the <highest level of schooling> completed by your father?	NUM	2.0	35	1 - 5		
						1	<ISCED level 3A>
						2	<ISCED level 3B, 3C>
						3	<ISCED level 2>
						4	<ISCED level 1>
						5	He did not complete <ISCED level 1>
						97 / .N	Not Applicable
						98 / .I	Invalid
						99 / .M	No Response
						SYSTEM MISSING	Missing

ST011Q01TA	In your home: A desk to study at	NUM	1.0	40	1 - 2		
						1	Yes
						2	No
ST011Q02TA	In your home: A room of your own	NUM	1.0	41	1 - 2		
						1	Yes
						2	No
ST011Q03TA	In your home: A quiet place to study	NUM	1.0	42	1 - 2		
						1	Yes
						2	No
ST011Q04TA	In your home: A computer you can use for school work	NUM	1.0	43	1 - 2		
						1	Yes
						2	No
ST011Q05TA	In your home: Educational software	NUM	1.0	44	1 - 2		
						1	Yes
						2	No
ST011Q06TA	In your home: A link to the Internet	NUM	1.0	45	1 - 2		
						1	Yes
						2	No
ST011Q07TA	In your home: Classic literature (e.g. <Shakespeare>)	NUM	1.0	46	1 - 2		
						1	Yes
						2	No
ST011Q08TA	In your home: Books of poetry	NUM	1.0	47	1 - 2		
						1	Yes
						2	No
ST011Q09TA	In your home: Works of art (e.g. paintings)	NUM	1.0	48	1 - 2		
						1	Yes
						2	No
ST011Q10TA	In your home: Books to help with your school work	NUM	1.0	49	1 - 2		
						1	Yes
						2	No
ST011Q11TA	In your home: <Technical reference books>	NUM	1.0	50	1 - 2		
						1	Yes
						2	No
ST011Q12TA	In your home: A dictionary	NUM	1.0	51	1 - 2		
						1	Yes
						2	No
ST011Q16NA	In your home: Books on art, music, or design	NUM	1.0	52	1 - 2		
						1	Yes
						2	No
ST011D17TA  A play station! (specific for Germany)
ST011D18TA  A TV in your room
ST011D19TA  Audiobooks

ST012Q01TA	How many in your home: Televisions	NUM	1.0	56	1 - 4		
						1	None
						2	One
						3	Two
						4	Three or more
						7 / .N	Not Applicable
						8 / .I	Invalid
						9 / .M	No Response
						SYSTEM MISSING	Missing

ST012Q02TA	How many in your home: Cars	NUM	1.0	57	1 - 4		
						1	None
						2	One
						3	Two
						4	Three or more
						7 / .N	Not Applicable
						8 / .I	Invalid
						9 / .M	No Response
						SYSTEM MISSING	Missing


ST012Q03TA	How many in your home: Rooms with a bath or shower	NUM	1.0	58	1 - 4		
						1	None
						2	One
						3	Two
						4	Three or more
						7 / .N	Not Applicable
						8 / .I	Invalid
						9 / .M	No Response
						SYSTEM MISSING	Missing

ST012Q05NA	How many in your home: <Cell phones> with Internet access (e.g. smartphones)	NUM	1.0	59	1 - 4		
						1	None
						2	One
						3	Two
						4	Three or more
						7 / .N	Not Applicable
						8 / .I	Invalid
						9 / .M	No Response
						SYSTEM MISSING	Missing
						
ST012Q06NA	How many in your home: Computers (desktop computer, portable laptop, or notebook)	NUM	1.0	60	1 - 4		
						1	None
						2	One
						3	Two
						4	Three or more
						7 / .N	Not Applicable
						8 / .I	Invalid
						9 / .M	No Response
						SYSTEM MISSING	Missing

ST012Q07NA	How many in your home: <Tablet computers> (e.g. <iPad®>, <BlackBerry® PlayBookTM>)	NUM	1.0	61	1 - 4		
						1	None
						2	One
						3	Two
						4	Three or more
						7 / .N	Not Applicable
						8 / .I	Invalid
						9 / .M	No Response
						SYSTEM MISSING	Missing

ST012Q08NA	How many in your home: E-book readers (e.g. <KindleTM>, <Kobo>, <Bookeen>)	NUM	1.0	62	1 - 4		
						1	None
						2	One
						3	Two
						4	Three or more
						7 / .N	Not Applicable
						8 / .I	Invalid
						9 / .M	No Response
						SYSTEM MISSING	Missing

ST012Q09NA	How many in your home: Musical instruments (e.g. guitar, piano)	NUM	1.0	63	1 - 4		
						1	None
						2	One
						3	Two
						4	Three or more
						7 / .N	Not Applicable
						8 / .I	Invalid
						9 / .M	No Response
						SYSTEM MISSING	Missing

ST013Q01TA	How many books are there in your home?	NUM	2.0	64	1 - 6		
						1	0-10 books
						2	11-25 books
						3	26-100 books
						4	101-200 books
						5	201-500 books
						6	More than 500 books
						97 / .N	Not Applicable
						98 / .I	Invalid
						99 / .M	No Response
						SYSTEM MISSING	Missing

ST019AQ01T	Country of Birth International - Self	NUM	2.0	69	1 - 2		
						1	Country of test
						2	Other country
						97 / .N	Not Applicable
						98 / .I	Invalid
						99 / .M	No Response
						SYSTEM MISSING	Missing
							
ST019BQ01T	Country of Birth International - Mother	NUM	2.0	70	1 - 2		
						1	Country of test
						2	Other country
						97 / .N	Not Applicable
						98 / .I	Invalid
						99 / .M	No Response
						SYSTEM MISSING	Missing
							
ST019CQ01T	Country of Birth International - Father	NUM	2.0	71	1 - 2		
						1	Country of test
						2	Other country
						97 / .N	Not Applicable
						98 / .I	Invalid
						99 / .M	No Response
						SYSTEM MISSING	Missing

ST076Q01NA	Before going to school did you: Eat breakfast	NUM	1.0	227	1 - 2		
						1	Yes
						2	No
						7 / .N	Not Applicable
						8 / .I	Invalid
						9 / .M	No Response
						SYSTEM MISSING	Missing

EC030Q01NA	In your family, who helps you regularly with your homework or private study? Mother or other female guardian	NUM	1.0	485	1 - 2		
						1	Yes
						2	No
						7 / .N	Not Applicable
						9 / .M	No Response
						SYSTEM MISSING	Missing
							
EC030Q02NA	In your family, who helps you regularly with your homework or private study? Father or other male guardian	NUM	1.0	486	1 - 2		
						1	Yes
						2	No
						7 / .N	Not Applicable
						9 / .M	No Response
						SYSTEM MISSING	Missing
							
EC030Q03NA	In your family, who helps you regularly with your homework or private study? Sister(s)\brother(s)	NUM	1.0	487	1 - 2		
						1	Yes
						2	No
						7 / .N	Not Applicable
						9 / .M	No Response
						SYSTEM MISSING	Missing
							
EC030Q04NA	In your family, who helps you regularly with your homework or private study? Grandparents	NUM	1.0	488	1 - 2		
						1	Yes
						2	No
						7 / .N	Not Applicable
						9 / .M	No Response
						SYSTEM MISSING	Missing
							
EC030Q05NA	In your family, who helps you regularly with your homework or private study? Other relatives	NUM	1.0	489	1 - 2		
						1	Yes
						2	No
						7 / .N	Not Applicable
						9 / .M	No Response
						SYSTEM MISSING	Missing
							
EC030Q06NA	In your family, who helps you regularly with your homework or private study? Nobody	NUM	1.0	490	1 - 2		
						1	Yes
						2	No
						7 / .N	Not Applicable
						9 / .M	No Response
						SYSTEM MISSING	Missing
							
EC030Q07NA	In your family, who helps you regularly with your homework or private study? Other person	NUM	1.0	491	1 - 2		
						1	Yes
						2	No
						7 / .N	Not Applicable
						9 / .M	No Response
						SYSTEM MISSING	Missing

PA042Q01TA	What is your annual household income?	NUM	2.0	640	1 - 6		
						1	Less than < $A >
						2	< $A > or more but less than < $B >
						3	< $B > or more but less than < $C >
						4	< $C > or more but less than < $D>
						5	< $D > or more but less than < $E>
						6	< $E > or more
						
PROGN	Unique national study programme code

DISCLISCI	Disciplinary climate in science classes (WLE)	NUM	7.4	646	-2.4162 - 1.8837		
							
TEACHSUP	Teacher support in a science classes of students choice (WLE)	NUM	7.4	647	-2.7195 - 1.4475		
							
IBTEACH	Inquiry-based science teaching an learning practices (WLE)	NUM	7.4	648	-3.3405 - 3.1829		
							
TDTEACH	Teacher-directed science instruction (WLE)	NUM	7.4	649	-2.4476 - 2.0781		
							
ENVAWARE	Environmental Awareness (WLE)	NUM	7.4	650	-3.4405 - 3.3001		
							
ENVOPT	Environmental optimism (WLE)	NUM	7.4	651	-1.7932 - 3.0127		
							
JOYSCIE	Enjoyment of science (WLE)	NUM	7.4	652	-2.1154 - 2.1635		
							
INTBRSCI	Interest in broad science topics (WLE)	NUM	7.4	653	-2.5813 - 2.7303		
							
INSTSCIE	Instrumental motivation (WLE)	NUM	7.4	654	-1.9301 - 1.7359		
							
SCIEEFF	Science self-efficacy (WLE)	NUM	7.4	655	-3.7565 - 3.2775		
							
EPIST	Epistemological beliefs (WLE)	NUM	7.4	656	-2.7904 - 2.1552		
							
SCIEACT	Index science activities (WLE)	NUM	7.4	657	-1.7722 - 3.3617		
							
BSMJ	Students' expected occupational status (SEI)	NUM	12.4	658	10 - 89		
							
GRADE	Grade compared to modal grade in country	NUM	12.4	659	-4 - 3		
							
IMMIG	Index Immigration status	NUM	1.0	660	1 - 3		
						1	Native
						2	Second-Generation
						3	First-Generation
						8 / .I	Invalid
						9 / .M	No Response
						SYSTEM MISSING	Missing
							
MISCED	Mother's Education (ISCED)	NUM	2.0	661	0 - 6		
						0	None
						1	ISCED 1
						2	ISCED 2
						3	ISCED 3B, C
						4	ISCED 3A, ISCED 4
						5	ISCED 5B
						6	ISCED 5A, 6
						97 / .N	Not Applicable
						98 / .I	Invalid
						99 / .M	No Response
						SYSTEM MISSING	Missing
							
FISCED	Father's Education (ISCED)	NUM	2.0	662	0 - 6		
						0	None
						1	ISCED 1
						2	ISCED 2
						3	ISCED 3B, C
						4	ISCED 3A, ISCED 4
						5	ISCED 5B
						6	ISCED 5A, 6
						97 / .N	Not Applicable
						98 / .I	Invalid
						99 / .M	No Response
						SYSTEM MISSING	Missing
							
HISCED	Highest Education of parents (ISCED)	NUM	2.0	663	0 - 6		
						0	None
						1	ISCED 1
						2	ISCED 2
						3	ISCED 3B, C
						4	ISCED 3A, ISCED 4
						5	ISCED 5B
						6	ISCED 5A, 6
						98 / .I	Invalid
						99 / .M	No Response
						SYSTEM MISSING	Missing
							
HOMESCH	ICT use outside of school for schoolwork (WLE)	NUM	7.4	664	-2.6918 - 3.6039		
							
ENTUSE	ICT use outside of school leisure (WLE)	NUM	7.4	665	-3.7095 - 4.8595		
							
BMMJ1	ISEI of mother	NUM	4.0	666	11 - 89		
							
BFMJ2	ISEI of father	NUM	4.0	667	11 - 89		
							
hisei	Index highest parental occupational status	NUM	4.0	668	11 - 89		
							
REPEAT	Grade Repetition	NUM	1.0	669	0 - 1		
						0	Did not repeat a <grade>
						1	Repeated a <grade>
						9 / .M	No Response
						SYSTEM MISSING	Missing
							
DURECEC	Duration in early childhood education and care	NUM	2.0	670	0 - 8		
						0	Attended ECEC for less than a year
						1	Attended ECEC for at least one but less than two years
						2	Attended ECEC for at least two but less than three years
						3	Attended ECEC for at least three but less than four years
						4	Attended ECEC for at least four but less than five years
						5	Attended ECEC for at least five but less than six years
						6	Attended ECEC for at least six but less than seven years
						7	Attended ECEC for at least seven but less than eight years
						8	Attended ECEC for at least eight years
						99 / .M	No Response
						SYSTEM MISSING	Missing

OUTHOURS	Out-of-School Study Time per week (Sum)	NUM	3.0	671	0 - 70		

PV1MATH	Plausible Value 1 in Mathematics	NUM	8.3	810	0 - 870.509	

PV1READ	Plausible Value 1 in Reading	NUM	8.3	820	0 - 882.12


'



