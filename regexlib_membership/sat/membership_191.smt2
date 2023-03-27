;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?<dayOfWeek>\w{3}) (?<monthName>\w{3}) (?<day>\d{1,2}) (?<year>\d{4})? ?(?<hours>\d{1,2}):(?<minutes>\d{1,2}):(?<seconds>\d{1,2}) (GMT|UTC)(?<timeZoneOffset>[-+]?\d{4}) (?<year>\d{4})?\(?(?<timeZoneName>[a-zA-Z\s]+)?\)?$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00FD\u00AA\u00AA \u00B5\u00DD2 3 211899:64:0 GMT9588 \xA)"
(define-fun Witness1 () String (str.++ "\u{fd}" (str.++ "\u{aa}" (str.++ "\u{aa}" (str.++ " " (str.++ "\u{b5}" (str.++ "\u{dd}" (str.++ "2" (str.++ " " (str.++ "3" (str.++ " " (str.++ "2" (str.++ "1" (str.++ "1" (str.++ "8" (str.++ "9" (str.++ "9" (str.++ ":" (str.++ "6" (str.++ "4" (str.++ ":" (str.++ "0" (str.++ " " (str.++ "G" (str.++ "M" (str.++ "T" (str.++ "9" (str.++ "5" (str.++ "8" (str.++ "8" (str.++ " " (str.++ "\u{0a}" (str.++ ")" "")))))))))))))))))))))))))))))))))
;witness2: "17c 0\u00AAA 30 9966 8:89:89 GMT8209 (\u00A0"
(define-fun Witness2 () String (str.++ "1" (str.++ "7" (str.++ "c" (str.++ " " (str.++ "0" (str.++ "\u{aa}" (str.++ "A" (str.++ " " (str.++ "3" (str.++ "0" (str.++ " " (str.++ "9" (str.++ "9" (str.++ "6" (str.++ "6" (str.++ " " (str.++ "8" (str.++ ":" (str.++ "8" (str.++ "9" (str.++ ":" (str.++ "8" (str.++ "9" (str.++ " " (str.++ "G" (str.++ "M" (str.++ "T" (str.++ "8" (str.++ "2" (str.++ "0" (str.++ "9" (str.++ " " (str.++ "(" (str.++ "\u{a0}" "")))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 3 3) (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))(re.++ (re.range " " " ")(re.++ ((_ re.loop 3 3) (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))(re.++ (re.range " " " ")(re.++ ((_ re.loop 1 2) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ (re.opt ((_ re.loop 4 4) (re.range "0" "9")))(re.++ (re.opt (re.range " " " "))(re.++ ((_ re.loop 1 2) (re.range "0" "9"))(re.++ (re.range ":" ":")(re.++ ((_ re.loop 1 2) (re.range "0" "9"))(re.++ (re.range ":" ":")(re.++ ((_ re.loop 1 2) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ (re.union (str.to_re (str.++ "G" (str.++ "M" (str.++ "T" "")))) (str.to_re (str.++ "U" (str.++ "T" (str.++ "C" "")))))(re.++ (re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-"))) ((_ re.loop 4 4) (re.range "0" "9")))(re.++ (re.range " " " ")(re.++ (re.opt ((_ re.loop 4 4) (re.range "0" "9")))(re.++ (re.opt (re.range "(" "("))(re.++ (re.opt (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "A" "Z")(re.union (re.range "a" "z")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))))(re.++ (re.opt (re.range ")" ")")) (str.to_re "")))))))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
