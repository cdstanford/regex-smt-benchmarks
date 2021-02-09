;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\s(SUN|MON|TUE|WED|THU|FRI|SAT)\s+(JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC)\s+(0?[1-9]|[1-2][0-9]|3[01])\s+(2[0-3]|[0-1][0-9]):([0-5][0-9]):((60|[0-5][0-9]))\s+(19[0-9]{2}|[2-9][0-9]{3}|[0-9]{2}))$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u0085WED JUL\u0085\xD\u00A0\u00A0 \u008506\xD 21:59:58\xC\u0085\u00A0 89"
(define-fun Witness1 () String (seq.++ "\x85" (seq.++ "W" (seq.++ "E" (seq.++ "D" (seq.++ " " (seq.++ "J" (seq.++ "U" (seq.++ "L" (seq.++ "\x85" (seq.++ "\x0d" (seq.++ "\xa0" (seq.++ "\xa0" (seq.++ " " (seq.++ "\x85" (seq.++ "0" (seq.++ "6" (seq.++ "\x0d" (seq.++ " " (seq.++ "2" (seq.++ "1" (seq.++ ":" (seq.++ "5" (seq.++ "9" (seq.++ ":" (seq.++ "5" (seq.++ "8" (seq.++ "\x0c" (seq.++ "\x85" (seq.++ "\xa0" (seq.++ " " (seq.++ "8" (seq.++ "9" "")))))))))))))))))))))))))))))))))
;witness2: "\u0085SUN\u0085AUG 28\xC23:59:60\u00851970"
(define-fun Witness2 () String (seq.++ "\x85" (seq.++ "S" (seq.++ "U" (seq.++ "N" (seq.++ "\x85" (seq.++ "A" (seq.++ "U" (seq.++ "G" (seq.++ " " (seq.++ "2" (seq.++ "8" (seq.++ "\x0c" (seq.++ "2" (seq.++ "3" (seq.++ ":" (seq.++ "5" (seq.++ "9" (seq.++ ":" (seq.++ "6" (seq.++ "0" (seq.++ "\x85" (seq.++ "1" (seq.++ "9" (seq.++ "7" (seq.++ "0" ""))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ (re.union (str.to_re (seq.++ "S" (seq.++ "U" (seq.++ "N" ""))))(re.union (str.to_re (seq.++ "M" (seq.++ "O" (seq.++ "N" ""))))(re.union (str.to_re (seq.++ "T" (seq.++ "U" (seq.++ "E" ""))))(re.union (str.to_re (seq.++ "W" (seq.++ "E" (seq.++ "D" ""))))(re.union (str.to_re (seq.++ "T" (seq.++ "H" (seq.++ "U" ""))))(re.union (str.to_re (seq.++ "F" (seq.++ "R" (seq.++ "I" "")))) (str.to_re (seq.++ "S" (seq.++ "A" (seq.++ "T" ""))))))))))(re.++ (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.union (str.to_re (seq.++ "J" (seq.++ "A" (seq.++ "N" ""))))(re.union (str.to_re (seq.++ "F" (seq.++ "E" (seq.++ "B" ""))))(re.union (str.to_re (seq.++ "M" (seq.++ "A" (seq.++ "R" ""))))(re.union (str.to_re (seq.++ "A" (seq.++ "P" (seq.++ "R" ""))))(re.union (str.to_re (seq.++ "M" (seq.++ "A" (seq.++ "Y" ""))))(re.union (str.to_re (seq.++ "J" (seq.++ "U" (seq.++ "N" ""))))(re.union (str.to_re (seq.++ "J" (seq.++ "U" (seq.++ "L" ""))))(re.union (str.to_re (seq.++ "A" (seq.++ "U" (seq.++ "G" ""))))(re.union (str.to_re (seq.++ "S" (seq.++ "E" (seq.++ "P" ""))))(re.union (str.to_re (seq.++ "O" (seq.++ "C" (seq.++ "T" ""))))(re.union (str.to_re (seq.++ "N" (seq.++ "O" (seq.++ "V" "")))) (str.to_re (seq.++ "D" (seq.++ "E" (seq.++ "C" "")))))))))))))))(re.++ (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.range "1" "9"))(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1"))))(re.++ (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.union (re.++ (re.range "2" "2") (re.range "0" "3")) (re.++ (re.range "0" "1") (re.range "0" "9")))(re.++ (re.range ":" ":")(re.++ (re.++ (re.range "0" "5") (re.range "0" "9"))(re.++ (re.range ":" ":")(re.++ (re.union (str.to_re (seq.++ "6" (seq.++ "0" ""))) (re.++ (re.range "0" "5") (re.range "0" "9")))(re.++ (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (re.union (re.++ (str.to_re (seq.++ "1" (seq.++ "9" ""))) ((_ re.loop 2 2) (re.range "0" "9")))(re.union (re.++ (re.range "2" "9") ((_ re.loop 3 3) (re.range "0" "9"))) ((_ re.loop 2 2) (re.range "0" "9"))))))))))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
