;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\s*((?:(?:\d+(?:\x20+\w+\.?)+(?:(?:\x20+STREET|ST|DRIVE|DR|AVENUE|AVE|ROAD|RD|LOOP|COURT|CT|CIRCLE|LANE|LN|BOULEVARD|BLVD)\.?)?)|(?:(?:P\.\x20?O\.|P\x20?O)\x20*Box\x20+\d+)|(?:General\x20+Delivery)|(?:C[\\\/]O\x20+(?:\w+\x20*)+))\,?\x20*(?:(?:(?:APT|BLDG|DEPT|FL|HNGR|LOT|PIER|RM|S(?:LIP|PC|T(?:E|OP))|TRLR|UNIT|\x23)\.?\x20*(?:[a-zA-Z0-9\-]+))|(?:BSMT|FRNT|LBBY|LOWR|OFC|PH|REAR|SIDE|UPPR))?)\,?\s+((?:(?:\d+(?:\x20+\w+\.?)+(?:(?:\x20+STREET|ST|DRIVE|DR|AVENUE|AVE|ROAD|RD|LOOP|COURT|CT|CIRCLE|LANE|LN|BOULEVARD|BLVD)\.?)?)|(?:(?:P\.\x20?O\.|P\x20?O)\x20*Box\x20+\d+)|(?:General\x20+Delivery)|(?:C[\\\/]O\x20+(?:\w+\x20*)+))\,?\x20*(?:(?:(?:APT|BLDG|DEPT|FL|HNGR|LOT|PIER|RM|S(?:LIP|PC|T(?:E|OP))|TRLR|UNIT|\x23)\.?\x20*(?:[a-zA-Z0-9\-]+))|(?:BSMT|FRNT|LBBY|LOWR|OFC|PH|REAR|SIDE|UPPR))?)?\,?\s+((?:[A-Za-z]+\x20*)+)\,\s+(A[BLKSZRAP]|BC|C[AOT]|D[EC]|F[LM]|G[AU]|HI|I[ADLN]|K[SY]|LA|M[ABDEHINOPST]|N[BCDEHJLMSTUVY]|O[HKRN]|P[AERW]|QC|RI|S[CDK]|T[NX]|UT|V[AIT]|W[AIVY]|YT)\s+((\d{5}-\d{4})|(\d{5})|([AaBbCcEeGgHhJjKkLlMmNnPpRrSsTtVvXxYy]\d[A-Za-z]\s?\d[A-Za-z]\d))\s*$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00A0POBox 97BSMT, \u0085\u00A0InPBmB,\u00A0KY\x987871"
(define-fun Witness1 () String (str.++ "\u{a0}" (str.++ "P" (str.++ "O" (str.++ "B" (str.++ "o" (str.++ "x" (str.++ " " (str.++ "9" (str.++ "7" (str.++ "B" (str.++ "S" (str.++ "M" (str.++ "T" (str.++ "," (str.++ " " (str.++ "\u{85}" (str.++ "\u{a0}" (str.++ "I" (str.++ "n" (str.++ "P" (str.++ "B" (str.++ "m" (str.++ "B" (str.++ "," (str.++ "\u{a0}" (str.++ "K" (str.++ "Y" (str.++ "\u{09}" (str.++ "8" (str.++ "7" (str.++ "8" (str.++ "7" (str.++ "1" ""))))))))))))))))))))))))))))))))))
;witness2: "C/O 799\u00FE\u00B5\u00B5,   RM.   K,\xDC\O \u00D1fAW,LOWR,\u00A0   KJD , \u00A0VA\u00A0\xD\xD\xC\u008562368"
(define-fun Witness2 () String (str.++ "C" (str.++ "/" (str.++ "O" (str.++ " " (str.++ "7" (str.++ "9" (str.++ "9" (str.++ "\u{fe}" (str.++ "\u{b5}" (str.++ "\u{b5}" (str.++ "," (str.++ " " (str.++ " " (str.++ " " (str.++ "R" (str.++ "M" (str.++ "." (str.++ " " (str.++ " " (str.++ " " (str.++ "K" (str.++ "," (str.++ "\u{0d}" (str.++ "C" (str.++ "\u{5c}" (str.++ "O" (str.++ " " (str.++ "\u{d1}" (str.++ "f" (str.++ "A" (str.++ "W" (str.++ "," (str.++ "L" (str.++ "O" (str.++ "W" (str.++ "R" (str.++ "," (str.++ "\u{a0}" (str.++ " " (str.++ " " (str.++ " " (str.++ "K" (str.++ "J" (str.++ "D" (str.++ " " (str.++ "," (str.++ " " (str.++ "\u{a0}" (str.++ "V" (str.++ "A" (str.++ "\u{a0}" (str.++ "\u{0d}" (str.++ "\u{0d}" (str.++ "\u{0c}" (str.++ "\u{85}" (str.++ "6" (str.++ "2" (str.++ "3" (str.++ "6" (str.++ "8" "")))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.++ (re.union (re.++ (re.+ (re.range "0" "9"))(re.++ (re.+ (re.++ (re.+ (re.range " " " "))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))) (re.opt (re.range "." "."))))) (re.opt (re.++ (re.union (re.++ (re.+ (re.range " " " ")) (str.to_re (str.++ "S" (str.++ "T" (str.++ "R" (str.++ "E" (str.++ "E" (str.++ "T" ""))))))))(re.union (str.to_re (str.++ "S" (str.++ "T" "")))(re.union (str.to_re (str.++ "D" (str.++ "R" (str.++ "I" (str.++ "V" (str.++ "E" ""))))))(re.union (str.to_re (str.++ "D" (str.++ "R" "")))(re.union (str.to_re (str.++ "A" (str.++ "V" (str.++ "E" (str.++ "N" (str.++ "U" (str.++ "E" "")))))))(re.union (str.to_re (str.++ "A" (str.++ "V" (str.++ "E" ""))))(re.union (str.to_re (str.++ "R" (str.++ "O" (str.++ "A" (str.++ "D" "")))))(re.union (str.to_re (str.++ "R" (str.++ "D" "")))(re.union (str.to_re (str.++ "L" (str.++ "O" (str.++ "O" (str.++ "P" "")))))(re.union (str.to_re (str.++ "C" (str.++ "O" (str.++ "U" (str.++ "R" (str.++ "T" ""))))))(re.union (str.to_re (str.++ "C" (str.++ "T" "")))(re.union (str.to_re (str.++ "C" (str.++ "I" (str.++ "R" (str.++ "C" (str.++ "L" (str.++ "E" "")))))))(re.union (str.to_re (str.++ "L" (str.++ "A" (str.++ "N" (str.++ "E" "")))))(re.union (str.to_re (str.++ "L" (str.++ "N" "")))(re.union (str.to_re (str.++ "B" (str.++ "O" (str.++ "U" (str.++ "L" (str.++ "E" (str.++ "V" (str.++ "A" (str.++ "R" (str.++ "D" "")))))))))) (str.to_re (str.++ "B" (str.++ "L" (str.++ "V" (str.++ "D" "")))))))))))))))))))) (re.opt (re.range "." "."))))))(re.union (re.++ (re.union (re.++ (str.to_re (str.++ "P" (str.++ "." "")))(re.++ (re.opt (re.range " " " ")) (str.to_re (str.++ "O" (str.++ "." ""))))) (re.++ (re.range "P" "P")(re.++ (re.opt (re.range " " " ")) (re.range "O" "O"))))(re.++ (re.* (re.range " " " "))(re.++ (str.to_re (str.++ "B" (str.++ "o" (str.++ "x" ""))))(re.++ (re.+ (re.range " " " ")) (re.+ (re.range "0" "9"))))))(re.union (re.++ (str.to_re (str.++ "G" (str.++ "e" (str.++ "n" (str.++ "e" (str.++ "r" (str.++ "a" (str.++ "l" ""))))))))(re.++ (re.+ (re.range " " " ")) (str.to_re (str.++ "D" (str.++ "e" (str.++ "l" (str.++ "i" (str.++ "v" (str.++ "e" (str.++ "r" (str.++ "y" ""))))))))))) (re.++ (re.range "C" "C")(re.++ (re.union (re.range "/" "/") (re.range "\u{5c}" "\u{5c}"))(re.++ (re.range "O" "O")(re.++ (re.+ (re.range " " " ")) (re.+ (re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))) (re.* (re.range " " " ")))))))))))(re.++ (re.opt (re.range "," ","))(re.++ (re.* (re.range " " " ")) (re.opt (re.union (re.++ (re.union (str.to_re (str.++ "A" (str.++ "P" (str.++ "T" ""))))(re.union (str.to_re (str.++ "B" (str.++ "L" (str.++ "D" (str.++ "G" "")))))(re.union (str.to_re (str.++ "D" (str.++ "E" (str.++ "P" (str.++ "T" "")))))(re.union (str.to_re (str.++ "F" (str.++ "L" "")))(re.union (str.to_re (str.++ "H" (str.++ "N" (str.++ "G" (str.++ "R" "")))))(re.union (str.to_re (str.++ "L" (str.++ "O" (str.++ "T" ""))))(re.union (str.to_re (str.++ "P" (str.++ "I" (str.++ "E" (str.++ "R" "")))))(re.union (str.to_re (str.++ "R" (str.++ "M" "")))(re.union (re.++ (re.range "S" "S") (re.union (str.to_re (str.++ "L" (str.++ "I" (str.++ "P" ""))))(re.union (str.to_re (str.++ "P" (str.++ "C" ""))) (re.++ (re.range "T" "T") (re.union (re.range "E" "E") (str.to_re (str.++ "O" (str.++ "P" ""))))))))(re.union (str.to_re (str.++ "T" (str.++ "R" (str.++ "L" (str.++ "R" "")))))(re.union (str.to_re (str.++ "U" (str.++ "N" (str.++ "I" (str.++ "T" ""))))) (re.range "#" "#"))))))))))))(re.++ (re.opt (re.range "." "."))(re.++ (re.* (re.range " " " ")) (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))))))(re.union (str.to_re (str.++ "B" (str.++ "S" (str.++ "M" (str.++ "T" "")))))(re.union (str.to_re (str.++ "F" (str.++ "R" (str.++ "N" (str.++ "T" "")))))(re.union (str.to_re (str.++ "L" (str.++ "B" (str.++ "B" (str.++ "Y" "")))))(re.union (str.to_re (str.++ "L" (str.++ "O" (str.++ "W" (str.++ "R" "")))))(re.union (str.to_re (str.++ "O" (str.++ "F" (str.++ "C" ""))))(re.union (str.to_re (str.++ "P" (str.++ "H" "")))(re.union (str.to_re (str.++ "R" (str.++ "E" (str.++ "A" (str.++ "R" "")))))(re.union (str.to_re (str.++ "S" (str.++ "I" (str.++ "D" (str.++ "E" ""))))) (str.to_re (str.++ "U" (str.++ "P" (str.++ "P" (str.++ "R" ""))))))))))))))))))(re.++ (re.opt (re.range "," ","))(re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.++ (re.union (re.++ (re.+ (re.range "0" "9"))(re.++ (re.+ (re.++ (re.+ (re.range " " " "))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))) (re.opt (re.range "." "."))))) (re.opt (re.++ (re.union (re.++ (re.+ (re.range " " " ")) (str.to_re (str.++ "S" (str.++ "T" (str.++ "R" (str.++ "E" (str.++ "E" (str.++ "T" ""))))))))(re.union (str.to_re (str.++ "S" (str.++ "T" "")))(re.union (str.to_re (str.++ "D" (str.++ "R" (str.++ "I" (str.++ "V" (str.++ "E" ""))))))(re.union (str.to_re (str.++ "D" (str.++ "R" "")))(re.union (str.to_re (str.++ "A" (str.++ "V" (str.++ "E" (str.++ "N" (str.++ "U" (str.++ "E" "")))))))(re.union (str.to_re (str.++ "A" (str.++ "V" (str.++ "E" ""))))(re.union (str.to_re (str.++ "R" (str.++ "O" (str.++ "A" (str.++ "D" "")))))(re.union (str.to_re (str.++ "R" (str.++ "D" "")))(re.union (str.to_re (str.++ "L" (str.++ "O" (str.++ "O" (str.++ "P" "")))))(re.union (str.to_re (str.++ "C" (str.++ "O" (str.++ "U" (str.++ "R" (str.++ "T" ""))))))(re.union (str.to_re (str.++ "C" (str.++ "T" "")))(re.union (str.to_re (str.++ "C" (str.++ "I" (str.++ "R" (str.++ "C" (str.++ "L" (str.++ "E" "")))))))(re.union (str.to_re (str.++ "L" (str.++ "A" (str.++ "N" (str.++ "E" "")))))(re.union (str.to_re (str.++ "L" (str.++ "N" "")))(re.union (str.to_re (str.++ "B" (str.++ "O" (str.++ "U" (str.++ "L" (str.++ "E" (str.++ "V" (str.++ "A" (str.++ "R" (str.++ "D" "")))))))))) (str.to_re (str.++ "B" (str.++ "L" (str.++ "V" (str.++ "D" "")))))))))))))))))))) (re.opt (re.range "." "."))))))(re.union (re.++ (re.union (re.++ (str.to_re (str.++ "P" (str.++ "." "")))(re.++ (re.opt (re.range " " " ")) (str.to_re (str.++ "O" (str.++ "." ""))))) (re.++ (re.range "P" "P")(re.++ (re.opt (re.range " " " ")) (re.range "O" "O"))))(re.++ (re.* (re.range " " " "))(re.++ (str.to_re (str.++ "B" (str.++ "o" (str.++ "x" ""))))(re.++ (re.+ (re.range " " " ")) (re.+ (re.range "0" "9"))))))(re.union (re.++ (str.to_re (str.++ "G" (str.++ "e" (str.++ "n" (str.++ "e" (str.++ "r" (str.++ "a" (str.++ "l" ""))))))))(re.++ (re.+ (re.range " " " ")) (str.to_re (str.++ "D" (str.++ "e" (str.++ "l" (str.++ "i" (str.++ "v" (str.++ "e" (str.++ "r" (str.++ "y" ""))))))))))) (re.++ (re.range "C" "C")(re.++ (re.union (re.range "/" "/") (re.range "\u{5c}" "\u{5c}"))(re.++ (re.range "O" "O")(re.++ (re.+ (re.range " " " ")) (re.+ (re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))) (re.* (re.range " " " ")))))))))))(re.++ (re.opt (re.range "," ","))(re.++ (re.* (re.range " " " ")) (re.opt (re.union (re.++ (re.union (str.to_re (str.++ "A" (str.++ "P" (str.++ "T" ""))))(re.union (str.to_re (str.++ "B" (str.++ "L" (str.++ "D" (str.++ "G" "")))))(re.union (str.to_re (str.++ "D" (str.++ "E" (str.++ "P" (str.++ "T" "")))))(re.union (str.to_re (str.++ "F" (str.++ "L" "")))(re.union (str.to_re (str.++ "H" (str.++ "N" (str.++ "G" (str.++ "R" "")))))(re.union (str.to_re (str.++ "L" (str.++ "O" (str.++ "T" ""))))(re.union (str.to_re (str.++ "P" (str.++ "I" (str.++ "E" (str.++ "R" "")))))(re.union (str.to_re (str.++ "R" (str.++ "M" "")))(re.union (re.++ (re.range "S" "S") (re.union (str.to_re (str.++ "L" (str.++ "I" (str.++ "P" ""))))(re.union (str.to_re (str.++ "P" (str.++ "C" ""))) (re.++ (re.range "T" "T") (re.union (re.range "E" "E") (str.to_re (str.++ "O" (str.++ "P" ""))))))))(re.union (str.to_re (str.++ "T" (str.++ "R" (str.++ "L" (str.++ "R" "")))))(re.union (str.to_re (str.++ "U" (str.++ "N" (str.++ "I" (str.++ "T" ""))))) (re.range "#" "#"))))))))))))(re.++ (re.opt (re.range "." "."))(re.++ (re.* (re.range " " " ")) (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))))))(re.union (str.to_re (str.++ "B" (str.++ "S" (str.++ "M" (str.++ "T" "")))))(re.union (str.to_re (str.++ "F" (str.++ "R" (str.++ "N" (str.++ "T" "")))))(re.union (str.to_re (str.++ "L" (str.++ "B" (str.++ "B" (str.++ "Y" "")))))(re.union (str.to_re (str.++ "L" (str.++ "O" (str.++ "W" (str.++ "R" "")))))(re.union (str.to_re (str.++ "O" (str.++ "F" (str.++ "C" ""))))(re.union (str.to_re (str.++ "P" (str.++ "H" "")))(re.union (str.to_re (str.++ "R" (str.++ "E" (str.++ "A" (str.++ "R" "")))))(re.union (str.to_re (str.++ "S" (str.++ "I" (str.++ "D" (str.++ "E" ""))))) (str.to_re (str.++ "U" (str.++ "P" (str.++ "P" (str.++ "R" "")))))))))))))))))))(re.++ (re.opt (re.range "," ","))(re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.+ (re.++ (re.+ (re.union (re.range "A" "Z") (re.range "a" "z"))) (re.* (re.range " " " "))))(re.++ (re.range "," ",")(re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.union (re.++ (re.range "A" "A") (re.union (re.range "A" "B")(re.union (re.range "K" "L")(re.union (re.range "P" "P")(re.union (re.range "R" "S") (re.range "Z" "Z"))))))(re.union (str.to_re (str.++ "B" (str.++ "C" "")))(re.union (re.++ (re.range "C" "C") (re.union (re.range "A" "A")(re.union (re.range "O" "O") (re.range "T" "T"))))(re.union (re.++ (re.range "D" "D") (re.union (re.range "C" "C") (re.range "E" "E")))(re.union (re.++ (re.range "F" "F") (re.range "L" "M"))(re.union (re.++ (re.range "G" "G") (re.union (re.range "A" "A") (re.range "U" "U")))(re.union (str.to_re (str.++ "H" (str.++ "I" "")))(re.union (re.++ (re.range "I" "I") (re.union (re.range "A" "A")(re.union (re.range "D" "D")(re.union (re.range "L" "L") (re.range "N" "N")))))(re.union (re.++ (re.range "K" "K") (re.union (re.range "S" "S") (re.range "Y" "Y")))(re.union (str.to_re (str.++ "L" (str.++ "A" "")))(re.union (re.++ (re.range "M" "M") (re.union (re.range "A" "B")(re.union (re.range "D" "E")(re.union (re.range "H" "I")(re.union (re.range "N" "P") (re.range "S" "T"))))))(re.union (re.++ (re.range "N" "N") (re.union (re.range "B" "E")(re.union (re.range "H" "H")(re.union (re.range "J" "J")(re.union (re.range "L" "M")(re.union (re.range "S" "V") (re.range "Y" "Y")))))))(re.union (re.++ (re.range "O" "O") (re.union (re.range "H" "H")(re.union (re.range "K" "K")(re.union (re.range "N" "N") (re.range "R" "R")))))(re.union (re.++ (re.range "P" "P") (re.union (re.range "A" "A")(re.union (re.range "E" "E")(re.union (re.range "R" "R") (re.range "W" "W")))))(re.union (str.to_re (str.++ "Q" (str.++ "C" "")))(re.union (str.to_re (str.++ "R" (str.++ "I" "")))(re.union (re.++ (re.range "S" "S") (re.union (re.range "C" "D") (re.range "K" "K")))(re.union (re.++ (re.range "T" "T") (re.union (re.range "N" "N") (re.range "X" "X")))(re.union (str.to_re (str.++ "U" (str.++ "T" "")))(re.union (re.++ (re.range "V" "V") (re.union (re.range "A" "A")(re.union (re.range "I" "I") (re.range "T" "T"))))(re.union (re.++ (re.range "W" "W") (re.union (re.range "A" "A")(re.union (re.range "I" "I")(re.union (re.range "V" "V") (re.range "Y" "Y"))))) (str.to_re (str.++ "Y" (str.++ "T" ""))))))))))))))))))))))))(re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.union (re.++ ((_ re.loop 5 5) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 4 4) (re.range "0" "9"))))(re.union ((_ re.loop 5 5) (re.range "0" "9")) (re.++ (re.union (re.range "A" "C")(re.union (re.range "E" "E")(re.union (re.range "G" "H")(re.union (re.range "J" "N")(re.union (re.range "P" "P")(re.union (re.range "R" "T")(re.union (re.range "V" "V")(re.union (re.range "X" "Y")(re.union (re.range "a" "c")(re.union (re.range "e" "e")(re.union (re.range "g" "h")(re.union (re.range "j" "n")(re.union (re.range "p" "p")(re.union (re.range "r" "t")(re.union (re.range "v" "v") (re.range "x" "y"))))))))))))))))(re.++ (re.range "0" "9")(re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.range "0" "9")(re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) (re.range "0" "9")))))))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (str.to_re ""))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
