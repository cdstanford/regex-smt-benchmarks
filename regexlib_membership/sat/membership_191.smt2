;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?<dayOfWeek>\w{3}) (?<monthName>\w{3}) (?<day>\d{1,2}) (?<year>\d{4})? ?(?<hours>\d{1,2}):(?<minutes>\d{1,2}):(?<seconds>\d{1,2}) (GMT|UTC)(?<timeZoneOffset>[-+]?\d{4}) (?<year>\d{4})?\(?(?<timeZoneName>[a-zA-Z\s]+)?\)?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00FD\u00AA\u00AA \u00B5\u00DD2 3 211899:64:0 GMT9588 \xA)"
(define-fun Witness1 () String (seq.++ "\xfd" (seq.++ "\xaa" (seq.++ "\xaa" (seq.++ " " (seq.++ "\xb5" (seq.++ "\xdd" (seq.++ "2" (seq.++ " " (seq.++ "3" (seq.++ " " (seq.++ "2" (seq.++ "1" (seq.++ "1" (seq.++ "8" (seq.++ "9" (seq.++ "9" (seq.++ ":" (seq.++ "6" (seq.++ "4" (seq.++ ":" (seq.++ "0" (seq.++ " " (seq.++ "G" (seq.++ "M" (seq.++ "T" (seq.++ "9" (seq.++ "5" (seq.++ "8" (seq.++ "8" (seq.++ " " (seq.++ "\x0a" (seq.++ ")" "")))))))))))))))))))))))))))))))))
;witness2: "17c 0\u00AAA 30 9966 8:89:89 GMT8209 (\u00A0"
(define-fun Witness2 () String (seq.++ "1" (seq.++ "7" (seq.++ "c" (seq.++ " " (seq.++ "0" (seq.++ "\xaa" (seq.++ "A" (seq.++ " " (seq.++ "3" (seq.++ "0" (seq.++ " " (seq.++ "9" (seq.++ "9" (seq.++ "6" (seq.++ "6" (seq.++ " " (seq.++ "8" (seq.++ ":" (seq.++ "8" (seq.++ "9" (seq.++ ":" (seq.++ "8" (seq.++ "9" (seq.++ " " (seq.++ "G" (seq.++ "M" (seq.++ "T" (seq.++ "8" (seq.++ "2" (seq.++ "0" (seq.++ "9" (seq.++ " " (seq.++ "(" (seq.++ "\xa0" "")))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 3 3) (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.range " " " ")(re.++ ((_ re.loop 3 3) (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.range " " " ")(re.++ ((_ re.loop 1 2) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ (re.opt ((_ re.loop 4 4) (re.range "0" "9")))(re.++ (re.opt (re.range " " " "))(re.++ ((_ re.loop 1 2) (re.range "0" "9"))(re.++ (re.range ":" ":")(re.++ ((_ re.loop 1 2) (re.range "0" "9"))(re.++ (re.range ":" ":")(re.++ ((_ re.loop 1 2) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ (re.union (str.to_re (seq.++ "G" (seq.++ "M" (seq.++ "T" "")))) (str.to_re (seq.++ "U" (seq.++ "T" (seq.++ "C" "")))))(re.++ (re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-"))) ((_ re.loop 4 4) (re.range "0" "9")))(re.++ (re.range " " " ")(re.++ (re.opt ((_ re.loop 4 4) (re.range "0" "9")))(re.++ (re.opt (re.range "(" "("))(re.++ (re.opt (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "A" "Z")(re.union (re.range "a" "z")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))))(re.++ (re.opt (re.range ")" ")")) (str.to_re "")))))))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
