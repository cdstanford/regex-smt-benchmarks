;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = A(?:CCESS|LLEY|PPROACH|R(?:CADE|TERY)|VE(?:NUE)?)|B(?:A(?:NK|SIN|Y)|E(?:ACH|ND)|L(?:DG|VD)|O(?:ULEVARD|ARDWALK|WL)|R(?:ACE|AE|EAK|IDGE|O(?:ADWAY|OK|W))|UILDING|YPASS)|C(?:A(?:NAL|USEWAY)|ENTRE(?:WAY)?|HASE|IRC(?:LET?|U(?:IT|S))|L(?:OSE)?|O(?:MMON|NCOURSE|PSE|R(?:NER|SO)|UR(?:SE|T(?:YARD)?)|VE)|R(?:ES(?:CENT|T)?|IEF|OSS(?:ING)?)|U(?:LDESAC|RVE))|D(?:ALE|EVIATION|IP|OWNS|R(?:IVE(?:WAY)?)?)|E(?:ASEMENT|DGE|LBOW|N(?:D|TRANCE)|S(?:PLANADE|TATE)|X(?:P(?:(?:RESS)?WAY)|TENSION))|F(?:AIRWAY|IRETRAIL|O(?:LLOW|R(?:D|MATION))|R(?:(?:EEWAY|ONT(?:AGE)?)))|G(?:A(?:P|RDENS?|TE(?:S|WAY)?)|L(?:ADE|EN)|R(?:ANGE|EEN|O(?:UND|VET?)))|H(?:AVEN|E(?:ATH|IGHTS)|I(?:GHWAY|LL)|UB|WY)|I(?:NTER(?:CHANGE)?|SLAND)|JUNCTION|K(?:EY|NOLL)|L(?:A(?:NE(?:WAY)?)?|IN(?:E|K)|O(?:O(?:KOUT|P)|WER))|M(?:ALL|E(?:A(?:D|NDER)|WS)|OTORWAY)|NOOK|O(?:UTLOOK|VERPASS)|P(?:A(?:R(?:ADE|K(?:LANDS|WAY)?)|SS|TH(?:WAY)?)|DE|IER|L(?:A(?:CE|ZA))?|O(?:CKET|INT|RT)|RO(?:MENADE|PERTY)|URSUIT)?|QUA(?:D(?:RANT)?|YS?)|R(?:AMBLE|D|E(?:ACH|S(?:ERVE|T)|T(?:REAT|URN))|I(?:D(?:E|GE)|NG|S(?:E|ING))|O(?:AD(?:WAY)?|TARY|U(?:ND|TE)|W)|UN)|S(?:(?:ER(?:VICE)?WAY)|IDING|LOPE|PUR|QUARE|T(?:EPS|RAND|R(?:EET|IP))?|UBWAY)|T(?:ARN|CE|ERRACE|HRO(?:UGHWAY|WAY)|O(?:LLWAY|P|R)|RA(?:CK|IL)|URN)|UNDERPASS|V(?:AL(?:E|LEY)|I(?:EW|STA))|W(?:A(?:LK(?:WAY)?|Y)|HARF|YND)
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "KNOLL"
(define-fun Witness1 () String (str.++ "K" (str.++ "N" (str.++ "O" (str.++ "L" (str.++ "L" ""))))))
;witness2: "HEATH"
(define-fun Witness2 () String (str.++ "H" (str.++ "E" (str.++ "A" (str.++ "T" (str.++ "H" ""))))))

