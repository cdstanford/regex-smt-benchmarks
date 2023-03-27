;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[ \w]{3,}([A-Za-z]\.)?([ \w]*\#\d+)?(\r\n| )[ \w]{3,},\x20[A-Za-z]{2}\x20\d{5}(-\d{4})?$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00AA\u00EA9\u00AA\u00AA#9\xD\xA \u00D2a, GY 80579"
(define-fun Witness1 () String (str.++ "\u{aa}" (str.++ "\u{ea}" (str.++ "9" (str.++ "\u{aa}" (str.++ "\u{aa}" (str.++ "#" (str.++ "9" (str.++ "\u{0d}" (str.++ "\u{0a}" (str.++ " " (str.++ "\u{d2}" (str.++ "a" (str.++ "," (str.++ " " (str.++ "G" (str.++ "Y" (str.++ " " (str.++ "8" (str.++ "0" (str.++ "5" (str.++ "7" (str.++ "9" "")))))))))))))))))))))))
;witness2: "\u00B5\u00B5oT\xD\xA7\u00BA\u00C6, gz 81992"
(define-fun Witness2 () String (str.++ "\u{b5}" (str.++ "\u{b5}" (str.++ "o" (str.++ "T" (str.++ "\u{0d}" (str.++ "\u{0a}" (str.++ "7" (str.++ "\u{ba}" (str.++ "\u{c6}" (str.++ "," (str.++ " " (str.++ "g" (str.++ "z" (str.++ " " (str.++ "8" (str.++ "1" (str.++ "9" (str.++ "9" (str.++ "2" ""))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ ((_ re.loop 3 3) (re.union (re.range " " " ")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))) (re.* (re.union (re.range " " " ")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))))(re.++ (re.opt (re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) (re.range "." ".")))(re.++ (re.opt (re.++ (re.* (re.union (re.range " " " ")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))))(re.++ (re.range "#" "#") (re.+ (re.range "0" "9")))))(re.++ (re.union (str.to_re (str.++ "\u{0d}" (str.++ "\u{0a}" ""))) (re.range " " " "))(re.++ (re.++ ((_ re.loop 3 3) (re.union (re.range " " " ")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))) (re.* (re.union (re.range " " " ")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))))(re.++ (str.to_re (str.++ "," (str.++ " " "")))(re.++ ((_ re.loop 2 2) (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.range " " " ")(re.++ ((_ re.loop 5 5) (re.range "0" "9"))(re.++ (re.opt (re.++ (re.range "-" "-") ((_ re.loop 4 4) (re.range "0" "9")))) (str.to_re ""))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