(assert (= regexA (re.union (re.++ (re.range "A" "A") (re.union (str.to_re (str.++ "C" (str.++ "C" (str.++ "E" (str.++ "S" (str.++ "S" ""))))))(re.union (str.to_re (str.++ "L" (str.++ "L" (str.++ "E" (str.++ "Y" "")))))(re.union (str.to_re (str.++ "P" (str.++ "P" (str.++ "R" (str.++ "O" (str.++ "A" (str.++ "C" (str.++ "H" ""))))))))(re.union (re.++ (re.range "R" "R") (re.union (str.to_re (str.++ "C" (str.++ "A" (str.++ "D" (str.++ "E" ""))))) (str.to_re (str.++ "T" (str.++ "E" (str.++ "R" (str.++ "Y" ""))))))) (re.++ (str.to_re (str.++ "V" (str.++ "E" ""))) (re.opt (str.to_re (str.++ "N" (str.++ "U" (str.++ "E" "")))))))))))(re.union (re.++ (re.range "B" "B") (re.union (re.++ (re.range "A" "A") (re.union (str.to_re (str.++ "N" (str.++ "K" "")))(re.union (str.to_re (str.++ "S" (str.++ "I" (str.++ "N" "")))) (re.range "Y" "Y"))))(re.union (re.++ (re.range "E" "E") (re.union (str.to_re (str.++ "A" (str.++ "C" (str.++ "H" "")))) (str.to_re (str.++ "N" (str.++ "D" "")))))(re.union (re.++ (re.range "L" "L") (re.union (str.to_re (str.++ "D" (str.++ "G" ""))) (str.to_re (str.++ "V" (str.++ "D" "")))))(re.union (re.++ (re.range "O" "O") (re.union (str.to_re (str.++ "U" (str.++ "L" (str.++ "E" (str.++ "V" (str.++ "A" (str.++ "R" (str.++ "D" ""))))))))(re.union (str.to_re (str.++ "A" (str.++ "R" (str.++ "D" (str.++ "W" (str.++ "A" (str.++ "L" (str.++ "K" "")))))))) (str.to_re (str.++ "W" (str.++ "L" ""))))))(re.union (re.++ (re.range "R" "R") (re.union (str.to_re (str.++ "A" (str.++ "C" (str.++ "E" ""))))(re.union (str.to_re (str.++ "A" (str.++ "E" "")))(re.union (str.to_re (str.++ "E" (str.++ "A" (str.++ "K" ""))))(re.union (str.to_re (str.++ "I" (str.++ "D" (str.++ "G" (str.++ "E" ""))))) (re.++ (re.range "O" "O") (re.union (str.to_re (str.++ "A" (str.++ "D" (str.++ "W" (str.++ "A" (str.++ "Y" ""))))))(re.union (str.to_re (str.++ "O" (str.++ "K" ""))) (re.range "W" "W")))))))))(re.union (str.to_re (str.++ "U" (str.++ "I" (str.++ "L" (str.++ "D" (str.++ "I" (str.++ "N" (str.++ "G" "")))))))) (str.to_re (str.++ "Y" (str.++ "P" (str.++ "A" (str.++ "S" (str.++ "S" "")))))))))))))(re.union (re.++ (re.range "C" "C") (re.union (re.++ (re.range "A" "A") (re.union (str.to_re (str.++ "N" (str.++ "A" (str.++ "L" "")))) (str.to_re (str.++ "U" (str.++ "S" (str.++ "E" (str.++ "W" (str.++ "A" (str.++ "Y" "")))))))))(re.union (re.++ (str.to_re (str.++ "E" (str.++ "N" (str.++ "T" (str.++ "R" (str.++ "E" "")))))) (re.opt (str.to_re (str.++ "W" (str.++ "A" (str.++ "Y" ""))))))(re.union (str.to_re (str.++ "H" (str.++ "A" (str.++ "S" (str.++ "E" "")))))(re.union (re.++ (str.to_re (str.++ "I" (str.++ "R" (str.++ "C" "")))) (re.union (re.++ (str.to_re (str.++ "L" (str.++ "E" ""))) (re.opt (re.range "T" "T"))) (re.++ (re.range "U" "U") (re.union (str.to_re (str.++ "I" (str.++ "T" ""))) (re.range "S" "S")))))(re.union (re.++ (re.range "L" "L") (re.opt (str.to_re (str.++ "O" (str.++ "S" (str.++ "E" ""))))))(re.union (re.++ (re.range "O" "O") (re.union (str.to_re (str.++ "M" (str.++ "M" (str.++ "O" (str.++ "N" "")))))(re.union (str.to_re (str.++ "N" (str.++ "C" (str.++ "O" (str.++ "U" (str.++ "R" (str.++ "S" (str.++ "E" ""))))))))(re.union (str.to_re (str.++ "P" (str.++ "S" (str.++ "E" ""))))(re.union (re.++ (re.range "R" "R") (re.union (str.to_re (str.++ "N" (str.++ "E" (str.++ "R" "")))) (str.to_re (str.++ "S" (str.++ "O" "")))))(re.union (re.++ (str.to_re (str.++ "U" (str.++ "R" ""))) (re.union (str.to_re (str.++ "S" (str.++ "E" ""))) (re.++ (re.range "T" "T") (re.opt (str.to_re (str.++ "Y" (str.++ "A" (str.++ "R" (str.++ "D" ""))))))))) (str.to_re (str.++ "V" (str.++ "E" "")))))))))(re.union (re.++ (re.range "R" "R") (re.union (re.++ (str.to_re (str.++ "E" (str.++ "S" ""))) (re.opt (re.union (str.to_re (str.++ "C" (str.++ "E" (str.++ "N" (str.++ "T" ""))))) (re.range "T" "T"))))(re.union (str.to_re (str.++ "I" (str.++ "E" (str.++ "F" "")))) (re.++ (str.to_re (str.++ "O" (str.++ "S" (str.++ "S" "")))) (re.opt (str.to_re (str.++ "I" (str.++ "N" (str.++ "G" ""))))))))) (re.++ (re.range "U" "U") (re.union (str.to_re (str.++ "L" (str.++ "D" (str.++ "E" (str.++ "S" (str.++ "A" (str.++ "C" ""))))))) (str.to_re (str.++ "R" (str.++ "V" (str.++ "E" ""))))))))))))))(re.union (re.++ (re.range "D" "D") (re.union (str.to_re (str.++ "A" (str.++ "L" (str.++ "E" ""))))(re.union (str.to_re (str.++ "E" (str.++ "V" (str.++ "I" (str.++ "A" (str.++ "T" (str.++ "I" (str.++ "O" (str.++ "N" "")))))))))(re.union (str.to_re (str.++ "I" (str.++ "P" "")))(re.union (str.to_re (str.++ "O" (str.++ "W" (str.++ "N" (str.++ "S" ""))))) (re.++ (re.range "R" "R") (re.opt (re.++ (str.to_re (str.++ "I" (str.++ "V" (str.++ "E" "")))) (re.opt (str.to_re (str.++ "W" (str.++ "A" (str.++ "Y" "")))))))))))))(re.union (re.++ (re.range "E" "E") (re.union (str.to_re (str.++ "A" (str.++ "S" (str.++ "E" (str.++ "M" (str.++ "E" (str.++ "N" (str.++ "T" ""))))))))(re.union (str.to_re (str.++ "D" (str.++ "G" (str.++ "E" ""))))(re.union (str.to_re (str.++ "L" (str.++ "B" (str.++ "O" (str.++ "W" "")))))(re.union (re.++ (re.range "N" "N") (re.union (re.range "D" "D") (str.to_re (str.++ "T" (str.++ "R" (str.++ "A" (str.++ "N" (str.++ "C" (str.++ "E" "")))))))))(re.union (re.++ (re.range "S" "S") (re.union (str.to_re (str.++ "P" (str.++ "L" (str.++ "A" (str.++ "N" (str.++ "A" (str.++ "D" (str.++ "E" "")))))))) (str.to_re (str.++ "T" (str.++ "A" (str.++ "T" (str.++ "E" ""))))))) (re.++ (re.range "X" "X") (re.union (re.++ (re.range "P" "P")(re.++ (re.opt (str.to_re (str.++ "R" (str.++ "E" (str.++ "S" (str.++ "S" "")))))) (str.to_re (str.++ "W" (str.++ "A" (str.++ "Y" "")))))) (str.to_re (str.++ "T" (str.++ "E" (str.++ "N" (str.++ "S" (str.++ "I" (str.++ "O" (str.++ "N" ""))))))))))))))))(re.union (re.++ (re.range "F" "F") (re.union (str.to_re (str.++ "A" (str.++ "I" (str.++ "R" (str.++ "W" (str.++ "A" (str.++ "Y" "")))))))(re.union (str.to_re (str.++ "I" (str.++ "R" (str.++ "E" (str.++ "T" (str.++ "R" (str.++ "A" (str.++ "I" (str.++ "L" "")))))))))(re.union (re.++ (re.range "O" "O") (re.union (str.to_re (str.++ "L" (str.++ "L" (str.++ "O" (str.++ "W" ""))))) (re.++ (re.range "R" "R") (re.union (re.range "D" "D") (str.to_re (str.++ "M" (str.++ "A" (str.++ "T" (str.++ "I" (str.++ "O" (str.++ "N" ""))))))))))) (re.++ (re.range "R" "R") (re.union (str.to_re (str.++ "E" (str.++ "E" (str.++ "W" (str.++ "A" (str.++ "Y" "")))))) (re.++ (str.to_re (str.++ "O" (str.++ "N" (str.++ "T" "")))) (re.opt (str.to_re (str.++ "A" (str.++ "G" (str.++ "E" ""))))))))))))(re.union (re.++ (re.range "G" "G") (re.union (re.++ (re.range "A" "A") (re.union (re.range "P" "P")(re.union (re.++ (str.to_re (str.++ "R" (str.++ "D" (str.++ "E" (str.++ "N" ""))))) (re.opt (re.range "S" "S"))) (re.++ (str.to_re (str.++ "T" (str.++ "E" ""))) (re.opt (re.union (re.range "S" "S") (str.to_re (str.++ "W" (str.++ "A" (str.++ "Y" ""))))))))))(re.union (re.++ (re.range "L" "L") (re.union (str.to_re (str.++ "A" (str.++ "D" (str.++ "E" "")))) (str.to_re (str.++ "E" (str.++ "N" ""))))) (re.++ (re.range "R" "R") (re.union (str.to_re (str.++ "A" (str.++ "N" (str.++ "G" (str.++ "E" "")))))(re.union (str.to_re (str.++ "E" (str.++ "E" (str.++ "N" "")))) (re.++ (re.range "O" "O") (re.union (str.to_re (str.++ "U" (str.++ "N" (str.++ "D" "")))) (re.++ (str.to_re (str.++ "V" (str.++ "E" ""))) (re.opt (re.range "T" "T")))))))))))(re.union (re.++ (re.range "H" "H") (re.union (str.to_re (str.++ "A" (str.++ "V" (str.++ "E" (str.++ "N" "")))))(re.union (re.++ (re.range "E" "E") (re.union (str.to_re (str.++ "A" (str.++ "T" (str.++ "H" "")))) (str.to_re (str.++ "I" (str.++ "G" (str.++ "H" (str.++ "T" (str.++ "S" ""))))))))(re.union (re.++ (re.range "I" "I") (re.union (str.to_re (str.++ "G" (str.++ "H" (str.++ "W" (str.++ "A" (str.++ "Y" "")))))) (str.to_re (str.++ "L" (str.++ "L" "")))))(re.union (str.to_re (str.++ "U" (str.++ "B" ""))) (str.to_re (str.++ "W" (str.++ "Y" ""))))))))(re.union (re.++ (re.range "I" "I") (re.union (re.++ (str.to_re (str.++ "N" (str.++ "T" (str.++ "E" (str.++ "R" ""))))) (re.opt (str.to_re (str.++ "C" (str.++ "H" (str.++ "A" (str.++ "N" (str.++ "G" (str.++ "E" ""))))))))) (str.to_re (str.++ "S" (str.++ "L" (str.++ "A" (str.++ "N" (str.++ "D" ""))))))))(re.union (str.to_re (str.++ "J" (str.++ "U" (str.++ "N" (str.++ "C" (str.++ "T" (str.++ "I" (str.++ "O" (str.++ "N" "")))))))))(re.union (re.++ (re.range "K" "K") (re.union (str.to_re (str.++ "E" (str.++ "Y" ""))) (str.to_re (str.++ "N" (str.++ "O" (str.++ "L" (str.++ "L" "")))))))(re.union (re.++ (re.range "L" "L") (re.union (re.++ (re.range "A" "A") (re.opt (re.++ (str.to_re (str.++ "N" (str.++ "E" ""))) (re.opt (str.to_re (str.++ "W" (str.++ "A" (str.++ "Y" ""))))))))(re.union (re.++ (str.to_re (str.++ "I" (str.++ "N" ""))) (re.union (re.range "E" "E") (re.range "K" "K"))) (re.++ (re.range "O" "O") (re.union (re.++ (re.range "O" "O") (re.union (str.to_re (str.++ "K" (str.++ "O" (str.++ "U" (str.++ "T" ""))))) (re.range "P" "P"))) (str.to_re (str.++ "W" (str.++ "E" (str.++ "R" "")))))))))(re.union (re.++ (re.range "M" "M") (re.union (str.to_re (str.++ "A" (str.++ "L" (str.++ "L" ""))))(re.union (re.++ (re.range "E" "E") (re.union (re.++ (re.range "A" "A") (re.union (re.range "D" "D") (str.to_re (str.++ "N" (str.++ "D" (str.++ "E" (str.++ "R" ""))))))) (str.to_re (str.++ "W" (str.++ "S" ""))))) (str.to_re (str.++ "O" (str.++ "T" (str.++ "O" (str.++ "R" (str.++ "W" (str.++ "A" (str.++ "Y" "")))))))))))(re.union (str.to_re (str.++ "N" (str.++ "O" (str.++ "O" (str.++ "K" "")))))(re.union (re.++ (re.range "O" "O") (re.union (str.to_re (str.++ "U" (str.++ "T" (str.++ "L" (str.++ "O" (str.++ "O" (str.++ "K" ""))))))) (str.to_re (str.++ "V" (str.++ "E" (str.++ "R" (str.++ "P" (str.++ "A" (str.++ "S" (str.++ "S" ""))))))))))(re.union (re.++ (re.range "P" "P") (re.opt (re.union (re.++ (re.range "A" "A") (re.union (re.++ (re.range "R" "R") (re.union (str.to_re (str.++ "A" (str.++ "D" (str.++ "E" "")))) (re.++ (re.range "K" "K") (re.opt (re.union (str.to_re (str.++ "L" (str.++ "A" (str.++ "N" (str.++ "D" (str.++ "S" "")))))) (str.to_re (str.++ "W" (str.++ "A" (str.++ "Y" "")))))))))(re.union (str.to_re (str.++ "S" (str.++ "S" ""))) (re.++ (str.to_re (str.++ "T" (str.++ "H" ""))) (re.opt (str.to_re (str.++ "W" (str.++ "A" (str.++ "Y" "")))))))))(re.union (str.to_re (str.++ "D" (str.++ "E" "")))(re.union (str.to_re (str.++ "I" (str.++ "E" (str.++ "R" ""))))(re.union (re.++ (re.range "L" "L") (re.opt (re.++ (re.range "A" "A") (re.union (str.to_re (str.++ "C" (str.++ "E" ""))) (str.to_re (str.++ "Z" (str.++ "A" "")))))))(re.union (re.++ (re.range "O" "O") (re.union (str.to_re (str.++ "C" (str.++ "K" (str.++ "E" (str.++ "T" "")))))(re.union (str.to_re (str.++ "I" (str.++ "N" (str.++ "T" "")))) (str.to_re (str.++ "R" (str.++ "T" ""))))))(re.union (re.++ (str.to_re (str.++ "R" (str.++ "O" ""))) (re.union (str.to_re (str.++ "M" (str.++ "E" (str.++ "N" (str.++ "A" (str.++ "D" (str.++ "E" ""))))))) (str.to_re (str.++ "P" (str.++ "E" (str.++ "R" (str.++ "T" (str.++ "Y" "")))))))) (str.to_re (str.++ "U" (str.++ "R" (str.++ "S" (str.++ "U" (str.++ "I" (str.++ "T" "")))))))))))))))(re.union (re.++ (str.to_re (str.++ "Q" (str.++ "U" (str.++ "A" "")))) (re.union (re.++ (re.range "D" "D") (re.opt (str.to_re (str.++ "R" (str.++ "A" (str.++ "N" (str.++ "T" ""))))))) (re.++ (re.range "Y" "Y") (re.opt (re.range "S" "S")))))(re.union (re.++ (re.range "R" "R") (re.union (str.to_re (str.++ "A" (str.++ "M" (str.++ "B" (str.++ "L" (str.++ "E" ""))))))(re.union (re.range "D" "D")(re.union (re.++ (re.range "E" "E") (re.union (str.to_re (str.++ "A" (str.++ "C" (str.++ "H" ""))))(re.union (re.++ (re.range "S" "S") (re.union (str.to_re (str.++ "E" (str.++ "R" (str.++ "V" (str.++ "E" ""))))) (re.range "T" "T"))) (re.++ (re.range "T" "T") (re.union (str.to_re (str.++ "R" (str.++ "E" (str.++ "A" (str.++ "T" ""))))) (str.to_re (str.++ "U" (str.++ "R" (str.++ "N" "")))))))))(re.union (re.++ (re.range "I" "I") (re.union (re.++ (re.range "D" "D") (re.union (re.range "E" "E") (str.to_re (str.++ "G" (str.++ "E" "")))))(re.union (str.to_re (str.++ "N" (str.++ "G" ""))) (re.++ (re.range "S" "S") (re.union (re.range "E" "E") (str.to_re (str.++ "I" (str.++ "N" (str.++ "G" "")))))))))(re.union (re.++ (re.range "O" "O") (re.union (re.++ (str.to_re (str.++ "A" (str.++ "D" ""))) (re.opt (str.to_re (str.++ "W" (str.++ "A" (str.++ "Y" ""))))))(re.union (str.to_re (str.++ "T" (str.++ "A" (str.++ "R" (str.++ "Y" "")))))(re.union (re.++ (re.range "U" "U") (re.union (str.to_re (str.++ "N" (str.++ "D" ""))) (str.to_re (str.++ "T" (str.++ "E" ""))))) (re.range "W" "W"))))) (str.to_re (str.++ "U" (str.++ "N" "")))))))))(re.union (re.++ (re.range "S" "S") (re.union (re.++ (str.to_re (str.++ "E" (str.++ "R" "")))(re.++ (re.opt (str.to_re (str.++ "V" (str.++ "I" (str.++ "C" (str.++ "E" "")))))) (str.to_re (str.++ "W" (str.++ "A" (str.++ "Y" ""))))))(re.union (str.to_re (str.++ "I" (str.++ "D" (str.++ "I" (str.++ "N" (str.++ "G" ""))))))(re.union (str.to_re (str.++ "L" (str.++ "O" (str.++ "P" (str.++ "E" "")))))(re.union (str.to_re (str.++ "P" (str.++ "U" (str.++ "R" ""))))(re.union (str.to_re (str.++ "Q" (str.++ "U" (str.++ "A" (str.++ "R" (str.++ "E" ""))))))(re.union (re.++ (re.range "T" "T") (re.opt (re.union (str.to_re (str.++ "E" (str.++ "P" (str.++ "S" ""))))(re.union (str.to_re (str.++ "R" (str.++ "A" (str.++ "N" (str.++ "D" ""))))) (re.++ (re.range "R" "R") (re.union (str.to_re (str.++ "E" (str.++ "E" (str.++ "T" "")))) (str.to_re (str.++ "I" (str.++ "P" ""))))))))) (str.to_re (str.++ "U" (str.++ "B" (str.++ "W" (str.++ "A" (str.++ "Y" "")))))))))))))(re.union (re.++ (re.range "T" "T") (re.union (str.to_re (str.++ "A" (str.++ "R" (str.++ "N" ""))))(re.union (str.to_re (str.++ "C" (str.++ "E" "")))(re.union (str.to_re (str.++ "E" (str.++ "R" (str.++ "R" (str.++ "A" (str.++ "C" (str.++ "E" "")))))))(re.union (re.++ (str.to_re (str.++ "H" (str.++ "R" (str.++ "O" "")))) (re.union (str.to_re (str.++ "U" (str.++ "G" (str.++ "H" (str.++ "W" (str.++ "A" (str.++ "Y" ""))))))) (str.to_re (str.++ "W" (str.++ "A" (str.++ "Y" ""))))))(re.union (re.++ (re.range "O" "O") (re.union (str.to_re (str.++ "L" (str.++ "L" (str.++ "W" (str.++ "A" (str.++ "Y" "")))))) (re.union (re.range "P" "P") (re.range "R" "R"))))(re.union (re.++ (str.to_re (str.++ "R" (str.++ "A" ""))) (re.union (str.to_re (str.++ "C" (str.++ "K" ""))) (str.to_re (str.++ "I" (str.++ "L" ""))))) (str.to_re (str.++ "U" (str.++ "R" (str.++ "N" "")))))))))))(re.union (str.to_re (str.++ "U" (str.++ "N" (str.++ "D" (str.++ "E" (str.++ "R" (str.++ "P" (str.++ "A" (str.++ "S" (str.++ "S" ""))))))))))(re.union (re.++ (re.range "V" "V") (re.union (re.++ (str.to_re (str.++ "A" (str.++ "L" ""))) (re.union (re.range "E" "E") (str.to_re (str.++ "L" (str.++ "E" (str.++ "Y" "")))))) (re.++ (re.range "I" "I") (re.union (str.to_re (str.++ "E" (str.++ "W" ""))) (str.to_re (str.++ "S" (str.++ "T" (str.++ "A" "")))))))) (re.++ (re.range "W" "W") (re.union (re.++ (re.range "A" "A") (re.union (re.++ (str.to_re (str.++ "L" (str.++ "K" ""))) (re.opt (str.to_re (str.++ "W" (str.++ "A" (str.++ "Y" "")))))) (re.range "Y" "Y")))(re.union (str.to_re (str.++ "H" (str.++ "A" (str.++ "R" (str.++ "F" ""))))) (str.to_re (str.++ "Y" (str.++ "N" (str.++ "D" "")))))))))))))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
